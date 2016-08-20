///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:35
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\IMU\VCAN_MPU6050_IMU.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\IMU\VCAN_MPU6050_IMU.c
//        -D DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\
//        -lB
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\ -o
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\Obj\
//        --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa
//        --no_clustering --no_scheduling --debug --endian=little
//        --cpu=Cortex-M4 -e --fpu=None --dlib_config "E:\IAR for
//        ARM\arm\INC\c\DLib_Config_Full.h" -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\App\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\App\Inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\IAR\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\kinetis\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\CMSIS\Inc\
//        -I D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\FatFs\
//        -I D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\USB\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\MPU6050\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\IMU\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\Driver\
//        -On
//    List file    =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_MPU6050_IMU.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN MPU6050_getMotion6
        EXTERN MPU6050_initialize
        EXTERN __aeabi_cfcmpeq
        EXTERN __aeabi_d2f
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_f2d
        EXTERN __aeabi_fadd
        EXTERN __aeabi_fdiv
        EXTERN __aeabi_fmul
        EXTERN __aeabi_fsub
        EXTERN __aeabi_i2f
        EXTERN __aeabi_ui2f
        EXTERN asin
        EXTERN atan2
        EXTERN bus_clk_khz
        EXTERN pit_time_get
        EXTERN pit_time_start
        EXTERN systick_delay_ms

        PUBLIC IMU_AHRSupdate
        PUBLIC IMU_getQ
        PUBLIC IMU_getValues
        PUBLIC IMU_getYawPitchRoll
        PUBLIC IMU_init
        PUBLIC exInt
        PUBLIC eyInt
        PUBLIC ezInt
        PUBLIC handdiff
        PUBLIC integralFBhand
        PUBLIC invSqrt
        PUBLIC lastUpdate
        PUBLIC mygetqval
        PUBLIC now
        PUBLIC q0
        PUBLIC q1
        PUBLIC q2
        PUBLIC q3

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\IMU\VCAN_MPU6050_IMU.c
//    1 /* IMU.c file
//    2 功能：
//    3 姿态解算 IMU
//    4 将传感器的输出值进行姿态解算。得到目标载体的俯仰角和横滚角 和航向角
//    5 ------------------------------------
//    6  */
//    7 
//    8 #include "VCAN_MPU6050_IMU.h"
//    9 #include "VCAN_MPU6050.h"
//   10 #include "include.h"
//   11 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12 volatile float exInt, eyInt, ezInt;  // 误差积分
exInt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
eyInt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
ezInt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 volatile float q0, q1, q2, q3; // 全局四元数
q0:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
q1:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
q2:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
q3:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 volatile float integralFBhand,handdiff;
integralFBhand:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
handdiff:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 volatile uint32_t lastUpdate, now; // 采样周期计数 单位 us
lastUpdate:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
now:
        DS8 4
//   16 
//   17 void MadgwickAHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz);
//   18 
//   19 /**************************实现函数********************************************
//   20 *函数原型:		void Initial_Timer3(void)
//   21 *功　　能:	  初始化Tim2  Tim3 将两个定时器级联，以产生一个32位的定时器来提供系统us 级的计时	
//   22 输入参数：无
//   23 输出参数：没有	
//   24 *******************************************************************************/
//   25 
//   26 
//   27 // Fast inverse square-root
//   28 /**************************实现函数********************************************
//   29 *函数原型:	   float invSqrt(float x)
//   30 *功　　能:	   快速计算 1/Sqrt(x) 	
//   31 输入参数： 要计算的值
//   32 输出参数： 结果
//   33 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 float invSqrt(float x) {
invSqrt:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
//   35 	float halfx = 0.5f * x;
        MOVS     R0,#+1056964608
        MOVS     R1,R4
        BL       __aeabi_fmul
        MOVS     R5,R0
//   36 	float y = x;
        MOVS     R6,R4
//   37 	long i = *(long*)&y;
        MOVS     R7,R6
//   38 	i = 0x5f3759df - (i>>1);
        LDR.W    R0,??DataTable5  ;; 0x5f3759df
        SUBS     R7,R0,R7, ASR #+1
//   39 	y = *(float*)&i;
        MOVS     R6,R7
//   40 	y = y * (1.5f - (halfx * y * y));
        MOVS     R0,R5
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOVS     R0,#+1069547520
        BL       __aeabi_fsub
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOVS     R6,R0
//   41 	return y;
        MOVS     R0,R6
        POP      {R1,R4-R7,PC}    ;; return
//   42 }
//   43 
//   44 /**************************实现函数********************************************
//   45 *函数原型:		uint32_t micros(void)
//   46 *功　　能:	  读取系统运行的时间 ，返回单位为us 的时间数。	
//   47 输入参数：无
//   48 输出参数：处理器当前时间，从上电开始计时  单位 us
//   49 *******************************************************************************/
//   50 
//   51 
//   52 /**************************实现函数********************************************
//   53 *函数原型:	   void IMU_init(void)
//   54 *功　　能:	  初始化IMU相关	
//   55 			  初始化各个传感器
//   56 			  初始化四元数
//   57 			  将积分清零
//   58 			  更新系统时间
//   59 输入参数：无
//   60 输出参数：没有
//   61 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void IMU_init(void)
//   63 {	 
IMU_init:
        PUSH     {R7,LR}
//   64 	MPU6050_initialize();
        BL       MPU6050_initialize
//   65         DELAY_MS(5);
        MOVS     R0,#+5
        BL       systick_delay_ms
//   66 	MPU6050_initialize();
        BL       MPU6050_initialize
//   67         DELAY_MS(5);
        MOVS     R0,#+5
        BL       systick_delay_ms
//   68 
//   69         pit_time_start(PIT0);
        MOVS     R0,#+0
        BL       pit_time_start
//   70 
//   71   	q0 = 1.0f;  //初始化四元数
        MOVS     R0,#+1065353216
        LDR.W    R1,??DataTable5_1
        STR      R0,[R1, #+0]
//   72   	q1 = 0.0f;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_2
        STR      R0,[R1, #+0]
//   73   	q2 = 0.0f;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_3
        STR      R0,[R1, #+0]
//   74   	q3 = 0.0f;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_4
        STR      R0,[R1, #+0]
//   75   	exInt = 0.0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_5
        STR      R0,[R1, #+0]
//   76   	eyInt = 0.0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_6
        STR      R0,[R1, #+0]
//   77   	ezInt = 0.0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_7
        STR      R0,[R1, #+0]
//   78   	lastUpdate = pit_time_get_us(PIT0);//更新时间
        MOVS     R0,#+0
        BL       pit_time_get
        LDR.W    R1,??DataTable5_8
        LDR      R1,[R1, #+0]
        MOV      R2,#+1000
        SDIV     R1,R1,R2
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable5_9
        STR      R0,[R1, #+0]
//   79   	now = pit_time_get_us(PIT0);
        MOVS     R0,#+0
        BL       pit_time_get
        LDR.W    R1,??DataTable5_8
        LDR      R1,[R1, #+0]
        MOV      R2,#+1000
        SDIV     R1,R1,R2
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable5_10
        STR      R0,[R1, #+0]
//   80 }
        POP      {R0,PC}          ;; return
//   81 
//   82 /**************************实现函数********************************************
//   83 *函数原型:	   void IMU_getValues(float * values)
//   84 *功　　能:	 读取加速度 陀螺仪 磁力计 的当前值  
//   85 输入参数： 将结果存放的数组首地址
//   86 输出参数：没有
//   87 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   88 void IMU_getValues(float * values) {  
IMU_getValues:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+20
        MOVS     R4,R0
//   89 	int16_t accgyroval[6];
//   90 	int i;
//   91 	//读取加速度和陀螺仪的当前ADC
//   92     MPU6050_getMotion6(&accgyroval[0], &accgyroval[1], &accgyroval[2], &accgyroval[3], &accgyroval[4], &accgyroval[5]);
        ADD      R0,SP,#+18
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+14
        ADD      R2,SP,#+12
        ADD      R1,SP,#+10
        ADD      R0,SP,#+8
        BL       MPU6050_getMotion6
//   93     for(i = 0; i<6; i++) {
        MOVS     R0,#+0
        MOVS     R5,R0
??IMU_getValues_0:
        CMP      R5,#+6
        BGE.N    ??IMU_getValues_1
//   94       if(i < 3) {
        CMP      R5,#+3
        BGE.N    ??IMU_getValues_2
//   95         values[i] = (float) accgyroval[i];
        ADD      R0,SP,#+8
        LDRSH    R0,[R0, R5, LSL #+1]
        BL       __aeabi_i2f
        STR      R0,[R4, R5, LSL #+2]
        B.N      ??IMU_getValues_3
//   96       }
//   97       else {
//   98         values[i] = ((float) accgyroval[i]) / 32.8f; //转成度每秒
??IMU_getValues_2:
        ADD      R0,SP,#+8
        LDRSH    R0,[R0, R5, LSL #+1]
        BL       __aeabi_i2f
        LDR.W    R1,??DataTable5_11  ;; 0x42033333
        BL       __aeabi_fdiv
        STR      R0,[R4, R5, LSL #+2]
//   99 		//这里已经将量程改成了 1000度每秒  32.8 对应 1度每秒
//  100       }
//  101     }
??IMU_getValues_3:
        ADDS     R5,R5,#+1
        B.N      ??IMU_getValues_0
//  102     //HMC58X3_mgetValues(&values[6]);	//读取磁力计的ADC值
//  103 }
??IMU_getValues_1:
        ADD      SP,SP,#+20
        POP      {R4,R5,PC}       ;; return
//  104 
//  105 
//  106 /**************************实现函数********************************************
//  107 *函数原型:	   void IMU_AHRSupdate
//  108 *功　　能:	 更新AHRS 更新四元数 
//  109 输入参数： 当前的测量值。
//  110 输出参数：没有
//  111 *******************************************************************************/
//  112 #define Kp 2.0f   // proportional gain governs rate of convergence to accelerometer/magnetometer
//  113 #define Ki 0.01f   // integral gain governs rate of convergence of gyroscope biases
//  114 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  115 void IMU_AHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz) 
//  116 {
IMU_AHRSupdate:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+92
        MOVS     R7,R0
        MOV      R8,R1
        MOV      R9,R2
        MOVS     R4,R3
        LDR      R5,[SP, #+128]
        LDR      R6,[SP, #+132]
//  117   float norm;
//  118   float hx, hy, hz, bx, bz;
//  119   float vx, vy, vz, wx, wy, wz;
//  120   float ex, ey, ez,halfT;
//  121   float tempq0,tempq1,tempq2,tempq3;
//  122 
//  123   // 先把这些用得到的值算好
//  124   float q0q0 = q0*q0;        //volatile类型变量一般不直接参与运算,
        LDR.W    R0,??DataTable5_1
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_1
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+80]
//  125   float q0q1 = q0*q1;        //可以尝试赋值给局部变量后进行运算.
        LDR.W    R0,??DataTable5_1
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+76]
//  126   float q0q2 = q0*q2;
        LDR.W    R0,??DataTable5_1
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+72]
//  127   float q0q3 = q0*q3;
        LDR.W    R0,??DataTable5_1
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+88]
//  128   float q1q1 = q1*q1;
        LDR.W    R0,??DataTable5_2
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+68]
//  129   float q1q2 = q1*q2;
        LDR.W    R0,??DataTable5_2
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+84]
//  130   float q1q3 = q1*q3;
        LDR.W    R0,??DataTable5_2
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+64]
//  131   float q2q2 = q2*q2;   
        LDR.W    R0,??DataTable5_3
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+60]
//  132   float q2q3 = q2*q3;
        LDR.W    R0,??DataTable5_3
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+56]
//  133   float q3q3 = q3*q3;          
        LDR.W    R0,??DataTable5_4
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        BL       __aeabi_fmul
        STR      R0,[SP, #+52]
//  134   
//  135   now = pit_time_get_us(PIT0);  //读取时间
        MOVS     R0,#+0
        BL       pit_time_get
        LDR.W    R1,??DataTable5_8
        LDR      R1,[R1, #+0]
        MOV      R2,#+1000
        SDIV     R1,R1,R2
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable5_10
        STR      R0,[R1, #+0]
//  136   
//  137   if(now<lastUpdate){ //定时器溢出过了。    //volatile类型变量lastUpdate一般不直接参与运算,
        LDR.W    R0,??DataTable5_10
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable5_9
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??IMU_AHRSupdate_0
//  138   halfT =  ((float)(now + (0x04444444- lastUpdate)) / 1750000.0f);   //default 2000000.0f
        LDR.W    R0,??DataTable5_10
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable5_12  ;; 0x4444444
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable5_9
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_ui2f
        LDR.W    R1,??DataTable5_13  ;; 0x49d59f80
        BL       __aeabi_fdiv
        STR      R0,[SP, #+4]
        B.N      ??IMU_AHRSupdate_1
//  139   }
//  140   else	{
//  141   halfT =  ((float)(now - lastUpdate) / 1750000.0f);
??IMU_AHRSupdate_0:
        LDR.W    R0,??DataTable5_10
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable5_9
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_ui2f
        LDR.W    R1,??DataTable5_13  ;; 0x49d59f80
        BL       __aeabi_fdiv
        STR      R0,[SP, #+4]
//  142   }
//  143   
//  144   lastUpdate = now;	//更新时间
??IMU_AHRSupdate_1:
        LDR.W    R0,??DataTable5_10
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable5_9
        STR      R0,[R1, #+0]
//  145 
//  146   norm = invSqrt(ax*ax + ay*ay + az*az);       
        MOVS     R0,R4
        MOVS     R1,R4
        BL       __aeabi_fmul
        MOV      R10,R0
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        MOV      R10,R0
        MOVS     R0,R6
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        BL       invSqrt
        STR      R0,[SP, #+8]
//  147   ax = ax * norm;
        LDR      R0,[SP, #+8]
        MOVS     R1,R4
        BL       __aeabi_fmul
        MOVS     R4,R0
//  148   ay = ay * norm;
        LDR      R0,[SP, #+8]
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R5,R0
//  149   az = az * norm;
        LDR      R0,[SP, #+8]
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOVS     R6,R0
//  150   //把加计的三维向量转成单位向量。
//  151 
//  152   //norm = invSqrt(mx*mx + my*my + mz*mz);          
//  153   //mx = mx * norm;
//  154   //my = my * norm;
//  155   //mz = mz * norm;
//  156 
//  157   // compute reference direction of flux
//  158   //hx = 2*mx*(0.5f - q2q2 - q3q3) + 2*my*(q1q2 - q0q3) + 2*mz*(q1q3 + q0q2);
//  159   //hy = 2*mx*(q1q2 + q0q3) + 2*my*(0.5f - q1q1 - q3q3) + 2*mz*(q2q3 - q0q1);
//  160   //hz = 2*mx*(q1q3 - q0q2) + 2*my*(q2q3 + q0q1) + 2*mz*(0.5f - q1q1 - q2q2);         
//  161   //bx = sqrt((hx*hx) + (hy*hy));
//  162   //bz = hz;     
//  163   
//  164   // estimated direction of gravity and flux (v and w)
//  165   vx = 2*(q1q3 - q0q2);
        LDR      R0,[SP, #+64]
        LDR      R1,[SP, #+72]
        BL       __aeabi_fsub
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        STR      R0,[SP, #+48]
//  166   vy = 2*(q0q1 + q2q3);
        LDR      R1,[SP, #+76]
        LDR      R0,[SP, #+56]
        BL       __aeabi_fadd
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        STR      R0,[SP, #+44]
//  167   vz = q0q0 - q1q1 - q2q2 + q3q3;
        LDR      R0,[SP, #+80]
        LDR      R1,[SP, #+68]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+60]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+52]
        BL       __aeabi_fadd
        STR      R0,[SP, #+40]
//  168   //wx = 2*bx*(0.5 - q2q2 - q3q3) + 2*bz*(q1q3 - q0q2);
//  169   //wy = 2*bx*(q1q2 - q0q3) + 2*bz*(q0q1 + q2q3);
//  170   //wz = 2*bx*(q0q2 + q1q3) + 2*bz*(0.5 - q1q1 - q2q2);  
//  171   
//  172   // error is sum of cross product between reference direction of fields and direction measured by sensors
//  173   ex = (ay*vz - az*vy); //+ (my*wz - mz*wy);
        LDR      R0,[SP, #+40]
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOV      R10,R0
        LDR      R0,[SP, #+44]
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R10
        BL       __aeabi_fsub
        STR      R0,[SP, #+36]
//  174   ey = (az*vx - ax*vz); //+ (mz*wx - mx*wz);
        LDR      R0,[SP, #+48]
        MOVS     R1,R6
        BL       __aeabi_fmul
        MOV      R10,R0
        LDR      R0,[SP, #+40]
        MOVS     R1,R4
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R10
        BL       __aeabi_fsub
        STR      R0,[SP, #+32]
//  175   ez = (ax*vy - ay*vx); //+ (mx*wy - my*wx);
        LDR      R0,[SP, #+44]
        MOVS     R1,R4
        BL       __aeabi_fmul
        MOV      R10,R0
        LDR      R0,[SP, #+48]
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R10
        BL       __aeabi_fsub
        STR      R0,[SP, #+28]
//  176 
//  177 if(ex != 0.0f && ey != 0.0f && ez != 0.0f){
        LDR      R0,[SP, #+36]
        MOVS     R1,#+0
        BL       __aeabi_cfcmpeq
        BEQ.N    ??IMU_AHRSupdate_2
        LDR      R0,[SP, #+32]
        MOVS     R1,#+0
        BL       __aeabi_cfcmpeq
        BEQ.N    ??IMU_AHRSupdate_2
        LDR      R0,[SP, #+28]
        MOVS     R1,#+0
        BL       __aeabi_cfcmpeq
        BEQ.N    ??IMU_AHRSupdate_2
//  178   exInt = exInt + ex * Ki * halfT;
        LDR      R1,[SP, #+36]
        LDR.W    R0,??DataTable5_14  ;; 0x3c23d70a
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        LDR.W    R1,??DataTable5_5
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_5
        STR      R0,[R1, #+0]
//  179   eyInt = eyInt + ey * Ki * halfT;	
        LDR      R1,[SP, #+32]
        LDR.W    R0,??DataTable5_14  ;; 0x3c23d70a
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        LDR.W    R1,??DataTable5_6
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_6
        STR      R0,[R1, #+0]
//  180   ezInt = ezInt + ez * Ki * halfT;
        LDR      R1,[SP, #+28]
        LDR.W    R0,??DataTable5_14  ;; 0x3c23d70a
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        LDR.W    R1,??DataTable5_7
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_7
        STR      R0,[R1, #+0]
//  181 
//  182   // 用叉积误差来做PI修正陀螺零偏
//  183   gx = gx + Kp*ex + exInt;
        LDR      R1,[SP, #+36]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_5
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        MOVS     R7,R0
//  184   gy = gy + Kp*ey + eyInt;
        LDR      R1,[SP, #+32]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        MOV      R1,R8
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_6
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        MOV      R8,R0
//  185   gz = gz + Kp*ez + ezInt;
        LDR      R1,[SP, #+28]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        MOV      R1,R9
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable5_7
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        MOV      R9,R0
//  186 
//  187   }
//  188 
//  189   // 四元数微分方程
//  190   tempq0 = q0 + (-q1*gx - q2*gy - q3*gz)*halfT;   //volatile类型变量一般不直接参与运算,
??IMU_AHRSupdate_2:
        LDR.W    R0,??DataTable5_1
        LDR      R10,[R0, #+0]
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable5_3
        LDR      R11,[R1, #+0]
        EORS     R0,R0,#0x80000000
        MOVS     R1,R7
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R11
        MOV      R1,R8
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        MOV      R11,R0
        LDR.W    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R11
        BL       __aeabi_fsub
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        STR      R0,[SP, #+24]
//  191   tempq1 = q1 + (q0*gx + q2*gz - q3*gy)*halfT;    //可以尝试赋值给局部变量后进行运算.
        LDR.N    R0,??DataTable5_2
        LDR      R10,[R0, #+0]
        LDR.N    R0,??DataTable5_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable5_3
        LDR      R11,[R1, #+0]
        MOVS     R1,R7
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R11
        MOV      R1,R9
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        MOV      R11,R0
        LDR.N    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        MOV      R1,R8
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R11
        BL       __aeabi_fsub
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        STR      R0,[SP, #+20]
//  192   tempq2 = q2 + (q0*gy - q1*gz + q3*gx)*halfT;
        LDR.N    R0,??DataTable5_3
        LDR      R10,[R0, #+0]
        LDR.N    R0,??DataTable5_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable5_2
        LDR      R11,[R1, #+0]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R11
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        MOV      R11,R0
        LDR.N    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        MOVS     R1,R7
        BL       __aeabi_fmul
        MOV      R1,R11
        BL       __aeabi_fadd
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        STR      R0,[SP, #+16]
//  193   tempq3 = q3 + (q0*gz + q1*gy - q2*gx)*halfT;  
        LDR.N    R0,??DataTable5_4
        LDR      R10,[R0, #+0]
        LDR.N    R0,??DataTable5_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable5_2
        LDR      R11,[R1, #+0]
        MOV      R1,R9
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R11
        MOV      R1,R8
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        MOV      R11,R0
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        MOVS     R1,R7
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R11
        BL       __aeabi_fsub
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        STR      R0,[SP, #+12]
//  194   
//  195   // 四元数规范化
//  196   norm = invSqrt(tempq0*tempq0 + tempq1*tempq1 + tempq2*tempq2 + tempq3*tempq3);
        LDR      R1,[SP, #+24]
        LDR      R0,[SP, #+24]
        BL       __aeabi_fmul
        MOV      R10,R0
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+20]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        MOV      R10,R0
        LDR      R1,[SP, #+16]
        LDR      R0,[SP, #+16]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        MOV      R10,R0
        LDR      R1,[SP, #+12]
        LDR      R0,[SP, #+12]
        BL       __aeabi_fmul
        MOV      R1,R10
        BL       __aeabi_fadd
        BL       invSqrt
        STR      R0,[SP, #+8]
//  197   q0 = tempq0 * norm;
        LDR      R1,[SP, #+24]
        LDR      R0,[SP, #+8]
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_1
        STR      R0,[R1, #+0]
//  198   q1 = tempq1 * norm;
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+8]
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_2
        STR      R0,[R1, #+0]
//  199   q2 = tempq2 * norm;
        LDR      R1,[SP, #+16]
        LDR      R0,[SP, #+8]
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_3
        STR      R0,[R1, #+0]
//  200   q3 = tempq3 * norm;
        LDR      R1,[SP, #+12]
        LDR      R0,[SP, #+8]
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_4
        STR      R0,[R1, #+0]
//  201 }
        ADD      SP,SP,#+92
        POP      {R4-R11,PC}      ;; return
//  202 
//  203 /**************************实现函数********************************************
//  204 *函数原型:	   void IMU_getQ(float * q)
//  205 *功　　能:	 更新四元数 返回当前的四元数组值
//  206 输入参数： 将要存放四元数的数组首地址
//  207 输出参数：没有
//  208 *******************************************************************************/

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  209 float mygetqval[9];	//用于存放传感器转换结果的数组
mygetqval:
        DS8 36

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  210 void IMU_getQ(float * q) {
IMU_getQ:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+20
        MOVS     R4,R0
//  211 
//  212   IMU_getValues(mygetqval);	 
        LDR.N    R0,??DataTable5_15
        BL       IMU_getValues
//  213   //将陀螺仪的测量值转成弧度每秒
//  214   //加速度和磁力计保持 ADC值　不需要转换
//  215 IMU_AHRSupdate(mygetqval[3] * M_PI/180, mygetqval[4] * M_PI/180, mygetqval[5] * M_PI/180,
//  216    mygetqval[0], mygetqval[1], mygetqval[2], mygetqval[6], mygetqval[7], mygetqval[8]);
        LDR.N    R0,??DataTable5_15
        LDR      R0,[R0, #+32]
        STR      R0,[SP, #+16]
        LDR.N    R0,??DataTable5_15
        LDR      R0,[R0, #+28]
        STR      R0,[SP, #+12]
        LDR.N    R0,??DataTable5_15
        LDR      R0,[R0, #+24]
        STR      R0,[SP, #+8]
        LDR.N    R0,??DataTable5_15
        LDR      R0,[R0, #+8]
        STR      R0,[SP, #+4]
        LDR.N    R0,??DataTable5_15
        LDR      R0,[R0, #+4]
        STR      R0,[SP, #+0]
        LDR.N    R0,??DataTable5_15
        LDR      R3,[R0, #+0]
        MOVS     R5,R3
        LDR.N    R0,??DataTable5_15
        LDR      R1,[R0, #+20]
        LDR.N    R0,??DataTable5_16  ;; 0x40490fdb
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_17  ;; 0x43340000
        BL       __aeabi_fdiv
        MOVS     R2,R0
        MOVS     R3,R5
        MOVS     R5,R2
        MOVS     R6,R3
        LDR.N    R0,??DataTable5_15
        LDR      R1,[R0, #+16]
        LDR.N    R0,??DataTable5_16  ;; 0x40490fdb
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_17  ;; 0x43340000
        BL       __aeabi_fdiv
        MOVS     R1,R0
        MOVS     R3,R6
        MOVS     R2,R5
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
        LDR.N    R0,??DataTable5_15
        LDR      R1,[R0, #+12]
        LDR.N    R0,??DataTable5_16  ;; 0x40490fdb
        BL       __aeabi_fmul
        LDR.N    R1,??DataTable5_17  ;; 0x43340000
        BL       __aeabi_fdiv
        MOVS     R3,R7
        MOVS     R2,R6
        MOVS     R1,R5
        BL       IMU_AHRSupdate
//  217 
//  218   q[0] = q0; //返回当前值
        LDR.N    R0,??DataTable5_1
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+0]
//  219   q[1] = q1;
        LDR.N    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+4]
//  220   q[2] = q2;
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+8]
//  221   q[3] = q3;
        LDR.N    R0,??DataTable5_4
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+12]
//  222 }
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
//  223 
//  224 
//  225 /**************************实现函数********************************************
//  226 *函数原型:	   void IMU_getYawPitchRoll(float * angles)
//  227 *功　　能:	 更新四元数 返回当前解算后的姿态数据
//  228 输入参数： 将要存放姿态角的数组首地址
//  229 输出参数：没有
//  230 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  231 void IMU_getYawPitchRoll(float * angles) {
IMU_getYawPitchRoll:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+28
        MOVS     R6,R0
//  232   float q[4]; //　四元数
//  233   volatile float gx=0.0, gy=0.0, gz=0.0; //估计重力方向
        MOVS     R0,#+0
        STR      R0,[SP, #+24]
        MOVS     R0,#+0
        STR      R0,[SP, #+20]
        MOVS     R0,#+0
        STR      R0,[SP, #+16]
//  234   IMU_getQ(q); //更新全局四元数
        ADD      R0,SP,#+0
        BL       IMU_getQ
//  235   
//  236   angles[0] = -atan2(2 * q[1] * q[2] + 2 * q[0] * q[3], -2 * q[2]*q[2] - 2 * q[3] * q[3] + 1)* 180/M_PI; // yaw
        LDR      R1,[SP, #+8]
        MOVS     R0,#-1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+8]
        BL       __aeabi_fmul
        MOVS     R4,R0
        LDR      R1,[SP, #+12]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+12]
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOVS     R0,R4
        BL       __aeabi_fsub
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R4,R2
        MOVS     R5,R3
        LDR      R1,[SP, #+4]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+8]
        BL       __aeabi_fmul
        MOVS     R7,R0
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+12]
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       atan2
        EORS     R1,R1,#0x80000000
        MOVS     R2,#+0
        LDR.N    R3,??DataTable5_18  ;; 0x40668000
        BL       __aeabi_dmul
        MOVS     R2,#+1610612736
        LDR.N    R3,??DataTable5_19  ;; 0x400921fb
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        STR      R0,[R6, #+0]
//  237   angles[1] = -asin(-2 * q[1] * q[3] + 2 * q[0] * q[2])* 180/M_PI; // pitch
        LDR      R1,[SP, #+4]
        MOVS     R0,#-1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+12]
        BL       __aeabi_fmul
        MOVS     R4,R0
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+8]
        BL       __aeabi_fmul
        MOVS     R1,R4
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       asin
        EORS     R1,R1,#0x80000000
        MOVS     R2,#+0
        LDR.N    R3,??DataTable5_18  ;; 0x40668000
        BL       __aeabi_dmul
        MOVS     R2,#+1610612736
        LDR.N    R3,??DataTable5_19  ;; 0x400921fb
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        STR      R0,[R6, #+4]
//  238   angles[2] = atan2(2 * q[2] * q[3] + 2 * q[0] * q[1], -2 * q[1] * q[1] - 2 * q[2] * q[2] + 1)* 180/M_PI; // roll
        LDR      R1,[SP, #+4]
        MOVS     R0,#-1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOVS     R4,R0
        LDR      R1,[SP, #+8]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+8]
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOVS     R0,R4
        BL       __aeabi_fsub
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R4,R2
        MOVS     R5,R3
        LDR      R1,[SP, #+8]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+12]
        BL       __aeabi_fmul
        MOVS     R7,R0
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1073741824
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       atan2
        MOVS     R2,#+0
        LDR.N    R3,??DataTable5_18  ;; 0x40668000
        BL       __aeabi_dmul
        MOVS     R2,#+1610612736
        LDR.N    R3,??DataTable5_19  ;; 0x400921fb
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        STR      R0,[R6, #+8]
//  239   //if(angles[0]<0)angles[0]+=360.0f;  //将 -+180度  转成0-360度
//  240 }
        ADD      SP,SP,#+28
        POP      {R4-R7,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x5f3759df

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     q0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     q1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     q2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     q3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     exInt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     eyInt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     ezInt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     lastUpdate

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     now

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     0x42033333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     0x4444444

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     0x49d59f80

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     0x3c23d70a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     mygetqval

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_16:
        DC32     0x40490fdb

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_17:
        DC32     0x43340000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_18:
        DC32     0x40668000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_19:
        DC32     0x400921fb

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  241 
//  242 //------------------End of File----------------------------
// 
//    80 bytes in section .bss
// 2 088 bytes in section .text
// 
// 2 088 bytes of CODE memory
//    80 bytes of DATA memory
//
//Errors: none
//Warnings: 25
