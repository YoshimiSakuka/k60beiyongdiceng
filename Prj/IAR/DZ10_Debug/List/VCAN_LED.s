///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:34
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LED.C
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LED.C -D
//        DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_LED.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init
        EXTERN gpio_set
        EXTERN gpio_turn

        PUBLIC LED_PTxn
        PUBLIC led
        PUBLIC led_init
        PUBLIC led_turn

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LED.C
//    1  /*!
//    2   *     COPYRIGHT NOTICE
//    3   *     Copyright (c) 2014,山外科技
//    4   *     All rights reserved.
//    5   *     技术讨论：山外论坛 http://www.vcan123.com
//    6   *
//    7   *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8   *     修改内容时必须保留山外科技的版权声明。
//    9   *
//   10   * @file       VCAN_LED.c
//   11   * @brief      led驱动函数实现
//   12   * @author     山外科技
//   13   * @version    v5.2
//   14   * @date       2014-10-4
//   15   */
//   16 
//   17 /*
//   18  * 包含头文件
//   19  */
//   20 #include "common.h"
//   21 #include "MK60_port.h"
//   22 #include "MK60_gpio.h"
//   23 #include "VCAN_LED.H"
//   24 
//   25 
//   26 /*
//   27  * 定义LED 编号对应的管脚
//   28  */

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   29 PTXn_e LED_PTxn[LED_MAX] = {PTE6,PTE7,PTE8,PTE9,PTE10};
LED_PTxn:
        DATA
        DC8 134, 135, 136, 137, 138, 0, 0, 0
//   30 
//   31 
//   32 /*!
//   33  *  @brief      初始化LED端口
//   34  *  @param      LED_e    LED编号
//   35  *  @since      v5.0
//   36  *  Sample usage:       led_init (LED0);    //初始化 LED0
//   37  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   38 void    led_init(LED_e ledn)
//   39 {
led_init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   40     if(ledn < LED_MAX)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BGE.N    ??led_init_0
//   41     {
//   42         gpio_init(LED_PTxn[ledn],GPO,LED_OFF);
        MOVS     R2,#+1
        MOVS     R1,#+1
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_init
        B.N      ??led_init_1
//   43     }
//   44     else
//   45     {
//   46         ledn = LED_MAX;
??led_init_0:
        MOVS     R0,#+5
        MOVS     R4,R0
//   47         while(ledn--)
??led_init_2:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??led_init_1
//   48         {
//   49             gpio_init(LED_PTxn[ledn],GPO,LED_OFF);
        MOVS     R2,#+1
        MOVS     R1,#+1
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_init
        B.N      ??led_init_2
//   50         }
//   51 
//   52     }
//   53 }
??led_init_1:
        POP      {R4,PC}          ;; return
//   54 
//   55 
//   56 
//   57 /*!
//   58  *  @brief      设置LED灯亮灭
//   59  *  @param      LED_e           LED编号（LED0、LED1、LED2、LED3）
//   60  *  @param      LED_status      LED亮灭状态（LED_ON、LED_OFF）
//   61  *  @since      v5.2
//   62  *  Sample usage:       led (LED0,LED_ON);    //点亮 LED0
//   63  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 void    led(LED_e ledn,LED_status status)
//   65 {
led:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   66     if(ledn < LED_MAX)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BGE.N    ??led_0
//   67     {
//   68         gpio_set(LED_PTxn[ledn],status);
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_set
        B.N      ??led_1
//   69     }
//   70     else
//   71     {
//   72         ledn = LED_MAX;
??led_0:
        MOVS     R0,#+5
        MOVS     R4,R0
//   73         while(ledn--)
??led_2:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??led_1
//   74         {
//   75             gpio_set(LED_PTxn[ledn],status);
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_set
        B.N      ??led_2
//   76         }
//   77     }
//   78 }
??led_1:
        POP      {R0,R4,R5,PC}    ;; return
//   79 
//   80 /*!
//   81  *  @brief      设置LED灯亮灭反转
//   82  *  @param      LED_e           LED编号（LED0、LED1、LED2、LED3）
//   83  *  @since      v5.2
//   84  *  Sample usage:       led_turn (LED0);    // LED0灯亮灭反转
//   85  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   86 void led_turn(LED_e ledn)
//   87 {
led_turn:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   88     if(ledn < LED_MAX)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BGE.N    ??led_turn_0
//   89     {
//   90         gpio_turn(LED_PTxn[ledn]);
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_turn
        B.N      ??led_turn_1
//   91     }
//   92     else
//   93     {
//   94         ledn = LED_MAX;
??led_turn_0:
        MOVS     R0,#+5
        MOVS     R4,R0
//   95         while(ledn--)
??led_turn_2:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??led_turn_1
//   96         {
//   97             gpio_turn(LED_PTxn[ledn]);
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_turn
        B.N      ??led_turn_2
//   98         }
//   99     }
//  100 }
??led_turn_1:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     LED_PTxn

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
//   8 bytes in section .data
// 172 bytes in section .text
// 
// 172 bytes of CODE memory
//   8 bytes of DATA memory
//
//Errors: none
//Warnings: none
