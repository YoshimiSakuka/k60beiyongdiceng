#ifndef __SOFTWARE_I2C_H__
#define __SOFTWARE_I2C_H__
#include "common.h"


#define LDC_SCL   PTC0
#define LDC_SDA   PTC1

extern void IIC_LDC_Start(void);
extern void IIC_LDC_Stop(void);
extern void Send_Ack(void);
extern void Send_NoAck(void);
extern uint8 CACK_flag(void);
extern void IIC_LDC_SendByte(int8 bdata);
extern uint8 IIC_LDC_ReceiveByte(void);
extern uint8 IIC_LDC_write_byte(uint8 cadd,uint8 data_address,uint16 data_byte);
extern uint16 IIC_LDC_read_byte(uint8 cadd,uint8 data_address);




#endif