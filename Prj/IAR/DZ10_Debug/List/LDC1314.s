///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  14:45:12
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\LDC1314.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\LDC1314.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\LDC1314.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN IIC_LDC_read_byte
        EXTERN IIC_LDC_write_byte
        EXTERN gpio_init

        PUBLIC LDC1314_CH_Read
        PUBLIC LDC1314_Init
        PUBLIC LDC1314_Run
        PUBLIC MotorControl
        PUBLIC QUADRead
        PUBLIC SpeedWant
        PUBLIC Speed_Control
        PUBLIC Speed_Kd
        PUBLIC Speed_Ki
        PUBLIC Speed_Kp

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\LDC1314.c
//    1 #include "LDC1314.h"
//    2 #include "MK60_gpio.h"
//    3 #include "SOFTWARE_I2C.h"
//    4 
//    5 
//    6 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    7 int SpeedWant;
SpeedWant:
        DS8 4
//    8 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    9 int Speed_Kp; 
Speed_Kp:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   10 int Speed_Ki; 
Speed_Ki:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   11 int Speed_Kd; 
Speed_Kd:
        DS8 4
//   12 
//   13 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   14 void LDC1314_Init(void)                    //地址0x1d
//   15 {
LDC1314_Init:
        PUSH     {R7,LR}
//   16     gpio_init(LDC_SCL, GPO, 1);                                  
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_init
//   17     gpio_init(LDC_SDA, GPO, 1);
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_init
//   18     IIC_LDC_write_byte(LDC1314_ADDR, RESET_DEV, 0x0200);//1000 0110 0000 0000    8600   16倍增益
        MOV      R2,#+512
        MOVS     R1,#+28
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   19                                                               //10               8400   8倍增益         
//   20                                                               //01               8200   4倍增益
//   21                                                               //00               8000   1倍(不)增益    
//   22     IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH0, 0x04D6);//0000 0100 1101 0110
        MOVW     R2,#+1238
        MOVS     R1,#+8
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   23     IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH1, 0x04D6);//通道参考计数转换间隔时间 0x0005~0xffff有效
        MOVW     R2,#+1238
        MOVS     R1,#+9
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   24     IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH2, 0x04D6);//转换时间 = RCOUNT_CHx * 16/fREFx
        MOVW     R2,#+1238
        MOVS     R1,#+10
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   25     IIC_LDC_write_byte(LDC1314_ADDR, RCOUNT_CH3, 0x04D6);
        MOVW     R2,#+1238
        MOVS     R1,#+11
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   26     IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH0, 0x000A);//0000 0000 0000 1010  
        MOVS     R2,#+10
        MOVS     R1,#+16
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   27     IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH1, 0x000A);//通道转换稳定时间，LDC使用这个稳定时间在初始化通道0的转换开始之前来让LC传感器稳定。
        MOVS     R2,#+10
        MOVS     R1,#+17
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   28     IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH2, 0x000A);//0000 0000 0000 0000:稳定时间(tsx) = 32 / fREFx
        MOVS     R2,#+10
        MOVS     R1,#+18
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   29     IIC_LDC_write_byte(LDC1314_ADDR, SETTLECOUNT_CH3, 0x000A);//b0000 0000 0000 0010~b1111 1111 1111 1111:稳定时间(tsx) = (CH0_SETTLECOUNT * 16) / fREF0
        MOVS     R2,#+10
        MOVS     R1,#+19
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   30     
//   31     IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH0, 0x1002);//0001 0000 0000 0010
        MOVW     R2,#+4098
        MOVS     R1,#+20
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   32     IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH1, 0x1002);//CH0_FIN_DIVIDER通道输入分频fin   CHx_FREF_DIVIDER通道参考分频fREF
        MOVW     R2,#+4098
        MOVS     R1,#+21
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   33     IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH2, 0x1002);//CHx_FIN_DIVIDER ≥ b0001: finx=fSENSOR0/CH0_FIN_DIVIDER   finx = fSENSOR0 / 1
        MOVW     R2,#+4098
        MOVS     R1,#+22
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   34     IIC_LDC_write_byte(LDC1314_ADDR, CLOCK_DIVIDERS_CH3, 0x1002);//CHx_FREF_DIVIDER ≥ b00’0000’0001:  fREFx = fCLK/CHx_FREF_DIVIDER  fREFx = fCLK / 2
        MOVW     R2,#+4098
        MOVS     R1,#+23
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   35     
//   36     IIC_LDC_write_byte(LDC1314_ADDR, ERROR_CONFIG, 0x0000);//0000 0000 0000 0000  
        MOVS     R2,#+0
        MOVS     R1,#+25
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   37     IIC_LDC_write_byte(LDC1314_ADDR, MUX_CONFIG, 0xC20D);//0xA20F);//0xA20C);  1100 0010 0000 1101 多通道模式，四通道，33MHz
        MOVW     R2,#+49677
        MOVS     R1,#+27
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   38     
//   39     IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH0, 0x9000);//1001 0000 0000 0000   驱动电流大小
        MOV      R2,#+36864
        MOVS     R1,#+30
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   40     IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH1, 0x9000);  
        MOV      R2,#+36864
        MOVS     R1,#+31
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   41     IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH2, 0x9000);  
        MOV      R2,#+36864
        MOVS     R1,#+32
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   42     IIC_LDC_write_byte(LDC1314_ADDR, DRIVE_CURRENT_CH3, 0x9000);  
        MOV      R2,#+36864
        MOVS     R1,#+33
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   43     
//   44     IIC_LDC_write_byte(LDC1314_ADDR, CONFIG, 0x1601);//0xD681); //1101 0110 1000 0001
        MOVW     R2,#+5633
        MOVS     R1,#+26
        MOVS     R0,#+42
        BL       IIC_LDC_write_byte
//   45 
//   46 }
        POP      {R0,PC}          ;; return
//   47 
//   48 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void LDC1314_CH_Read(uint16 *LDCstr)
//   50 {
LDC1314_CH_Read:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   51 
//   52       LDCstr[0]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH0)&0x0FFF;
        MOVS     R1,#+0
        MOVS     R0,#+42
        BL       IIC_LDC_read_byte
        LSLS     R0,R0,#+20       ;; ZeroExtS R0,R0,#+20,#+20
        LSRS     R0,R0,#+20
        STRH     R0,[R4, #+0]
//   53       LDCstr[1]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH1)&0x0FFF;
        MOVS     R1,#+2
        MOVS     R0,#+42
        BL       IIC_LDC_read_byte
        LSLS     R0,R0,#+20       ;; ZeroExtS R0,R0,#+20,#+20
        LSRS     R0,R0,#+20
        STRH     R0,[R4, #+2]
//   54       LDCstr[2]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH2)&0x0FFF;
        MOVS     R1,#+4
        MOVS     R0,#+42
        BL       IIC_LDC_read_byte
        LSLS     R0,R0,#+20       ;; ZeroExtS R0,R0,#+20,#+20
        LSRS     R0,R0,#+20
        STRH     R0,[R4, #+4]
//   55       LDCstr[3]=IIC_LDC_read_byte(LDC1314_ADDR,DATA_CH3)&0x0FFF; 
        MOVS     R1,#+6
        MOVS     R0,#+42
        BL       IIC_LDC_read_byte
        LSLS     R0,R0,#+20       ;; ZeroExtS R0,R0,#+20,#+20
        LSRS     R0,R0,#+20
        STRH     R0,[R4, #+6]
//   56 
//   57 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   58 void LDC1314_Run(void)
//   59 {
//   60   
//   61 
//   62 
//   63 
//   64 
//   65 }
LDC1314_Run:
        BX       LR               ;; return
//   66 
//   67 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   68 int Speed_Control(int Speed_Test)    //速度PID
//   69 {
Speed_Control:
        PUSH     {R4}
        MOVS     R1,R0
//   70     int Speed_Set_R = 0;
        MOVS     R0,#+0
//   71     static int SpeedDev[4] = {0};
//   72     static int SpeedInt = 0;
//   73     static int SpeedUp, SpeedUi, SpeedUd;
//   74     SpeedDev[3] = SpeedDev[2];
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+8]
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+12]
//   75     SpeedDev[2] = SpeedDev[1];
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+4]
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+8]
//   76     SpeedDev[1] = SpeedDev[0];
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+4]
//   77 
//   78     SpeedDev[0] = SpeedWant-Speed_Test;
        LDR.N    R2,??DataTable2_1
        LDR      R2,[R2, #+0]
        SUBS     R2,R2,R1
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+0]
//   79 
//   80     SpeedDev[0] = SpeedDev[0]>500?500:(SpeedDev[0]<-500?-500:SpeedDev[0]);
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+0]
        CMP      R2,#+500
        BLE.N    ??Speed_Control_0
        MOV      R2,#+500
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+0]
        B.N      ??Speed_Control_1
??Speed_Control_0:
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+0]
        CMN      R2,#+500
        BGE.N    ??Speed_Control_2
        LDR.N    R2,??DataTable2_2  ;; 0xfffffe0c
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+0]
        B.N      ??Speed_Control_1
??Speed_Control_2:
        LDR.N    R2,??DataTable2
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2
        STR      R2,[R3, #+0]
//   81 
//   82     SpeedInt += SpeedDev[0];
??Speed_Control_1:
        LDR.N    R2,??DataTable2_3
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2
        LDR.N    R3,??DataTable2_3
        STR      R2,[R3, #+0]
//   83     SpeedInt =  SpeedInt>10000?10000:(SpeedInt<-10000?-10000:SpeedInt);
        LDR.N    R2,??DataTable2_3
        LDR      R2,[R2, #+0]
        MOVW     R3,#+10001
        CMP      R2,R3
        BLT.N    ??Speed_Control_3
        MOVW     R2,#+10000
        LDR.N    R3,??DataTable2_3
        STR      R2,[R3, #+0]
        B.N      ??Speed_Control_4
??Speed_Control_3:
        LDR.N    R2,??DataTable2_3
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2_4  ;; 0xffffd8f0
        CMP      R2,R3
        BGE.N    ??Speed_Control_5
        LDR.N    R2,??DataTable2_4  ;; 0xffffd8f0
        LDR.N    R3,??DataTable2_3
        STR      R2,[R3, #+0]
        B.N      ??Speed_Control_4
??Speed_Control_5:
        LDR.N    R2,??DataTable2_3
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2_3
        STR      R2,[R3, #+0]
//   84     
//   85     SpeedUp = (int)(Speed_Kp * SpeedDev[0]);
??Speed_Control_4:
        LDR.N    R2,??DataTable2_5
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2
        LDR      R3,[R3, #+0]
        MULS     R2,R3,R2
        LDR.N    R3,??DataTable2_6
        STR      R2,[R3, #+0]
//   86     SpeedUi = (int)(Speed_Ki * SpeedInt/10);
        LDR.N    R2,??DataTable2_7
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2_3
        LDR      R3,[R3, #+0]
        MULS     R2,R3,R2
        MOVS     R3,#+10
        SDIV     R2,R2,R3
        LDR.N    R3,??DataTable2_8
        STR      R2,[R3, #+0]
//   87     SpeedUd = (int)(Speed_Kd * (SpeedDev[0]-SpeedDev[1]));
        LDR.N    R2,??DataTable2_9
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2
        LDR      R3,[R3, #+0]
        LDR.N    R4,??DataTable2
        LDR      R4,[R4, #+4]
        SUBS     R3,R3,R4
        MULS     R2,R3,R2
        LDR.N    R3,??DataTable2_10
        STR      R2,[R3, #+0]
//   88  
//   89     Speed_Set_R = SpeedUp + SpeedUi + SpeedUd;
        LDR.N    R2,??DataTable2_6
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable2_8
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2
        LDR.N    R3,??DataTable2_10
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2
        MOVS     R0,R2
//   90 
//   91     return Speed_Set_R;
        POP      {R4}
        BX       LR               ;; return
//   92 }

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??SpeedDev:
        DS8 16

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??SpeedInt:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??SpeedUp:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??SpeedUi:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??SpeedUd:
        DS8 4
//   93 
//   94 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   95 int QUADRead(void)                    //0为右1为左  5.3凌晨改动
//   96 {
//   97  uint8 direction;
//   98  int speed;
//   99   direction = (FTM2_QDCTRL & FTM_QDCTRL_QUADIR_MASK) >> FTM_QDCTRL_QUADIR_SHIFT;//正负标志
QUADRead:
        LDR.N    R2,??DataTable2_11  ;; 0x400b8080
        LDR      R2,[R2, #+0]
        UBFX     R2,R2,#+2,#+1
        MOVS     R1,R2
//  100   if(direction)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??QUADRead_0
//  101   {
//  102    speed = -(int)FTM2_CNT;                  //改   计数递增 到顶部溢出 负值 反转？
        LDR.N    R2,??DataTable2_12  ;; 0x400b8004
        LDR      R2,[R2, #+0]
        RSBS     R2,R2,#+0
        MOVS     R0,R2
        B.N      ??QUADRead_1
//  103    
//  104   }
//  105   else
//  106   {
//  107    speed = 10000 - (int)FTM2_CNT;    //计数递减 到底部溢出 正值 正转？ 
??QUADRead_0:
        MOVW     R2,#+10000
        LDR.N    R3,??DataTable2_12  ;; 0x400b8004
        LDR      R3,[R3, #+0]
        SUBS     R2,R2,R3
        MOVS     R0,R2
//  108    
//  109   }
//  110   FTM2_CNT = 0;
??QUADRead_1:
        MOVS     R2,#+0
        LDR.N    R3,??DataTable2_12  ;; 0x400b8004
        STR      R2,[R3, #+0]
//  111  
//  112  
//  113  if(speed < -10000)    speed = 0;
        LDR.N    R2,??DataTable2_4  ;; 0xffffd8f0
        CMP      R0,R2
        BGE.N    ??QUADRead_2
        MOVS     R2,#+0
        MOVS     R0,R2
//  114  if(speed > 10000)     speed = 0;
??QUADRead_2:
        MOVW     R2,#+10001
        CMP      R0,R2
        BLT.N    ??QUADRead_3
        MOVS     R2,#+0
        MOVS     R0,R2
//  115  return speed;
??QUADRead_3:
        BX       LR               ;; return
//  116 }
//  117 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  118 void MotorControl(int data)
//  119 {
//  120    if(data > 0)
MotorControl:
        CMP      R0,#+1
        BLT.N    ??MotorControl_0
//  121    {
//  122     if(data > 4999)
        MOVW     R1,#+5000
        CMP      R0,R1
        BLT.N    ??MotorControl_1
//  123      data = 4999;
        MOVW     R1,#+4999
        MOVS     R0,R1
//  124 
//  125     FTM0_C4V = 0;
??MotorControl_1:
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_13  ;; 0x40038030
        STR      R1,[R2, #+0]
//  126     FTM0_C5V = data;      //左轮正转
        LDR.N    R1,??DataTable2_14  ;; 0x40038038
        STR      R0,[R1, #+0]
        B.N      ??MotorControl_2
//  127     
//  128    }
//  129    else if(data < 0)
??MotorControl_0:
        CMP      R0,#+0
        BPL.N    ??MotorControl_3
//  130    {
//  131     
//  132     if(data < -4999)
        LDR.N    R1,??DataTable2_15  ;; 0xffffec79
        CMP      R0,R1
        BGE.N    ??MotorControl_4
//  133      data = -4999;
        LDR.N    R1,??DataTable2_15  ;; 0xffffec79
        MOVS     R0,R1
//  134 
//  135     FTM0_C5V = 0;
??MotorControl_4:
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_14  ;; 0x40038038
        STR      R1,[R2, #+0]
//  136     FTM0_C4V = -1 * data;  //左轮反转
        MOVS     R1,#-1
        MUL      R1,R1,R0
        LDR.N    R2,??DataTable2_13  ;; 0x40038030
        STR      R1,[R2, #+0]
        B.N      ??MotorControl_2
//  137     
//  138    }
//  139    else if(data == 0)
??MotorControl_3:
        CMP      R0,#+0
        BNE.N    ??MotorControl_2
//  140    {
//  141     FTM0_C7V = 0;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_16  ;; 0x40038048
        STR      R1,[R2, #+0]
//  142     FTM0_C6V = 0;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_17  ;; 0x40038040
        STR      R1,[R2, #+0]
//  143    }
//  144 }
??MotorControl_2:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ??SpeedDev

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     SpeedWant

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0xfffffe0c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ??SpeedInt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0xffffd8f0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     Speed_Kp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     ??SpeedUp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     Speed_Ki

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     ??SpeedUi

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     Speed_Kd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     ??SpeedUd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     0x400b8080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     0x400b8004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     0x40038030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_14:
        DC32     0x40038038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_15:
        DC32     0xffffec79

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_16:
        DC32     0x40038048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_17:
        DC32     0x40038040

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
//  48 bytes in section .bss
// 764 bytes in section .text
// 
// 764 bytes of CODE memory
//  48 bytes of DATA memory
//
//Errors: none
//Warnings: none
