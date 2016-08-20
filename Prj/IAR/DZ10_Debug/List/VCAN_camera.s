///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:06
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_camera.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_camera.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_camera.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC img_extract

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_camera.c
//    1 #include "common.h"
//    2 
//    3 
//    4 //压缩二值化图像解压（空间 换 时间 解压）
//    5 //srclen 是二值化图像的占用空间大小
//    6 //【鹰眼解压】鹰眼图像解压，转为 二维数组 - 智能车资料区 - 山外论坛 http://vcan123.com/forum.php?mod=viewthread&tid=17&ctid=6
//    7 //解压的时候，里面有个数组，配置黑、白对应的值是多少。

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//    8 void img_extract(void *dst, void *src, uint32_t srclen)
//    9 {
img_extract:
        PUSH     {R3-R7}
//   10     uint8_t colour[2] = {255, 0}; //0 和 1 分别对应的颜色
        LDR.N    R3,??img_extract_0
        LDRH     R3,[R3, #+0]
        STRH     R3,[SP, #+0]
//   11     uint8_t * mdst = dst;
        MOVS     R5,R0
//   12     uint8_t * msrc = src;
        MOVS     R4,R1
//   13     //注：山外的摄像头 0 表示 白色，1表示 黑色
//   14     uint8_t tmpsrc;
//   15     while(srclen --)
??img_extract_1:
        MOVS     R6,R2
        SUBS     R2,R6,#+1
        CMP      R6,#+0
        BEQ.N    ??img_extract_2
//   16     {
//   17         tmpsrc = *msrc++;
        LDRB     R6,[R4, #+0]
        MOVS     R3,R6
        ADDS     R4,R4,#+1
//   18         *mdst++ = colour[ (tmpsrc >> 7 ) & 0x01 ];
        ADD      R6,SP,#+0
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        ASRS     R7,R3,#+7
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   19         *mdst++ = colour[ (tmpsrc >> 6 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+6,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   20         *mdst++ = colour[ (tmpsrc >> 5 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+5,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   21         *mdst++ = colour[ (tmpsrc >> 4 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+4,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   22         *mdst++ = colour[ (tmpsrc >> 3 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+3,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   23         *mdst++ = colour[ (tmpsrc >> 2 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+2,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   24         *mdst++ = colour[ (tmpsrc >> 1 ) & 0x01 ];
        ADD      R6,SP,#+0
        UBFX     R7,R3,#+1,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
//   25         *mdst++ = colour[ (tmpsrc >> 0 ) & 0x01 ];
        ADD      R6,SP,#+0
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        ANDS     R7,R3,#0x1
        LDRB     R6,[R7, R6]
        STRB     R6,[R5, #+0]
        ADDS     R5,R5,#+1
        B.N      ??img_extract_1
//   26     }
//   27 }
??img_extract_2:
        POP      {R0,R4-R7}
        BX       LR               ;; return
        DATA
??img_extract_0:
        DC32     ?_0

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
        DC8 255, 0

        END
// 
//   2 bytes in section .rodata
// 148 bytes in section .text
// 
// 148 bytes of CODE  memory
//   2 bytes of CONST memory
//
//Errors: none
//Warnings: none
