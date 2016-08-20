///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:33
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_computer.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_computer.c
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_computer.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN uart_putbuff

        PUBLIC vcan_sendccd
        PUBLIC vcan_sendimg
        PUBLIC vcan_sendware

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_computer.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2015,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       VCAN_computer.c
//   11  * @brief      山外多功能调试助手上位机驱动代码
//   12  * @author     山外科技
//   13  * @version    v5.2.2
//   14  * @date       2015-03-24
//   15  */
//   16 
//   17 
//   18 /*
//   19  * 包含头文件
//   20  */
//   21 #include "common.h"
//   22 #include "MK60_uart.h"
//   23 #include "VCAN_computer.h"
//   24 
//   25 
//   26 
//   27 /*!
//   28  *  @brief      山外多功能调试助手上位机，摄像头显示函数
//   29  *  @param      imgaddr    图像起始地址
//   30  *  @param      imgsize    图像占用空间的大小
//   31  *  @since      v5.0
//   32 *  Sample usage:
//   33              具体用法参考这帖子:
//   34             【山外摄像头】鹰眼上位机例程和微焦效果 - 智能车资料区
//   35              http://vcan123.com/forum.php?mod=viewthread&tid=6242&ctid=27
//   36  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 void vcan_sendimg(void *imgaddr, uint32_t imgsize)
//   38 {
vcan_sendimg:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   39 #define CMD_IMG     1
//   40     uint8_t cmdf[2] = {CMD_IMG, ~CMD_IMG};    //山外上位机 使用的命令
        LDR.N    R0,??DataTable2
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+2]
//   41     uint8_t cmdr[2] = {~CMD_IMG, CMD_IMG};    //山外上位机 使用的命令
        LDR.N    R0,??DataTable2_1
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+0]
//   42 
//   43     uart_putbuff(VCAN_PORT, cmdf, sizeof(cmdf));    //先发送命令
        MOVS     R2,#+2
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        BL       uart_putbuff
//   44 
//   45     uart_putbuff(VCAN_PORT, (uint8_t *)imgaddr, imgsize); //再发送图像
        MOVS     R2,R5
        MOVS     R1,R4
        MOVS     R0,#+1
        BL       uart_putbuff
//   46 
//   47     uart_putbuff(VCAN_PORT, cmdr, sizeof(cmdr));    //先发送命令
        MOVS     R2,#+2
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        BL       uart_putbuff
//   48 }
        POP      {R0,R4,R5,PC}    ;; return
//   49 
//   50 
//   51 /*!
//   52  *  @brief      山外多功能调试助手上位机，线性CCD显示函数
//   53  *  @param      ccdaddr    CCD图像起始地址
//   54  *  @param      ccdsize    CCD图像占用空间的大小
//   55  *  @since      v5.0
//   56 *  Sample usage:
//   57              具体用法参考这帖子:
//   58             【山外线性CCD】上位机显示例程和超广角采集效果 - 智能车资料区
//   59              http://vcan123.com/forum.php?mod=viewthread&tid=6340&ctid=27
//   60  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   61 void vcan_sendccd(void *ccdaddr, uint32_t ccdsize)
//   62 {
vcan_sendccd:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   63 #define CMD_CCD     2
//   64     uint8_t cmdf[2] = {CMD_CCD, ~CMD_CCD};    //开头命令
        LDR.N    R0,??DataTable2_2
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+2]
//   65     uint8_t cmdr[2] = {~CMD_CCD, CMD_CCD};    //结尾命令
        LDR.N    R0,??DataTable2_3
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+0]
//   66 
//   67     uart_putbuff(VCAN_PORT, cmdf, sizeof(cmdf));    //先发送命令
        MOVS     R2,#+2
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        BL       uart_putbuff
//   68 
//   69     uart_putbuff(VCAN_PORT, (uint8_t *)ccdaddr, ccdsize); //再发送图像
        MOVS     R2,R5
        MOVS     R1,R4
        MOVS     R0,#+1
        BL       uart_putbuff
//   70 
//   71     uart_putbuff(VCAN_PORT, cmdr, sizeof(cmdr));    //再发送命令
        MOVS     R2,#+2
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        BL       uart_putbuff
//   72 }
        POP      {R0,R4,R5,PC}    ;; return
//   73 
//   74 
//   75 /*!
//   76  *  @brief      山外多功能调试助手上位机，虚拟示波器显示函数
//   77  *  @param      wareaddr    波形数组起始地址
//   78  *  @param      waresize    波形数组占用空间的大小
//   79  *  @since      v5.0
//   80 *  Sample usage:
//   81              具体用法参考这帖子:
//   82             【山外资料】陀螺仪和加速度 上位机显示例程 - 智能车资料区
//   83              http://vcan123.com/forum.php?mod=viewthread&tid=6253&ctid=27
//   84  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   85 void vcan_sendware(void *wareaddr, uint32_t waresize)
//   86 {
vcan_sendware:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   87 #define CMD_WARE     3
//   88     uint8_t cmdf[2] = {CMD_WARE, ~CMD_WARE};    //串口调试 使用的前命令
        LDR.N    R0,??DataTable2_4
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+2]
//   89     uint8_t cmdr[2] = {~CMD_WARE, CMD_WARE};    //串口调试 使用的后命令
        LDR.N    R0,??DataTable2_5
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+0]
//   90 
//   91     uart_putbuff(VCAN_PORT, cmdf, sizeof(cmdf));    //先发送前命令
        MOVS     R2,#+2
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        BL       uart_putbuff
//   92     uart_putbuff(VCAN_PORT, (uint8_t *)wareaddr, waresize);    //发送数据
        MOVS     R2,R5
        MOVS     R1,R4
        MOVS     R0,#+1
        BL       uart_putbuff
//   93     uart_putbuff(VCAN_PORT, cmdr, sizeof(cmdr));    //发送后命令
        MOVS     R2,#+2
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        BL       uart_putbuff
//   94 
//   95 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ?_5

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_0:
        DATA
        DC8 1, 254

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_1:
        DATA
        DC8 254, 1

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_2:
        DATA
        DC8 2, 253

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_3:
        DATA
        DC8 253, 2

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_4:
        DATA
        DC8 3, 252

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
?_5:
        DATA
        DC8 252, 3

        END
// 
//  12 bytes in section .rodata
// 192 bytes in section .text
// 
// 192 bytes of CODE  memory
//  12 bytes of CONST memory
//
//Errors: none
//Warnings: none
