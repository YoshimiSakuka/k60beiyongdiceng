/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,ɽ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�ɽ����̳ http://www.vcan123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
 *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
 *
 * @file       main.c
 * @brief      ɽ��K60 ƽ̨������
 * @author     ɽ��Ƽ�
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
  ftm_pwm_init(FTM0, FTM_CH4,10 * 1000, 0);        //�������
  ftm_pwm_init(FTM0, FTM_CH5,10 * 1000, 0);
  ftm_pwm_init(FTM1, FTM_CH0,50, 816);              //�������
  ftm_quad_init(FTM2);                             //��������
  //pit_init(PIT0, 500000);                          //��ʱ5ms���ж�
  //set_vector_handler(PIT0_VECTORn,PIT0_IRQHandler);   
//  while(!nrf_init())                  //��ʼ��NRF24L01+ ,�ȴ���ʼ���ɹ�Ϊֹ
//  {
//      printf("\n  NRF��MCU����ʧ�ܣ������¼����ߡ�\n");
//  }
//   set_vector_handler(PORTE_VECTORn ,PORTE_IRQHandler);    			//���� PORTE ���жϷ�����Ϊ PORTE_VECTORn
//   enable_irq(PORTE_IRQn);
  
 
  //ParmAdjust();
  
  LCD_P6x8Str(0,0,"LDC_Ch0  =");
  LCD_P6x8Str(0,1,"LDC_Ch1  =");
  LCD_P6x8Str(0,2,"LDC_Ch2  =");
  LCD_P6x8Str(0,3,"LDC_Ch3  =");
  LCD_P6x8Str(0,4,"TimeCost =");
  LCD_P6x8Str(0,5,"Distance =");
  

  enable_irq(PIT0_IRQn);                         // ʹ��PIT�ж�
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


