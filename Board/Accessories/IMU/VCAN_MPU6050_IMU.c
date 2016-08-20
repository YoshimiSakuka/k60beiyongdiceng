/* IMU.c file
功能：
姿态解算 IMU
将传感器的输出值进行姿态解算。得到目标载体的俯仰角和横滚角 和航向角
------------------------------------
 */

#include "VCAN_MPU6050_IMU.h"
#include "VCAN_MPU6050.h"
#include "include.h"

volatile float exInt, eyInt, ezInt;  // 误差积分
volatile float q0, q1, q2, q3; // 全局四元数
volatile float integralFBhand,handdiff;
volatile uint32_t lastUpdate, now; // 采样周期计数 单位 us

void MadgwickAHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz);

/**************************实现函数********************************************
*函数原型:		void Initial_Timer3(void)
*功　　能:	  初始化Tim2  Tim3 将两个定时器级联，以产生一个32位的定时器来提供系统us 级的计时	
输入参数：无
输出参数：没有	
*******************************************************************************/


// Fast inverse square-root
/**************************实现函数********************************************
*函数原型:	   float invSqrt(float x)
*功　　能:	   快速计算 1/Sqrt(x) 	
输入参数： 要计算的值
输出参数： 结果
*******************************************************************************/
float invSqrt(float x) {
	float halfx = 0.5f * x;
	float y = x;
	long i = *(long*)&y;
	i = 0x5f3759df - (i>>1);
	y = *(float*)&i;
	y = y * (1.5f - (halfx * y * y));
	return y;
}

/**************************实现函数********************************************
*函数原型:		uint32_t micros(void)
*功　　能:	  读取系统运行的时间 ，返回单位为us 的时间数。	
输入参数：无
输出参数：处理器当前时间，从上电开始计时  单位 us
*******************************************************************************/


/**************************实现函数********************************************
*函数原型:	   void IMU_init(void)
*功　　能:	  初始化IMU相关	
			  初始化各个传感器
			  初始化四元数
			  将积分清零
			  更新系统时间
输入参数：无
输出参数：没有
*******************************************************************************/
void IMU_init(void)
{	 
	MPU6050_initialize();
        DELAY_MS(5);
	MPU6050_initialize();
        DELAY_MS(5);

        pit_time_start(PIT0);

  	q0 = 1.0f;  //初始化四元数
  	q1 = 0.0f;
  	q2 = 0.0f;
  	q3 = 0.0f;
  	exInt = 0.0;
  	eyInt = 0.0;
  	ezInt = 0.0;
  	lastUpdate = pit_time_get_us(PIT0);//更新时间
  	now = pit_time_get_us(PIT0);
}

/**************************实现函数********************************************
*函数原型:	   void IMU_getValues(float * values)
*功　　能:	 读取加速度 陀螺仪 磁力计 的当前值  
输入参数： 将结果存放的数组首地址
输出参数：没有
*******************************************************************************/
void IMU_getValues(float * values) {  
	int16_t accgyroval[6];
	int i;
	//读取加速度和陀螺仪的当前ADC
    MPU6050_getMotion6(&accgyroval[0], &accgyroval[1], &accgyroval[2], &accgyroval[3], &accgyroval[4], &accgyroval[5]);
    for(i = 0; i<6; i++) {
      if(i < 3) {
        values[i] = (float) accgyroval[i];
      }
      else {
        values[i] = ((float) accgyroval[i]) / 32.8f; //转成度每秒
		//这里已经将量程改成了 1000度每秒  32.8 对应 1度每秒
      }
    }
    //HMC58X3_mgetValues(&values[6]);	//读取磁力计的ADC值
}


/**************************实现函数********************************************
*函数原型:	   void IMU_AHRSupdate
*功　　能:	 更新AHRS 更新四元数 
输入参数： 当前的测量值。
输出参数：没有
*******************************************************************************/
#define Kp 2.0f   // proportional gain governs rate of convergence to accelerometer/magnetometer
#define Ki 0.01f   // integral gain governs rate of convergence of gyroscope biases

void IMU_AHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz) 
{
  float norm;
  float hx, hy, hz, bx, bz;
  float vx, vy, vz, wx, wy, wz;
  float ex, ey, ez,halfT;
  float tempq0,tempq1,tempq2,tempq3;

  // 先把这些用得到的值算好
  float q0q0 = q0*q0;        //volatile类型变量一般不直接参与运算,
  float q0q1 = q0*q1;        //可以尝试赋值给局部变量后进行运算.
  float q0q2 = q0*q2;
  float q0q3 = q0*q3;
  float q1q1 = q1*q1;
  float q1q2 = q1*q2;
  float q1q3 = q1*q3;
  float q2q2 = q2*q2;   
  float q2q3 = q2*q3;
  float q3q3 = q3*q3;          
  
  now = pit_time_get_us(PIT0);  //读取时间
  
  if(now<lastUpdate){ //定时器溢出过了。    //volatile类型变量lastUpdate一般不直接参与运算,
  halfT =  ((float)(now + (0x04444444- lastUpdate)) / 1750000.0f);   //default 2000000.0f
  }
  else	{
  halfT =  ((float)(now - lastUpdate) / 1750000.0f);
  }
  
  lastUpdate = now;	//更新时间

  norm = invSqrt(ax*ax + ay*ay + az*az);       
  ax = ax * norm;
  ay = ay * norm;
  az = az * norm;
  //把加计的三维向量转成单位向量。

  //norm = invSqrt(mx*mx + my*my + mz*mz);          
  //mx = mx * norm;
  //my = my * norm;
  //mz = mz * norm;

  // compute reference direction of flux
  //hx = 2*mx*(0.5f - q2q2 - q3q3) + 2*my*(q1q2 - q0q3) + 2*mz*(q1q3 + q0q2);
  //hy = 2*mx*(q1q2 + q0q3) + 2*my*(0.5f - q1q1 - q3q3) + 2*mz*(q2q3 - q0q1);
  //hz = 2*mx*(q1q3 - q0q2) + 2*my*(q2q3 + q0q1) + 2*mz*(0.5f - q1q1 - q2q2);         
  //bx = sqrt((hx*hx) + (hy*hy));
  //bz = hz;     
  
  // estimated direction of gravity and flux (v and w)
  vx = 2*(q1q3 - q0q2);
  vy = 2*(q0q1 + q2q3);
  vz = q0q0 - q1q1 - q2q2 + q3q3;
  //wx = 2*bx*(0.5 - q2q2 - q3q3) + 2*bz*(q1q3 - q0q2);
  //wy = 2*bx*(q1q2 - q0q3) + 2*bz*(q0q1 + q2q3);
  //wz = 2*bx*(q0q2 + q1q3) + 2*bz*(0.5 - q1q1 - q2q2);  
  
  // error is sum of cross product between reference direction of fields and direction measured by sensors
  ex = (ay*vz - az*vy); //+ (my*wz - mz*wy);
  ey = (az*vx - ax*vz); //+ (mz*wx - mx*wz);
  ez = (ax*vy - ay*vx); //+ (mx*wy - my*wx);

if(ex != 0.0f && ey != 0.0f && ez != 0.0f){
  exInt = exInt + ex * Ki * halfT;
  eyInt = eyInt + ey * Ki * halfT;	
  ezInt = ezInt + ez * Ki * halfT;

  // 用叉积误差来做PI修正陀螺零偏
  gx = gx + Kp*ex + exInt;
  gy = gy + Kp*ey + eyInt;
  gz = gz + Kp*ez + ezInt;

  }

  // 四元数微分方程
  tempq0 = q0 + (-q1*gx - q2*gy - q3*gz)*halfT;   //volatile类型变量一般不直接参与运算,
  tempq1 = q1 + (q0*gx + q2*gz - q3*gy)*halfT;    //可以尝试赋值给局部变量后进行运算.
  tempq2 = q2 + (q0*gy - q1*gz + q3*gx)*halfT;
  tempq3 = q3 + (q0*gz + q1*gy - q2*gx)*halfT;  
  
  // 四元数规范化
  norm = invSqrt(tempq0*tempq0 + tempq1*tempq1 + tempq2*tempq2 + tempq3*tempq3);
  q0 = tempq0 * norm;
  q1 = tempq1 * norm;
  q2 = tempq2 * norm;
  q3 = tempq3 * norm;
}

/**************************实现函数********************************************
*函数原型:	   void IMU_getQ(float * q)
*功　　能:	 更新四元数 返回当前的四元数组值
输入参数： 将要存放四元数的数组首地址
输出参数：没有
*******************************************************************************/
float mygetqval[9];	//用于存放传感器转换结果的数组
void IMU_getQ(float * q) {

  IMU_getValues(mygetqval);	 
  //将陀螺仪的测量值转成弧度每秒
  //加速度和磁力计保持 ADC值　不需要转换
IMU_AHRSupdate(mygetqval[3] * M_PI/180, mygetqval[4] * M_PI/180, mygetqval[5] * M_PI/180,
   mygetqval[0], mygetqval[1], mygetqval[2], mygetqval[6], mygetqval[7], mygetqval[8]);

  q[0] = q0; //返回当前值
  q[1] = q1;
  q[2] = q2;
  q[3] = q3;
}


/**************************实现函数********************************************
*函数原型:	   void IMU_getYawPitchRoll(float * angles)
*功　　能:	 更新四元数 返回当前解算后的姿态数据
输入参数： 将要存放姿态角的数组首地址
输出参数：没有
*******************************************************************************/
void IMU_getYawPitchRoll(float * angles) {
  float q[4]; //　四元数
  volatile float gx=0.0, gy=0.0, gz=0.0; //估计重力方向
  IMU_getQ(q); //更新全局四元数
  
  angles[0] = -atan2(2 * q[1] * q[2] + 2 * q[0] * q[3], -2 * q[2]*q[2] - 2 * q[3] * q[3] + 1)* 180/M_PI; // yaw
  angles[1] = -asin(-2 * q[1] * q[3] + 2 * q[0] * q[2])* 180/M_PI; // pitch
  angles[2] = atan2(2 * q[2] * q[3] + 2 * q[0] * q[1], -2 * q[1] * q[1] - 2 * q[2] * q[2] + 1)* 180/M_PI; // roll
  //if(angles[0]<0)angles[0]+=360.0f;  //将 -+180度  转成0-360度
}

//------------------End of File----------------------------