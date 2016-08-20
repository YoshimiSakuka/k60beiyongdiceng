#include "LDC1000.h"



uint8 RPMAX = 0x07;
uint8 RPMIN = 0x2F;

uint8 proximtyData[2];
uint8 frequencyData[3];
uint8 orgVal[20] = {0};
int frequencyDataMAX = 0;
uint8 frequencyData[3]={0};
int proximtyDataMAX = 0;
uint8 proximtyData[2]={0};



int LCD1000_ProximtyGet(void)    
{  

   uint32 dat;
   spi_readBytes(LDC1000_CMD_PROXLSB,proximtyData,2);
   
   proximtyDataMAX = ((unsigned char) proximtyData[1]<<8) + proximtyData[0];
   dat = proximtyDataMAX;
   proximtyDataMAX = 0;
   return dat;
}


int LCD1000_FrequencyGet(void)    
{  
   
   uint32 dat;
   spi_readBytes(LDC1000_CMD_FREQCTRLSB,frequencyData,3);
   
   frequencyDataMAX = ((unsigned char)frequencyData[2]<<16) + ((unsigned char)frequencyData[1]<<8) + frequencyData[0];
   dat = frequencyDataMAX;
   frequencyDataMAX = 0;
   return dat;
}


float Rp_Cal(void)
{
   int  Proximity = 0;
   double y = 0.0;
   double RpData;
   Proximity = LCD1000_ProximtyGet();
   y = (double)Proximity / (2<<15);
   RpData = (RPMAX - RPMIN) / ((float)RPMIN * (1 - y)+(float)RPMAX * y);
   return RpData;

}

float Sensor_Cal(uint8 choice) //0为输出数据速率  ，1为电感计算
{

  int Fcount = 0;
  float Ldata = 0;   //输出值
  float Fext = 1000000.0;       //需自行修改
  float RespTime = 0x17;   //需自行修改
  float Cdata = 0.0001;      //需自行修改
  float Fsensor = 0;
  float OutputDataRate = 0;   //输出值
  Fcount = LCD1000_FrequencyGet();
  OutputDataRate = Fext / Fcount;
  Fsensor = (1.0 / 3.0) * OutputDataRate * RespTime; 
  Ldata = 1.0 / (Cdata * (2 * PI * Fsensor));
  if(choice)
  {
    return Ldata;
  }
  else
  { 
    return OutputDataRate;  
  }
}


void IO_SPI_Init(void)
{
         gpio_init (SPI_IO_CS,  GPO,0);
         gpio_init (SPI_IO_SDI, GPO,0);
         gpio_init (SPI_IO_CLK, GPO,0);
         gpio_init (SPI_IO_SDO, GPI,0);


     /*****************TEST*********TEST***************TEST*********/

    //read all REG value using default setting

    //write to register
        spi_writeByte(LDC1000_CMD_RPMAX,       RPMAX);//01
        spi_writeByte(LDC1000_CMD_RPMIN,       RPMIN);//02
	spi_writeByte(LDC1000_CMD_SENSORFREQ,  0x94);//03
	spi_writeByte(LDC1000_CMD_LDCCONFIG,   0x17);//04
	spi_writeByte(LDC1000_CMD_CLKCONFIG,   0x02);//05
	spi_writeByte(LDC1000_CMD_INTCONFIG,   0x02);//0A

	spi_writeByte(LDC1000_CMD_THRESHILSB,  0x50);//06
	spi_writeByte(LDC1000_CMD_THRESHIMSB,  0x14);//07
	spi_writeByte(LDC1000_CMD_THRESLOLSB,  0xC0);//08
	spi_writeByte(LDC1000_CMD_THRESLOMSB,  0x12);//09

	spi_writeByte(LDC1000_CMD_PWRCONFIG,   0x01);//0B

	//read all registers

        spi_readBytes(LDC1000_CMD_REVID, orgVal,12);








}
int8 spi_readBytes( int8 addr, uint8 * buffer, uint8 len)
{
   
    		uint8 dat,i;
                dat=addr|0x80;

		gpio_set(SPI_IO_CS,0);
           
		for  (i=0;i<8;i++)  
		{  
		  gpio_set(SPI_IO_CLK,0);
                 
		  if((dat & 0x80)==0x80)gpio_set(SPI_IO_SDI,1);  
		  else gpio_set(SPI_IO_SDI,0);
            
		  gpio_set(SPI_IO_CLK,1);
              
		  dat=(dat<<1);  
		 } 
		while (len > 0) 
		{
		    dat=0;
		    DELAY_MS(1);
		    *buffer=spi_read();
		    buffer++;
		    len--;
		}
		gpio_set(SPI_IO_CS,1);
    
    return 0;
}
int8 spi_writeByte(int8 addr, int8 data)
{
		uint8 dat,i;
                dat=addr&0x7f;

		gpio_set(SPI_IO_CS,0);
		for  (i=0;i<8;i++)  
		{  
		  gpio_set(SPI_IO_CLK,0);    
             
		  if((dat & 0x80)==0x80)gpio_set(SPI_IO_SDI,1);  
		  else gpio_set(SPI_IO_SDI,0);
        
			gpio_set(SPI_IO_CLK,1);
     
		  dat=(dat<<1);  
		 }  
		for  (i=0;i<8;i++)  
		 {  
		  gpio_set(SPI_IO_CLK,0);
           
		  if((data & 0x80)==0x80)gpio_set(SPI_IO_SDI,1);  
		  else gpio_set(SPI_IO_SDI,0);
        
		  gpio_set(SPI_IO_CLK,1);
   
		  data=(data<<1);  
		 }  
		gpio_set(SPI_IO_CS,1);

		return 0;
}


/*******************************
    向SPI器件写入一个字节数据
*******************************/
void spi_write(uint8 spi_dat)  
{  
 unsigned  char  i;  
 gpio_set(SPI_IO_CS,0);

 for  (i=0;i<8;i++)  
 {  
  gpio_set(SPI_IO_CLK,0);

  if((spi_dat & 0x80)==0x80)gpio_set(SPI_IO_SDI,1);  
  else gpio_set(SPI_IO_SDI,0);

  gpio_set(SPI_IO_CLK,1);

  spi_dat=(spi_dat<<1);  
 }  
 gpio_set(SPI_IO_CS,1);
}  
/********************************
  从SPI器件读出一个字节数据
********************************/
uint8 spi_read(void)  
{  
 uint8 i,spi_dat;  

   for (i=0;i<8;i++)  
 {                                  
    gpio_set(SPI_IO_CLK,0);

    spi_dat=(spi_dat<<1);  
    gpio_set(SPI_IO_CLK,1);

    if(gpio_get(SPI_IO_SDO)==1)spi_dat|=0x01;  
    else spi_dat&=~0x01;

 }  

 return spi_dat;  
}
