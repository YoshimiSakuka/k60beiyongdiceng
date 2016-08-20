/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,山外科技
 *     All rights reserved.
 *     技术讨论：山外论坛 http://www.vcan123.com
 *
 *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
 *     修改内容时必须保留山外科技的版权声明。
 *
 * @file       main.c
 * @brief      山外K60 平台主程序
 * @author     山外科技
 * @version    v5.0
 * @date       2013-08-28
 */

#include "common.h"
#include "include.h"


void PORTE_IRQHandler(void);
void PIT0_IRQHandler(void);
_Bool Roadflag;
uint16 LDC_Read[4] = {0};
uint16 test,test1,test2;
int Speed_Cnt;
int SpeedSingle;
int motor;
int MotorRun;
uint8 Pit0_cnt;
int testcnt;
uint8 SpeedFlag;
void main(void)
{
  LDC1314_Init();
  Common_Key();
  FiveDir_Key_Init();
  LCD_Init();
  ftm_pwm_init(FTM0, FTM_CH4,10 * 1000, 0);        //电机驱动
  ftm_pwm_init(FTM0, FTM_CH5,10 * 1000, 0);
  ftm_pwm_init(FTM1, FTM_CH0,50, 816);              //舵机驱动
  ftm_quad_init(FTM2);                             //正交解码
  //pit_init(PIT0, 500000);                          //定时5ms后中断
  //set_vector_handler(PIT0_VECTORn,PIT0_IRQHandler);   
//  while(!nrf_init())                  //初始化NRF24L01+ ,等待初始化成功为止
//  {
//      printf("\n  NRF与MCU连接失败，请重新检查接线。\n");
//  }
//   set_vector_handler(PORTE_VECTORn ,PORTE_IRQHandler);    			//设置 PORTE 的中断服务函数为 PORTE_VECTORn
//   enable_irq(PORTE_IRQn);
  
 
  //ParmAdjust();
  
  LCD_P6x8Str(0,0,"LDC_Ch0  =");
  LCD_P6x8Str(0,1,"LDC_Ch1  =");
  LCD_P6x8Str(0,2,"LDC_Ch2  =");
  LCD_P6x8Str(0,3,"LDC_Ch3  =");
  LCD_P6x8Str(0,4,"TimeCost =");
  LCD_P6x8Str(0,5,"Distance =");
  

  enable_irq(PIT0_IRQn);                         // 使能PIT中断
  while(1)
  {

      sprintf(str,"%5d",(int)LDC_Read[0]);
      LCD_P6x8Str(80,0,str);
      sprintf(str,"%5d",(int)LDC_Read[1]);
      LCD_P6x8Str(80,1,str);
      sprintf(str,"%5d",(int)LDC_Read[2]);
      LCD_P6x8Str(80,2,str);
      sprintf(str,"%5d",(int)LDC_Read[3]);
      LCD_P6x8Str(80,3,str);      
      DELAY_MS(200);
      
      

    }
    
    
    
    
   
  

   
}


