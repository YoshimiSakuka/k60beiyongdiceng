///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:31
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_wdog.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_wdog.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_wdog.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC wdog_disable
        PUBLIC wdog_enable
        PUBLIC wdog_feed
        PUBLIC wdog_init_ms

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_wdog.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_wdog.c
//   11  * @brief      ���Ź���������
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.1
//   14  * @date       2014-04-25
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_wdog.h"
//   19 
//   20 //�ڲ���������
//   21 static void wdog_unlock(void);          //���Ź�����
//   22 
//   23 /*!
//   24  *  @brief      ��ʼ�����Ź�������ι��ʱ��
//   25  *  @param      cnt     ι��ʱ�䣨��λΪ ms��
//   26  *  @since      v5.0
//   27  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void wdog_init_ms(uint32 ms)
//   29 {
wdog_init_ms:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   30     ASSERT(ms >= 4);                                //���ԣ�����ʱ����СΪ4��ʱ�����ڣ�WDOG_TOVALL��˵����
        CMP      R4,#+4
        BCS.N    ??wdog_init_ms_0
        MOVS     R1,#+30
        LDR.N    R0,??DataTable4
        BL       assert_failed
//   31 
//   32     wdog_unlock();                                  //�������Ź��������������ÿ��Ź�
??wdog_init_ms_0:
        BL       wdog_unlock
//   33 
//   34     WDOG_PRESC = WDOG_PRESC_PRESCVAL(0);            //���÷�Ƶϵ�� = PRESCVAL +1(PRESCVALȡֵ��ΧΪ0~7)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_1  ;; 0x40052016
        STRH     R0,[R1, #+0]
//   35 
//   36     WDOG_TOVALH = ms >> 16;                         //����ι��ʱ��
        LSRS     R0,R4,#+16
        LDR.N    R1,??DataTable4_2  ;; 0x40052004
        STRH     R0,[R1, #+0]
//   37     WDOG_TOVALL = (uint16)ms;
        LDR.N    R0,??DataTable4_3  ;; 0x40052006
        STRH     R4,[R0, #+0]
//   38 
//   39     WDOG_STCTRLH = ( 0
//   40                     | WDOG_STCTRLH_WDOGEN_MASK     //WDOGEN��λ��ʹ�� ���Ź�
//   41                     //| WDOG_STCTRLH_CLKSRC_MASK   //���Ź�ʱ��ѡ��0Ϊ LDO ��1Ϊbus ʱ�ӣ�
//   42                     | WDOG_STCTRLH_ALLOWUPDATE_MASK
//   43                     | WDOG_STCTRLH_STOPEN_MASK
//   44                     | WDOG_STCTRLH_WAITEN_MASK
//   45                     | WDOG_STCTRLH_STNDBYEN_MASK
//   46                     //|
//   47                     );
        MOVW     R0,#+465
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   48 }
        POP      {R4,PC}          ;; return
//   49 
//   50 
//   51 /*!
//   52  *  @brief      ���ÿ��Ź�
//   53  *  @since      v5.0
//   54  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   55 void wdog_enable(void)
//   56 {
wdog_enable:
        PUSH     {R7,LR}
//   57     wdog_unlock();                                  //�������Ź��������������ÿ��Ź�
        BL       wdog_unlock
//   58 
//   59     WDOG_STCTRLH |= WDOG_STCTRLH_WDOGEN_MASK;       //WDOGEN��λ��ʹ�� ���Ź�
        LDR.N    R0,??DataTable4_4  ;; 0x40052000
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   60 }
        POP      {R0,PC}          ;; return
//   61 
//   62 
//   63 /*!
//   64  *  @brief      ���ÿ��Ź�
//   65  *  @since      v5.0
//   66  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void wdog_disable(void)
//   68 {
wdog_disable:
        PUSH     {R7,LR}
//   69     wdog_unlock();                                  //�������Ź��������������ÿ��Ź�
        BL       wdog_unlock
//   70 
//   71     WDOG_STCTRLH &= ~WDOG_STCTRLH_WDOGEN_MASK;      //WDOGEN��0������ ���Ź�
        LDR.N    R0,??DataTable4_4  ;; 0x40052000
        LDRH     R0,[R0, #+0]
        MOVW     R1,#+65534
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable4_4  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   72 }
        POP      {R0,PC}          ;; return
//   73 
//   74 /*!
//   75  *  @brief      ι��
//   76  *  @since      v5.0
//   77  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 void wdog_feed(void)
//   79 {
//   80     //�˺������ܵ���ִ��
//   81 
//   82     //WDOG_REFRESH �Ĵ�����������������˼Ĵ���д��0xA602 ��0xB480���ɽ�����
//   83     //�м䲻�ó���20��ʱ�����ڣ������Ҫ�ȹ����ж�
//   84 
//   85     uint8 tmp = __get_BASEPRI();    //���ڷ��ؼĴ��� PRIMASK ��ֵ(1bit)
wdog_feed:
        MRS      R0,BASEPRI
//   86                                     //1��ʾ���жϣ�0��ʾ���ж�
//   87 
//   88     //�ر����жϣ������п���û���� 20������������д�� WDOG_UNLOCK
//   89     DisableInterrupts;
        CPSID    I
//   90 
//   91     //���� ���Ź���ι����
//   92     WDOG_REFRESH = 0xA602;
        MOVW     R1,#+42498
        LDR.N    R2,??DataTable4_5  ;; 0x4005200c
        STRH     R1,[R2, #+0]
//   93     WDOG_REFRESH = 0xB480;
        MOVW     R1,#+46208
        LDR.N    R2,??DataTable4_5  ;; 0x4005200c
        STRH     R1,[R2, #+0]
//   94 
//   95     if(tmp == 0)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??wdog_feed_0
//   96     {
//   97         EnableInterrupts;
        CPSIE    I
//   98     }
//   99 }
??wdog_feed_0:
        BX       LR               ;; return
//  100 
//  101 /*!
//  102  *  @brief      �������Ź�
//  103  *  @since      v5.0
//  104  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  105 void wdog_unlock(void)
//  106 {
//  107     //�˺������ܵ���ִ��
//  108 
//  109     //WDOG_UNLOCK �Ĵ�����������������˼Ĵ���д��0xC520��0xD928���ɽ�����
//  110     //�м䲻�ó���20��ʱ�����ڣ������Ҫ�ȹ����ж�
//  111     uint8 tmp = __get_BASEPRI();        //���ڷ��ؼĴ��� PRIMASK ��ֵ(1bit)
wdog_unlock:
        MRS      R0,BASEPRI
//  112                                         //1��ʾ���жϣ�0��ʾ���ж�
//  113 
//  114     //�ر����жϣ������п���û���� 20������������д�� WDOG_UNLOCK
//  115     DisableInterrupts;
        CPSID    I
//  116 
//  117     //���� ���Ź�
//  118     WDOG_UNLOCK = 0xC520;
        MOVW     R1,#+50464
        LDR.N    R2,??DataTable4_6  ;; 0x4005200e
        STRH     R1,[R2, #+0]
//  119     WDOG_UNLOCK = 0xD928;
        MOVW     R1,#+55592
        LDR.N    R2,??DataTable4_6  ;; 0x4005200e
        STRH     R1,[R2, #+0]
//  120 
//  121     if(tmp == 0)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??wdog_unlock_0
//  122     {
//  123         EnableInterrupts;
        CPSIE    I
//  124     }
//  125 }
??wdog_unlock_0:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x40052016

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40052004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40052006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40052000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x4005200c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x4005200e

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
        DC8 77H, 64H, 6FH, 67H, 2EH, 63H, 0
        DC8 0

        END
//  126 
// 
//  64 bytes in section .rodata
// 180 bytes in section .text
// 
// 180 bytes of CODE  memory
//  64 bytes of CONST memory
//
//Errors: none
//Warnings: none
