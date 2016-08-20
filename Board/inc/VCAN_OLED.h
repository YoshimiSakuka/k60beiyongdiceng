/*2014/6/12
  k60 oled驱动 by Mx
*/
  #ifndef  _OLED_H
  #define _OLED_H


  #include "common.h"

//引脚配置


  #define     RST_PIN       PTB8          
  #define     DC_PIN        PTB9          
  #define     SCL_PIN       PTA28         
  #define     SDA_PIN       PTA29  

  #define     SET_DC_H      gpio_set(DC_PIN  , 1)   //PTE0
  #define     SET_DC_L      gpio_set(DC_PIN  , 0)

  #define     SET_RST_H     gpio_set(RST_PIN , 1)   //PTE1
  #define     SET_RST_L     gpio_set(RST_PIN , 0)

  #define     SET_SDA_H     gpio_set(SDA_PIN , 1)   //PTE2
  #define     SET_SDA_L     gpio_set(SDA_PIN , 0)

  #define     SET_SCL_H     gpio_set(SCL_PIN , 1)   //PTE3
  #define     SET_SCL_L     gpio_set(SCL_PIN , 0)

       


  #define XLevelL		    0x00
  #define XLevelH		    0x10
  #define XLevel	            ((XLevelH&0x0F)*16+XLevelL)
  #define Max_Column	            128
  #define Max_Row		    64
  #define Brightness	            0xCF 
  #define X_WIDTH                   128
  #define Y_WIDTH                   64

  #define GPIO_PIN(x)               (((1)<<(x & GPIO_PIN_MASK)))
  extern uint8 str[80];
  void LCD_WrDat(uint8 dat);                                     //LCD写数据
  void LCD_WrCmd(uint8 cmd);                                     //LCD写命令
  void LCD_Set_Pos(uint8 x, uint8 y);                            //LCD设置坐标
  void LCD_Fill(uint8 bmp_dat);                                  //LCD全屏
  void LCD_CLS(void);                                            //LCD复位
  void LCD_Init(void);                                           //LCD初始化 
  void LCD_P6x8Str(uint8 x,uint8 y,uint8 ch[]);                  //显示6*8一组标准ASCII字符串	显示的坐标（x,y），y为页范围0～7
  void LCD_P8x16Str(uint8 x,uint8 y,uint8 ch[]);                 //显示8*16一组标准ASCII字符串	 显示的坐标（x,y），y为页范围0～7
  void LCD_P16x16Ch(uint8 x,uint8 y,uint8 N);                    //显示16*16点阵  显示的坐标（x,y），y为页范围0～7
  void Draw_BMP(uint8 x0,uint8 y0,uint8 x1,uint8 y1,uint8 BMP[]);//显示显示BMP图片128×64起始点坐标(x,y),x的范围0～127，y为页的范围0～7
  void LCD_PutPixel(uint8 x,uint8 y);                                  //绘制一个点（x,y）真实坐标值(x,y),x的范围0～127，y的范围0～64
  void LCD_Rectangle(uint8 x1,uint8 y1,uint8 x2,uint8 y2,uint8 gif);            //绘制一个实心矩形左上角坐标（x1,y1）,右下角坐标（x2，y2）,其中x1、x2的范围0～127，y1，y2的范围0～63，即真实坐标值
  
  
  
  void ParmAdjust(void);





  #endif