///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:14
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_MMA7455.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_MMA7455.c -D
//        DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\
//        -lB
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\ -o
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\Obj\
//        --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa
//        --no_clustering --no_scheduling --debug --endian=little
//        --cpu=Cortex-M4 -e --fpu=None --dlib_config "E:\IAR for
//        ARM\arm\INC\c\DLib_Config_Full.h" -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\App\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\App\Inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\IAR\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\kinetis\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\CMSIS\Inc\
//        -I D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\FatFs\
//        -I D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\USB\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\MPU6050\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\IMU\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\Driver\
//        -On
//    List file    =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_MMA7455.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN i2c_init
        EXTERN i2c_read_reg
        EXTERN i2c_write_reg

        PUBLIC mma7455_init
        PUBLIC mma7455_read_reg
        PUBLIC mma7455_write_reg

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_MMA7455.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       VCAN_MMA7455.c
//   11  * @brief      MMA7455��������ʵ��
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.0
//   14  * @date       2013-07-9
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_port.h"
//   19 #include "MK60_i2c.h"
//   20 #include "VCAN_MMA7455.h"
//   21 
//   22 //�궨����õײ��I2C�ӿ�
//   23 #define MMA7455_OPEN(baud)      i2c_init(MMA7455_DEVICE,baud)
//   24 #define MMA7455_WR(reg,value)   i2c_write_reg(MMA7455_DEVICE,MMA7455_ADRESS,reg,value)  //mma7455 д�Ĵ���
//   25 #define MMA7455_RD(reg)         i2c_read_reg(MMA7455_DEVICE,MMA7455_ADRESS,reg)         //mma7455 ���Ĵ���
//   26 
//   27 /*!
//   28  *  @brief      MMA7455��ʼ�������� 2g ���̲���ģʽ
//   29  *  @since      v5.0
//   30  *  Sample usage:            mma7455_init();    //��ʼ�� MMA7455
//   31  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   32 void mma7455_init(void)
//   33 {
mma7455_init:
        PUSH     {R7,LR}
//   34     MMA7455_OPEN(400 * 1000);           //��ʼ��mma7455�ӿڣ����ò����� 400k
        LDR.N    R1,??DataTable0  ;; 0x61a80
        MOVS     R0,#+0
        BL       i2c_init
//   35 
//   36     /*MMA���� 2g ���̲���ģʽ*/
//   37     MMA7455_WR(MMA7455_MCTL, 0x05);
        MOVS     R3,#+5
        MOVS     R2,#+22
        MOVS     R1,#+29
        MOVS     R0,#+0
        BL       i2c_write_reg
//   38 
//   39     /*DRDY����λ,�ȴ��������*/
//   40     while(!(MMA7455_RD(MMA7455_STATUS) & 0x01));
??mma7455_init_0:
        MOVS     R2,#+9
        MOVS     R1,#+29
        MOVS     R0,#+0
        BL       i2c_read_reg
        LSLS     R0,R0,#+31
        BPL.N    ??mma7455_init_0
//   41 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x61a80
//   42 
//   43 /*!
//   44  *  @brief      MMA7455д�Ĵ���
//   45  *  @param      reg         �Ĵ���
//   46  *  @param      dat         ��Ҫд������ݵļĴ�����ַ
//   47  *  @since      v5.0
//   48  *  Sample usage:       mma7455_write_reg(MMA7455_XOFFL,0);   // д�Ĵ��� MMA7455_XOFFL Ϊ 0
//   49  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   50 void mma7455_write_reg(uint8 reg, uint8 Data)
//   51 {
mma7455_write_reg:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   52     MMA7455_WR(reg, Data);
        MOVS     R3,R5
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,R4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+29
        MOVS     R0,#+0
        BL       i2c_write_reg
//   53 }
        POP      {R0,R4,R5,PC}    ;; return
//   54 
//   55 /*!
//   56  *  @brief      MMA7455���Ĵ���
//   57  *  @param      reg         �Ĵ���
//   58  *  @param      dat         ��Ҫ��ȡ���ݵļĴ�����ַ
//   59  *  @since      v5.0
//   60  *  Sample usage:       uint8 data = mma7455_read_reg(MMA7455_XOFFL);    // ���Ĵ��� MMA7455_XOFFL
//   61  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 uint8 mma7455_read_reg(uint8 reg)
//   63 {
mma7455_read_reg:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   64     return MMA7455_RD(reg);
        MOVS     R2,R4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,#+29
        MOVS     R0,#+0
        BL       i2c_read_reg
        POP      {R4,PC}          ;; return
//   65 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   66 
//   67 
// 
// 84 bytes in section .text
// 
// 84 bytes of CODE memory
//
//Errors: none
//Warnings: none
