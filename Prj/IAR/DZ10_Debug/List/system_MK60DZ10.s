///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:32
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\IAR\system_MK60DZ10.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\IAR\system_MK60DZ10.c
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\system_MK60DZ10.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        EXTERN __VECTOR_RAM
        EXTERN __VECTOR_TABLE
        EXTERN gpio_init
        EXTERN main
        EXTERN pll_init
        EXTERN wdog_disable
        EXTERN write_vtor

        PUBLIC bus_clk_khz
        PUBLIC common_startup
        PUBLIC core_clk_khz
        PUBLIC core_clk_mhz
        PUBLIC fb_clk_init
        PUBLIC start
        PUBLIC sysinit
        PUBLIC trace_clk_init

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\IAR\system_MK60DZ10.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       system_MK60DZ10.c
//   11  * @brief      系统启动相关函数
//   12  * @author     山外科技
//   13  * @version    v5.2
//   14  * @date       2014-10-09
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "system_MK60DZ10.h"
//   19 #include "MK60_uart.h"
//   20 #include "MK60_wdog.h"
//   21 #include "MK60_gpio.h"
//   22 
//   23 
//   24 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 int core_clk_khz;
core_clk_khz:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 int core_clk_mhz;
core_clk_mhz:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 int bus_clk_khz;
bus_clk_khz:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   28 
//   29 extern void main(void);
//   30 
//   31 /*!
//   32  *  @brief      kinetis 启动函数
//   33  *  @since      v5.0
//   34  *  @author     飞思卡尔公司
//   35  *  @note       此函数是系统启动初期由汇编函数调用，然后执行main函数
//   36  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 void start(void)
//   38 {
start:
        PUSH     {R7,LR}
//   39     wdog_disable();     // 关闭看门狗
        BL       wdog_disable
//   40 
//   41     common_startup();   // 复制中断向量表 和 必要的数据到 RAM里
        BL       common_startup
//   42 
//   43     sysinit();          // 系统初始化，设置系统频率，初始化printf端口
        BL       sysinit
//   44 
//   45     //为了防止 main 函数 里 复用了 下载口，导致 下载失败，此处增加 按下 KEY_A 就进入死循环
//   46     //SRART_CHECK();
//   47 
//   48     gpio_init(PTA4,GPO,1);  //初始化为输出1，即 禁用了 NMI 中断
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       gpio_init
//   49 
//   50     main();             // 执行用户主函数
        BL       main
//   51 
//   52     while(1);           // 死循环
??start_0:
        B.N      ??start_0
//   53 }
//   54 
//   55 /*!
//   56  *  @brief      系统初始化，设置系统频率，初始化printf端口
//   57  *  @since      v5.0
//   58  *  @note       此函数是系统启动初期由汇编函数调用，然后执行main函数
//   59  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 void sysinit (void)
//   61 {
sysinit:
        PUSH     {R7,LR}
//   62     core_clk_mhz = pll_init(CORE_CLK);     //设置系统时钟
        MOVS     R0,#+4
        BL       pll_init
        LDR.N    R1,??DataTable3
        STR      R0,[R1, #+0]
//   63 
//   64     core_clk_khz = core_clk_mhz * 1000;     //把配置好的时钟都保存在全局变量里，以便后续使用
        LDR.N    R0,??DataTable3
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_1
        STR      R0,[R1, #+0]
//   65     bus_clk_khz = core_clk_khz / (((SIM_CLKDIV1 & SIM_CLKDIV1_OUTDIV2_MASK) >> 24) + 1);
        LDR.N    R0,??DataTable3_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_2  ;; 0x40048044
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+24,#+4
        ADDS     R1,R1,#+1
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_3
        STR      R0,[R1, #+0]
//   66 
//   67     //uart_init (VCAN_PORT, VCAN_BAUD);   //初始化printf用到的管脚
//   68 }
        POP      {R0,PC}          ;; return
//   69 
//   70 /*!
//   71  *  @brief      trace 时钟输出 初始化
//   72  *  @since      v5.0
//   73  *  @note       可用来校验时钟输出是否正确
//   74  *  @author     飞思卡尔公司
//   75  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 void trace_clk_init(void)
//   77 {
//   78     /* Set the trace clock to the core clock frequency */
//   79     SIM_SOPT2 |= SIM_SOPT2_TRACECLKSEL_MASK;
trace_clk_init:
        LDR.N    R0,??DataTable3_4  ;; 0x40048004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable3_4  ;; 0x40048004
        STR      R0,[R1, #+0]
//   80 
//   81     /* Enable the TRACE_CLKOUT pin function on PTA6 (alt7 function) */
//   82     PORTA_PCR6 = ( PORT_PCR_MUX(0x7));
        MOV      R0,#+1792
        LDR.N    R1,??DataTable3_5  ;; 0x40049018
        STR      R0,[R1, #+0]
//   83 }
        BX       LR               ;; return
//   84 
//   85 /*!
//   86  *  @brief      fb 时钟输出 初始化
//   87  *  @since      v5.0
//   88  *  @note       可用来校验时钟输出是否正确
//   89  *  @author     飞思卡尔公司
//   90  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   91 void fb_clk_init(void)
//   92 {
//   93     /* Enable the clock to the FlexBus module */
//   94     SIM_SCGC7 |= SIM_SCGC7_FLEXBUS_MASK;
fb_clk_init:
        LDR.N    R0,??DataTable3_6  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable3_6  ;; 0x40048040
        STR      R0,[R1, #+0]
//   95 
//   96     /* Enable the FB_CLKOUT function on PTC3 (alt5 function) */
//   97     PORTC_PCR3 = ( PORT_PCR_MUX(0x5));
        MOV      R0,#+1280
        LDR.N    R1,??DataTable3_7  ;; 0x4004b00c
        STR      R0,[R1, #+0]
//   98 }
        BX       LR               ;; return
//   99 
//  100 
//  101 /*!
//  102  *  @brief      复制中断向量表 和 必要的数据到 RAM里
//  103  *  @since      v5.0
//  104  *  @author     飞思卡尔公司
//  105  */
//  106 #pragma section = ".data"
//  107 #pragma section = ".data_init"
//  108 #pragma section = ".bss"
//  109 #pragma section = "CodeRelocate"
//  110 #pragma section = "CodeRelocateRam"
//  111 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  112 void common_startup(void)
//  113 {
common_startup:
        PUSH     {R3-R9,LR}
//  114     /* Declare a counter we'll use in all of the copy loops */
//  115     uint32 n;
//  116 
//  117     /* Declare pointers for various data sections. These pointers
//  118      * are initialized using values pulled in from the linker file
//  119      */
//  120     uint8 *data_ram, * data_rom, * data_rom_end;
//  121     uint8 *bss_start, * bss_end;
//  122 
//  123 
//  124     /*  VECTOR_TABLE 和 VECTOR_RAM 的地址从  linker 文件里获得 （*.icf） */
//  125     extern uint32 __VECTOR_TABLE[];
//  126     extern uint32 __VECTOR_RAM[];
//  127 
//  128     /* 复制ROM里的中断向量表到RAM里 */
//  129     if (__VECTOR_RAM != __VECTOR_TABLE)             //如果不是RAM启动，则需要复制中断向量表
        LDR.N    R0,??DataTable3_8
        LDR.N    R1,??DataTable3_9
        CMP      R0,R1
        BEQ.N    ??common_startup_0
//  130     {
//  131         for (n = 0; n < 0x410; n++)                 //逐个复制
        MOVS     R0,#+0
        MOV      R8,R0
??common_startup_1:
        CMP      R8,#+1040
        BCS.N    ??common_startup_0
//  132             __VECTOR_RAM[n] = __VECTOR_TABLE[n];
        LDR.N    R0,??DataTable3_9
        LDR      R0,[R0, R8, LSL #+2]
        LDR.N    R1,??DataTable3_8
        STR      R0,[R1, R8, LSL #+2]
        ADDS     R8,R8,#+1
        B.N      ??common_startup_1
//  133     }
//  134     /* 指定新的中断向量表地址为 __VECTOR_RAM */
//  135     write_vtor((uint32)__VECTOR_RAM);
??common_startup_0:
        LDR.N    R0,??DataTable3_8
        BL       write_vtor
//  136 
//  137     /* 把已赋初值的变量从ROM里复制数据到RAM里 */
//  138     data_ram = __section_begin(".data");            //已赋初值的变量的地址在RAM里
        LDR.N    R0,??DataTable3_10
        MOVS     R7,R0
//  139     data_rom = __section_begin(".data_init");       //已赋初值的变量的数据存放在ROM里，需要赋值到RAM里
        LDR.N    R0,??DataTable3_11
        MOVS     R6,R0
//  140     data_rom_end = __section_end(".data_init");
        LDR.N    R0,??DataTable3_12
        MOVS     R4,R0
//  141     n = data_rom_end - data_rom;
        SUBS     R0,R4,R6
        MOV      R8,R0
//  142 
//  143     /* 复制初始化数据到RAM里 */
//  144     while (n--)
??common_startup_2:
        MOV      R0,R8
        SUBS     R8,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??common_startup_3
//  145         *data_ram++ = *data_rom++;
        LDRB     R0,[R6, #+0]
        STRB     R0,[R7, #+0]
        ADDS     R6,R6,#+1
        ADDS     R7,R7,#+1
        B.N      ??common_startup_2
//  146 
//  147     /* 没赋初值或者初值为0的变量，需要清除其RAM里的数据，确保值为0 */
//  148     bss_start = __section_begin(".bss");
??common_startup_3:
        LDR.N    R0,??DataTable3_13
        MOV      R9,R0
//  149     bss_end = __section_end(".bss");
        LDR.N    R0,??DataTable3_14
        MOVS     R5,R0
//  150 
//  151     /* 清除没赋初值或者初值为0的变量数据值 */
//  152     n = bss_end - bss_start;
        SUBS     R0,R5,R9
        MOV      R8,R0
//  153     while(n--)
??common_startup_4:
        MOV      R0,R8
        SUBS     R8,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??common_startup_5
//  154         *bss_start++ = 0;
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
        ADDS     R9,R9,#+1
        B.N      ??common_startup_4
//  155 
//  156     /* 赋值用 __ramfunc 声明的函数的的代码段到 RAM，可以加快代码的运行        */
//  157     uint8 *code_relocate_ram = __section_begin("CodeRelocateRam");
??common_startup_5:
        LDR.N    R0,??DataTable3_15
//  158     uint8 *code_relocate = __section_begin("CodeRelocate");
        LDR.N    R1,??DataTable3_16
//  159     uint8 *code_relocate_end = __section_end("CodeRelocate");
        LDR.N    R2,??DataTable3_17
//  160 
//  161     /* 从ROM里复制函数代码到RAM里 */
//  162     n = code_relocate_end - code_relocate;
        SUBS     R3,R2,R1
        MOV      R8,R3
//  163     while (n--)
??common_startup_6:
        MOV      R3,R8
        SUBS     R8,R3,#+1
        CMP      R3,#+0
        BEQ.N    ??common_startup_7
//  164         *code_relocate_ram++ = *code_relocate++;
        LDRB     R3,[R1, #+0]
        STRB     R3,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
        B.N      ??common_startup_6
//  165 
//  166 }
??common_startup_7:
        POP      {R0,R4-R9,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     core_clk_mhz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x40048044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x40048004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x40049018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     __VECTOR_RAM

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     __VECTOR_TABLE

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     SFB(`.data`)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     SFB(`.data_init`)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     SFE(`.data_init`)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     SFB(`.bss`)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     SFE(`.bss`)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     SFB(CodeRelocateRam)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     SFB(CodeRelocate)

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     SFE(CodeRelocate)

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
//  12 bytes in section .bss
// 348 bytes in section .text
// 
// 348 bytes of CODE memory
//  12 bytes of DATA memory
//
//Errors: none
//Warnings: none
