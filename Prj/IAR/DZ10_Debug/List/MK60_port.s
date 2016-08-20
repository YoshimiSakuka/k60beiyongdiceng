///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:29
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_port.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_port.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_port.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC PORTX
        PUBLIC port_init
        PUBLIC port_init_NoALT
        PUBLIC porta_handler

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_port.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_port.c
//   11  * @brief      port复用配置和各种功能配置
//   12  * @author     山外科技
//   13  * @version    v5.1
//   14  * @date       2014-04-25
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_port.h"
//   19 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20 PORT_MemMapPtr PORTX[PTX_MAX] = {PORTA_BASE_PTR, PORTB_BASE_PTR, PORTC_BASE_PTR, PORTD_BASE_PTR, PORTE_BASE_PTR};
PORTX:
        DATA
        DC32 40049000H, 4004A000H, 4004B000H, 4004C000H, 4004D000H
//   21 
//   22 /*!
//   23  *  @brief      PORT初始化
//   24  *  @param      PTxn    端口
//   25  *  @param      cfg     端口属性配置，如触发选项和上拉下拉选项
//   26  *  @since      v5.0
//   27  *  @note       与port_init_NoALT不同的是，此函数需要配置 MUX 复用功能，
//   28                 否则 MUX = ALT0
//   29  *  Sample usage:       port_init (PTA8, IRQ_RISING | PF | ALT1 | PULLUP );    //初始化 PTA8 管脚，上升沿触发中断，带无源滤波器，复用功能为GPIO ，上拉电阻
//   30  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   31 void  port_init(PTXn_e ptxn, uint32 cfg )
//   32 {
port_init:
        PUSH     {R4}
//   33     SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK << PTX(ptxn));                           //开启PORTx端口
        LDR.N    R2,??DataTable2  ;; 0x40048038
        LDR      R2,[R2, #+0]
        MOV      R3,#+512
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R4,R0,#+5
        LSLS     R3,R3,R4
        ORRS     R2,R3,R2
        LDR.N    R3,??DataTable2  ;; 0x40048038
        STR      R2,[R3, #+0]
//   34 
//   35     PORT_ISFR_REG(PORTX_BASE(ptxn)) = (1<<PTn(ptxn));                           // 清空标志位
        LDR.N    R2,??DataTable2_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ASRS     R3,R0,#+5
        LDR      R2,[R2, R3, LSL #+2]
        MOVS     R3,#+1
        ANDS     R4,R0,#0x1F
        LSLS     R3,R3,R4
        STR      R3,[R2, #+160]
//   36 
//   37     PORT_PCR_REG(PORTX_BASE(ptxn), PTn(ptxn)) = cfg;                            // 复用功能 , 确定触发模式 ,开启上拉或下拉电阻
        LDR.N    R2,??DataTable2_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ASRS     R3,R0,#+5
        LDR      R2,[R2, R3, LSL #+2]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ANDS     R3,R0,#0x1F
        STR      R1,[R2, R3, LSL #+2]
//   38 }
        POP      {R4}
        BX       LR               ;; return
//   39 
//   40 /*!
//   41  *  @brief      PORT初始化
//   42  *  @param      PTxn    端口
//   43  *  @param      cfg     端口属性配置，如触发选项和上拉下拉选项
//   44  *  @since      v5.0
//   45  *  @note       与port_init不同的是，此函数不需要配置 MUX 复用功能（即使配置了也不生效），
//   46                 MUX 保留 为原先寄存器配置的值
//   47  *  Sample usage:       port_init_NoALT (PTA8, IRQ_RISING | PF | PULLUP );    //初始化 PTA8 管脚，上升沿触发中断，带无源滤波器，保留原先复用功能，上拉电阻
//   48  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void  port_init_NoALT(PTXn_e ptxn, uint32 cfg)
//   50 {
port_init_NoALT:
        PUSH     {R4}
//   51     SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK << PTX(ptxn));                           //开启PORTx端口
        LDR.N    R2,??DataTable2  ;; 0x40048038
        LDR      R2,[R2, #+0]
        MOV      R3,#+512
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R4,R0,#+5
        LSLS     R3,R3,R4
        ORRS     R2,R3,R2
        LDR.N    R3,??DataTable2  ;; 0x40048038
        STR      R2,[R3, #+0]
//   52 
//   53     PORT_ISFR_REG(PORTX_BASE(ptxn)) = (1<<PTn(ptxn));                           // 清空标志位
        LDR.N    R2,??DataTable2_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ASRS     R3,R0,#+5
        LDR      R2,[R2, R3, LSL #+2]
        MOVS     R3,#+1
        ANDS     R4,R0,#0x1F
        LSLS     R3,R3,R4
        STR      R3,[R2, #+160]
//   54 
//   55     //清空cfg里的MUX，加载寄存器里的MUX
//   56     cfg &= ~PORT_PCR_MUX_MASK;                      //清了MUX 字段（即不需要配置ALT，保持原来的ALT）
        BICS     R1,R1,#0x700
//   57     cfg |=  (PORT_PCR_REG(PORTX_BASE(ptxn), PTn(ptxn)) & PORT_PCR_MUX_MASK);    //读取寄存器里配置的 MUX
        LDR.N    R2,??DataTable2_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ASRS     R3,R0,#+5
        LDR      R2,[R2, R3, LSL #+2]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ANDS     R3,R0,#0x1F
        LDR      R2,[R2, R3, LSL #+2]
        ANDS     R2,R2,#0x700
        ORRS     R1,R2,R1
//   58 
//   59     PORT_PCR_REG(PORTX_BASE(ptxn), PTn(ptxn)) = cfg;            // 复用功能 , 确定触发模式 ,开启上拉或下拉电阻
        LDR.N    R2,??DataTable2_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ASRS     R3,R0,#+5
        LDR      R2,[R2, R3, LSL #+2]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ANDS     R3,R0,#0x1F
        STR      R1,[R2, R3, LSL #+2]
//   60 }
        POP      {R4}
        BX       LR               ;; return
//   61 
//   62 /*!
//   63  *  @brief      PORTA的参考中断服务函数
//   64  *  @since      v5.0
//   65  *  @warning    此函数需要用户根据自己需求完成，这里仅仅是提供一个模版
//   66  *  Sample usage:       set_vector_handler(PORTA_VECTORn , porta_handler);    //把 porta_handler 函数添加到中断向量表，不需要我们手动调用
//   67  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   68 void porta_handler(void)
//   69 {
//   70     uint8  n = 0;    //引脚号
porta_handler:
        MOVS     R0,#+0
//   71 
//   72     //PTA6
//   73     n = 6;
        MOVS     R1,#+6
        MOVS     R0,R1
//   74     if(PORTA_ISFR & (1 << n))           //PTA6触发中断
        LDR.N    R1,??DataTable2_2  ;; 0x400490a0
        LDR      R1,[R1, #+0]
        MOVS     R2,R1
        LSRS     R2,R2,R0
        LSLS     R1,R2,#+31
        BPL.N    ??porta_handler_0
//   75     {
//   76         PORTA_ISFR  = (1 << n);        //写1清中断标志位
        MOVS     R1,#+1
        LSLS     R1,R1,R0
        LDR.N    R2,??DataTable2_2  ;; 0x400490a0
        STR      R1,[R2, #+0]
//   77 
//   78         /*  以下为用户任务  */
//   79 
//   80 
//   81         /*  以上为用户任务  */
//   82     }
//   83 
//   84     //假设 PTA7 需要执行的用户任务函数为 func() ，则可以直接调用如下宏定义：
//   85     //PORT_FUNC(A,7,func);
//   86     //这个宏的作用与上面 PTA6 的效果是一样的，只不过是简化了用户的输入
//   87 }
??porta_handler_0:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     PORTX

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x400490a0

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
//  20 bytes in section .data
// 206 bytes in section .text
// 
// 206 bytes of CODE memory
//  20 bytes of DATA memory
//
//Errors: none
//Warnings: none
