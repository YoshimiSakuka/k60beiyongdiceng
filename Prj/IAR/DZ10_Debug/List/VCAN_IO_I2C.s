///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:33
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\Driver\VCAN_IO_I2C.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\Driver\VCAN_IO_I2C.c
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_IO_I2C.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init
        EXTERN port_init_NoALT

        PUBLIC I2C_ReadOneByte
        PUBLIC IIC_Ack
        PUBLIC IIC_Init
        PUBLIC IIC_NAck
        PUBLIC IIC_Read_Byte
        PUBLIC IIC_Send_Byte
        PUBLIC IIC_Start
        PUBLIC IIC_Stop
        PUBLIC IIC_Wait_Ack
        PUBLIC IICreadByte
        PUBLIC IICreadBytes
        PUBLIC IICwriteBit
        PUBLIC IICwriteBits
        PUBLIC IICwriteByte
        PUBLIC IICwriteBytes
        PUBLIC ms5611_IICread2Data
        PUBLIC ms5611_IICread3Data
        PUBLIC ms5611_IICwriteData

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\Accessories\Driver\VCAN_IO_I2C.c
//    1 /* IOI2C.c file
//    2 功能：
//    3 提供I2C接口操作API 。
//    4 使用IO模拟方式
//    5 ------------------------------------
//    6  */
//    7 #include "VCAN_IO_I2C.h"
//    8 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    9 static void IIC_delay(volatile uint16_t time)
//   10 {
IIC_delay:
        PUSH     {R0}
//   11     while(time)
??IIC_delay_0:
        LDRH     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??IIC_delay_1
//   12     {
//   13         time--;
        LDRH     R0,[SP, #+0]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+0]
        B.N      ??IIC_delay_0
//   14     }
//   15 }
??IIC_delay_1:
        ADD      SP,SP,#+4
        BX       LR               ;; return
//   16   
//   17 /**************************实现函数********************************************
//   18 *函数原型:		void IIC_Init(void)
//   19 *功　　能:		初始化I2C对应的接口引脚。
//   20 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 void IIC_Init(void)
//   22 {			
IIC_Init:
        PUSH     {R7,LR}
//   23     gpio_init  (PTD8, GPO, 1); //初始化SCL0
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+104
        BL       gpio_init
//   24     gpio_init  (PTD9, GPO, 1); //初始化SDA0
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+105
        BL       gpio_init
//   25     port_init_NoALT(PTD8,ODO | PULLUP);
        MOVS     R1,#+35
        MOVS     R0,#+104
        BL       port_init_NoALT
//   26     port_init_NoALT(PTD9,ODO | PULLUP);
        MOVS     R1,#+35
        MOVS     R0,#+105
        BL       port_init_NoALT
//   27 }
        POP      {R0,PC}          ;; return
//   28 
//   29 /**************************实现函数********************************************
//   30 *函数原型:		void IIC_Start(void)
//   31 *功　　能:		产生IIC起始信号
//   32 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void IIC_Start(void)
//   34 {
IIC_Start:
        PUSH     {R7,LR}
//   35 	SDA_DDR_OUT();     
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//   36 	SDA_H();	  	  
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//   37 	SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   38 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//   39  	SDA_L();//START:when CLK is high,DATA change form high to low 
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//   40 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//   41 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   42 }
        POP      {R0,PC}          ;; return
//   43 
//   44 /**************************实现函数********************************************
//   45 *函数原型:		void IIC_Stop(void)
//   46 *功　　能:	    //产生IIC停止信号
//   47 *******************************************************************************/	  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   48 void IIC_Stop(void)
//   49 {
IIC_Stop:
        PUSH     {R7,LR}
//   50 	SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//   51 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   52 	SDA_L();//STOP:when CLK is high DATA change form low to high
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//   53  	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//   54 	SCL_H(); 
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   55 	SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//   56 	IIC_DELAY();							   	
        MOV      R0,#+400
        BL       IIC_delay
//   57 }
        POP      {R0,PC}          ;; return
//   58 
//   59 /**************************实现函数********************************************
//   60 *函数原型:		u8 IIC_Wait_Ack(void)
//   61 *功　　能:	    等待应答信号到来 
//   62 //返回值：1，接收应答失败
//   63 //        0，接收应答成功
//   64 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   65 uint8 IIC_Wait_Ack(void)
//   66 {
IIC_Wait_Ack:
        PUSH     {R4,LR}
//   67 	uint8 ucErrTime=0;
        MOVS     R4,#+0
//   68 	SDA_DDR_IN();     
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//   69 	SDA_H(); IIC_DELAY();	   
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
        MOV      R0,#+400
        BL       IIC_delay
//   70 	SCL_H(); IIC_DELAY();	 
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
        MOV      R0,#+400
        BL       IIC_delay
//   71 	while(SDA_IN())
??IIC_Wait_Ack_0:
        LDR.N    R0,??DataTable6_3  ;; 0x43fe1a24
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??IIC_Wait_Ack_1
//   72 	{
//   73 		ucErrTime++;
        ADDS     R4,R4,#+1
//   74 		if(ucErrTime>50)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+51
        BLT.N    ??IIC_Wait_Ack_2
//   75 		{
//   76 			IIC_Stop();
        BL       IIC_Stop
//   77 			return 1;
        MOVS     R0,#+1
        B.N      ??IIC_Wait_Ack_3
//   78 		}
//   79 	  IIC_DELAY();
??IIC_Wait_Ack_2:
        MOV      R0,#+400
        BL       IIC_delay
        B.N      ??IIC_Wait_Ack_0
//   80 	}
//   81 	SCL_L();//ê±?óê?3?0 	   
??IIC_Wait_Ack_1:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   82 	return 0;  
        MOVS     R0,#+0
??IIC_Wait_Ack_3:
        POP      {R4,PC}          ;; return
//   83 } 
//   84 
//   85 /**************************实现函数********************************************
//   86 *函数原型:		void IIC_Ack(void)
//   87 *功　　能:	    产生ACK应答
//   88 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   89 void IIC_Ack(void)
//   90 {
IIC_Ack:
        PUSH     {R7,LR}
//   91 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   92 	SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//   93 	SDA_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//   94 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//   95 	SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   96 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//   97 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//   98 }
        POP      {R0,PC}          ;; return
//   99 	
//  100 /**************************实现函数********************************************
//  101 *函数原型:		void IIC_NAck(void)
//  102 *功　　能:	    产生NACK应答
//  103 *******************************************************************************/	    

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 void IIC_NAck(void)
//  105 {
IIC_NAck:
        PUSH     {R7,LR}
//  106 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  107 	SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//  108 	SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//  109 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//  110 	SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  111 	IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//  112 	SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  113 }					 				     
        POP      {R0,PC}          ;; return
//  114 
//  115 /**************************实现函数********************************************
//  116 *函数原型:		void IIC_Send_Byte(u8 txd)
//  117 *功　　能:	    IIC发送一个字节
//  118 *******************************************************************************/		  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 void IIC_Send_Byte(uint8 txd)
//  120 {                        
IIC_Send_Byte:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  121     uint8 t=8;   
        MOVS     R5,#+8
//  122     SDA_DDR_OUT(); 	    
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//  123     SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  124     while(t--)
??IIC_Send_Byte_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??IIC_Send_Byte_1
//  125     {
//  126         if(txd&0x80)
        LSLS     R0,R4,#+24
        BPL.N    ??IIC_Send_Byte_2
//  127         {
//  128             SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
        B.N      ??IIC_Send_Byte_3
//  129         }
//  130         else
//  131         {
//  132             SDA_L();
??IIC_Send_Byte_2:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe1824
        STR      R0,[R1, #+0]
//  133         }
//  134         txd<<=1; 
??IIC_Send_Byte_3:
        LSLS     R4,R4,#+1
//  135         IIC_DELAY();   
        MOV      R0,#+400
        BL       IIC_delay
//  136 	SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  137 	IIC_DELAY(); 
        MOV      R0,#+400
        BL       IIC_delay
//  138 	SCL_L();	
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
        B.N      ??IIC_Send_Byte_0
//  139 	//IIC_delay();
//  140     }
//  141 } 	 
??IIC_Send_Byte_1:
        POP      {R0,R4,R5,PC}    ;; return
//  142    
//  143 /**************************实现函数********************************************
//  144 *函数原型:		u8 IIC_Read_Byte(unsigned char ack)
//  145 *功　　能:	    //读1个字节，ack=1时，发送ACK，ack=0，发送nACK 
//  146 *******************************************************************************/ 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 uint8 IIC_Read_Byte(unsigned char ack)
//  148 {
IIC_Read_Byte:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//  149     unsigned char i,receive=0;
        MOVS     R6,#+0
//  150     SDA_DDR_IN();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe1aa4
        STR      R0,[R1, #+0]
//  151     for(i=0;i<8;i++ )
        MOVS     R0,#+0
        MOVS     R5,R0
??IIC_Read_Byte_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+8
        BGE.N    ??IIC_Read_Byte_1
//  152     {
//  153         SCL_L(); 
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  154         IIC_DELAY();
        MOV      R0,#+400
        BL       IIC_delay
//  155 	SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe1820
        STR      R0,[R1, #+0]
//  156         receive<<=1;
        LSLS     R6,R6,#+1
//  157         if(SDA_IN())receive++;   
        LDR.N    R0,??DataTable6_3  ;; 0x43fe1a24
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??IIC_Read_Byte_2
        ADDS     R6,R6,#+1
//  158 	IIC_DELAY(); 
??IIC_Read_Byte_2:
        MOV      R0,#+400
        BL       IIC_delay
//  159     }					 
        ADDS     R5,R5,#+1
        B.N      ??IIC_Read_Byte_0
//  160     if (ack)
??IIC_Read_Byte_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??IIC_Read_Byte_3
//  161         IIC_Ack(); 
        BL       IIC_Ack
        B.N      ??IIC_Read_Byte_4
//  162     else
//  163         IIC_NAck();
??IIC_Read_Byte_3:
        BL       IIC_NAck
//  164     return receive;
??IIC_Read_Byte_4:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R6,PC}       ;; return
//  165 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x43fe1aa4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0x43fe1824

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x43fe1820

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x43fe1a24
//  166 
//  167 /**************************实现函数********************************************
//  168 *函数原型:		unsigned char I2C_ReadOneByte(unsigned char I2C_Addr,unsigned char addr)
//  169 *功　　能:	    读取指定设备 指定寄存器的一个值
//  170 输入	I2C_Addr  目标设备地址
//  171 		addr	   寄存器地址
//  172 返回   读出来的值
//  173 *******************************************************************************/ 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  174 unsigned char I2C_ReadOneByte(unsigned char I2C_Addr,unsigned char addr)
//  175 {
I2C_ReadOneByte:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  176 	unsigned char res=0;
        MOVS     R6,#+0
//  177 	
//  178 	IIC_Start();	
        BL       IIC_Start
//  179 	IIC_Send_Byte(I2C_Addr);	   
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  180 	res++;
        ADDS     R6,R6,#+1
//  181 	IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  182 	IIC_Send_Byte(addr); res++;  
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
        ADDS     R6,R6,#+1
//  183 	IIC_Wait_Ack();	  
        BL       IIC_Wait_Ack
//  184 	//IIC_Stop();
//  185 	IIC_Start();
        BL       IIC_Start
//  186 	IIC_Send_Byte(I2C_Addr+1); res++; 	   
        ADDS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
        ADDS     R6,R6,#+1
//  187 	IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  188 	res=IIC_Read_Byte(0);	   
        MOVS     R0,#+0
        BL       IIC_Read_Byte
        MOVS     R6,R0
//  189     IIC_Stop();
        BL       IIC_Stop
//  190 
//  191 	return res;
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R6,PC}       ;; return
//  192 }
//  193 
//  194 
//  195 /**************************实现函数********************************************
//  196 *函数原型:		u8 IICreadBytes(u8 dev, u8 reg, u8 length, u8 *data)
//  197 *功　　能:	    读取指定设备 指定寄存器的 length个值
//  198 输入	dev  目标设备地址
//  199 		reg	  寄存器地址
//  200 		length 要读的字节数
//  201 		*data  读出的数据将要存放的指针
//  202 返回   读出来的字节数量
//  203 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  204 uint8 IICreadBytes(uint8 dev, uint8 reg, uint8 length, uint8 *data){
IICreadBytes:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  205     uint8 count = 0;
        MOVS     R8,#+0
//  206 	
//  207 	IIC_Start();
        BL       IIC_Start
//  208 	IIC_Send_Byte(dev);	   
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  209 	IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  210 	IIC_Send_Byte(reg);   
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  211     IIC_Wait_Ack();	  
        BL       IIC_Wait_Ack
//  212 	IIC_Start();
        BL       IIC_Start
//  213 	IIC_Send_Byte(dev+1);  
        ADDS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  214 	IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  215 	
//  216     for(count=0;count<length;count++){
        MOVS     R0,#+0
        MOV      R8,R0
??IICreadBytes_0:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R8,R6
        BCS.N    ??IICreadBytes_1
//  217 		 
//  218 		 if(count!=length-1)data[count]=IIC_Read_Byte(1);  
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SUBS     R0,R6,#+1
        CMP      R8,R0
        BEQ.N    ??IICreadBytes_2
        MOVS     R0,#+1
        BL       IIC_Read_Byte
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        STRB     R0,[R8, R7]
        B.N      ??IICreadBytes_3
//  219 		 	else  data[count]=IIC_Read_Byte(0);	 
??IICreadBytes_2:
        MOVS     R0,#+0
        BL       IIC_Read_Byte
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        STRB     R0,[R8, R7]
//  220 	}
??IICreadBytes_3:
        ADDS     R8,R8,#+1
        B.N      ??IICreadBytes_0
//  221     IIC_Stop();
??IICreadBytes_1:
        BL       IIC_Stop
//  222     return count;
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R8,PC}       ;; return
//  223 }
//  224 
//  225 /**************************实现函数********************************************
//  226 *函数原型:		u8 IICwriteBytes(u8 dev, u8 reg, u8 length, u8* data)
//  227 *功　　能:	    将多个字节写入指定设备 指定寄存器
//  228 输入	dev  目标设备地址
//  229 		reg	  寄存器地址
//  230 		length 要写的字节数
//  231 		*data  将要写的数据的首地址
//  232 返回   返回是否成功
//  233 *******************************************************************************/ 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  234 uint8 IICwriteBytes(uint8 dev, uint8 reg, uint8 length, uint8* data){
IICwriteBytes:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  235   
//  236  	uint8 count = 0;
        MOVS     R8,#+0
//  237 	IIC_Start();
        BL       IIC_Start
//  238 	IIC_Send_Byte(dev);	   
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  239 	IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  240 	IIC_Send_Byte(reg);   
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  241     IIC_Wait_Ack();	  
        BL       IIC_Wait_Ack
//  242 	for(count=0;count<length;count++){
        MOVS     R0,#+0
        MOV      R8,R0
??IICwriteBytes_0:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R8,R6
        BCS.N    ??IICwriteBytes_1
//  243 		IIC_Send_Byte(data[count]); 
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        LDRB     R0,[R8, R7]
        BL       IIC_Send_Byte
//  244 		IIC_Wait_Ack(); 
        BL       IIC_Wait_Ack
//  245 	 }
        ADDS     R8,R8,#+1
        B.N      ??IICwriteBytes_0
//  246 	IIC_Stop();
??IICwriteBytes_1:
        BL       IIC_Stop
//  247 
//  248     return 1; //status == 0;
        MOVS     R0,#+1
        POP      {R4-R8,PC}       ;; return
//  249 }
//  250 
//  251 /**************************实现函数********************************************
//  252 *函数原型:		u8 IICreadByte(u8 dev, u8 reg, u8 *data)
//  253 *功　　能:	    读取指定设备 指定寄存器的一个值
//  254 输入	dev  目标设备地址
//  255 		reg	   寄存器地址
//  256 		*data  读出的数据将要存放的地址
//  257 返回   1
//  258 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  259 uint8 IICreadByte(uint8 dev, uint8 reg, uint8 *data){
IICreadByte:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  260 	*data=I2C_ReadOneByte(dev, reg);
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       I2C_ReadOneByte
        STRB     R0,[R6, #+0]
//  261     return 1;
        MOVS     R0,#+1
        POP      {R4-R6,PC}       ;; return
//  262 }
//  263 
//  264 /**************************实现函数********************************************
//  265 *函数原型:		unsigned char IICwriteByte(unsigned char dev, unsigned char reg, unsigned char data)
//  266 *功　　能:	    写入指定设备 指定寄存器一个字节
//  267 输入	dev  目标设备地址
//  268 		reg	   寄存器地址
//  269 		data  将要写入的字节
//  270 返回   1
//  271 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  272 unsigned char IICwriteByte(unsigned char dev, unsigned char reg, unsigned char data){
IICwriteByte:
        PUSH     {R2,R4,R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  273     return IICwriteBytes(dev, reg, 1, &data);
        ADD      R3,SP,#+0
        MOVS     R2,#+1
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IICwriteBytes
        POP      {R1,R4,R5,PC}    ;; return
//  274 }
//  275 
//  276 /**************************实现函数********************************************
//  277 *函数原型:		u8 IICwriteBits(u8 dev,u8 reg,u8 bitStart,u8 length,u8 data)
//  278 *功　　能:	    读 修改 写 指定设备 指定寄存器一个字节 中的多个位
//  279 输入	dev  目标设备地址
//  280 		reg	   寄存器地址
//  281 		bitStart  目标字节的起始位
//  282 		length   位长度
//  283 		data    存放改变目标字节位的值
//  284 返回   成功 为1 
//  285  		失败为0
//  286 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  287 uint8 IICwriteBits(uint8 dev,uint8 reg,uint8 bitStart,uint8 length,uint8 data)
//  288 {
IICwriteBits:
        PUSH     {R3-R9,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
        LDR      R9,[SP, #+32]
//  289 
//  290     uint8 b;
//  291     if (IICreadByte(dev, reg, &b) != 0) {
        ADD      R2,SP,#+0
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IICreadByte
        CMP      R0,#+0
        BEQ.N    ??IICwriteBits_0
//  292         uint8 mask = (0xFF << (bitStart + 1)) | 0xFF >> ((8 - bitStart) + length - 1);
        MOVS     R0,#+255
        ADDS     R1,R6,#+1
        LSLS     R0,R0,R1
        MOVS     R1,#+255
        SUBS     R2,R7,R6
        ADDS     R2,R2,#+7
        MOVS     R3,R1
        ASRS     R3,R3,R2
        ORRS     R8,R3,R0
//  293         data <<= (8 - length);
        RSBS     R0,R7,#+8
        LSLS     R9,R9,R0
//  294         data >>= (7 - bitStart);
        RSBS     R1,R6,#+7
        MOV      R0,R9
        MOV      R9,R0
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        LSRS     R9,R9,R1
//  295         b &= mask;
        LDRB     R0,[SP, #+0]
        ANDS     R0,R8,R0
        STRB     R0,[SP, #+0]
//  296         b |= data;
        LDRB     R0,[SP, #+0]
        ORRS     R0,R9,R0
        STRB     R0,[SP, #+0]
//  297         return IICwriteByte(dev, reg, b);
        LDRB     R2,[SP, #+0]
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IICwriteByte
        B.N      ??IICwriteBits_1
//  298     } else {
//  299         return 0;
??IICwriteBits_0:
        MOVS     R0,#+0
??IICwriteBits_1:
        POP      {R1,R4-R9,PC}    ;; return
//  300     }
//  301 }
//  302 
//  303 /**************************实现函数********************************************
//  304 *函数原型:		u8 IICwriteBit(u8 dev, u8 reg, u8 bitNum, u8 data)
//  305 *功　　能:	    读 修改 写 指定设备 指定寄存器一个字节 中的1个位
//  306 输入	dev  目标设备地址
//  307 		reg	   寄存器地址
//  308 		bitNum  要修改目标字节的bitNum位
//  309 		data  为0 时，目标位将被清0 否则将被置位
//  310 返回   成功 为1 
//  311  		失败为0
//  312 *******************************************************************************/ 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  313 uint8 IICwriteBit(uint8 dev, uint8 reg, uint8 bitNum, uint8 data){
IICwriteBit:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  314     uint8 b;
//  315     IICreadByte(dev, reg, &b);
        ADD      R2,SP,#+0
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IICreadByte
//  316     b = (data != 0) ? (b | (1 << bitNum)) : (b & ~(1 << bitNum));
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??IICwriteBit_0
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R6
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        B.N      ??IICwriteBit_1
??IICwriteBit_0:
        LDRB     R0,[SP, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R6
        BICS     R0,R0,R1
        STRB     R0,[SP, #+0]
//  317     return IICwriteByte(dev, reg, b);
??IICwriteBit_1:
        LDRB     R2,[SP, #+0]
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IICwriteByte
        POP      {R1,R4-R7,PC}    ;; return
//  318 }
//  319 
//  320 
//  321 
//  322 /*********************************MS5611 IIC**********************************
//  323 **MS5611 IIC Read & Write Functions
//  324 **(1) MS5611 Write Data
//  325 **(2) MS5611 Read 2 Bytes
//  326 **(3) MS5611 Read 3 Bytes
//  327 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  328 uint8 ms5611_IICwriteData(uint8 dev, uint8 data)
//  329 {
ms5611_IICwriteData:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  330     IIC_Start();
        BL       IIC_Start
//  331     IIC_Send_Byte(dev);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  332     IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  333     IIC_Send_Byte(data);
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  334     IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  335     IIC_Stop();
        BL       IIC_Stop
//  336     return 1;
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
//  337 }
//  338 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  339 uint16 ms5611_IICread2Data(uint8 dev)
//  340 {
ms5611_IICread2Data:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//  341     uint8 temp1, temp2;
//  342     IIC_Start();
        BL       IIC_Start
//  343     IIC_Send_Byte(dev+1);
        ADDS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  344     IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  345     temp1 = IIC_Read_Byte(1);
        MOVS     R0,#+1
        BL       IIC_Read_Byte
        MOVS     R5,R0
//  346     temp2 = IIC_Read_Byte(0);
        MOVS     R0,#+0
        BL       IIC_Read_Byte
        MOVS     R6,R0
//  347     IIC_Stop();
        BL       IIC_Stop
//  348     return (temp1<<8 | temp2);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ORRS     R0,R6,R5, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R4-R6,PC}       ;; return
//  349 }
//  350 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  351 uint32 ms5611_IICread3Data(uint8 dev)
//  352 {
ms5611_IICread3Data:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
//  353     uint8 temp1, temp2, temp3;
//  354     IIC_Start();
        BL       IIC_Start
//  355     IIC_Send_Byte(dev+1);
        ADDS     R0,R4,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       IIC_Send_Byte
//  356     IIC_Wait_Ack();
        BL       IIC_Wait_Ack
//  357     temp1 = IIC_Read_Byte(1);
        MOVS     R0,#+1
        BL       IIC_Read_Byte
        MOVS     R5,R0
//  358     temp2 = IIC_Read_Byte(1);
        MOVS     R0,#+1
        BL       IIC_Read_Byte
        MOVS     R6,R0
//  359     temp3 = IIC_Read_Byte(0);
        MOVS     R0,#+0
        BL       IIC_Read_Byte
        MOVS     R7,R0
//  360     IIC_Stop();
        BL       IIC_Stop
//  361     return (temp1<<16 | temp2 <<8 | temp3);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LSLS     R0,R6,#+8
        ORRS     R0,R0,R5, LSL #+16
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        ORRS     R0,R7,R0
        POP      {R1,R4-R7,PC}    ;; return
//  362 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  363 //------------------End of File----------------------------
// 
// 1 244 bytes in section .text
// 
// 1 244 bytes of CODE memory
//
//Errors: none
//Warnings: 35
