#include "LDC1314.h"
#include "MK60_gpio.h"
#include "SOFTWARE_I2C.h"



int SpeedWant;

int Speed_Kp; 
int Speed_Ki; 
int Speed_Kd; 


void LDC1314_Init(void)                    //地址0x1d
{
    gpio_init(LDC_SCL, GPO, 1);                                  
    gpio_init(LDC_SDA, GPO, 1);
    IIC_LDC_write_byte(LDC1314_ADDR, RESET_DEV, 0x0200);//1000 0110 0000 0000    8600   16倍增益
                                                              //10               8400   8倍增益         
                                                              //01               8200   4倍增益
                                                              //00               8000   1倍(不)增益    
    IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH0, 0x04D6);//0000 0100 1101 0110
    IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH1, 0x04D6);//通道参考计数转换间隔时间 0x0005~0xffff有效
    IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH2, 0x04D6);//转换时间 = RCOUNT_CHx * 16/fREFx
    IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH3, 0x04D6);
    IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH0, 0x000A);//0000 0000 0000 1010  
    IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH1, 0x000A);//通道转换稳定时间，LDC使用这个稳定时间在初始化通道0的转换开始之前来让LC传感器稳定。
    IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH2, 0x000A);//0000 0000 0000 0000:稳定时间(tsx) = 32 / fREFx
    IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH3, 0x000A);//b0000 0000 0000 0010~b1111 1111 1111 1111:稳定时间(tsx) = (CH0_SETTLECOUNT * 16) / fREF0
    
    IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH0, 0x1002);//0001 0000 0000 0010
    IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH1, 0x1002);//CH0_FIN_DIVIDER通道输入分频fin   CHx_FREF_DIVIDER通道参考分频fREF
    IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH2, 0x1002);//CHx_FIN_DIVIDER ≥ b0001: finx=fSENSOR0/CH0_FIN_DIVIDER   finx = fSENSOR0 / 1
    IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH3, 0x1002);//CHx_FREF_DIVIDER ≥ b00’0000’0001:  fREFx = fCLK/CHx_FREF_DIVIDER  fREFx = fCLK / 2
    
    IIC_LDC_write_byte(LDC1314_ADDR, ERROR_CONFIG, 0x0000);//0000 0000 0000 0000  
    IIC_LDC_write_byte(LDC1314_ADDR, MUX_CONFIG, 0xC20D);//0xA20F);//0xA20C);  1100 0010 0000 1101 多通道模式，四通道，33MHz
    
    IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH0, 0x9000);//1001 0000 0000 0000   驱动电流大小
    IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH1, 0x9000);  
    IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH2, 0x9000);  
    IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH3, 0x9000);  
    
    IIC_LDC_write_byte(LDC1314_ADDR, CONFIG, 0x1601);//0xD681); //1101 0110 1000 0001

}


void LDC1314_CH_Read(uint16 *LDCstr)
{

      LDCstr[0]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH0)&0x0FFF;
      LDCstr[1]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH1)&0x0FFF;
      LDCstr[2]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH2)&0x0FFF;
      LDCstr[3]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH3)&0x0FFF; 

}
void LDC1314_Run(void)
{
  




}


int Speed_Control(int Speed_Test)    //速度PID
{
    int Speed_Set_R = 0;
    static int SpeedDev[4] = {0};
    static int SpeedInt = 0;
    static int SpeedUp, SpeedUi, SpeedUd;
    SpeedDev[3] = SpeedDev[2];
    SpeedDev[2] = SpeedDev[1];
    SpeedDev[1] = SpeedDev[0];

    SpeedDev[0] = SpeedWant-Speed_Test;

    SpeedDev[0] = SpeedDev[0]>500?500:(SpeedDev[0]<-500?-500:SpeedDev[0]);

    SpeedInt += SpeedDev[0];
    SpeedInt =  SpeedInt>10000?10000:(SpeedInt<-10000?-10000:SpeedInt);
    
    SpeedUp = (int)(Speed_Kp * SpeedDev[0]);
    SpeedUi = (int)(Speed_Ki * SpeedInt/10);
    SpeedUd = (int)(Speed_Kd * (SpeedDev[0]-SpeedDev[1]));
 
    Speed_Set_R = SpeedUp + SpeedUi + SpeedUd;

    return Speed_Set_R;
}


int QUADRead(void)                    //0为右1为左  5.3凌晨改动
{
 uint8 direction;
 int speed;
  direction = (FTM2_QDCTRL & FTM_QDCTRL_QUADIR_MASK) >> FTM_QDCTRL_QUADIR_SHIFT;//正负标志
  if(direction)
  {
   speed = -(int)FTM2_CNT;                  //改   计数递增 到顶部溢出 负值 反转？
   
  }
  else
  {
   speed = 10000 - (int)FTM2_CNT;    //计数递减 到底部溢出 正值 正转？ 
   
  }
  FTM2_CNT = 0;
 
 
 if(speed < -10000)    speed = 0;
 if(speed > 10000)     speed = 0;
 return speed;
}

void MotorControl(int data)
{
   if(data > 0)
   {
    if(data > 4999)
     data = 4999;

    FTM0_C4V = 0;
    FTM0_C5V = data;      //左轮正转
    
   }
   else if(data < 0)
   {
    
    if(data < -4999)
     data = -4999;

    FTM0_C5V = 0;
    FTM0_C4V = -1 * data;  //左轮反转
    
   }
   else if(data == 0)
   {
    FTM0_C7V = 0;
    FTM0_C6V = 0;
   }
}