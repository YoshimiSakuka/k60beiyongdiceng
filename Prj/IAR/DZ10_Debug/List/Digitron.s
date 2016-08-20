///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  00:13:57
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Digitron.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Digitron.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\Digitron.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN GPIOX
        EXTERN gpio_init
        EXTERN gpio_set
        EXTERN systick_delay_ms

        PUBLIC Digit_Show
        PUBLIC Digitron_IO_Init
        PUBLIC Digitron_Show
        PUBLIC decade
        PUBLIC hundred
        PUBLIC thousand
        PUBLIC unit

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\Digitron.c
//    1 #include "Digitron.h"
//    2 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    3 int unit,decade,hundred,thousand;
unit:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
decade:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
hundred:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
thousand:
        DS8 4
//    4 
//    5 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    6 void Digitron_IO_Init(void)
//    7 {
Digitron_IO_Init:
        PUSH     {R7,LR}
//    8     gpio_init(PTC10,GPO,0); // a       
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+74
        BL       gpio_init
//    9     gpio_init(PTC11,GPO,0); // b
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+75
        BL       gpio_init
//   10     gpio_init(PTC12,GPO,0); // c
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+76
        BL       gpio_init
//   11     gpio_init(PTC13,GPO,0); // d
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+77
        BL       gpio_init
//   12     gpio_init(PTC14,GPO,0); // e
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+78
        BL       gpio_init
//   13     gpio_init(PTC15,GPO,0); // f
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+79
        BL       gpio_init
//   14     gpio_init(PTC16,GPO,0); // g
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+80
        BL       gpio_init
//   15     gpio_init(PTC17,GPO,0); // .
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+81
        BL       gpio_init
//   16     
//   17     gpio_init(PTC0,GPO,1); // 位选 0位  置0生效  
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_init
//   18     gpio_init(PTC1,GPO,1); //      1位
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_init
//   19     gpio_init(PTC2,GPO,1); //      2位
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+66
        BL       gpio_init
//   20     gpio_init(PTC3,GPO,1); //      3位
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+67
        BL       gpio_init
//   21     
//   22 
//   23     gpio_init(PTC4,GPO,0); // 段使能
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+68
        BL       gpio_init
//   24     gpio_init(PTC5,GPO,0); // 位使能
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+69
        BL       gpio_init
//   25     
//   26 }
        POP      {R0,PC}          ;; return
//   27 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void Digit_Show(int timecount)
//   29 {
//   30 
//   31 
//   32   switch(timecount)
Digit_Show:
        CMP      R0,#+0
        BEQ.N    ??Digit_Show_0
        CMP      R0,#+2
        BEQ.N    ??Digit_Show_1
        BCC.N    ??Digit_Show_2
        CMP      R0,#+4
        BEQ.N    ??Digit_Show_3
        BCC.N    ??Digit_Show_4
        CMP      R0,#+6
        BEQ.N    ??Digit_Show_5
        BCC.N    ??Digit_Show_6
        CMP      R0,#+8
        BEQ.N    ??Digit_Show_7
        BCC.N    ??Digit_Show_8
        CMP      R0,#+9
        BEQ.N    ??Digit_Show_9
        B.N      ??Digit_Show_10
//   33   {
//   34     case 0:  ZERO;  break;
??Digit_Show_0:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0xFC00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   35     case 1:  ONE;   break;
??Digit_Show_2:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1800
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   36     case 2:  TWO;   break;
??Digit_Show_1:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x16C00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   37     case 3:  THREE; break;
??Digit_Show_4:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x13C00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   38     case 4:  FOUR;  break;
??Digit_Show_3:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x19800
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   39     case 5:  FIVE;  break;
??Digit_Show_6:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1B400
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   40     case 6:  SIX;   break;
??Digit_Show_5:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1F400
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   41     case 7:  SEVEN; break;
??Digit_Show_8:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1C00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   42     case 8:  EIGHT; break;
??Digit_Show_7:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1FC00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   43     case 9:  NINE;  break;
??Digit_Show_9:
        LDR.N    R1,??DataTable1
        LDR      R1,[R1, #+8]
        LDR      R1,[R1, #+0]
        BICS     R1,R1,#0x3FC00
        ORRS     R1,R1,#0x1BC00
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+8]
        STR      R1,[R2, #+0]
        B.N      ??Digit_Show_11
//   44     default:        break;
//   45   }  
//   46 
//   47 }
??Digit_Show_10:
??Digit_Show_11:
        BX       LR               ;; return
//   48 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void Digitron_Show(void)
//   50 {
Digitron_Show:
        PUSH     {R7,LR}
//   51 
//   52 
//   53     
//   54     if(unit>=0)
        LDR.N    R0,??DataTable1_1
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BMI.N    ??Digitron_Show_0
//   55     {
//   56       gpio_set (PTC1, 1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   57       gpio_set (PTC2, 1);
        MOVS     R1,#+1
        MOVS     R0,#+66
        BL       gpio_set
//   58       gpio_set (PTC3, 1);
        MOVS     R1,#+1
        MOVS     R0,#+67
        BL       gpio_set
//   59       Digit_Show(unit);
        LDR.N    R0,??DataTable1_1
        LDR      R0,[R0, #+0]
        BL       Digit_Show
//   60       UNIT_SHOW;
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   61       DELAY_MS(1);
        MOVS     R0,#+1
        BL       systick_delay_ms
//   62     }
//   63     
//   64     if(decade>=0)
??Digitron_Show_0:
        LDR.N    R0,??DataTable1_2
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BMI.N    ??Digitron_Show_1
//   65     {
//   66       gpio_set (PTC0, 1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   67       gpio_set (PTC2, 1);
        MOVS     R1,#+1
        MOVS     R0,#+66
        BL       gpio_set
//   68       gpio_set (PTC3, 1);
        MOVS     R1,#+1
        MOVS     R0,#+67
        BL       gpio_set
//   69       Digit_Show(decade);
        LDR.N    R0,??DataTable1_2
        LDR      R0,[R0, #+0]
        BL       Digit_Show
//   70       DECADE_SHOW;
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_set
//   71       DELAY_MS(1);
        MOVS     R0,#+1
        BL       systick_delay_ms
//   72      }
//   73     
//   74     if(hundred>=0)
??Digitron_Show_1:
        LDR.N    R0,??DataTable1_3
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BMI.N    ??Digitron_Show_2
//   75     {
//   76       gpio_set (PTC0, 1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   77       gpio_set (PTC1, 1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   78       gpio_set (PTC3, 1);
        MOVS     R1,#+1
        MOVS     R0,#+67
        BL       gpio_set
//   79       Digit_Show(hundred);
        LDR.N    R0,??DataTable1_3
        LDR      R0,[R0, #+0]
        BL       Digit_Show
//   80       HUNDRED_SHOW;
        MOVS     R1,#+0
        MOVS     R0,#+66
        BL       gpio_set
//   81       DELAY_MS(1);
        MOVS     R0,#+1
        BL       systick_delay_ms
//   82      }
//   83 
//   84     if(thousand>=0)
??Digitron_Show_2:
        LDR.N    R0,??DataTable1_4
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BMI.N    ??Digitron_Show_3
//   85     {
//   86       gpio_set (PTC0, 1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   87       gpio_set (PTC1, 1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   88       gpio_set (PTC2, 1);
        MOVS     R1,#+1
        MOVS     R0,#+66
        BL       gpio_set
//   89       Digit_Show(thousand);
        LDR.N    R0,??DataTable1_4
        LDR      R0,[R0, #+0]
        BL       Digit_Show
//   90       THOUSAND_SHOW;
        MOVS     R1,#+0
        MOVS     R0,#+67
        BL       gpio_set
//   91       DELAY_MS(1);
        MOVS     R0,#+1
        BL       systick_delay_ms
//   92      }      
//   93   
//   94   
//   95   
//   96   
//   97     
//   98   
//   99 }
??Digitron_Show_3:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     GPIOX

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     unit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     decade

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     hundred

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     thousand

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  100 
// 
//  16 bytes in section .bss
// 640 bytes in section .text
// 
// 640 bytes of CODE memory
//  16 bytes of DATA memory
//
//Errors: none
//Warnings: none
