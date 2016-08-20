///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  15:24:23
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层 -只调LDC\App\main.c
//    Command line =  
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层 -只调LDC\App\main.c" -D
//        DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\DZ10_Debug\List\" -lB
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\DZ10_Debug\List\" -o
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\DZ10_Debug\Obj\" --no_cse --no_unroll --no_inline
//        --no_code_motion --no_tbaa --no_clustering --no_scheduling --debug
//        --endian=little --cpu=Cortex-M4 -e --fpu=None --dlib_config "E:\IAR
//        for ARM\arm\INC\c\DLib_Config_Full.h" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\App\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\App\Inc\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Board\Inc\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Chip\inc\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Chip\inc\IAR\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Chip\inc\kinetis\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Lib\CMSIS\Inc\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Lib\FatFs\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Lib\USB\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Board\Accessories\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Board\Accessories\MPU6050\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Board\Accessories\IMU\" -I
//        "D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\..\..\Board\Accessories\Driver\" -On
//    List file    =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层
//        -只调LDC\Prj\IAR\DZ10_Debug\List\main.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Common_Key
        EXTERN FiveDir_Key_Init
        EXTERN LCD_Init
        EXTERN LCD_P6x8Str
        EXTERN LDC1314_Init
        EXTERN ftm_pwm_init
        EXTERN ftm_quad_init
        EXTERN sprintf
        EXTERN `str`
        EXTERN systick_delay_ms

        PUBLIC LDC_Read
        PUBLIC MotorRun
        PUBLIC Pit0_cnt
        PUBLIC Roadflag
        PUBLIC SpeedFlag
        PUBLIC SpeedSingle
        PUBLIC Speed_Cnt
        PUBLIC main
        PUBLIC motor
        PUBLIC test
        PUBLIC test1
        PUBLIC test2
        PUBLIC testcnt

// D:\Study\2016电子设计大赛\Ti\电赛备用底层 -只调LDC\App\main.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       main.c
//   11  * @brief      山外K60 平台主程序
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-08-28
//   15  */
//   16 
//   17 #include "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable1_1  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R3,R0,#+5
        STR      R1,[R2, R3, LSL #+2]
        BX       LR               ;; return
//   18 #include "include.h"
//   19 
//   20 
//   21 void PORTE_IRQHandler(void);
//   22 void PIT0_IRQHandler(void);

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   23 _Bool Roadflag;
Roadflag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 uint16 LDC_Read[4] = {0};
LDC_Read:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   25 uint16 test,test1,test2;
test:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
test1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
test2:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 int Speed_Cnt;
Speed_Cnt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 int SpeedSingle;
SpeedSingle:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 int motor;
motor:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   29 int MotorRun;
MotorRun:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   30 uint8 Pit0_cnt;
Pit0_cnt:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   31 int testcnt;
testcnt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   32 uint8 SpeedFlag;
SpeedFlag:
        DS8 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void main(void)
//   34 {
main:
        PUSH     {R7,LR}
//   35   LDC1314_Init();
        BL       LDC1314_Init
//   36   Common_Key();
        BL       Common_Key
//   37   FiveDir_Key_Init();
        BL       FiveDir_Key_Init
//   38   LCD_Init();
        BL       LCD_Init
//   39   ftm_pwm_init(FTM0, FTM_CH4,10 * 1000, 0);        //电机驱动
        MOVS     R3,#+0
        MOVW     R2,#+10000
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       ftm_pwm_init
//   40   ftm_pwm_init(FTM0, FTM_CH5,10 * 1000, 0);
        MOVS     R3,#+0
        MOVW     R2,#+10000
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       ftm_pwm_init
//   41   ftm_pwm_init(FTM1, FTM_CH0,50, 816);              //舵机驱动
        MOV      R3,#+816
        MOVS     R2,#+50
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       ftm_pwm_init
//   42   ftm_quad_init(FTM2);                             //正交解码
        MOVS     R0,#+2
        BL       ftm_quad_init
//   43   //pit_init(PIT0, 500000);                          //定时5ms后中断
//   44   //set_vector_handler(PIT0_VECTORn,PIT0_IRQHandler);   
//   45 //  while(!nrf_init())                  //初始化NRF24L01+ ,等待初始化成功为止
//   46 //  {
//   47 //      printf("\n  NRF与MCU连接失败，请重新检查接线。\n");
//   48 //  }
//   49 //   set_vector_handler(PORTE_VECTORn ,PORTE_IRQHandler);    			//设置 PORTE 的中断服务函数为 PORTE_VECTORn
//   50 //   enable_irq(PORTE_IRQn);
//   51   
//   52  
//   53   //ParmAdjust();
//   54   
//   55   LCD_P6x8Str(0,0,"LDC_Ch0  =");
        LDR.N    R2,??DataTable1_2
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   56   LCD_P6x8Str(0,1,"LDC_Ch1  =");
        LDR.N    R2,??DataTable1_3
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   57   LCD_P6x8Str(0,2,"LDC_Ch2  =");
        LDR.N    R2,??DataTable1_4
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   58   LCD_P6x8Str(0,3,"LDC_Ch3  =");
        LDR.N    R2,??DataTable1_5
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   59   LCD_P6x8Str(0,4,"TimeCost =");
        LDR.N    R2,??DataTable1_6
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   60   LCD_P6x8Str(0,5,"Distance =");
        LDR.N    R2,??DataTable1_7
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LCD_P6x8Str
//   61   
//   62 
//   63   enable_irq(PIT0_IRQn);                         // 使能PIT中断
        MOVS     R0,#+68
        BL       NVIC_EnableIRQ
//   64   while(1)
//   65   {
//   66 
//   67       sprintf(str,"%5d",(int)LDC_Read[0]);
??main_0:
        LDR.N    R0,??DataTable1_8
        LDRH     R2,[R0, #+0]
        ADR.N    R1,??DataTable1  ;; "%5d"
        LDR.N    R0,??DataTable1_9
        BL       sprintf
//   68       LCD_P6x8Str(80,0,str);
        LDR.N    R2,??DataTable1_9
        MOVS     R1,#+0
        MOVS     R0,#+80
        BL       LCD_P6x8Str
//   69       sprintf(str,"%5d",(int)LDC_Read[1]);
        LDR.N    R0,??DataTable1_8
        LDRH     R2,[R0, #+2]
        ADR.N    R1,??DataTable1  ;; "%5d"
        LDR.N    R0,??DataTable1_9
        BL       sprintf
//   70       LCD_P6x8Str(80,1,str);
        LDR.N    R2,??DataTable1_9
        MOVS     R1,#+1
        MOVS     R0,#+80
        BL       LCD_P6x8Str
//   71       sprintf(str,"%5d",(int)LDC_Read[2]);
        LDR.N    R0,??DataTable1_8
        LDRH     R2,[R0, #+4]
        ADR.N    R1,??DataTable1  ;; "%5d"
        LDR.N    R0,??DataTable1_9
        BL       sprintf
//   72       LCD_P6x8Str(80,2,str);
        LDR.N    R2,??DataTable1_9
        MOVS     R1,#+2
        MOVS     R0,#+80
        BL       LCD_P6x8Str
//   73       sprintf(str,"%5d",(int)LDC_Read[3]);
        LDR.N    R0,??DataTable1_8
        LDRH     R2,[R0, #+6]
        ADR.N    R1,??DataTable1  ;; "%5d"
        LDR.N    R0,??DataTable1_9
        BL       sprintf
//   74       LCD_P6x8Str(80,3,str);      
        LDR.N    R2,??DataTable1_9
        MOVS     R1,#+3
        MOVS     R0,#+80
        BL       LCD_P6x8Str
//   75       DELAY_MS(200);
        MOVS     R0,#+200
        BL       systick_delay_ms
        B.N      ??main_0
//   76       
//   77       
//   78 
//   79     }
//   80     
//   81     
//   82     
//   83     
//   84    
//   85   
//   86 
//   87    
//   88 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC8      "%5d"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_6:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_7:
        DC32     ?_5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_8:
        DC32     LDC_Read

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_9:
        DC32     `str`

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "LDC_Ch0  ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "LDC_Ch1  ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "LDC_Ch2  ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "LDC_Ch3  ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "TimeCost ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC8 "Distance ="
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "%5d"

        END
//   89 
//   90 
// 
//  37 bytes in section .bss
//  76 bytes in section .rodata
// 288 bytes in section .text
// 
// 288 bytes of CODE  memory
//  76 bytes of CONST memory
//  37 bytes of DATA  memory
//
//Errors: none
//Warnings: 4
