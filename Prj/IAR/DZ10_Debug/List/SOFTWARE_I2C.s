///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:32
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\SOFTWARE_I2C.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\SOFTWARE_I2C.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\SOFTWARE_I2C.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN core_clk_khz
        EXTERN gpio_ddr
        EXTERN gpio_get
        EXTERN gpio_init
        EXTERN gpio_set
        EXTERN systick_delay

        PUBLIC CACK_flag
        PUBLIC IIC_LDC_ReceiveByte
        PUBLIC IIC_LDC_SendByte
        PUBLIC IIC_LDC_Start
        PUBLIC IIC_LDC_Stop
        PUBLIC IIC_LDC_read_byte
        PUBLIC IIC_LDC_write_byte
        PUBLIC Send_Ack
        PUBLIC Send_NoAck

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\SOFTWARE_I2C.c
//    1 #include "SOFTWARE_I2C.h"
//    2 #include "MK60_gpio.h"
//    3 
//    4 
//    5 
//    6 
//    7 
//    8 
//    9 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   10 void IIC_LDC_Start(void)
//   11 {
IIC_LDC_Start:
        PUSH     {R7,LR}
//   12   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   13   gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   14   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   15 
//   16   gpio_set(LDC_SDA,0);
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_set
//   17   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   18   gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   19 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   20 void IIC_LDC_Stop(void)
//   21 {
IIC_LDC_Stop:
        PUSH     {R7,LR}
//   22   gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   23   gpio_set(LDC_SDA,0);
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_set
//   24   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   25   gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   26   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   27   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   28 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 void Send_Ack(void)
//   30 {
Send_Ack:
        PUSH     {R7,LR}
//   31   gpio_set(LDC_SDA,0);
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_set
//   32   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   33   gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   34   DELAY_US(500);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+500
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   35   gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   36   DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   37   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   38 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 void Send_NoAck(void)
//   40 {
Send_NoAck:
        PUSH     {R7,LR}
//   41   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   42   DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   43   gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   44   DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   45   gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   46 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   47 uint8 CACK_flag(void)
//   48 {
CACK_flag:
        PUSH     {R4,LR}
//   49   uint8 ack_flag;
//   50   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   51   DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   52   gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   53   DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   54   gpio_init(LDC_SDA,GPI,1);
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_init
//   55   if(gpio_get(LDC_SDA)==0)
        MOVS     R0,#+65
        BL       gpio_get
        CMP      R0,#+0
        BNE.N    ??CACK_flag_0
//   56   {
//   57     ack_flag=1;
        MOVS     R0,#+1
        MOVS     R4,R0
//   58     gpio_init(LDC_SDA,GPO,0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_init
        B.N      ??CACK_flag_1
//   59   }
//   60   else
//   61   {
//   62     ack_flag=0;
??CACK_flag_0:
        MOVS     R0,#+0
        MOVS     R4,R0
//   63     gpio_init(LDC_SDA,GPO,1);
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_init
//   64   }
//   65   
//   66   gpio_set(LDC_SCL,0);
??CACK_flag_1:
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   67   return ack_flag;
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
//   68 }
//   69 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void IIC_LDC_SendByte(int8 bdata)
//   71 {
IIC_LDC_SendByte:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   72   unsigned char i=8;
        MOVS     R5,#+8
//   73   while(i--)
??IIC_LDC_SendByte_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??IIC_LDC_SendByte_1
//   74   {
//   75     gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   76     DELAY_US(200);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOVS     R1,#+200
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   77     if((bdata&0x80)==0x80)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+24
        BPL.N    ??IIC_LDC_SendByte_2
//   78       gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   79     if((bdata&0x80)==0x00)
??IIC_LDC_SendByte_2:
        LSLS     R0,R4,#+24
        BMI.N    ??IIC_LDC_SendByte_3
//   80       gpio_set(LDC_SDA,0);      
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_set
//   81     bdata<<=1;
??IIC_LDC_SendByte_3:
        LSLS     R4,R4,#+1
//   82     DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   83     gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   84     DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
        B.N      ??IIC_LDC_SendByte_0
//   85   }
//   86   gpio_set(LDC_SCL,0);
??IIC_LDC_SendByte_1:
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   87 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   88 uint8 IIC_LDC_ReceiveByte(void)
//   89 {
IIC_LDC_ReceiveByte:
        PUSH     {R3-R5,LR}
//   90   uint8 i,data=0;
        MOVS     R5,#+0
//   91   gpio_set(LDC_SDA,1);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_set
//   92   for(i=0;i<8;i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??IIC_LDC_ReceiveByte_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??IIC_LDC_ReceiveByte_1
//   93   {
//   94     data<<=1;
        LSLS     R5,R5,#+1
//   95     gpio_set(LDC_SCL,0);
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//   96     DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//   97     gpio_set(LDC_SCL,1);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       gpio_set
//   98     gpio_ddr(LDC_SDA,GPI);
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       gpio_ddr
//   99     DELAY_US(300);
        LDR.N    R0,??DataTable6
        LDR      R0,[R0, #+0]
        MOV      R1,#+300
        MULS     R0,R1,R0
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       systick_delay
//  100     data|=gpio_get(LDC_SDA);
        MOVS     R0,#+65
        BL       gpio_get
        ORRS     R0,R0,R5
        MOVS     R5,R0
//  101     gpio_ddr(LDC_SDA,GPO);
        MOVS     R1,#+1
        MOVS     R0,#+65
        BL       gpio_ddr
//  102   }
        ADDS     R4,R4,#+1
        B.N      ??IIC_LDC_ReceiveByte_0
//  103   gpio_set(LDC_SCL,0);
??IIC_LDC_ReceiveByte_1:
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       gpio_set
//  104   return data;
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  105 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     core_clk_khz
//  106 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 uint8 IIC_LDC_write_byte(uint8 cadd,uint8 data_address,uint16 data_byte)
//  108 { 
IIC_LDC_write_byte:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  109   uint8 data_byte1,data_byte2;
//  110   data_byte1=(uint8)((data_byte)>>8);
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R0,R6,#+8
        MOVS     R7,R0
//  111   data_byte2=(uint8)data_byte;
        MOVS     R0,R6
        MOV      R8,R0
//  112   IIC_LDC_Start();
        BL       IIC_LDC_Start
//  113   IIC_LDC_SendByte((cadd<<1));//xie
        LSLS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  114   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_write_byte_0
//  115   {
//  116     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_write_byte_1
//  117   }
//  118   IIC_LDC_SendByte(data_address);
??IIC_LDC_write_byte_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  119   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_write_byte_2
//  120   {
//  121     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_write_byte_1
//  122   }
//  123   IIC_LDC_SendByte(data_byte1);
??IIC_LDC_write_byte_2:
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  124   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_write_byte_3
//  125   {
//  126     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_write_byte_1
//  127   }
//  128   IIC_LDC_SendByte(data_byte2);
??IIC_LDC_write_byte_3:
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  129   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_write_byte_4
//  130   {
//  131     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_write_byte_1
//  132   }
//  133   IIC_LDC_Stop();
??IIC_LDC_write_byte_4:
        BL       IIC_LDC_Stop
//  134   return 1;
        MOVS     R0,#+1
??IIC_LDC_write_byte_1:
        POP      {R4-R8,PC}       ;; return
//  135 }
//  136 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  137 uint16 IIC_LDC_read_byte(uint8 cadd,uint8 data_address)
//  138 {
IIC_LDC_read_byte:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  139   int temp;
//  140   uint16 temp1,temp2;
//  141   
//  142   IIC_LDC_Start();
        BL       IIC_LDC_Start
//  143   IIC_LDC_SendByte((cadd<<1));//xie
        LSLS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  144   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_read_byte_0
//  145   {
//  146     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_read_byte_1
//  147   }
//  148   IIC_LDC_SendByte(data_address);
??IIC_LDC_read_byte_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  149   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_read_byte_2
//  150   {
//  151     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_read_byte_1
//  152   }
//  153   IIC_LDC_Start();
??IIC_LDC_read_byte_2:
        BL       IIC_LDC_Start
//  154   IIC_LDC_SendByte((cadd<<1)|0x01);//du
        LSLS     R0,R4,#+1
        ORRS     R0,R0,#0x1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_LDC_SendByte
//  155   if(CACK_flag()==0)
        BL       CACK_flag
        CMP      R0,#+0
        BNE.N    ??IIC_LDC_read_byte_3
//  156   {
//  157     return 0;
        MOVS     R0,#+0
        B.N      ??IIC_LDC_read_byte_1
//  158   }
//  159   temp1=(uint16)IIC_LDC_ReceiveByte();
??IIC_LDC_read_byte_3:
        BL       IIC_LDC_ReceiveByte
        MOVS     R7,R0
//  160   Send_Ack();
        BL       Send_Ack
//  161   temp2=(uint16)IIC_LDC_ReceiveByte();
        BL       IIC_LDC_ReceiveByte
        MOV      R8,R0
//  162   Send_NoAck();
        BL       Send_NoAck
//  163   IIC_LDC_Stop();
        BL       IIC_LDC_Stop
//  164   temp=(temp1<<8)+temp2;
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LSLS     R0,R7,#+8
        UXTAH    R0,R0,R8
        MOVS     R6,R0
//  165   //temp=(temp2<<8)+temp1;
//  166   return temp;
        MOVS     R0,R6
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
??IIC_LDC_read_byte_1:
        POP      {R4-R8,PC}       ;; return
//  167 }

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
// 964 bytes in section .text
// 
// 964 bytes of CODE memory
//
//Errors: none
//Warnings: none
