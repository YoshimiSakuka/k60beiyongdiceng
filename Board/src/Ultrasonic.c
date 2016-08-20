#include "Ultrasonic.h"



float DistanceCollect[3];
float DistanceNew;
float DistanceCal[3];
float DistanceConfim;


void Ultra_Init(void)  //右
{
  int i;
  gpio_init (TRIG, GPO, 1);
  for(i=0;i<500;i++);
  gpio_init (TRIG, GPO, 0);
  PORTC_PCR0=PORT_PCR_MUX(1)|PORT_PCR_IRQC(9);
  enable_irq(PORTC_IRQn);
}

void Ultrasonic(void)
{
   
        static uint8 SendFlag = 0;
        static int64 StartTime, FinishTime;
        if(SendFlag==0)
        {
          StartTime=PIT_CVAL1 ;
          SendFlag=1;
          PORTC_PCR0=PORT_PCR_MUX(1)|PORT_PCR_IRQC(10);
        }
        else if(SendFlag==1)
        {
            FinishTime=PIT_CVAL1;
            SendFlag=0;
            PIT_TFLG1 = 1;
            if((StartTime-FinishTime)<0)
            {
              DistanceNew=0.00011*(StartTime-FinishTime+15000000);
            }     
            else if((StartTime-FinishTime)>0)
            DistanceNew=0.00011*(StartTime-FinishTime);
        DistanceCollect[2]=DistanceCollect[1];
        DistanceCollect[1]=DistanceCollect[0];
        DistanceCollect[0]=DistanceNew;  

        DistanceConfim=0.1*DistanceCollect[2]+0.3*DistanceCollect[1]+DistanceCollect[0]*0.6;
        }   
   
  PORTC_PCR0|=PORT_PCR_ISF_MASK;//清除中断标志位



}