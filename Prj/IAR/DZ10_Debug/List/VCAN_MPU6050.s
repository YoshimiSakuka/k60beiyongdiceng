///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:35
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\MPU6050\VCAN_MPU6050.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\MPU6050\VCAN_MPU6050.c
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_MPU6050.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Config
        EXTERN IICreadBytes
        EXTERN IICwriteBit
        EXTERN IICwriteBits
        EXTERN Write_config
        EXTERN core_clk_khz
        EXTERN gpio_get
        EXTERN systick_delay

        PUBLIC Gx_offset
        PUBLIC Gy_offset
        PUBLIC Gz_offset
        PUBLIC MPU6050_FIFO
        PUBLIC MPU6050_InitGyro_Offset
        PUBLIC MPU6050_Lastax
        PUBLIC MPU6050_Lastay
        PUBLIC MPU6050_Lastaz
        PUBLIC MPU6050_Lastgx
        PUBLIC MPU6050_Lastgy
        PUBLIC MPU6050_Lastgz
        PUBLIC MPU6050_getDeviceID
        PUBLIC MPU6050_getMotion6
        PUBLIC MPU6050_getlastMotion6
        PUBLIC MPU6050_initialize
        PUBLIC MPU6050_is_DRY
        PUBLIC MPU6050_newValues
        PUBLIC MPU6050_setAccelXSelfTest
        PUBLIC MPU6050_setAccelYSelfTest
        PUBLIC MPU6050_setAccelZSelfTest
        PUBLIC MPU6050_setClockSource
        PUBLIC MPU6050_setDLPFMode
        PUBLIC MPU6050_setFullScaleAccelRange
        PUBLIC MPU6050_setFullScaleGyroRange
        PUBLIC MPU6050_setI2CBypassEnabled
        PUBLIC MPU6050_setI2CMasterModeEnabled
        PUBLIC MPU6050_setSleepEnabled
        PUBLIC MPU6050_testConnection
        PUBLIC buffer

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\MPU6050\VCAN_MPU6050.c
//    1 #include "VCAN_MPU6050.h"
//    2 #include "VCAN_IO_I2C.h"
//    3 #include "datamap.h"
//    4 #include "include.h"
//    5 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    6 uint8_t buffer[14];
buffer:
        DS8 16
//    7 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    8 int16_t  MPU6050_FIFO[6][11];
MPU6050_FIFO:
        DS8 132

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//    9 int16_t Gx_offset=0,Gy_offset=0,Gz_offset=0;
Gx_offset:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
Gy_offset:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
Gz_offset:
        DS8 2
//   10 
//   11 
//   12 /**************************实现函数********************************************
//   13 *函数原型:		void  MPU6050_newValues(int16_t ax,int16_t ay,int16_t az,int16_t gx,int16_t gy,int16_t gz)
//   14 *功　　能:	    将新的ADC数据更新到 FIFO数组，进行滤波处理
//   15 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   16 void  MPU6050_newValues(int16_t ax,int16_t ay,int16_t az,int16_t gx,int16_t gy,int16_t gz)
//   17 {
MPU6050_newValues:
        PUSH     {R4-R7,LR}
        LDRSH    R4,[SP, #+20]
        LDRSH    R5,[SP, #+24]
//   18     unsigned char i ;
//   19     int32_t sum=0;
        MOVS     R7,#+0
//   20     for(i=1;i<10;i++){	//FIFO 操作  六轴更新数据
        MOVS     R12,#+1
        MOV      R6,R12
??MPU6050_newValues_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_1
//   21     MPU6050_FIFO[0][i-1]=MPU6050_FIFO[0][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDRH     R12,[R12, R6, LSL #+1]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #-2]
//   22     MPU6050_FIFO[1][i-1]=MPU6050_FIFO[1][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRH     R12,[R12, #+22]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #+20]
//   23     MPU6050_FIFO[2][i-1]=MPU6050_FIFO[2][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRH     R12,[R12, #+44]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #+42]
//   24     MPU6050_FIFO[3][i-1]=MPU6050_FIFO[3][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRH     R12,[R12, #+66]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #+64]
//   25     MPU6050_FIFO[4][i-1]=MPU6050_FIFO[4][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRH     R12,[R12, #+88]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #+86]
//   26     MPU6050_FIFO[5][i-1]=MPU6050_FIFO[5][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRH     R12,[R12, #+110]
        LDR.W    LR,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     LR,LR,R6, LSL #+1
        STRH     R12,[LR, #+108]
//   27     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_0
//   28     MPU6050_FIFO[0][9]=ax;//将新的数据放置到 数据的最后面
??MPU6050_newValues_1:
        LDR.W    R12,??DataTable5
        STRH     R0,[R12, #+18]
//   29     MPU6050_FIFO[1][9]=ay;
        LDR.W    R12,??DataTable5
        STRH     R1,[R12, #+40]
//   30     MPU6050_FIFO[2][9]=az;
        LDR.W    R12,??DataTable5
        STRH     R2,[R12, #+62]
//   31     MPU6050_FIFO[3][9]=gx;
        LDR.W    R12,??DataTable5
        STRH     R3,[R12, #+84]
//   32     MPU6050_FIFO[4][9]=gy;
        LDR.W    R12,??DataTable5
        STRH     R4,[R12, #+106]
//   33     MPU6050_FIFO[5][9]=gz;
        LDR.W    R12,??DataTable5
        STRH     R5,[R12, #+128]
//   34 
//   35     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   36     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_2:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_3
//   37     {	//求当前数组的和，再取平均值
//   38         sum+=MPU6050_FIFO[0][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDRSH    R12,[R12, R6, LSL #+1]
        ADDS     R7,R7,R12
//   39     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_2
//   40     MPU6050_FIFO[0][10]=sum/10;
??MPU6050_newValues_3:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+20]
//   41 
//   42     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   43     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_5
//   44     {
//   45         sum+=MPU6050_FIFO[1][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRSH    R12,[R12, #+22]
        SXTAH    R7,R7,R12
//   46     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_4
//   47     MPU6050_FIFO[1][10]=sum/10;
??MPU6050_newValues_5:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+42]
//   48 
//   49     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   50     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_6:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_7
//   51     {
//   52       sum+=MPU6050_FIFO[2][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRSH    R12,[R12, #+44]
        SXTAH    R7,R7,R12
//   53     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_6
//   54     MPU6050_FIFO[2][10]=sum/10;
??MPU6050_newValues_7:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+64]
//   55 
//   56     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   57     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_9
//   58     {
//   59       sum+=MPU6050_FIFO[3][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRSH    R12,[R12, #+66]
        SXTAH    R7,R7,R12
//   60     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_8
//   61     MPU6050_FIFO[3][10]=sum/10;
??MPU6050_newValues_9:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+86]
//   62 
//   63     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   64     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_11
//   65     {
//   66       sum+=MPU6050_FIFO[4][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRSH    R12,[R12, #+88]
        SXTAH    R7,R7,R12
//   67     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_10
//   68     MPU6050_FIFO[4][10]=sum/10;
??MPU6050_newValues_11:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+108]
//   69 
//   70     sum=0;
        MOVS     R12,#+0
        MOV      R7,R12
//   71     for(i=0;i<10;i++)
        MOVS     R12,#+0
        MOV      R6,R12
??MPU6050_newValues_12:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+10
        BGE.N    ??MPU6050_newValues_13
//   72     {
//   73       sum+=MPU6050_FIFO[5][i];
        LDR.W    R12,??DataTable5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R12,R12,R6, LSL #+1
        LDRSH    R12,[R12, #+110]
        SXTAH    R7,R7,R12
//   74     }
        ADDS     R6,R6,#+1
        B.N      ??MPU6050_newValues_12
//   75     MPU6050_FIFO[5][10]=sum/10;
??MPU6050_newValues_13:
        MOVS     R12,#+10
        SDIV     R12,R7,R12
        LDR.W    LR,??DataTable5
        STRH     R12,[LR, #+130]
//   76 }
        POP      {R4-R7,PC}       ;; return
//   77 
//   78 /**************************实现函数********************************************
//   79 *函数原型:		void MPU6050_setClockSource(uint8_t source)
//   80 *功　　能:	    设置  MPU6050 的时钟源
//   81  * CLK_SEL | Clock Source
//   82  * --------+--------------------------------------
//   83  * 0       | Internal oscillator
//   84  * 1       | PLL with X Gyro reference
//   85  * 2       | PLL with Y Gyro reference
//   86  * 3       | PLL with Z Gyro reference
//   87  * 4       | PLL with external 32.768kHz reference
//   88  * 5       | PLL with external 19.2MHz reference
//   89  * 6       | Reserved
//   90  * 7       | Stops the clock and keeps the timing generator in reset
//   91 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void MPU6050_setClockSource(uint8_t source){
MPU6050_setClockSource:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//   93     IICwriteBits(devAddr, MPU6050_RA_PWR_MGMT_1, MPU6050_PWR1_CLKSEL_BIT, MPU6050_PWR1_CLKSEL_LENGTH, source);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        MOVS     R3,#+3
        MOVS     R2,#+2
        MOVS     R1,#+107
        MOVS     R0,#+208
        BL       IICwriteBits
//   94 //                0xd0            0x6b                      2                         3                 形参
//   95 }
        POP      {R0,R1,R4,PC}    ;; return
//   96 /**************************实现函数********************************************
//   97 *函数原型:		void MPU6050_setFullScaleGyroscopeRange(uint8_t range)
//   98 *功　　能:	    设置  MPU6050 陀螺仪的最大量程
//   99 *******************************************************************************/
//  100 /** Set full-scale gyroscope range.
//  101  * @param range New full-scale gyroscope range value
//  102  * @see getFullScaleRange()
//  103  * @see MPU6050_GYRO_FS_250
//  104  * @see MPU6050_RA_GYRO_CONFIG
//  105  * @see MPU6050_GCONFIG_FS_SEL_BIT
//  106  * @see MPU6050_GCONFIG_FS_SEL_LENGTH
//  107  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  108 void MPU6050_setFullScaleGyroRange(uint8_t range) {
MPU6050_setFullScaleGyroRange:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  109     IICwriteBits(devAddr, MPU6050_RA_GYRO_CONFIG, MPU6050_GCONFIG_FS_SEL_BIT, MPU6050_GCONFIG_FS_SEL_LENGTH, range);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        MOVS     R3,#+2
        MOVS     R2,#+4
        MOVS     R1,#+27
        MOVS     R0,#+208
        BL       IICwriteBits
//  110 }
        POP      {R0,R1,R4,PC}    ;; return
//  111 
//  112 /**************************实现函数********************************************
//  113 *函数原型:		void MPU6050_setFullScaleAccelRange(uint8_t range)
//  114 *功　　能:	    设置  MPU6050 加速度计的最大量程
//  115 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  116 void MPU6050_setFullScaleAccelRange(uint8_t range) {
MPU6050_setFullScaleAccelRange:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  117     IICwriteBits(devAddr, MPU6050_RA_ACCEL_CONFIG, MPU6050_ACONFIG_AFS_SEL_BIT, MPU6050_ACONFIG_AFS_SEL_LENGTH, range);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        MOVS     R3,#+2
        MOVS     R2,#+4
        MOVS     R1,#+28
        MOVS     R0,#+208
        BL       IICwriteBits
//  118 }
        POP      {R0,R1,R4,PC}    ;; return
//  119 
//  120 /**************************实现函数********************************************
//  121 *函数原型:		void MPU6050_setSleepEnabled(uint8_t enabled)
//  122 *功　　能:	    设置  MPU6050 是否进入睡眠模式
//  123 				enabled =1   睡觉
//  124 			    enabled =0   工作
//  125 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  126 void MPU6050_setSleepEnabled(uint8_t enabled) {
MPU6050_setSleepEnabled:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  127     IICwriteBit(devAddr, MPU6050_RA_PWR_MGMT_1, MPU6050_PWR1_SLEEP_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+6
        MOVS     R1,#+107
        MOVS     R0,#+208
        BL       IICwriteBit
//  128 }
        POP      {R4,PC}          ;; return
//  129 
//  130 /**************************实现函数********************************************
//  131 *函数原型:		uint8_t MPU6050_getDeviceID(void)
//  132 *功　　能:	    读取  MPU6050 WHO_AM_I 标识	 将返回 0x68
//  133 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 uint8_t MPU6050_getDeviceID(void) {
MPU6050_getDeviceID:
        PUSH     {R7,LR}
//  135 
//  136     IICreadBytes(devAddr, MPU6050_RA_WHO_AM_I, 1, buffer);
        LDR.W    R3,??DataTable5_1
        MOVS     R2,#+1
        MOVS     R1,#+117
        MOVS     R0,#+208
        BL       IICreadBytes
//  137     return buffer[0];
        LDR.W    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        POP      {R1,PC}          ;; return
//  138 }
//  139 
//  140 /**************************实现函数********************************************
//  141 *函数原型:		uint8_t MPU6050_testConnection(void)
//  142 *功　　能:	    检测MPU6050 是否已经连接
//  143 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  144 uint8_t MPU6050_testConnection(void) {
MPU6050_testConnection:
        PUSH     {R7,LR}
//  145    if(MPU6050_getDeviceID() == 0x68)  //0b01101000;
        BL       MPU6050_getDeviceID
        CMP      R0,#+104
        BNE.N    ??MPU6050_testConnection_0
//  146    return 1;
        MOVS     R0,#+1
        B.N      ??MPU6050_testConnection_1
//  147    	else return 0;
??MPU6050_testConnection_0:
        MOVS     R0,#+0
??MPU6050_testConnection_1:
        POP      {R1,PC}          ;; return
//  148 }
//  149 
//  150 /**************************实现函数*******************************************
//  151 *函数原型:  设置低通滤波器配置
//  152 *功      能:
//  153 ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  154 void MPU6050_setDLPFMode(uint8_t mode){
MPU6050_setDLPFMode:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  155     IICwriteBits(devAddr, MPU6050_RA_CONFIG, MPU6050_CFG_DLPF_CFG_BIT, MPU6050_CFG_DLPF_CFG_LENGTH, mode);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        MOVS     R3,#+3
        MOVS     R2,#+2
        MOVS     R1,#+26
        MOVS     R0,#+208
        BL       IICwriteBits
//  156 }
        POP      {R0,R1,R4,PC}    ;; return
//  157 
//  158 /**************************实现函数*******************************************
//  159 * 开启加速度器X轴的安全自测功能。
//  160 * @安全自测启用参数
//  161 * @请参见MPU6050_RA_ACCEL_CONFIG字段
//  162 ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  163 void MPU6050_setAccelXSelfTest(uint8_t enabled) {
MPU6050_setAccelXSelfTest:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  164     IICwriteBit(devAddr, MPU6050_RA_ACCEL_CONFIG, MPU6050_ACONFIG_XA_ST_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+7
        MOVS     R1,#+28
        MOVS     R0,#+208
        BL       IICwriteBit
//  165 }
        POP      {R4,PC}          ;; return
//  166 
//  167 /**************************实现函数*******************************************
//  168 * 开启加速度器Y轴的安全自测功能。
//  169 * @安全自测启用参数
//  170 * @请参见MPU6050_RA_ACCEL_CONFIG字段
//  171 ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  172 void MPU6050_setAccelYSelfTest(uint8_t enabled) {
MPU6050_setAccelYSelfTest:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  173     IICwriteBit(devAddr, MPU6050_RA_ACCEL_CONFIG, MPU6050_ACONFIG_YA_ST_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+6
        MOVS     R1,#+28
        MOVS     R0,#+208
        BL       IICwriteBit
//  174 }
        POP      {R4,PC}          ;; return
//  175 
//  176 
//  177 
//  178 /**************************实现函数*******************************************
//  179 * 开启加速度器Z轴的安全自测功能。
//  180 * @安全自测启用参数
//  181 * @请参见MPU6050_RA_ACCEL_CONFIG字段
//  182 ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  183 void MPU6050_setAccelZSelfTest(uint8_t enabled) {
MPU6050_setAccelZSelfTest:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  184     IICwriteBit(devAddr, MPU6050_RA_ACCEL_CONFIG, MPU6050_ACONFIG_ZA_ST_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+5
        MOVS     R1,#+28
        MOVS     R0,#+208
        BL       IICwriteBit
//  185 }
        POP      {R4,PC}          ;; return
//  186 
//  187 
//  188 
//  189 /**************************实现函数********************************************
//  190 *函数原型:		void MPU6050_setI2CMasterModeEnabled(uint8_t enabled)
//  191 *功　　能:	    设置 MPU6050 是否为AUX I2C线的主机
//  192 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  193 void MPU6050_setI2CMasterModeEnabled(uint8_t enabled) {
MPU6050_setI2CMasterModeEnabled:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  194     IICwriteBit(devAddr, MPU6050_RA_USER_CTRL, MPU6050_USERCTRL_I2C_MST_EN_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+5
        MOVS     R1,#+106
        MOVS     R0,#+208
        BL       IICwriteBit
//  195 }
        POP      {R4,PC}          ;; return
//  196 
//  197 /**************************实现函数********************************************
//  198 *函数原型:		void MPU6050_setI2CBypassEnabled(uint8_t enabled)
//  199 *功　　能:	    设置 MPU6050 是否为AUX I2C线的主机
//  200 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  201 void MPU6050_setI2CBypassEnabled(uint8_t enabled) {
MPU6050_setI2CBypassEnabled:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  202     IICwriteBit(devAddr, MPU6050_RA_INT_PIN_CFG, MPU6050_INTCFG_I2C_BYPASS_EN_BIT, enabled);
        MOVS     R3,R4
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,#+1
        MOVS     R1,#+55
        MOVS     R0,#+208
        BL       IICwriteBit
//  203 }
        POP      {R4,PC}          ;; return
//  204 
//  205 /**************************实现函数********************************************
//  206 *函数原型:		void MPU6050_initialize(void)
//  207 *功　　能:	    初始化 	MPU6050 以进入可用状态。
//  208 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 void MPU6050_initialize(void) 
//  210 {
MPU6050_initialize:
        PUSH     {R4,LR}
        SUB      SP,SP,#+24
//  211     int16_t temp[6];
//  212     unsigned char i;
//  213 
//  214     MPU6050_setClockSource(MPU6050_CLOCK_PLL_XGYRO);    //设置时钟
        MOVS     R0,#+1
        BL       MPU6050_setClockSource
//  215     MPU6050_setFullScaleGyroRange(MPU6050_GYRO_FS_1000);//陀螺仪最大量程 +-1000度每秒
        MOVS     R0,#+2
        BL       MPU6050_setFullScaleGyroRange
//  216     MPU6050_setFullScaleAccelRange(MPU6050_ACCEL_FS_2);	//加速度度最大量程 +-2G
        MOVS     R0,#+0
        BL       MPU6050_setFullScaleAccelRange
//  217     MPU6050_setDLPFMode(MPU6050_DLPF_BW_98);            //设置低通滤波器，98Hz
        MOVS     R0,#+2
        BL       MPU6050_setDLPFMode
//  218     MPU6050_setSleepEnabled(0);                         //进入工作状态
        MOVS     R0,#+0
        BL       MPU6050_setSleepEnabled
//  219     MPU6050_setI2CMasterModeEnabled(0);	                //不让MPU6050 控制AUXI2C
        MOVS     R0,#+0
        BL       MPU6050_setI2CMasterModeEnabled
//  220     MPU6050_setI2CBypassEnabled(1);	                //主控制器的I2C与MPU6050的AUXI2C直通。控制器可以直接访问HMC5883L
        MOVS     R0,#+1
        BL       MPU6050_setI2CBypassEnabled
//  221 	
//  222 
//  223 	//配置MPU6050 的中断模式 和中断电平模式
//  224 	IICwriteBit(devAddr, MPU6050_RA_INT_PIN_CFG, MPU6050_INTCFG_INT_LEVEL_BIT, 0);
        MOVS     R3,#+0
        MOVS     R2,#+7
        MOVS     R1,#+55
        MOVS     R0,#+208
        BL       IICwriteBit
//  225 	IICwriteBit(devAddr, MPU6050_RA_INT_PIN_CFG, MPU6050_INTCFG_INT_OPEN_BIT, 0);
        MOVS     R3,#+0
        MOVS     R2,#+6
        MOVS     R1,#+55
        MOVS     R0,#+208
        BL       IICwriteBit
//  226 	IICwriteBit(devAddr, MPU6050_RA_INT_PIN_CFG, MPU6050_INTCFG_LATCH_INT_EN_BIT, 1);
        MOVS     R3,#+1
        MOVS     R2,#+5
        MOVS     R1,#+55
        MOVS     R0,#+208
        BL       IICwriteBit
//  227 	IICwriteBit(devAddr, MPU6050_RA_INT_PIN_CFG, MPU6050_INTCFG_INT_RD_CLEAR_BIT, 1);
        MOVS     R3,#+1
        MOVS     R2,#+4
        MOVS     R1,#+55
        MOVS     R0,#+208
        BL       IICwriteBit
//  228 	//开数据转换完成中断
//  229         IICwriteBit(devAddr, MPU6050_RA_INT_ENABLE, MPU6050_INTERRUPT_DATA_RDY_BIT, 1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+56
        MOVS     R0,#+208
        BL       IICwriteBit
//  230 
//  231     for(i=0;i<10;i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??MPU6050_initialize_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+10
        BGE.N    ??MPU6050_initialize_1
//  232     {//更新FIFO数组
//  233 	DELAY_US(50);
        LDR.N    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        MOVS     R1,#+50
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//  234 	MPU6050_getMotion6(&temp[0],&temp[1],&temp[2],&temp[3],&temp[4],&temp[5]);
        ADD      R0,SP,#+18
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+14
        ADD      R2,SP,#+12
        ADD      R1,SP,#+10
        ADD      R0,SP,#+8
        BL       MPU6050_getMotion6
//  235     }
        ADDS     R4,R4,#+1
        B.N      ??MPU6050_initialize_0
//  236 	Gx_offset = Config.dGx_offset;
??MPU6050_initialize_1:
        LDR.N    R0,??DataTable5_3
        LDRH     R0,[R0, #+2]
        LDR.N    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
//  237 	Gy_offset = Config.dGy_offset;
        LDR.N    R0,??DataTable5_3
        LDRH     R0,[R0, #+4]
        LDR.N    R1,??DataTable5_5
        STRH     R0,[R1, #+0]
//  238 	Gz_offset = Config.dGz_offset;																		 
        LDR.N    R0,??DataTable5_3
        LDRH     R0,[R0, #+6]
        LDR.N    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
//  239 }
        ADD      SP,SP,#+24
        POP      {R4,PC}          ;; return
//  240 
//  241 /**************************实现函数********************************************
//  242 *函数原型:		unsigned char MPU6050_is_DRY(void)
//  243 *功　　能:	    检查 MPU6050的中断引脚，测试是否完成转换
//  244 返回 1  转换完成
//  245 0 数据寄存器还没有更新
//  246 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  247 unsigned char MPU6050_is_DRY(void)
//  248 {
MPU6050_is_DRY:
        PUSH     {R7,LR}
//  249     if(gpio_get(PTC18)){
        MOVS     R0,#+82
        BL       gpio_get
        CMP      R0,#+0
        BEQ.N    ??MPU6050_is_DRY_0
//  250 	  return 1;
        MOVS     R0,#+1
        B.N      ??MPU6050_is_DRY_1
//  251 	 }
//  252 	 else return 0;
??MPU6050_is_DRY_0:
        MOVS     R0,#+0
??MPU6050_is_DRY_1:
        POP      {R1,PC}          ;; return
//  253 }
//  254 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  255 int16_t MPU6050_Lastax,MPU6050_Lastay,MPU6050_Lastaz
MPU6050_Lastax:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
MPU6050_Lastay:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
MPU6050_Lastaz:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  256 				,MPU6050_Lastgx,MPU6050_Lastgy,MPU6050_Lastgz;
MPU6050_Lastgx:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
MPU6050_Lastgy:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
MPU6050_Lastgz:
        DS8 2
//  257 /**************************实现函数********************************************
//  258 *函数原型:		void MPU6050_getMotion6(int16_t* ax, int16_t* ay, int16_t* az, int16_t* gx, int16_t* gy, int16_t* gz) {
//  259 *功　　能:	    读取 MPU6050的当前测量值 获得姿态
//  260 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  261 void MPU6050_getMotion6(int16_t* ax, int16_t* ay, int16_t* az, int16_t* gx, int16_t* gy, int16_t* gz) {
MPU6050_getMotion6:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
        LDR      R8,[SP, #+40]
        LDR      R9,[SP, #+44]
//  262   
//  263 	if(MPU6050_is_DRY())            //检查MPU6050的中断引脚，测试是否完成转换
        BL       MPU6050_is_DRY
        CMP      R0,#+0
        BEQ.N    ??MPU6050_getMotion6_0
//  264         {                                   
//  265           IICreadBytes(devAddr, MPU6050_RA_ACCEL_XOUT_H, 14, buffer);//读取指定设备 指定寄存器的 length个值
        LDR.N    R3,??DataTable5_1
        MOVS     R2,#+14
        MOVS     R1,#+59
        MOVS     R0,#+208
        BL       IICreadBytes
//  266     
//  267           MPU6050_Lastax=(((int16_t)buffer[0])  << 8) | buffer[1] ;
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+1]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
//  268           MPU6050_Lastay=(((int16_t)buffer[2])  << 8) | buffer[3] ;
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+3]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_8
        STRH     R0,[R1, #+0]
//  269           MPU6050_Lastaz=(((int16_t)buffer[4])  << 8) | buffer[5] ;
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+4]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+5]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_9
        STRH     R0,[R1, #+0]
//  270           //跳过温度ADC
//  271           MPU6050_Lastgx=(((int16_t)buffer[8])  << 8) | buffer[9] ;
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+8]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+9]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_10
        STRH     R0,[R1, #+0]
//  272           MPU6050_Lastgy=(((int16_t)buffer[10]) << 8) | buffer[11];
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+10]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+11]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_11
        STRH     R0,[R1, #+0]
//  273           MPU6050_Lastgz=(((int16_t)buffer[12]) << 8) | buffer[13];
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+12]
        LDR.N    R1,??DataTable5_1
        LDRB     R1,[R1, #+13]
        ORRS     R0,R1,R0, LSL #+8
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
//  274           MPU6050_newValues(MPU6050_Lastax,MPU6050_Lastay,MPU6050_Lastaz
//  275 		,MPU6050_Lastgx,MPU6050_Lastgy,MPU6050_Lastgz);
        LDR.N    R0,??DataTable5_12
        LDRSH    R0,[R0, #+0]
        STR      R0,[SP, #+4]
        LDR.N    R0,??DataTable5_11
        LDRSH    R0,[R0, #+0]
        STR      R0,[SP, #+0]
        LDR.N    R0,??DataTable5_10
        LDRSH    R3,[R0, #+0]
        LDR.N    R0,??DataTable5_9
        LDRSH    R2,[R0, #+0]
        LDR.N    R0,??DataTable5_8
        LDRSH    R1,[R0, #+0]
        LDR.N    R0,??DataTable5_7
        LDRSH    R0,[R0, #+0]
        BL       MPU6050_newValues
//  276           *ax  =MPU6050_FIFO[0][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+20]
        STRH     R0,[R4, #+0]
//  277           *ay  =MPU6050_FIFO[1][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+42]
        STRH     R0,[R5, #+0]
//  278           *az = MPU6050_FIFO[2][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+64]
        STRH     R0,[R6, #+0]
//  279           *gx  =MPU6050_FIFO[3][10]-Gx_offset;
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+86]
        LDR.N    R1,??DataTable5_4
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R7, #+0]
//  280           *gy = MPU6050_FIFO[4][10]-Gy_offset;
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable5_5
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R8, #+0]
//  281           *gz = MPU6050_FIFO[5][10]-Gz_offset;
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+130]
        LDR.N    R1,??DataTable5_6
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R9, #+0]
        B.N      ??MPU6050_getMotion6_1
//  282           } 
//  283           else 
//  284           {
//  285           *ax = MPU6050_FIFO[0][10];//=MPU6050_FIFO[0][10];
??MPU6050_getMotion6_0:
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+20]
        STRH     R0,[R4, #+0]
//  286           *ay = MPU6050_FIFO[1][10];//=MPU6050_FIFO[1][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+42]
        STRH     R0,[R5, #+0]
//  287           *az = MPU6050_FIFO[2][10];//=MPU6050_FIFO[2][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+64]
        STRH     R0,[R6, #+0]
//  288           *gx = MPU6050_FIFO[3][10]-Gx_offset;//=MPU6050_FIFO[3][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+86]
        LDR.N    R1,??DataTable5_4
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R7, #+0]
//  289           *gy = MPU6050_FIFO[4][10]-Gy_offset;//=MPU6050_FIFO[4][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable5_5
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R8, #+0]
//  290           *gz = MPU6050_FIFO[5][10]-Gz_offset;//=MPU6050_FIFO[5][10];
        LDR.N    R0,??DataTable5
        LDRH     R0,[R0, #+130]
        LDR.N    R1,??DataTable5_6
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        STRH     R0,[R9, #+0]
//  291           }
//  292 }
??MPU6050_getMotion6_1:
        POP      {R0-R2,R4-R9,PC}  ;; return
//  293 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  294 void MPU6050_getlastMotion6(int16_t* ax, int16_t* ay, 
//  295 		int16_t* az, int16_t* gx, int16_t* gy, int16_t* gz)
//  296 {
MPU6050_getlastMotion6:
        PUSH     {R4-R7}
        LDR      R4,[SP, #+16]
        LDR      R5,[SP, #+20]
//  297 	*ax  =MPU6050_FIFO[0][10];
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+20]
        STRH     R6,[R0, #+0]
//  298 	*ay  =MPU6050_FIFO[1][10];
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+42]
        STRH     R6,[R1, #+0]
//  299 	*az = MPU6050_FIFO[2][10];
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+64]
        STRH     R6,[R2, #+0]
//  300 	*gx  =MPU6050_FIFO[3][10]-Gx_offset;
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+86]
        LDR.N    R7,??DataTable5_4
        LDRH     R7,[R7, #+0]
        SUBS     R6,R6,R7
        STRH     R6,[R3, #+0]
//  301 	*gy = MPU6050_FIFO[4][10]-Gy_offset;
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+108]
        LDR.N    R7,??DataTable5_5
        LDRH     R7,[R7, #+0]
        SUBS     R6,R6,R7
        STRH     R6,[R4, #+0]
//  302 	*gz = MPU6050_FIFO[5][10]-Gz_offset;
        LDR.N    R6,??DataTable5
        LDRH     R6,[R6, #+130]
        LDR.N    R7,??DataTable5_6
        LDRH     R7,[R7, #+0]
        SUBS     R6,R6,R7
        STRH     R6,[R5, #+0]
//  303 }
        POP      {R4-R7}
        BX       LR               ;; return
//  304 
//  305 /**************************实现函数********************************************
//  306 *函数原型:		void MPU6050_InitGyro_Offset(void)
//  307 *功　　能:	    读取 MPU6050的陀螺仪偏置
//  308 此时模块应该被静止放置。以测试静止时的陀螺仪输出
//  309 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  310 void MPU6050_InitGyro_Offset(void)
//  311 {
MPU6050_InitGyro_Offset:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+24
//  312 	unsigned char i;
//  313 	int16_t temp[6];
//  314 	int32_t	tempgx=0,tempgy=0,tempgz=0;
        MOVS     R5,#+0
        MOVS     R6,#+0
        MOVS     R7,#+0
//  315 	int32_t	tempax=0,tempay=0,tempaz=0;
        MOVS     R8,#+0
        MOVS     R9,#+0
        MOVS     R10,#+0
//  316 	Gx_offset=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
//  317 	Gy_offset=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_5
        STRH     R0,[R1, #+0]
//  318 	Gz_offset=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
//  319 	for(i=0;i<50;i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??MPU6050_InitGyro_Offset_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+50
        BGE.N    ??MPU6050_InitGyro_Offset_1
//  320         {
//  321   		DELAY_US(100);
        LDR.N    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        MOVS     R1,#+100
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//  322   		MPU6050_getMotion6(&temp[0],&temp[1],&temp[2],&temp[3],&temp[4],&temp[5]);
        ADD      R0,SP,#+18
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+14
        ADD      R2,SP,#+12
        ADD      R1,SP,#+10
        ADD      R0,SP,#+8
        BL       MPU6050_getMotion6
//  323   		//LED_Change();
//  324 	}
        ADDS     R4,R4,#+1
        B.N      ??MPU6050_InitGyro_Offset_0
//  325  	for(i=0;i<100;i++)
??MPU6050_InitGyro_Offset_1:
        MOVS     R0,#+0
        MOVS     R4,R0
??MPU6050_InitGyro_Offset_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+100
        BGE.N    ??MPU6050_InitGyro_Offset_3
//  326         {
//  327 		DELAY_US(200);
        LDR.N    R0,??DataTable5_2
        LDR      R0,[R0, #+0]
        MOVS     R1,#+200
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//  328 		MPU6050_getMotion6(&temp[0],&temp[1],&temp[2],&temp[3],&temp[4],&temp[5]);
        ADD      R0,SP,#+18
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+14
        ADD      R2,SP,#+12
        ADD      R1,SP,#+10
        ADD      R0,SP,#+8
        BL       MPU6050_getMotion6
//  329 		tempax+= temp[0];
        LDRSH    R0,[SP, #+8]
        SXTAH    R8,R8,R0
//  330 		tempay+= temp[1];
        LDRSH    R0,[SP, #+10]
        SXTAH    R9,R9,R0
//  331 		tempaz+= temp[2];
        LDRSH    R0,[SP, #+12]
        SXTAH    R10,R10,R0
//  332 		tempgx+= temp[3];
        LDRSH    R0,[SP, #+14]
        SXTAH    R5,R5,R0
//  333 		tempgy+= temp[4];
        LDRSH    R0,[SP, #+16]
        SXTAH    R6,R6,R0
//  334 		tempgz+= temp[5];
        LDRSH    R0,[SP, #+18]
        SXTAH    R7,R7,R0
//  335 		//LED_Change();
//  336 	}
        ADDS     R4,R4,#+1
        B.N      ??MPU6050_InitGyro_Offset_2
//  337 
//  338 	Config.dGx_offset = Gx_offset = tempgx/100;//MPU6050_FIFO[3][10];
??MPU6050_InitGyro_Offset_3:
        MOVS     R0,#+100
        SDIV     R0,R5,R0
        LDR.N    R1,??DataTable5_4
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_4
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_3
        STRH     R0,[R1, #+2]
//  339 	Config.dGy_offset = Gy_offset = tempgy/100;//MPU6050_FIFO[4][10];
        MOVS     R0,#+100
        SDIV     R0,R6,R0
        LDR.N    R1,??DataTable5_5
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_5
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_3
        STRH     R0,[R1, #+4]
//  340 	Config.dGz_offset = Gz_offset = tempgz/100;//MPU6050_FIFO[5][10];
        MOVS     R0,#+100
        SDIV     R0,R7,R0
        LDR.N    R1,??DataTable5_6
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_6
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_3
        STRH     R0,[R1, #+6]
//  341 	Write_config();
        BL       Write_config
//  342 	tempax/=100;
        MOVS     R0,#+100
        SDIV     R8,R8,R0
//  343 	tempay/=100;
        MOVS     R0,#+100
        SDIV     R9,R9,R0
//  344 	tempaz/=100;
        MOVS     R0,#+100
        SDIV     R10,R10,R0
//  345 }
        ADD      SP,SP,#+24
        POP      {R4-R10,PC}      ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     MPU6050_FIFO

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     Config

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     Gx_offset

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     Gy_offset

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     Gz_offset

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     MPU6050_Lastax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     MPU6050_Lastay

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     MPU6050_Lastaz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     MPU6050_Lastgx

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     MPU6050_Lastgy

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     MPU6050_Lastgz

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  346 
//  347 //------------------End of File----------------------------
// 
//   166 bytes in section .bss
// 1 790 bytes in section .text
// 
// 1 790 bytes of CODE memory
//   166 bytes of DATA memory
//
//Errors: none
//Warnings: none
