#include "SOFTWARE_I2C.h"
#include "MK60_gpio.h"







void IIC_LDC_Start(void)
{
  gpio_set(LDC_SDA,1);
  gpio_set(LDC_SCL,1);
  DELAY_US(500);

  gpio_set(LDC_SDA,0);
  DELAY_US(500);
  gpio_set(LDC_SCL,0);
}
void IIC_LDC_Stop(void)
{
  gpio_set(LDC_SCL,0);
  gpio_set(LDC_SDA,0);
  DELAY_US(500);
  gpio_set(LDC_SCL,1);
  DELAY_US(500);
  gpio_set(LDC_SDA,1);
}
void Send_Ack(void)
{
  gpio_set(LDC_SDA,0);
  DELAY_US(500);
  gpio_set(LDC_SCL,1);
  DELAY_US(500);
  gpio_set(LDC_SCL,0);
  DELAY_US(300);
  gpio_set(LDC_SDA,1);
}
void Send_NoAck(void)
{
  gpio_set(LDC_SDA,1);
  DELAY_US(300);
  gpio_set(LDC_SCL,1);
  DELAY_US(300);
  gpio_set(LDC_SCL,0);
}
uint8 CACK_flag(void)
{
  uint8 ack_flag;
  gpio_set(LDC_SDA,1);
  DELAY_US(300);
  gpio_set(LDC_SCL,1);
  DELAY_US(300);
  gpio_init(LDC_SDA,GPI,1);
  if(gpio_get(LDC_SDA)==0)
  {
    ack_flag=1;
    gpio_init(LDC_SDA,GPO,0);
  }
  else
  {
    ack_flag=0;
    gpio_init(LDC_SDA,GPO,1);
  }
  
  gpio_set(LDC_SCL,0);
  return ack_flag;
}

void IIC_LDC_SendByte(int8 bdata)
{
  unsigned char i=8;
  while(i--)
  {
    gpio_set(LDC_SCL,0);
    DELAY_US(200);
    if((bdata&0x80)==0x80)
      gpio_set(LDC_SDA,1);
    if((bdata&0x80)==0x00)
      gpio_set(LDC_SDA,0);      
    bdata<<=1;
    DELAY_US(300);
    gpio_set(LDC_SCL,1);
    DELAY_US(300);
  }
  gpio_set(LDC_SCL,0);
}
uint8 IIC_LDC_ReceiveByte(void)
{
  uint8 i,data=0;
  gpio_set(LDC_SDA,1);
  for(i=0;i<8;i++)
  {
    data<<=1;
    gpio_set(LDC_SCL,0);
    DELAY_US(300);
    gpio_set(LDC_SCL,1);
    gpio_ddr(LDC_SDA,GPI);
    DELAY_US(300);
    data|=gpio_get(LDC_SDA);
    gpio_ddr(LDC_SDA,GPO);
  }
  gpio_set(LDC_SCL,0);
  return data;
}

uint8 IIC_LDC_write_byte(uint8 cadd,uint8 data_address,uint16 data_byte)
{ 
  uint8 data_byte1,data_byte2;
  data_byte1=(uint8)((data_byte)>>8);
  data_byte2=(uint8)data_byte;
  IIC_LDC_Start();
  IIC_LDC_SendByte((cadd<<1));//xie
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_SendByte(data_address);
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_SendByte(data_byte1);
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_SendByte(data_byte2);
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_Stop();
  return 1;
}

uint16 IIC_LDC_read_byte(uint8 cadd,uint8 data_address)
{
  int temp;
  uint16 temp1,temp2;
  
  IIC_LDC_Start();
  IIC_LDC_SendByte((cadd<<1));//xie
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_SendByte(data_address);
  if(CACK_flag()==0)
  {
    return 0;
  }
  IIC_LDC_Start();
  IIC_LDC_SendByte((cadd<<1)|0x01);//du
  if(CACK_flag()==0)
  {
    return 0;
  }
  temp1=(uint16)IIC_LDC_ReceiveByte();
  Send_Ack();
  temp2=(uint16)IIC_LDC_ReceiveByte();
  Send_NoAck();
  IIC_LDC_Stop();
  temp=(temp1<<8)+temp2;
  //temp=(temp2<<8)+temp1;
  return temp;
}