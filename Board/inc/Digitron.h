#ifndef __Digitron_H__
#define __Digitron_H__

#include "include.h"

/**************************************/
/*数码管数字显示                      */
/**************************************/
#define ZERO    GPIO_SET_NBIT(8,PTC10,0x3F)
#define ONE     GPIO_SET_NBIT(8,PTC10,0x06)
#define TWO     GPIO_SET_NBIT(8,PTC10,0x5B)
#define THREE   GPIO_SET_NBIT(8,PTC10,0x4F)
#define FOUR    GPIO_SET_NBIT(8,PTC10,0x66)
#define FIVE    GPIO_SET_NBIT(8,PTC10,0x6D)
#define SIX     GPIO_SET_NBIT(8,PTC10,0x7D)
#define SEVEN   GPIO_SET_NBIT(8,PTC10,0x07)
#define EIGHT   GPIO_SET_NBIT(8,PTC10,0x7F)
#define NINE    GPIO_SET_NBIT(8,PTC10,0x6F)
/**************************************/
/*四位数码管位选                          */
/**************************************/
#define UNIT_SHOW          gpio_set (PTC0, 0)
#define DECADE_SHOW        gpio_set (PTC1, 0)
#define HUNDRED_SHOW       gpio_set (PTC2, 0)
#define THOUSAND_SHOW      gpio_set (PTC3, 0)



void Digit_Show(int timecount);
void Digitron_IO_Init(void);
void Digitron_Show(void);

#endif