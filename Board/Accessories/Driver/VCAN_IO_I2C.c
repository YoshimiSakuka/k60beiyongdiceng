/* IOI2C.c file
���ܣ�
�ṩI2C�ӿڲ���API ��
ʹ��IOģ�ⷽʽ
------------------------------------
 */
#include "VCAN_IO_I2C.h"

static void IIC_delay(volatile uint16_t time)
{
    while(time)
    {
        time--;
    }
}
  
/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_Init(void)
*��������:		��ʼ��I2C��Ӧ�Ľӿ����š�
*******************************************************************************/
void IIC_Init(void)
{			
    gpio_init  (PTD8, GPO, 1); //��ʼ��SCL0
    gpio_init  (PTD9, GPO, 1); //��ʼ��SDA0
    port_init_NoALT(PTD8,ODO | PULLUP);
    port_init_NoALT(PTD9,ODO | PULLUP);
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_Start(void)
*��������:		����IIC��ʼ�ź�
*******************************************************************************/
void IIC_Start(void)
{
	SDA_DDR_OUT();     
	SDA_H();	  	  
	SCL_H();
	IIC_DELAY();
 	SDA_L();//START:when CLK is high,DATA change form high to low 
	IIC_DELAY();
	SCL_L();
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_Stop(void)
*��������:	    //����IICֹͣ�ź�
*******************************************************************************/	  
void IIC_Stop(void)
{
	SDA_DDR_OUT();
	SCL_L();
	SDA_L();//STOP:when CLK is high DATA change form low to high
 	IIC_DELAY();
	SCL_H(); 
	SDA_H();
	IIC_DELAY();							   	
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IIC_Wait_Ack(void)
*��������:	    �ȴ�Ӧ���źŵ��� 
//����ֵ��1������Ӧ��ʧ��
//        0������Ӧ��ɹ�
*******************************************************************************/
uint8 IIC_Wait_Ack(void)
{
	uint8 ucErrTime=0;
	SDA_DDR_IN();     
	SDA_H(); IIC_DELAY();	   
	SCL_H(); IIC_DELAY();	 
	while(SDA_IN())
	{
		ucErrTime++;
		if(ucErrTime>50)
		{
			IIC_Stop();
			return 1;
		}
	  IIC_DELAY();
	}
	SCL_L();//����?����?3?0 	   
	return 0;  
} 

/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_Ack(void)
*��������:	    ����ACKӦ��
*******************************************************************************/
void IIC_Ack(void)
{
	SCL_L();
	SDA_DDR_OUT();
	SDA_L();
	IIC_DELAY();
	SCL_H();
	IIC_DELAY();
	SCL_L();
}
	
/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_NAck(void)
*��������:	    ����NACKӦ��
*******************************************************************************/	    
void IIC_NAck(void)
{
	SCL_L();
	SDA_DDR_OUT();
	SDA_H();
	IIC_DELAY();
	SCL_H();
	IIC_DELAY();
	SCL_L();
}					 				     

/**************************ʵ�ֺ���********************************************
*����ԭ��:		void IIC_Send_Byte(u8 txd)
*��������:	    IIC����һ���ֽ�
*******************************************************************************/		  
void IIC_Send_Byte(uint8 txd)
{                        
    uint8 t=8;   
    SDA_DDR_OUT(); 	    
    SCL_L();
    while(t--)
    {
        if(txd&0x80)
        {
            SDA_H();
        }
        else
        {
            SDA_L();
        }
        txd<<=1; 
        IIC_DELAY();   
	SCL_H();
	IIC_DELAY(); 
	SCL_L();	
	//IIC_delay();
    }
} 	 
   
/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IIC_Read_Byte(unsigned char ack)
*��������:	    //��1���ֽڣ�ack=1ʱ������ACK��ack=0������nACK 
*******************************************************************************/ 
uint8 IIC_Read_Byte(unsigned char ack)
{
    unsigned char i,receive=0;
    SDA_DDR_IN();
    for(i=0;i<8;i++ )
    {
        SCL_L(); 
        IIC_DELAY();
	SCL_H();
        receive<<=1;
        if(SDA_IN())receive++;   
	IIC_DELAY(); 
    }					 
    if (ack)
        IIC_Ack(); 
    else
        IIC_NAck();
    return receive;
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		unsigned char I2C_ReadOneByte(unsigned char I2C_Addr,unsigned char addr)
*��������:	    ��ȡָ���豸 ָ���Ĵ�����һ��ֵ
����	I2C_Addr  Ŀ���豸��ַ
		addr	   �Ĵ�����ַ
����   ��������ֵ
*******************************************************************************/ 
unsigned char I2C_ReadOneByte(unsigned char I2C_Addr,unsigned char addr)
{
	unsigned char res=0;
	
	IIC_Start();	
	IIC_Send_Byte(I2C_Addr);	   
	res++;
	IIC_Wait_Ack();
	IIC_Send_Byte(addr); res++;  
	IIC_Wait_Ack();	  
	//IIC_Stop();
	IIC_Start();
	IIC_Send_Byte(I2C_Addr+1); res++; 	   
	IIC_Wait_Ack();
	res=IIC_Read_Byte(0);	   
    IIC_Stop();

	return res;
}


/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IICreadBytes(u8 dev, u8 reg, u8 length, u8 *data)
*��������:	    ��ȡָ���豸 ָ���Ĵ����� length��ֵ
����	dev  Ŀ���豸��ַ
		reg	  �Ĵ�����ַ
		length Ҫ�����ֽ���
		*data  ���������ݽ�Ҫ��ŵ�ָ��
����   ���������ֽ�����
*******************************************************************************/
uint8 IICreadBytes(uint8 dev, uint8 reg, uint8 length, uint8 *data){
    uint8 count = 0;
	
	IIC_Start();
	IIC_Send_Byte(dev);	   
	IIC_Wait_Ack();
	IIC_Send_Byte(reg);   
    IIC_Wait_Ack();	  
	IIC_Start();
	IIC_Send_Byte(dev+1);  
	IIC_Wait_Ack();
	
    for(count=0;count<length;count++){
		 
		 if(count!=length-1)data[count]=IIC_Read_Byte(1);  
		 	else  data[count]=IIC_Read_Byte(0);	 
	}
    IIC_Stop();
    return count;
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IICwriteBytes(u8 dev, u8 reg, u8 length, u8* data)
*��������:	    ������ֽ�д��ָ���豸 ָ���Ĵ���
����	dev  Ŀ���豸��ַ
		reg	  �Ĵ�����ַ
		length Ҫд���ֽ���
		*data  ��Ҫд�����ݵ��׵�ַ
����   �����Ƿ�ɹ�
*******************************************************************************/ 
uint8 IICwriteBytes(uint8 dev, uint8 reg, uint8 length, uint8* data){
  
 	uint8 count = 0;
	IIC_Start();
	IIC_Send_Byte(dev);	   
	IIC_Wait_Ack();
	IIC_Send_Byte(reg);   
    IIC_Wait_Ack();	  
	for(count=0;count<length;count++){
		IIC_Send_Byte(data[count]); 
		IIC_Wait_Ack(); 
	 }
	IIC_Stop();

    return 1; //status == 0;
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IICreadByte(u8 dev, u8 reg, u8 *data)
*��������:	    ��ȡָ���豸 ָ���Ĵ�����һ��ֵ
����	dev  Ŀ���豸��ַ
		reg	   �Ĵ�����ַ
		*data  ���������ݽ�Ҫ��ŵĵ�ַ
����   1
*******************************************************************************/
uint8 IICreadByte(uint8 dev, uint8 reg, uint8 *data){
	*data=I2C_ReadOneByte(dev, reg);
    return 1;
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		unsigned char IICwriteByte(unsigned char dev, unsigned char reg, unsigned char data)
*��������:	    д��ָ���豸 ָ���Ĵ���һ���ֽ�
����	dev  Ŀ���豸��ַ
		reg	   �Ĵ�����ַ
		data  ��Ҫд����ֽ�
����   1
*******************************************************************************/
unsigned char IICwriteByte(unsigned char dev, unsigned char reg, unsigned char data){
    return IICwriteBytes(dev, reg, 1, &data);
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IICwriteBits(u8 dev,u8 reg,u8 bitStart,u8 length,u8 data)
*��������:	    �� �޸� д ָ���豸 ָ���Ĵ���һ���ֽ� �еĶ��λ
����	dev  Ŀ���豸��ַ
		reg	   �Ĵ�����ַ
		bitStart  Ŀ���ֽڵ���ʼλ
		length   λ����
		data    ��Ÿı�Ŀ���ֽ�λ��ֵ
����   �ɹ� Ϊ1 
 		ʧ��Ϊ0
*******************************************************************************/
uint8 IICwriteBits(uint8 dev,uint8 reg,uint8 bitStart,uint8 length,uint8 data)
{

    uint8 b;
    if (IICreadByte(dev, reg, &b) != 0) {
        uint8 mask = (0xFF << (bitStart + 1)) | 0xFF >> ((8 - bitStart) + length - 1);
        data <<= (8 - length);
        data >>= (7 - bitStart);
        b &= mask;
        b |= data;
        return IICwriteByte(dev, reg, b);
    } else {
        return 0;
    }
}

/**************************ʵ�ֺ���********************************************
*����ԭ��:		u8 IICwriteBit(u8 dev, u8 reg, u8 bitNum, u8 data)
*��������:	    �� �޸� д ָ���豸 ָ���Ĵ���һ���ֽ� �е�1��λ
����	dev  Ŀ���豸��ַ
		reg	   �Ĵ�����ַ
		bitNum  Ҫ�޸�Ŀ���ֽڵ�bitNumλ
		data  Ϊ0 ʱ��Ŀ��λ������0 ���򽫱���λ
����   �ɹ� Ϊ1 
 		ʧ��Ϊ0
*******************************************************************************/ 
uint8 IICwriteBit(uint8 dev, uint8 reg, uint8 bitNum, uint8 data){
    uint8 b;
    IICreadByte(dev, reg, &b);
    b = (data != 0) ? (b | (1 << bitNum)) : (b & ~(1 << bitNum));
    return IICwriteByte(dev, reg, b);
}



/*********************************MS5611 IIC**********************************
**MS5611 IIC Read & Write Functions
**(1) MS5611 Write Data
**(2) MS5611 Read 2 Bytes
**(3) MS5611 Read 3 Bytes
*******************************************************************************/
uint8 ms5611_IICwriteData(uint8 dev, uint8 data)
{
    IIC_Start();
    IIC_Send_Byte(dev);
    IIC_Wait_Ack();
    IIC_Send_Byte(data);
    IIC_Wait_Ack();
    IIC_Stop();
    return 1;
}

uint16 ms5611_IICread2Data(uint8 dev)
{
    uint8 temp1, temp2;
    IIC_Start();
    IIC_Send_Byte(dev+1);
    IIC_Wait_Ack();
    temp1 = IIC_Read_Byte(1);
    temp2 = IIC_Read_Byte(0);
    IIC_Stop();
    return (temp1<<8 | temp2);
}

uint32 ms5611_IICread3Data(uint8 dev)
{
    uint8 temp1, temp2, temp3;
    IIC_Start();
    IIC_Send_Byte(dev+1);
    IIC_Wait_Ack();
    temp1 = IIC_Read_Byte(1);
    temp2 = IIC_Read_Byte(1);
    temp3 = IIC_Read_Byte(0);
    IIC_Stop();
    return (temp1<<16 | temp2 <<8 | temp3);
}
//------------------End of File----------------------------
