///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:25
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_dac.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_dac.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_dac.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC DACN
        PUBLIC dac_init
        PUBLIC dac_out

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_dac.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_dac.c
//   11  * @brief      DAC函数
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-08-28
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_dac.h"
//   19 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20 DAC_MemMapPtr DACN[2] = {DAC0_BASE_PTR, DAC1_BASE_PTR}; //定义两个指针数组保存 DACN 的地址
DACN:
        DATA
        DC32 400CC000H, 400CD000H
//   21 
//   22 
//   23 /*!
//   24  *  @brief      DAC初始化
//   25  *  @param      DACn_e      DAC模块号
//   26  *  @since      v5.0
//   27  *  Sample usage:       dac_init (DAC1 );    //初始化 DAC1
//   28  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 void dac_init(DACn_e dacn)
//   30 {
//   31     /* 使能时钟 */
//   32     SIM_SCGC2 |= (SIM_SCGC2_DAC0_MASK << dacn) ;    //使能DAC模块
dac_init:
        LDR.N    R1,??DataTable1  ;; 0x4004802c
        LDR      R1,[R1, #+0]
        MOV      R2,#+4096
        LSLS     R2,R2,R0
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable1  ;; 0x4004802c
        STR      R1,[R2, #+0]
//   33 
//   34     /*  配置DAC寄存器  */
//   35 
//   36     //配置DAC_C0寄存器
//   37     DAC_C0_REG(DACN[dacn])  = ( 0
//   38                                 |  DAC_C0_DACTRGSEL_MASK                //选择软件触发
//   39                                 |  DAC_C0_DACRFS_MASK                   //选择参考VDD电压(3.3V)
//   40                                 |  DAC_C0_DACEN_MASK                    //使能DAC模块
//   41                               );
        MOVS     R1,#+224
        LDR.N    R2,??DataTable1_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+33]
//   42 
//   43     //配置DAC_C1寄存器
//   44     DAC_C1_REG(DACN[dacn]) = ( 0
//   45                              ) ;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable1_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+34]
//   46     //配置DAC_C2寄存器
//   47     DAC_C2_REG(DACN[dacn]) = ( 0
//   48                                | DAC_C2_DACBFRP(0)             //设置缓冲区读指针指向0
//   49                              );
        MOVS     R1,#+0
        LDR.N    R2,??DataTable1_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+35]
//   50 
//   51     DAC_DATH_REG(DACN[dacn], 0) = 0;   //默认输出最低电压
        MOVS     R1,#+0
        LDR.N    R2,??DataTable1_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+1]
//   52     DAC_DATL_REG(DACN[dacn], 0) = 0;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable1_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+0]
//   53 }
        BX       LR               ;; return
//   54 
//   55 /*!
//   56  *  @brief      DAC输出
//   57  *  @param      DACn_e      DAC模块号
//   58  *  @param      val         输出模拟量所对应的数字量（12bit）
//   59  *  @since      v5.0
//   60  *  Sample usage:       dac_out (DAC1 ,0x100);    //初始化 DAC1 输出 0x100 数字量对应的模拟量
//   61  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void dac_out(DACn_e dacn, uint16 val)
//   63 {
dac_out:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   64     ASSERT(val < 0x1000);               //val 为 12bit
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+4096
        BLT.N    ??dac_out_0
        MOVS     R1,#+64
        LDR.N    R0,??DataTable1_2
        BL       assert_failed
//   65 
//   66     DAC_DATH_REG(DACN[dacn], 0) = (val >> 8);   //输出电压
??dac_out_0:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSRS     R0,R5,#+8
        LDR.N    R1,??DataTable1_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+1]
//   67     DAC_DATL_REG(DACN[dacn], 0) = (val & 0xFF);
        LDR.N    R0,??DataTable1_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STRB     R5,[R0, #+0]
//   68 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x4004802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     DACN

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     ?_0

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
        DC8 72H, 63H, 5CH, 4DH, 4BH, 36H, 30H, 5FH
        DC8 64H, 61H, 63H, 2EH, 63H, 0
        DC8 0, 0

        END
// 
//   8 bytes in section .data
//  64 bytes in section .rodata
// 144 bytes in section .text
// 
// 144 bytes of CODE  memory
//  64 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
