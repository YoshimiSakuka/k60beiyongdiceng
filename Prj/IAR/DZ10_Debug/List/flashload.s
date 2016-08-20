///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:23
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\flashload.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\flashload.c
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\flashload.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN flash_erase_sector
        EXTERN flash_write
        EXTERN systick_delay_ms

        PUBLIC Config
        PUBLIC Write_config
        PUBLIC load_config

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\flashload.c
//    1 #include  "include.h"
//    2 #include  "datamap.h"
//    3 
//    4 #define         PAGE_Config             FLASH_SECTOR_NUM-1
//    5 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    6 struct datamap Config;
Config:
        DS8 16
//    7 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    8 void load_config(void){
load_config:
        PUSH     {R3-R5,LR}
//    9 	int16_t i;
//   10 	int16_t *ptr = &Config.is_good;
        LDR.N    R4,??DataTable1
//   11 
//   12 	for(i=0 ; i< 8;i++)
        MOVS     R0,#+0
        MOVS     R5,R0
??load_config_0:
        SXTH     R5,R5            ;; SignExt  R5,R5,#+16,#+16
        CMP      R5,#+8
        BGE.N    ??load_config_1
//   13         {
//   14           *ptr = flash_read(PAGE_Config, i*8, uint16);
        SXTH     R5,R5            ;; SignExt  R5,R5,#+16,#+16
        LSLS     R0,R5,#+3
        ADDS     R0,R0,#+522240
        LDRSH    R0,[R0, #+0]
        STRH     R0,[R4, #+0]
//   15           ptr++;
        ADDS     R4,R4,#+2
//   16 	}
        ADDS     R5,R5,#+1
        B.N      ??load_config_0
//   17 	if(Config.is_good != (int16_t)0xA55A){ //Data invalid, load default configuartion
??load_config_1:
        LDR.N    R0,??DataTable1
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??DataTable1_1  ;; 0xffffa55a
        CMP      R0,R1
        BEQ.N    ??load_config_2
//   18 		Config.is_good = 0xA55A;
        LDR.N    R0,??DataTable1_1  ;; 0xffffa55a
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+0]
//   19 		Config.dGx_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+2]
//   20 		Config.dGy_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+4]
//   21 		Config.dGz_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+6]
//   22 	
//   23 		Config.dMx_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+8]
//   24 		Config.dMy_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+10]
//   25 		Config.dMz_offset = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable1
        STRH     R0,[R1, #+12]
//   26 	
//   27 		Write_config();	 //Write default configuration
        BL       Write_config
//   28 	}
//   29 }
??load_config_2:
        POP      {R0,R4,R5,PC}    ;; return
//   30 
//   31 //Write current configuration

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   32 void Write_config(void){
Write_config:
        PUSH     {R3-R5,LR}
//   33 	int16_t i;
//   34 	int16_t *ptr = &Config.is_good;
        LDR.N    R5,??DataTable1
//   35  	flash_erase_sector(PAGE_Config); //Erase pages
        MOVS     R0,#+255
        BL       flash_erase_sector
//   36         DELAY_MS(50);
        MOVS     R0,#+50
        BL       systick_delay_ms
//   37 	for(i=0;i<8;i++){
        MOVS     R0,#+0
        MOVS     R4,R0
??Write_config_0:
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        CMP      R4,#+8
        BGE.N    ??Write_config_1
//   38                 flash_write(PAGE_Config, i*8, (uint32_t)*ptr);
        LDRSH    R2,[R5, #+0]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LSLS     R1,R4,#+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+255
        BL       flash_write
//   39                 DELAY_MS(50);
        MOVS     R0,#+50
        BL       systick_delay_ms
//   40 	}
        ADDS     R4,R4,#+1
        B.N      ??Write_config_0
//   41 }
??Write_config_1:
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     Config

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0xffffa55a

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
//  16 bytes in section .bss
// 156 bytes in section .text
// 
// 156 bytes of CODE memory
//  16 bytes of DATA memory
//
//Errors: none
//Warnings: none
