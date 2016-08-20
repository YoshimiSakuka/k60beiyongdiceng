///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  00:13:59
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Ultrasonic.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Ultrasonic.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\Ultrasonic.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN __aeabi_d2f
        EXTERN __aeabi_dadd
        EXTERN __aeabi_dmul
        EXTERN __aeabi_f2d
        EXTERN __aeabi_l2d
        EXTERN gpio_init

        PUBLIC DistanceCal
        PUBLIC DistanceCollect
        PUBLIC DistanceConfim
        PUBLIC DistanceNew
        PUBLIC Ultra_Init
        PUBLIC Ultrasonic

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Ultrasonic.c
//    1 #include "Ultrasonic.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable2  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R3,R0,#+5
        STR      R1,[R2, R3, LSL #+2]
        BX       LR               ;; return
//    2 
//    3 
//    4 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    5 float DistanceCollect[3];
DistanceCollect:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    6 float DistanceNew;
DistanceNew:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    7 float DistanceCal[3];
DistanceCal:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    8 float DistanceConfim;
DistanceConfim:
        DS8 4
//    9 
//   10 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   11 void Ultra_Init(void)  //右
//   12 {
Ultra_Init:
        PUSH     {R4,LR}
//   13   int i;
//   14   gpio_init (TRIG, GPO, 1);
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+18
        BL       gpio_init
//   15   for(i=0;i<500;i++);
        MOVS     R0,#+0
        MOVS     R4,R0
??Ultra_Init_0:
        CMP      R4,#+500
        BGE.N    ??Ultra_Init_1
        ADDS     R4,R4,#+1
        B.N      ??Ultra_Init_0
//   16   gpio_init (TRIG, GPO, 0);
??Ultra_Init_1:
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+18
        BL       gpio_init
//   17   PORTC_PCR0=PORT_PCR_MUX(1)|PORT_PCR_IRQC(9);
        LDR.N    R0,??DataTable2_1  ;; 0x90100
        LDR.N    R1,??DataTable2_2  ;; 0x4004b000
        STR      R0,[R1, #+0]
//   18   enable_irq(PORTC_IRQn);
        MOVS     R0,#+89
        BL       NVIC_EnableIRQ
//   19 }
        POP      {R4,PC}          ;; return
//   20 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 void Ultrasonic(void)
//   22 {
Ultrasonic:
        PUSH     {R3-R5,LR}
//   23    
//   24         static uint8 SendFlag = 0;
//   25         static int64 StartTime, FinishTime;
//   26         if(SendFlag==0)
        LDR.N    R0,??DataTable2_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Ultrasonic_0
//   27         {
//   28           StartTime=PIT_CVAL1 ;
        LDR.N    R0,??DataTable2_4  ;; 0x40037114
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_5
        STRD     R0,R1,[R2, #+0]
//   29           SendFlag=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable2_3
        STRB     R0,[R1, #+0]
//   30           PORTC_PCR0=PORT_PCR_MUX(1)|PORT_PCR_IRQC(10);
        LDR.N    R0,??DataTable2_6  ;; 0xa0100
        LDR.N    R1,??DataTable2_2  ;; 0x4004b000
        STR      R0,[R1, #+0]
        B.N      ??Ultrasonic_1
//   31         }
//   32         else if(SendFlag==1)
??Ultrasonic_0:
        LDR.N    R0,??DataTable2_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??Ultrasonic_1
//   33         {
//   34             FinishTime=PIT_CVAL1;
        LDR.N    R0,??DataTable2_4  ;; 0x40037114
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_7
        STRD     R0,R1,[R2, #+0]
//   35             SendFlag=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STRB     R0,[R1, #+0]
//   36             PIT_TFLG1 = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable2_8  ;; 0x4003711c
        STR      R0,[R1, #+0]
//   37             if((StartTime-FinishTime)<0)
        LDR.N    R0,??DataTable2_5
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable2_7
        LDRD     R4,R5,[R0, #+0]
        SUBS     R0,R2,R4
        SBCS     R1,R3,R5
        CMP      R1,#+0
        BGT.N    ??Ultrasonic_2
        BLT.N    ??Ultrasonic_3
        CMP      R0,#+0
        BCS.N    ??Ultrasonic_2
//   38             {
//   39               DistanceNew=0.00011*(StartTime-FinishTime+15000000);
??Ultrasonic_3:
        LDR.N    R0,??DataTable2_5
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable2_7
        LDRD     R4,R5,[R0, #+0]
        SUBS     R0,R2,R4
        SBCS     R1,R3,R5
        LDR.N    R2,??DataTable2_9  ;; 0xe4e1c0
        MOVS     R3,#+0
        ADDS     R0,R0,R2
        ADCS     R1,R1,R3
        BL       __aeabi_l2d
        LDR.N    R2,??DataTable2_10  ;; 0x9c38b04b
        LDR.N    R3,??DataTable2_11  ;; 0x3f1cd5f9
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        LDR.N    R1,??DataTable2_12
        STR      R0,[R1, #+0]
        B.N      ??Ultrasonic_4
//   40             }     
//   41             else if((StartTime-FinishTime)>0)
??Ultrasonic_2:
        LDR.N    R0,??DataTable2_5
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable2_7
        LDRD     R4,R5,[R0, #+0]
        SUBS     R0,R2,R4
        SBCS     R1,R3,R5
        CMP      R1,#+0
        BLT.N    ??Ultrasonic_4
        BGT.N    ??Ultrasonic_5
        CMP      R0,#+1
        BCC.N    ??Ultrasonic_4
//   42             DistanceNew=0.00011*(StartTime-FinishTime);
??Ultrasonic_5:
        LDR.N    R0,??DataTable2_5
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable2_7
        LDRD     R4,R5,[R0, #+0]
        SUBS     R0,R2,R4
        SBCS     R1,R3,R5
        BL       __aeabi_l2d
        LDR.N    R2,??DataTable2_10  ;; 0x9c38b04b
        LDR.N    R3,??DataTable2_11  ;; 0x3f1cd5f9
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        LDR.N    R1,??DataTable2_12
        STR      R0,[R1, #+0]
//   43         DistanceCollect[2]=DistanceCollect[1];
??Ultrasonic_4:
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+4]
        LDR.N    R1,??DataTable2_13
        STR      R0,[R1, #+8]
//   44         DistanceCollect[1]=DistanceCollect[0];
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable2_13
        STR      R0,[R1, #+4]
//   45         DistanceCollect[0]=DistanceNew;  
        LDR.N    R0,??DataTable2_12
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable2_13
        STR      R0,[R1, #+0]
//   46 
//   47         DistanceConfim=0.1*DistanceCollect[2]+0.3*DistanceCollect[1]+DistanceCollect[0]*0.6;
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+8]
        BL       __aeabi_f2d
        LDR.N    R2,??DataTable2_14  ;; 0x9999999a
        LDR.N    R3,??DataTable2_15  ;; 0x3fb99999
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+4]
        BL       __aeabi_f2d
        MOVS     R2,#+858993459
        LDR.N    R3,??DataTable2_16  ;; 0x3fd33333
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        MOVS     R2,#+858993459
        LDR.N    R3,??DataTable2_17  ;; 0x3fe33333
        BL       __aeabi_dmul
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2f
        LDR.N    R1,??DataTable2_18
        STR      R0,[R1, #+0]
//   48         }   
//   49    
//   50   PORTC_PCR0|=PORT_PCR_ISF_MASK;//清除中断标志位
??Ultrasonic_1:
        LDR.N    R0,??DataTable2_2  ;; 0x4004b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.N    R1,??DataTable2_2  ;; 0x4004b000
        STR      R0,[R1, #+0]
//   51 
//   52 
//   53 
//   54 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x90100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x4004b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ??SendFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x40037114

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ??StartTime

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     0xa0100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ??FinishTime

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     0x4003711c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     0xe4e1c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     0x9c38b04b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     0x3f1cd5f9

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     DistanceNew

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     DistanceCollect

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_14:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_15:
        DC32     0x3fb99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_16:
        DC32     0x3fd33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_17:
        DC32     0x3fe33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_18:
        DC32     DistanceConfim

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
??SendFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
??StartTime:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
??FinishTime:
        DS8 8

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
//  49 bytes in section .bss
// 480 bytes in section .text
// 
// 480 bytes of CODE memory
//  49 bytes of DATA memory
//
//Errors: none
//Warnings: none
