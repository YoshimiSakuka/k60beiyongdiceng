///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:10
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_ILI9341.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_ILI9341.c
//        -D DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\
//        -lB
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\ -o
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\Obj\
//        --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa
//        --no_clustering --no_scheduling --debug --endian=little
//        --cpu=Cortex-M4 -e --fpu=None --dlib_config "E:\IAR for
//        ARM\arm\INC\c\DLib_Config_Full.h" -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\App\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\App\Inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\ -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\IAR\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Chip\inc\kinetis\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\CMSIS\Inc\
//        -I D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\FatFs\
//        -I D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Lib\USB\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\MPU6050\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\IMU\
//        -I
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\..\..\Board\Accessories\Driver\
//        -On
//    List file    =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_LCD_ILI9341.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN flexbus_8080_init
        EXTERN gpio_init
        EXTERN systick_delay_ms

        PUBLIC ILI9341_get_dir
        PUBLIC ILI9341_get_h
        PUBLIC ILI9341_get_w
        PUBLIC LCD_ILI9341_dir
        PUBLIC LCD_ILI9341_init
        PUBLIC LCD_ILI9341_ptlon
        PUBLIC ili9341_dir
        PUBLIC ili9341_h
        PUBLIC ili9341_w

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_ILI9341.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       VCAN_LCD_ILI9341.c
//   11  * @brief      LCD ILI9341函数库
//   12  * @author     山外科技
//   13  * @version    v5.1
//   14  * @date       2014-02-03
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_gpio.h"
//   19 #include "VCAN_LCD_ILI9341.h"
//   20 
//   21 
//   22 
//   23 #if (USE_LCD == LCD_ILI9341)
//   24 
//   25 //定义所用到的 IO管脚
//   26 #define LCD_RST    PTC13                //复位
//   27 #define LCD_BL     PTB8                 //背光
//   28 
//   29 
//   30 #define ILI9341_DELAY()          DELAY_MS(100)
//   31 #define ILI9341_DELAYMS(ms)      DELAY_MS(ms)
//   32 
//   33 
//   34 #define ILI9341_H       240
//   35 #define ILI9341_W       320
//   36 
//   37 #if ((ILI9341_DIR_DEFAULT&1 )== 0)      //横屏
//   38 uint16  ili9341_h   = ILI9341_H;
//   39 uint16  ili9341_w   = ILI9341_W;
//   40 #else

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   41 uint16  ili9341_h   = ILI9341_W;
ili9341_h:
        DATA
        DC16 320

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   42 uint16  ili9341_w   = ILI9341_H;
ili9341_w:
        DATA
        DC16 240
//   43 #endif

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   44 uint8   ili9341_dir = ILI9341_DIR_DEFAULT;
ili9341_dir:
        DATA
        DC8 1
//   45 /*!
//   46  *  @brief      LCD_ILI9341初始化
//   47  *  @since      v5.0
//   48  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void    LCD_ILI9341_init()
//   50 {
LCD_ILI9341_init:
        PUSH     {R7,LR}
//   51     gpio_init (LCD_BL, GPO, 1); //LCD背光管脚输出1，表示关闭LCD背光
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+40
        BL       gpio_init
//   52 
//   53     //复位LCD
//   54     gpio_init (LCD_RST, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+77
        BL       gpio_init
//   55 
//   56     ILI9341_DELAYMS(1);
        MOVS     R0,#+1
        BL       systick_delay_ms
//   57     GPIO_SET   (LCD_RST, 1);
        MOVS     R0,#+1
        LDR.W    R1,??DataTable4  ;; 0x43fe1034
        STR      R0,[R1, #+0]
//   58 
//   59     //初始化总线
//   60     flexbus_8080_init();
        BL       flexbus_8080_init
//   61 
//   62     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   63     LCD_ILI9341_WR_CMD(0xCF);
        MOVS     R0,#+207
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   64     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   65     LCD_ILI9341_WR_DATA(0x81);
        MOVS     R0,#+129
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   66     LCD_ILI9341_WR_DATA(0x30);
        MOVS     R0,#+48
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   67 
//   68     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   69     LCD_ILI9341_WR_CMD(0xED);
        MOVS     R0,#+237
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   70     LCD_ILI9341_WR_DATA(0x64);
        MOVS     R0,#+100
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   71     LCD_ILI9341_WR_DATA(0x03);
        MOVS     R0,#+3
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   72     LCD_ILI9341_WR_DATA(0x12);
        MOVS     R0,#+18
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   73     LCD_ILI9341_WR_DATA(0x81);
        MOVS     R0,#+129
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   74 
//   75     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   76     LCD_ILI9341_WR_CMD(0xE8);
        MOVS     R0,#+232
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   77     LCD_ILI9341_WR_DATA(0x85);
        MOVS     R0,#+133
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   78     LCD_ILI9341_WR_DATA(0x10);
        MOVS     R0,#+16
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   79     LCD_ILI9341_WR_DATA(0x78);
        MOVS     R0,#+120
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   80 
//   81     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   82     LCD_ILI9341_WR_CMD(0xCB);
        MOVS     R0,#+203
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   83     LCD_ILI9341_WR_DATA(0x39);
        MOVS     R0,#+57
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   84     LCD_ILI9341_WR_DATA(0x2C);
        MOVS     R0,#+44
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   85     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   86     LCD_ILI9341_WR_DATA(0x34);
        MOVS     R0,#+52
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   87     LCD_ILI9341_WR_DATA(0x02);
        MOVS     R0,#+2
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   88 
//   89     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   90     LCD_ILI9341_WR_CMD(0xF7);
        MOVS     R0,#+247
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   91     LCD_ILI9341_WR_DATA(0x20);
        MOVS     R0,#+32
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   92 
//   93     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   94     LCD_ILI9341_WR_CMD(0xEA);
        MOVS     R0,#+234
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   95     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   96     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//   97 
//   98     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//   99     LCD_ILI9341_WR_CMD(0xB1);
        MOVS     R0,#+177
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  100     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  101     LCD_ILI9341_WR_DATA(0x1B);
        MOVS     R0,#+27
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  102 
//  103     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  104     LCD_ILI9341_WR_CMD(0xB6);
        MOVS     R0,#+182
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  105     LCD_ILI9341_WR_DATA(0x0A);
        MOVS     R0,#+10
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  106     LCD_ILI9341_WR_DATA(0xA2);
        MOVS     R0,#+162
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  107 
//  108     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  109     LCD_ILI9341_WR_CMD(0xC0);
        MOVS     R0,#+192
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  110     LCD_ILI9341_WR_DATA(0x35);
        MOVS     R0,#+53
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  111 
//  112     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  113     LCD_ILI9341_WR_CMD(0xC1);
        MOVS     R0,#+193
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  114     LCD_ILI9341_WR_DATA(0x11);
        MOVS     R0,#+17
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  115 
//  116     LCD_ILI9341_WR_CMD(0xC5);
        MOVS     R0,#+197
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  117     LCD_ILI9341_WR_DATA(0x45);
        MOVS     R0,#+69
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  118     LCD_ILI9341_WR_DATA(0x45);
        MOVS     R0,#+69
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  119 
//  120     LCD_ILI9341_WR_CMD(0xC7);
        MOVS     R0,#+199
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  121     LCD_ILI9341_WR_DATA(0xA2);
        MOVS     R0,#+162
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  122 
//  123     LCD_ILI9341_WR_CMD(0xF2);
        MOVS     R0,#+242
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  124     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  125 
//  126     LCD_ILI9341_WR_CMD(0x26);
        MOVS     R0,#+38
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  127     LCD_ILI9341_WR_DATA(0x01);
        MOVS     R0,#+1
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  128     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  129     LCD_ILI9341_WR_CMD(0xE0); //Set Gamma
        MOVS     R0,#+224
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  130     LCD_ILI9341_WR_DATA(0x0F);
        MOVS     R0,#+15
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  131     LCD_ILI9341_WR_DATA(0x26);
        MOVS     R0,#+38
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  132     LCD_ILI9341_WR_DATA(0x24);
        MOVS     R0,#+36
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  133     LCD_ILI9341_WR_DATA(0x0B);
        MOVS     R0,#+11
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  134     LCD_ILI9341_WR_DATA(0x0E);
        MOVS     R0,#+14
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  135     LCD_ILI9341_WR_DATA(0x09);
        MOVS     R0,#+9
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  136     LCD_ILI9341_WR_DATA(0x54);
        MOVS     R0,#+84
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  137     LCD_ILI9341_WR_DATA(0xA8);
        MOVS     R0,#+168
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  138     LCD_ILI9341_WR_DATA(0x46);
        MOVS     R0,#+70
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  139     LCD_ILI9341_WR_DATA(0x0C);
        MOVS     R0,#+12
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  140     LCD_ILI9341_WR_DATA(0x17);
        MOVS     R0,#+23
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  141     LCD_ILI9341_WR_DATA(0x09);
        MOVS     R0,#+9
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  142     LCD_ILI9341_WR_DATA(0x0F);
        MOVS     R0,#+15
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  143     LCD_ILI9341_WR_DATA(0x07);
        MOVS     R0,#+7
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  144     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  145     LCD_ILI9341_WR_CMD(0XE1); //Set Gamma
        MOVS     R0,#+225
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  146     LCD_ILI9341_WR_DATA(0x00);
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  147     LCD_ILI9341_WR_DATA(0x19);
        MOVS     R0,#+25
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  148     LCD_ILI9341_WR_DATA(0x1B);
        MOVS     R0,#+27
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  149     LCD_ILI9341_WR_DATA(0x04);
        MOVS     R0,#+4
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  150     LCD_ILI9341_WR_DATA(0x10);
        MOVS     R0,#+16
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  151     LCD_ILI9341_WR_DATA(0x07);
        MOVS     R0,#+7
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  152     LCD_ILI9341_WR_DATA(0x2A);
        MOVS     R0,#+42
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  153     LCD_ILI9341_WR_DATA(0x47);
        MOVS     R0,#+71
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  154     LCD_ILI9341_WR_DATA(0x39);
        MOVS     R0,#+57
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  155     LCD_ILI9341_WR_DATA(0x03);
        MOVS     R0,#+3
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  156     LCD_ILI9341_WR_DATA(0x06);
        MOVS     R0,#+6
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  157     LCD_ILI9341_WR_DATA(0x06);
        MOVS     R0,#+6
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  158     LCD_ILI9341_WR_DATA(0x30);
        MOVS     R0,#+48
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  159     LCD_ILI9341_WR_DATA(0x38);
        MOVS     R0,#+56
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  160     LCD_ILI9341_WR_DATA(0x0F);
        MOVS     R0,#+15
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  161     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  162 
//  163 
//  164     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  165     LCD_ILI9341_WR_CMD(0x3a); // Memory Access Control
        MOVS     R0,#+58
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  166     LCD_ILI9341_WR_DATA(0x55);
        MOVS     R0,#+85
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  167     LCD_ILI9341_WR_CMD(0x11); //Exit Sleep
        MOVS     R0,#+17
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  168     ILI9341_DELAY();
        MOVS     R0,#+100
        BL       systick_delay_ms
//  169     LCD_ILI9341_WR_CMD(0x29); //display on
        MOVS     R0,#+41
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  170 
//  171 
//  172     LCD_SET_DIR(ili9341_dir);   //液晶方向显示函数
        LDR.N    R0,??DataTable4_1
        LDRB     R0,[R0, #+0]
        BL       LCD_ILI9341_dir
//  173 
//  174     LCD_ILI9341_WR_CMD(0x2c);
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  175 
//  176     PTXn_T(LCD_BL,OUT) = 0;     //开LCD背光
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_2  ;; 0x43fe0820
        STR      R0,[R1, #+0]
//  177 }
        POP      {R0,PC}          ;; return
//  178 
//  179 /*!
//  180  *  @brief      设置ILI9341GRAM指针扫描方向
//  181  *  @param      option    方向选择（0~3）
//  182  *  @since      v5.0
//  183  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  184 void LCD_ILI9341_dir(uint8 option)
//  185 {
//  186 
//  187     option = option % 4;
LCD_ILI9341_dir:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+4
        MOVS     R1,R0
        SDIV     R0,R1,R2
        MLS      R0,R0,R2,R1
//  188 
//  189 
//  190     ili9341_dir = option;
        LDR.N    R1,??DataTable4_1
        STRB     R0,[R1, #+0]
//  191 
//  192 
//  193     switch(option)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LCD_ILI9341_dir_0
        CMP      R0,#+2
        BEQ.N    ??LCD_ILI9341_dir_1
        BCC.N    ??LCD_ILI9341_dir_2
        CMP      R0,#+3
        BEQ.W    ??LCD_ILI9341_dir_3
        B.N      ??LCD_ILI9341_dir_4
//  194     {
//  195         case 0:
//  196         {
//  197             /*横屏*/
//  198             LCD_ILI9341_WR_CMD(0x36);
??LCD_ILI9341_dir_0:
        MOVS     R1,#+54
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  199             LCD_ILI9341_WR_DATA(0xA8);    //横屏
        MOVS     R1,#+168
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  200 
//  201             LCD_ILI9341_WR_CMD(0X2A);
        MOVS     R1,#+42
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  202             LCD_ILI9341_WR_DATA(0x00);  //start
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  203             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  204             LCD_ILI9341_WR_DATA(0x01);  //end
        MOVS     R1,#+1
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  205             LCD_ILI9341_WR_DATA(0x3F);
        MOVS     R1,#+63
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  206 
//  207             LCD_ILI9341_WR_CMD(0X2B);
        MOVS     R1,#+43
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  208             LCD_ILI9341_WR_DATA(0x00);   //start
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  209             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  210             LCD_ILI9341_WR_DATA(0x00);   //end
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  211             LCD_ILI9341_WR_DATA(0xEF);
        MOVS     R1,#+239
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  212 
//  213             ili9341_h   = ILI9341_H;
        MOVS     R1,#+240
        LDR.N    R2,??DataTable4_3
        STRH     R1,[R2, #+0]
//  214             ili9341_w   = ILI9341_W;
        MOV      R1,#+320
        LDR.N    R2,??DataTable4_4
        STRH     R1,[R2, #+0]
//  215         }
//  216         break;
        B.N      ??LCD_ILI9341_dir_5
//  217         case 1:
//  218         {
//  219             /*竖屏*/
//  220             LCD_ILI9341_WR_CMD(0x36);
??LCD_ILI9341_dir_2:
        MOVS     R1,#+54
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  221             LCD_ILI9341_WR_DATA(0xD8);  //竖屏
        MOVS     R1,#+216
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  222 
//  223             LCD_ILI9341_WR_CMD(0X2A);
        MOVS     R1,#+42
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  224             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  225             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  226             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  227             LCD_ILI9341_WR_DATA(0xEF);
        MOVS     R1,#+239
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  228 
//  229             LCD_ILI9341_WR_CMD(0X2B);
        MOVS     R1,#+43
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  230             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  231             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  232             LCD_ILI9341_WR_DATA(0x01);
        MOVS     R1,#+1
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  233             LCD_ILI9341_WR_DATA(0x3F);
        MOVS     R1,#+63
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  234 
//  235             ili9341_h   = ILI9341_W;
        MOV      R1,#+320
        LDR.N    R2,??DataTable4_3
        STRH     R1,[R2, #+0]
//  236             ili9341_w   = ILI9341_H;
        MOVS     R1,#+240
        LDR.N    R2,??DataTable4_4
        STRH     R1,[R2, #+0]
//  237         }
//  238         break;
        B.N      ??LCD_ILI9341_dir_5
//  239         case 2:
//  240         {
//  241             /*横屏*/
//  242             LCD_ILI9341_WR_CMD(0x36);
??LCD_ILI9341_dir_1:
        MOVS     R1,#+54
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  243             LCD_ILI9341_WR_DATA(0x68);    //横屏
        MOVS     R1,#+104
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  244 
//  245             LCD_ILI9341_WR_CMD(0X2A);
        MOVS     R1,#+42
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  246             LCD_ILI9341_WR_DATA(0x00);  //start
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  247             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  248             LCD_ILI9341_WR_DATA(0x01);  //end
        MOVS     R1,#+1
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  249             LCD_ILI9341_WR_DATA(0x3F);
        MOVS     R1,#+63
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  250 
//  251             LCD_ILI9341_WR_CMD(0X2B);
        MOVS     R1,#+43
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  252             LCD_ILI9341_WR_DATA(0x00);   //start
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  253             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  254             LCD_ILI9341_WR_DATA(0x00);   //end
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  255             LCD_ILI9341_WR_DATA(0xEF);
        MOVS     R1,#+239
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  256             ili9341_h   = ILI9341_H;
        MOVS     R1,#+240
        LDR.N    R2,??DataTable4_3
        STRH     R1,[R2, #+0]
//  257             ili9341_w   = ILI9341_W;
        MOV      R1,#+320
        LDR.N    R2,??DataTable4_4
        STRH     R1,[R2, #+0]
//  258         }
//  259         break;
        B.N      ??LCD_ILI9341_dir_5
//  260         case 3:
//  261         {
//  262             /*竖屏*/
//  263             LCD_ILI9341_WR_CMD(0x36);
??LCD_ILI9341_dir_3:
        MOVS     R1,#+54
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  264             LCD_ILI9341_WR_DATA(0x18);  //竖屏
        MOVS     R1,#+24
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  265 
//  266             LCD_ILI9341_WR_CMD(0X2A);
        MOVS     R1,#+42
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  267             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  268             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  269             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  270             LCD_ILI9341_WR_DATA(0xEF);
        MOVS     R1,#+239
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  271 
//  272             LCD_ILI9341_WR_CMD(0X2B);
        MOVS     R1,#+43
        MOVS     R2,#+1610612736
        STRH     R1,[R2, #+0]
//  273             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  274             LCD_ILI9341_WR_DATA(0x00);
        MOVS     R1,#+0
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  275             LCD_ILI9341_WR_DATA(0x01);
        MOVS     R1,#+1
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  276             LCD_ILI9341_WR_DATA(0x3F);
        MOVS     R1,#+63
        MOVS     R2,#+1744830464
        STRH     R1,[R2, #+0]
//  277 
//  278             ili9341_h   = ILI9341_W;
        MOV      R1,#+320
        LDR.N    R2,??DataTable4_3
        STRH     R1,[R2, #+0]
//  279             ili9341_w   = ILI9341_H;
        MOVS     R1,#+240
        LDR.N    R2,??DataTable4_4
        STRH     R1,[R2, #+0]
//  280         }
//  281         break;
        B.N      ??LCD_ILI9341_dir_5
//  282         default:
//  283             //由于开头有校验，因而不会执行到这里
//  284             //LCD_ILI9341_dir(ILI9341_DIR_DEFAULT);
//  285             break;
//  286 
//  287     }
//  288 
//  289 }
??LCD_ILI9341_dir_4:
??LCD_ILI9341_dir_5:
        BX       LR               ;; return
//  290 
//  291 /*!
//  292  *  @brief      设置ILI9341开窗
//  293  *  @param      site        左上角坐标位置
//  294  *  @param      size        开窗大小
//  295  *  @since      v5.0
//  296  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  297 void LCD_ILI9341_ptlon(Site_t site, Size_t size)
//  298 {
LCD_ILI9341_ptlon:
        PUSH     {R0,R1}
//  299 
//  300     LCD_ILI9341_WR_CMD(0X2A);
        MOVS     R0,#+42
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  301     LCD_ILI9341_WR_DATA(site.x >> 8); //start
        LDRH     R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  302     LCD_ILI9341_WR_DATA(site.x & 0xFF);
        LDRH     R0,[SP, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  303     LCD_ILI9341_WR_DATA((site.x + size.W - 1) >> 8); //end
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+4]
        UXTAH    R0,R1,R0
        SUBS     R0,R0,#+1
        ASRS     R0,R0,#+8
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  304     LCD_ILI9341_WR_DATA((site.x  + size.W - 1) & 0xFF);
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+4]
        ADDS     R0,R1,R0
        SUBS     R0,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  305 
//  306     LCD_ILI9341_WR_CMD(0X2B);
        MOVS     R0,#+43
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  307     LCD_ILI9341_WR_DATA(site.y >> 8); //start
        LDRH     R0,[SP, #+2]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  308     LCD_ILI9341_WR_DATA(site.y & 0xFF);
        LDRB     R0,[SP, #+2]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  309     LCD_ILI9341_WR_DATA((site.y + size.H - 1) >> 8); //end
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+6]
        UXTAH    R0,R1,R0
        SUBS     R0,R0,#+1
        ASRS     R0,R0,#+8
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  310     LCD_ILI9341_WR_DATA((site.y + size.H - 1) & 0xFF);
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+6]
        ADDS     R0,R1,R0
        SUBS     R0,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  311 }
        ADD      SP,SP,#+8
        BX       LR               ;; return
//  312 
//  313 /*!
//  314  *  @brief      获取 ILI9341 高度
//  315  *  @return     ILI9341 高度
//  316  *  @since      v5.0
//  317  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  318 uint16 ILI9341_get_h()
//  319 {
//  320     return ili9341_h;
ILI9341_get_h:
        LDR.N    R0,??DataTable4_3
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
//  321 }
//  322 
//  323 /*!
//  324  *  @brief      获取 ILI9341 宽度
//  325  *  @return     ILI9341 宽度
//  326  *  @since      v5.0
//  327  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  328 uint16 ILI9341_get_w()
//  329 {
//  330     return ili9341_w;
ILI9341_get_w:
        LDR.N    R0,??DataTable4_4
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
//  331 }
//  332 
//  333 /*!
//  334  *  @brief      获取 ILI9341 显示方向
//  335  *  @return     ILI9341 方向
//  336  *  @since      v5.0
//  337  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  338 uint8 ILI9341_get_dir()
//  339 {
//  340     return ili9341_dir;
ILI9341_get_dir:
        LDR.N    R0,??DataTable4_1
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  341 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0x43fe1034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     ili9341_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x43fe0820

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     ili9341_h

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     ili9341_w

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  342 
//  343 
//  344 #endif //(USE_LCD == LCD_ILI9341)
//  345 
// 
//     5 bytes in section .data
// 1 464 bytes in section .text
// 
// 1 464 bytes of CODE memory
//     5 bytes of DATA memory
//
//Errors: none
//Warnings: 2
