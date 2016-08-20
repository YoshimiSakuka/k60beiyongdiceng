///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:07
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\vcan_img2sd.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\vcan_img2sd.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\vcan_img2sd.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN f_close
        EXTERN f_mount
        EXTERN f_open
        EXTERN f_sync
        EXTERN f_write
        EXTERN sprintf

        PUBLIC img_sd_exit
        PUBLIC img_sd_init
        PUBLIC img_sd_save

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\vcan_img2sd.c
//    1 #include "common.h"
//    2 #include "vcan_img2sd.h"
//    3 #include "ff.h"
//    4 #include "VCAN_camera.h"       //摄像头总头文件
//    5 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    6 static FATFS vcanfs;    //文件系统
vcanfs:
        DS8 560

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    7 static FIL   vcansrc;   //文件
vcansrc:
        DS8 548
//    8 
//    9 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   10 void img_sd_init(void)
//   11 {
img_sd_init:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+28
//   12     int     vcanres;
//   13     char    myfilename[20];
//   14     uint16  imgsize[] = {
//   15                             CAMERA_H,
//   16                             CAMERA_W,
//   17                             //CAMERA_COLOR,
//   18                          };      //高、宽、摄像头颜色类型
        ADD      R0,SP,#+0
        LDR.N    R1,??DataTable2
        LDR      R2,[R1, #0]
        STR      R2,[R0, #+0]
//   19     uint32  mybw;
//   20     uint32  Imag_num = 0;
        MOVS     R5,#+0
//   21 
//   22     f_mount(0, &vcanfs);
        LDR.N    R1,??DataTable2_1
        MOVS     R0,#+0
        BL       f_mount
//   23 
//   24     do
//   25     {
//   26         Imag_num ++;
??img_sd_init_0:
        ADDS     R5,R5,#+1
//   27         sprintf(myfilename, "0:/vcan%d.sd", Imag_num);
        MOVS     R2,R5
        LDR.N    R1,??DataTable2_2
        ADD      R0,SP,#+8
        BL       sprintf
//   28         vcanres = f_open( &vcansrc , myfilename, FA_CREATE_NEW | FA_WRITE);
        MOVS     R2,#+6
        ADD      R1,SP,#+8
        LDR.N    R0,??DataTable2_3
        BL       f_open
        MOVS     R4,R0
//   29 
//   30         if(vcanfs.fs_type == 0)
        LDR.N    R0,??DataTable2_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??img_sd_init_1
//   31         {
//   32             vcansrc.fs = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STR      R0,[R1, #+0]
//   33             return;
        B.N      ??img_sd_init_2
//   34         }
//   35 
//   36     }while(vcanres == FR_EXIST);        //如果文件存在，则命名继续加1
??img_sd_init_1:
        CMP      R4,#+8
        BEQ.N    ??img_sd_init_0
//   37 
//   38     if ( vcanres == FR_OK )
        CMP      R4,#+0
        BNE.N    ??img_sd_init_3
//   39     {
//   40         vcanres = f_write(&vcansrc, imgsize, sizeof(imgsize),&mybw);  //先写入高和宽，方便上位机处理
        ADD      R3,SP,#+4
        MOVS     R2,#+4
        ADD      R1,SP,#+0
        LDR.N    R0,??DataTable2_3
        BL       f_write
        MOVS     R4,R0
        B.N      ??img_sd_init_4
//   41     }
//   42     else
//   43     {
//   44         f_close(&vcansrc);
??img_sd_init_3:
        LDR.N    R0,??DataTable2_3
        BL       f_close
//   45         vcansrc.fs = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STR      R0,[R1, #+0]
//   46     }
//   47 }
??img_sd_init_4:
??img_sd_init_2:
        ADD      SP,SP,#+28
        POP      {R4,R5,PC}       ;; return
//   48 
//   49 
//   50 
//   51 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 void img_sd_save(uint8 * imgaddr,uint32 size)
//   53 {
img_sd_save:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
        MOVS     R5,R1
//   54 #define F_SYNC_TIME   30      //保存 n 次后 才 同步
//   55 
//   56     int   vcanres;
//   57     uint32 mybw;
//   58     static uint8 time = 0;
//   59     //uint32 size = CAMERA_SIZE;
//   60 
//   61     if(vcansrc.fs != 0)
        LDR.N    R0,??DataTable2_3
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??img_sd_save_0
//   62     {
//   63         time ++;
        LDR.N    R0,??DataTable2_4
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable2_4
        STRB     R0,[R1, #+0]
//   64 
//   65         vcanres = f_write(&vcansrc, imgaddr, size ,&mybw);
        ADD      R3,SP,#+0
        MOVS     R2,R5
        MOVS     R1,R4
        LDR.N    R0,??DataTable2_3
        BL       f_write
        MOVS     R6,R0
//   66 
//   67         if(vcanres != FR_OK)
        CMP      R6,#+0
        BEQ.N    ??img_sd_save_1
//   68         {
//   69             f_close(&vcansrc);
        LDR.N    R0,??DataTable2_3
        BL       f_close
//   70             vcansrc.fs = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STR      R0,[R1, #+0]
//   71         }
//   72 
//   73         if(time > F_SYNC_TIME)
??img_sd_save_1:
        LDR.N    R0,??DataTable2_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+31
        BLT.N    ??img_sd_save_0
//   74         {
//   75             time = 0 ;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_4
        STRB     R0,[R1, #+0]
//   76             f_sync(&vcansrc);
        LDR.N    R0,??DataTable2_3
        BL       f_sync
//   77         }
//   78     }
//   79 }
??img_sd_save_0:
        POP      {R0,R1,R4-R6,PC}  ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
??time:
        DS8 1
//   80 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   81 void img_sd_exit(void)
//   82 {
img_sd_exit:
        PUSH     {R7,LR}
//   83     f_close(&vcansrc);
        LDR.N    R0,??DataTable2_3
        BL       f_close
//   84     vcansrc.fs = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STR      R0,[R1, #+0]
//   85 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     vcanfs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     vcansrc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     ??time

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
        DC16 60, 80

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "0:/vcan%d.sd"
        DC8 0, 0, 0

        END
// 
// 1 109 bytes in section .bss
//    20 bytes in section .rodata
//   216 bytes in section .text
// 
//   216 bytes of CODE  memory
//    20 bytes of CONST memory
// 1 109 bytes of DATA  memory
//
//Errors: none
//Warnings: none
