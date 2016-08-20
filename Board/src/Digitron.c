#include "Digitron.h"

int unit,decade,hundred,thousand;


void Digitron_IO_Init(void)
{
    gpio_init(PTC10,GPO,0); // a       
    gpio_init(PTC11,GPO,0); // b
    gpio_init(PTC12,GPO,0); // c
    gpio_init(PTC13,GPO,0); // d
    gpio_init(PTC14,GPO,0); // e
    gpio_init(PTC15,GPO,0); // f
    gpio_init(PTC16,GPO,0); // g
    gpio_init(PTC17,GPO,0); // .
    
    gpio_init(PTC0,GPO,1); // 位选 0位  置0生效  
    gpio_init(PTC1,GPO,1); //      1位
    gpio_init(PTC2,GPO,1); //      2位
    gpio_init(PTC3,GPO,1); //      3位
    

    gpio_init(PTC4,GPO,0); // 段使能
    gpio_init(PTC5,GPO,0); // 位使能
    
}

void Digit_Show(int timecount)
{


  switch(timecount)
  {
    case 0:  ZERO;  break;
    case 1:  ONE;   break;
    case 2:  TWO;   break;
    case 3:  THREE; break;
    case 4:  FOUR;  break;
    case 5:  FIVE;  break;
    case 6:  SIX;   break;
    case 7:  SEVEN; break;
    case 8:  EIGHT; break;
    case 9:  NINE;  break;
    default:        break;
  }  

}

void Digitron_Show(void)
{


    
    if(unit>=0)
    {
      gpio_set (PTC1, 1);
      gpio_set (PTC2, 1);
      gpio_set (PTC3, 1);
      Digit_Show(unit);
      UNIT_SHOW;
      DELAY_MS(1);
    }
    
    if(decade>=0)
    {
      gpio_set (PTC0, 1);
      gpio_set (PTC2, 1);
      gpio_set (PTC3, 1);
      Digit_Show(decade);
      DECADE_SHOW;
      DELAY_MS(1);
     }
    
    if(hundred>=0)
    {
      gpio_set (PTC0, 1);
      gpio_set (PTC1, 1);
      gpio_set (PTC3, 1);
      Digit_Show(hundred);
      HUNDRED_SHOW;
      DELAY_MS(1);
     }

    if(thousand>=0)
    {
      gpio_set (PTC0, 1);
      gpio_set (PTC1, 1);
      gpio_set (PTC2, 1);
      Digit_Show(thousand);
      THOUSAND_SHOW;
      DELAY_MS(1);
     }      
  
  
  
  
    
  
}

