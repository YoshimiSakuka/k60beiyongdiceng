///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:26
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_DWT.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_DWT.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_DWT.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN core_clk_khz

        PUBLIC dwt_delay_ms
        PUBLIC dwt_delay_us

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_DWT.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_dwt.h
//   11  * @brief      flash函数库
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-10-22
//   15  */
//   16 
//   17 #include "common.h"
//   18 
//   19 #define  DWT_CLK_HHZ                        (core_clk_khz )
//   20 #define  DEM_CR_TRCENA_MASK                 (1 << 24)
//   21 #define  DWT_CTRL_CYCCNTENA                 (1 <<  0)
//   22 
//   23 /*!
//   24  *  @brief      延时(us)
//   25  *  @param      us      延时时间
//   26  *  @since      v5.0
//   27  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void dwt_delay_us(uint32 us)
//   29 {
dwt_delay_us:
        PUSH     {R4,R5}
//   30     uint32 st,et,ts;
//   31     DEMCR            |=  DEM_CR_TRCENA_MASK;        //使能 调试时钟 （默认已经打开）
        LDR.N    R4,??DataTable0  ;; 0xe000edfc
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x1000000
        LDR.N    R5,??DataTable0  ;; 0xe000edfc
        STR      R4,[R5, #+0]
//   32     DWT_CTRL         |=  DWT_CTRL_CYCCNTENA;
        LDR.N    R4,??DataTable0_1  ;; 0xe0001000
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x1
        LDR.N    R5,??DataTable0_1  ;; 0xe0001000
        STR      R4,[R5, #+0]
//   33 
//   34     st = DWT_CYCCNT;
        LDR.N    R4,??DataTable0_2  ;; 0xe0001004
        LDR      R4,[R4, #+0]
        MOVS     R1,R4
//   35     ts =  us * (DWT_CLK_HHZ /(1000));
        LDR.N    R4,??DataTable0_3
        LDR      R4,[R4, #+0]
        MOV      R5,#+1000
        SDIV     R4,R4,R5
        MUL      R4,R4,R0
        MOVS     R3,R4
//   36     et = st + ts;
        ADDS     R4,R3,R1
        MOVS     R2,R4
//   37     if(et < st)
        CMP      R2,R1
        BCS.N    ??dwt_delay_us_0
//   38     {
//   39         //溢出，需要转动一周
//   40         while(DWT_CYCCNT > et);      //等待 DWT_CYCCNT 溢出 返回0
??dwt_delay_us_1:
        LDR.N    R4,??DataTable0_2  ;; 0xe0001004
        LDR      R4,[R4, #+0]
        CMP      R2,R4
        BCC.N    ??dwt_delay_us_1
//   41     }
//   42 
//   43     while(DWT_CYCCNT < et);      //等待 DWT_CYCCNT 到底计数值
??dwt_delay_us_0:
        LDR.N    R4,??DataTable0_2  ;; 0xe0001004
        LDR      R4,[R4, #+0]
        CMP      R4,R2
        BCC.N    ??dwt_delay_us_0
//   44 }
        POP      {R4,R5}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0xe000edfc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0xe0001000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0xe0001004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     core_clk_khz
//   45 
//   46 /*!
//   47  *  @brief      延时(ms)
//   48  *  @param      ms      延时时间
//   49  *  @since      v5.0
//   50  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   51 void dwt_delay_ms(uint32 ms)
//   52 {
dwt_delay_ms:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   53     while(ms--)
??dwt_delay_ms_0:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??dwt_delay_ms_1
//   54     {
//   55         dwt_delay_us(1000);
        MOV      R0,#+1000
        BL       dwt_delay_us
        B.N      ??dwt_delay_ms_0
//   56     }
//   57 }
??dwt_delay_ms_1:
        POP      {R4,PC}          ;; return

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
// 118 bytes in section .text
// 
// 118 bytes of CODE memory
//
//Errors: none
//Warnings: none
