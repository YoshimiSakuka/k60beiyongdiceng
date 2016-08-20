/*2014/6/12
  k60 oled驱动 by Mx
*/




#include "include.h"
#include "MK60_gpio.h"
#include "VCAN_OLED.h"
#include "codetab.h"

//******************************
//功能说明：LCD写数据
//参数说明：dat 写入八位数据
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************

void LCD_WrDat(uint8 dat)
{
	uint8 i;
	SET_DC_H;
        SET_SCL_L;   //自己加的
	for(i=0;i<8;i++)
	{
		if((dat << i) & 0x80)
			SET_SDA_H;
		else
			SET_SDA_L;
		SET_SCL_H;   //修改过，H与L互换位置
		SET_SCL_L;
	}
}



//******************************
//功能说明：LCD写命令
//参数说明：dat 写入八位数据
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************

void LCD_WrCmd(uint8 cmd)
{
	uint8 i;
	SET_DC_L;
        SET_SCL_L;          //自己加的
	for(i=0;i<8;i++)
	{
		if((cmd << i) & 0x80)
			SET_SDA_H;
		else
			SET_SDA_L;
		SET_SCL_H;     //互换过位置
		SET_SCL_L;
	}
}


//******************************
//功能说明：LCD 设置坐标
//参数说明：x  0~128
//          y  0~64
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************

void LCD_Set_Pos(uint8 x, uint8 y)
{
	LCD_WrCmd(0xb0 + y);
	LCD_WrCmd(((x&0xf0)>>4)|0x10);
	LCD_WrCmd((x&0x0f)|0x01);
    
}

//******************************
//功能说明：LCD 全屏
//参数说明：
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************

void LCD_Fill(uint8 bmp_dat)
{
	uint8 y,x;
	for(y=0;y<8;y++)
	{
		LCD_WrCmd(0xb0+y);
		LCD_WrCmd(0x01);
		LCD_WrCmd(0x10);
		for(x=0;x<X_WIDTH;x++)
			LCD_WrDat(bmp_dat);
	}
}

//******************************
//功能说明：LCD 复位
//参数说明：无
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************

void LCD_CLS(void)
{
	uint8 y,x;
	for(y=0;y<8;y++)
	{
		LCD_WrCmd(0xb0+y);
		LCD_WrCmd(0x01);
		LCD_WrCmd(0x10);
		for(x=0;x<X_WIDTH;x++)
			LCD_WrDat(0);
	}
}

//******************************
//功能说明：LCD 初始化
//参数说明：无
//函数返回：无
//修改时间：2014/6/12
//备注：无
//******************************
void LCD_Init(void)     
{  
    gpio_init (RST_PIN, GPO,0);
    gpio_init (DC_PIN , GPO,0);
    gpio_init (SCL_PIN, GPO,0);
    gpio_init (SDA_PIN, GPO,0);

    SET_SCL_H;
    SET_RST_L;
    DELAY_MS(50);
    SET_RST_H;          //从上电到下面开始初始化要有足够的时间，即等待RC复位完毕   
    LCD_WrCmd(0xae);//--turn off oled panel
    LCD_WrCmd(0x00);//---set low column address
    LCD_WrCmd(0x10);//---set high column address
    LCD_WrCmd(0x40);//--set start line address  Set Mapping RAM Display Start Line (0x00~0x3F)
    LCD_WrCmd(0x81);//--set contrast control register
    LCD_WrCmd(0xcf); // Set SEG Output Current Brightness
    LCD_WrCmd(0xa1);//--Set SEG/Column Mapping     0xa0左右反置 0xa1正常
    LCD_WrCmd(0xc8);//Set COM/Row Scan Direction   0xc0上下反置 0xc8正常
    LCD_WrCmd(0xa6);//--set normal display
    LCD_WrCmd(0xa8);//--set multiplex ratio(1 to 64)
    LCD_WrCmd(0x3f);//--1/64 duty
    LCD_WrCmd(0xd3);//-set display offset	Shift Mapping RAM Counter (0x00~0x3F)
    LCD_WrCmd(0x00);//-not offset
    LCD_WrCmd(0xd5);//--set display clock divide ratio/oscillator frequency
    LCD_WrCmd(0x80);//--set divide ratio, Set Clock as 100 Frames/Sec
    LCD_WrCmd(0xd9);//--set pre-charge period
    LCD_WrCmd(0xf1);//Set Pre-Charge as 15 Clocks & Discharge as 1 Clock
    LCD_WrCmd(0xda);//--set com pins hardware configuration
    LCD_WrCmd(0x12);
    LCD_WrCmd(0xdb);//--set vcomh
    LCD_WrCmd(0x40);//Set VCOM Deselect Level
    LCD_WrCmd(0x20);//-Set Page Addressing Mode (0x00/0x01/0x02)
    LCD_WrCmd(0x02);//
    LCD_WrCmd(0x8d);//--set Charge Pump enable/disable
    LCD_WrCmd(0x14);//--set(0x10) disable
    LCD_WrCmd(0xa4);// Disable Entire Display On (0xa4/0xa5)
    LCD_WrCmd(0xa6);// Disable Inverse Display On (0xa6/a7) 
    LCD_WrCmd(0xaf);//--turn on oled panel
    LCD_Fill(0x00);  //初始清屏
    LCD_Set_Pos(0,0); 	
} 
//******************************
//函数名： void LCD_PutPixel(byte x,byte y)
//功能描述：绘制一个点（x,y）
//参数说明：真实坐标值(x,y),x的范围0～127，y的范围0～64
//函数返回：无
//******************************
void LCD_PutPixel(uint8 x,uint8 y)
{
	uint8 data1;  //data1当前点的数据 
	 
  LCD_Set_Pos(x,y); 
	data1 = 0x01<<(y%8); 	
	LCD_WrCmd(0xb0+(y>>3));
	LCD_WrCmd(((x&0xf0)>>4)|0x10);
	LCD_WrCmd((x&0x0f)|0x00);
	LCD_WrDat(data1); 	 	
}
//******************************
//函数名： void LCD_Rectangle(uint8 x1,uint8 y1,uint8 x2,byte y2,byte color,byte gif)
//功能描述：绘制一个实心矩形
//参数说明：左上角坐标（x1,y1）,右下角坐标（x2，y2）,其中x1、x2的范围0～127，y1，y2的范围0～63，即真实坐标值
//函数返回：无
//******************************
void LCD_Rectangle(uint8 x1,uint8 y1,uint8 x2,uint8 y2,uint8 gif)
{
	uint8 n; 
		
	LCD_Set_Pos(x1,y1>>3);
	for(n=x1;n<=x2;n++)
	{
		LCD_WrDat(0x01<<(y1%8)); 			
		if(gif == 1) 	DELAY_MS(50);
	}  
	LCD_Set_Pos(x1,y2>>3);
  for(n=x1;n<=x2;n++)
	{
		LCD_WrDat(0x01<<(y2%8)); 			
		if(gif == 1) 	DELAY_MS(5);
	}
	
}  
//******************************
//功能说明：显示6*8一组标准ASCII字符串
//参数说明：显示的坐标（x,y），y为页范围0～7
//函数返回：无
//修改时间：2014/6/21
//备注：无
//******************************

void LCD_P6x8Str(uint8 x,uint8 y, uint8 ch[])
{
	uint8 c = 0, i = 0, j = 0;
	while(ch[j]!='\0')
	{
		c = ch[j] - 32;
		if(x > 126)
		{
			x = 0;
			y++;
		}
		LCD_Set_Pos(x, y);
		for(i = 0;i < 6;i++)
		{
			LCD_WrDat(F6x8[c][i]);
		}
		x+=6;
		j++;
	}
}

//******************************
//功能说明：显示8*16一组标准ASCII字符串
//参数说明：显示的坐标（x,y），y为页范围0～7
//函数返回：无
//修改时间：2014/6/21
//备注：无
//******************************
void LCD_P8x16Str(uint8 x,uint8 y, uint8 ch[])
{
	uint8 c = 0, i = 0, j = 0;
	while(ch[j]!='\0')
	{
		c = ch[j] - 32;
		if(x > 126)
		{
			x = 0;
			y++;
		}
		LCD_Set_Pos(x, y);
		for(i = 0;i < 8;i++)
		{
			LCD_WrDat(F8x16[i+c*16]);
		}
		LCD_Set_Pos(x,y+1); 
		for(i = 0;i < 8;i++)
		{
			LCD_WrDat(F8x16[i+8+c*16]);
		}
		x+=8;
		j++;
	}
}

//******************************
//功能说明：显示16*16点阵
//参数说明：显示的坐标（x,y），y为页范围0～7
//函数返回：无
//修改时间：2014/6/21
//备注：无
//******************************
void LCD_P16x16Ch(uint8 x, uint8 y, uint8 N)
{
	uint8 wm = 0;
	uint16 adder = 32*N;
	LCD_Set_Pos(x, y);
	for(wm = 0;wm < 16;wm++)
	{
		LCD_WrDat(F16x16[adder]);
		adder+=1;
	}
	LCD_Set_Pos(x, y+1);
	for(wm = 0;wm < 16;wm++)
	{
		LCD_WrDat(F16x16[adder]);
		adder+=1;
	}
}
//******************************
//功能说明：显示显示BMP图片128×64起始点坐标(x,y)
//参数说明：显示的坐标（x,y），y为页范围0～7
//函数返回：无
//修改时间：2014/6/21
//备注：无
//******************************
void Draw_BMP(uint8 x0, uint8 y0,uint8 x1,uint8 y1,uint8 BMP[])
{
	uint16 j = 0;
	uint8 x, y;
	if(y1%8 == 0)
		y = y1/8;
	else
		y = y1/8 + 1;
	for(y = y0;y < y1;y++)
	{
		LCD_Set_Pos(x0, y);
		for(x = x0;x < x1;x++)
			LCD_WrDat(BMP[j++]);
	}
}










uint8 str[80];
int LCD_Flag;
void ParmAdjust(void)
{
  LCD_P8x16Str(0,0,"    HEU-FLASH   ");


 while(1)
 {
  if(!gpio_get(PTA27))       //上
  {
   LCD_Flag++;
   DELAY_MS(200);
  }
  if(!gpio_get(PTA25))       //下
  {
   LCD_Flag--;
   DELAY_MS(200);
  }
  if(LCD_Flag > 4)
  {
   LCD_Flag = 0;
  }
  if(LCD_Flag < 0)
  {
   LCD_Flag = 4;
  }
  
   switch(LCD_Flag)
   {
	case 0:{LCD_P6x8Str(82,3,"=");
	        LCD_P6x8Str(82,4," ");
                LCD_P6x8Str(82,5," ");
                LCD_P6x8Str(82,6," ");
                LCD_P6x8Str(82,7," ");
                
	        break;}
        case 1:{LCD_P6x8Str(82,3," ");
	        LCD_P6x8Str(82,4,"=");
                LCD_P6x8Str(82,5," ");
                LCD_P6x8Str(82,6," ");
                LCD_P6x8Str(82,7," "); 
	        break;}
        case 2:{LCD_P6x8Str(82,3," ");
	        LCD_P6x8Str(82,4," ");
                LCD_P6x8Str(82,5,"=");
                LCD_P6x8Str(82,6," ");
                LCD_P6x8Str(82,7," "); 
	        break;}
        case 3:{LCD_P6x8Str(82,3," ");
	        LCD_P6x8Str(82,4," ");
                LCD_P6x8Str(82,5," ");
                LCD_P6x8Str(82,6,"=");
                LCD_P6x8Str(82,7," "); 
	        break;}
        case 4:{LCD_P6x8Str(82,3," ");
	        LCD_P6x8Str(82,4," ");
                LCD_P6x8Str(82,5," ");
                LCD_P6x8Str(82,6," ");
                LCD_P6x8Str(82,7,"="); 
                break;}
        default:break;
   }
   
   if(!gpio_get(PTD0))
   {
	DELAY_MS(200);
	switch(LCD_Flag)
	{
	 case 0: SpeedWant += 10;break;
	 case 2: Speed_Kp   += 1 ; break;
	 case 3: Speed_Ki   += 1 ; break;
         case 4: Speed_Kd   += 1 ; break;
	 default:  break;
	}
   }
   if(!gpio_get(PTA24))
   {
	DELAY_MS(200);
	switch(LCD_Flag)
	{
	 case 0: SpeedWant -= 10;break;
	 case 2: Speed_Kp   -= 1 ; break;
	 case 3: Speed_Ki   -= 1 ; break;
         case 4: Speed_Kd   -= 1 ; break;         
         default:  break;
	}
   }
   LCD_P6x8Str(0,3,"SpeedWant ");

   LCD_P6x8Str(0,5,"Speed_Kp");
   LCD_P6x8Str(0,6,"Speed_Ki");
   LCD_P6x8Str(0,7,"Speed_Kd");
   
   sprintf(str,"%6d",SpeedWant);
   LCD_P6x8Str(90,3,str);

   sprintf(str,"%6d",(long)Speed_Kp);
   LCD_P6x8Str(90,5,str);
   sprintf(str,"%6d",(long)Speed_Ki);
   LCD_P6x8Str(90,6,str);
   sprintf(str,"%6d",(long)Speed_Kd);
   LCD_P6x8Str(90,7,str);
   
  if(!gpio_get(PTA26))
  {
    LCD_CLS();
    DELAY_MS(500);
    //FlashSetPara();
    break;
  }
  
  
 
 }

}

