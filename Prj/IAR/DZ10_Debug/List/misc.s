///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:24
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\misc.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\misc.c -D DEBUG -D
//        ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\misc.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN __VECTOR_RAM
        EXTERN assert_failed

        PUBLIC set_vector_handler
        PUBLIC vcan_cpy
        PUBLIC write_vtor

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\misc.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       misc.c
//   11  * @brief      山外K60 平台其他需要用到的函数的实现
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-06-26
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_uart.h"
//   19 
//   20 
//   21 /*!
//   22  *  @brief      设置中断向量表地址
//   23  *  @param      vtor    新的中断向量表地址
//   24  *  @since      v5.0
//   25  *  @author     飞思卡尔公司
//   26  *  Sample usage:       write_vtor ((uint32)__VECTOR_RAM);  //新的中断向量地址
//   27  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void write_vtor (int vtor)
//   29 {
write_vtor:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   30     ASSERT(vtor % 0x200 == 0);   //Vector Table base offset field. This value must be a multiple of 0x200.
        MOV      R0,#+512
        SDIV     R1,R4,R0
        MLS      R1,R1,R0,R4
        CMP      R1,#+0
        BEQ.N    ??write_vtor_0
        MOVS     R1,#+30
        LDR.N    R0,??DataTable1
        BL       assert_failed
//   31 
//   32     /* Write the VTOR with the new value */
//   33     SCB->VTOR = vtor;
??write_vtor_0:
        LDR.N    R0,??DataTable1_1  ;; 0xe000ed08
        STR      R4,[R0, #+0]
//   34 }
        POP      {R4,PC}          ;; return
//   35 
//   36 
//   37 
//   38 /*!
//   39  *  @brief      设置中断向量表里的中断服务函数
//   40  *  @since      v5.0
//   41  *  @warning    只有中断向量表位于icf指定的RAM区域时，此函数才有效
//   42  *  Sample usage:       set_vector_handler(UART3_RX_TX_VECTORn , uart3_handler);    //把 uart3_handler 函数添加到中断向量表
//   43  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   44 void set_vector_handler(VECTORn_t vector , void pfunc_handler(void))
//   45 {
set_vector_handler:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   46     extern uint32 __VECTOR_RAM[];
//   47 
//   48     ASSERT(SCB->VTOR == (uint32)__VECTOR_RAM);  //断言，检测中断向量表是否在 RAM 里
        LDR.N    R0,??DataTable1_1  ;; 0xe000ed08
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable1_2
        CMP      R0,R1
        BEQ.N    ??set_vector_handler_0
        MOVS     R1,#+48
        LDR.N    R0,??DataTable1
        BL       assert_failed
//   49 
//   50     __VECTOR_RAM[vector] = (uint32)pfunc_handler;
??set_vector_handler_0:
        LDR.N    R0,??DataTable1_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R5,[R0, R4, LSL #+2]
//   51 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0xe000ed08

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     __VECTOR_RAM
//   52 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 void vcan_cpy( uint8 *dst, uint8 *src, uint32 count)
//   54 {
vcan_cpy:
        PUSH     {R4,R5}
//   55     uint32 n;
//   56     if(count != 0)
        CMP      R2,#+0
        BEQ.N    ??vcan_cpy_0
//   57     {
//   58         //printf("-");
//   59 
//   60         n = (count + 7 ) / 8 ;
        ADDS     R4,R2,#+7
        LSRS     R4,R4,#+3
        MOVS     R3,R4
//   61         switch (count % 8 )
        MOVS     R4,#+8
        UDIV     R5,R2,R4
        MLS      R5,R5,R4,R2
        CMP      R5,#+0
        BEQ.N    ??vcan_cpy_1
        CMP      R5,#+2
        BEQ.N    ??vcan_cpy_2
        BCC.N    ??vcan_cpy_3
        CMP      R5,#+4
        BEQ.N    ??vcan_cpy_4
        BCC.N    ??vcan_cpy_5
        CMP      R5,#+6
        BEQ.N    ??vcan_cpy_6
        BCC.N    ??vcan_cpy_7
        CMP      R5,#+7
        BEQ.N    ??vcan_cpy_8
        B.N      ??vcan_cpy_0
//   62         {
//   63             do
//   64             {
//   65             case 0 :
//   66                 * dst ++ = * src ++ ;
??vcan_cpy_1:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   67             case 7 :
//   68                 * dst ++ = * src ++ ;
??vcan_cpy_8:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   69             case 6 :
//   70                 * dst ++ = * src ++ ;
??vcan_cpy_6:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   71             case 5 :
//   72                 * dst ++ = * src ++ ;
??vcan_cpy_7:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   73             case 4 :
//   74                 * dst ++ = * src ++ ;
??vcan_cpy_4:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   75             case 3 :
//   76                 * dst ++ = * src ++ ;
??vcan_cpy_5:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   77             case 2 :
//   78                 * dst ++ = * src ++ ;
??vcan_cpy_2:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   79             case 1 :
//   80                 * dst ++ = * src ++ ;
??vcan_cpy_3:
        LDRB     R4,[R1, #+0]
        STRB     R4,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
//   81             }
//   82             while ( -- n >    0 );
        SUBS     R3,R3,#+1
        CMP      R3,#+0
        BNE.N    ??vcan_cpy_1
//   83         }
//   84     }
//   85 }
??vcan_cpy_0:
        POP      {R4,R5}
        BX       LR               ;; return

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
        DC8 44H, 3AH, 5CH, 53H, 74H, 75H, 64H, 79H
        DC8 5CH, 32H, 30H, 31H, 36H, 0B5H, 0E7H, 0D7H
        DC8 0D3H, 0C9H, 0E8H, 0BCH, 0C6H, 0B4H, 0F3H, 0C8H
        DC8 0FCH, 5CH, 54H, 69H, 5CH, 0B5H, 0E7H, 0C8H
        DC8 0FCH, 0B1H, 0B8H, 0D3H, 0C3H, 0B5H, 0D7H, 0B2H
        DC8 0E3H, 5CH, 43H, 68H, 69H, 70H, 5CH, 73H
        DC8 72H, 63H, 5CH, 6DH, 69H, 73H, 63H, 2EH
        DC8 63H, 0
        DC8 0, 0

        END
//   86 
// 
//  60 bytes in section .rodata
// 204 bytes in section .text
// 
// 204 bytes of CODE  memory
//  60 bytes of CONST memory
//
//Errors: none
//Warnings: none
