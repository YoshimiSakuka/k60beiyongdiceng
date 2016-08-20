///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:18
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_SCCB.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_SCCB.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_SCCB.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init
        EXTERN port_init_NoALT

        PUBLIC SCCB_GPIO_init
        PUBLIC SCCB_ReadByte
        PUBLIC SCCB_WriteByte

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_SCCB.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       VCAN_SCCB.c
//   11  * @brief      OV摄像头配置总线SCCB函数库
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-09-01
//   15  */
//   16 
//   17 
//   18 #include "common.h"
//   19 #include "MK60_gpio.h"
//   20 #include "VCAN_SCCB.h"
//   21 
//   22 static void SCCB_delay(uint16 i);
//   23 
//   24 /*!
//   25  *  @brief      SCCB延迟函数
//   26  *  @param      time    延时时间
//   27  *  @since      v5.0
//   28  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 static void SCCB_delay(volatile uint16 time)
//   30 {
SCCB_delay:
        PUSH     {R0}
//   31     while(time)
??SCCB_delay_0:
        LDRH     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??SCCB_delay_1
//   32     {
//   33         time--;
        LDRH     R0,[SP, #+0]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+0]
        B.N      ??SCCB_delay_0
//   34     }
//   35 }
??SCCB_delay_1:
        ADD      SP,SP,#+4
        BX       LR               ;; return
//   36 
//   37 /*!
//   38  *  @brief      SCCB管脚配置
//   39  *  @since      v5.0
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 void SCCB_GPIO_init(void)
//   42 {
SCCB_GPIO_init:
        PUSH     {R7,LR}
//   43     gpio_init  (SCCB_SCL, GPO, 1); //初始化SCL
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+26
        BL       gpio_init
//   44     gpio_init  (SCCB_SDA, GPO, 1); //初始化SDA
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+25
        BL       gpio_init
//   45 
//   46     port_init_NoALT(SCCB_SCL,ODO | PULLUP);
        MOVS     R1,#+35
        MOVS     R0,#+26
        BL       port_init_NoALT
//   47     port_init_NoALT(SCCB_SDA,ODO | PULLUP);
        MOVS     R1,#+35
        MOVS     R0,#+25
        BL       port_init_NoALT
//   48 }
        POP      {R0,PC}          ;; return
//   49 
//   50 /*!
//   51  *  @brief      SCCB起始信号
//   52  *  @since      v5.0
//   53  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   54 static uint8 SCCB_Start(void)
//   55 {
SCCB_Start:
        PUSH     {R7,LR}
//   56     SCCB_SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//   57     SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//   58     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//   59 
//   60     SCCB_SDA_DDR_IN();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//   61     if(!SCCB_SDA_IN())
        LDR.N    R0,??DataTable6_3  ;; 0x43fe0264
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??SCCB_Start_0
//   62     {
//   63         SCCB_SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//   64         return 0;   /* SDA线为低电平则总线忙,退出 */
        MOVS     R0,#+0
        B.N      ??SCCB_Start_1
//   65     }
//   66     SCCB_SDA_DDR_OUT();
??SCCB_Start_0:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//   67     SCCB_SDA_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//   68 
//   69     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//   70     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//   71 
//   72     if(SCCB_SDA_IN())
        LDR.N    R0,??DataTable6_3  ;; 0x43fe0264
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??SCCB_Start_2
//   73     {
//   74         SCCB_SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//   75         return 0;   /* SDA线为高电平则总线出错,退出 */
        MOVS     R0,#+0
        B.N      ??SCCB_Start_1
//   76     }
//   77     //SCCB_SDA_DDR_OUT();
//   78     //SCCB_SDA_L();
//   79     //SCCB_delay();
//   80     return 1;
??SCCB_Start_2:
        MOVS     R0,#+1
??SCCB_Start_1:
        POP      {R1,PC}          ;; return
//   81 }
//   82 
//   83 /*!
//   84  *  @brief      SCCB停止信号
//   85  *  @since      v5.0
//   86  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   87 static void SCCB_Stop(void)
//   88 {
SCCB_Stop:
        PUSH     {R7,LR}
//   89     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//   90     //SCCB_DELAY();
//   91     
//   92     SCCB_SDA_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//   93     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//   94     
//   95     SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//   96     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//   97     
//   98     SCCB_SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//   99     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  100 }
        POP      {R0,PC}          ;; return
//  101 
//  102 /*!
//  103  *  @brief      SCCB应答信号
//  104  *  @since      v5.0
//  105  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  106 static void SCCB_Ack(void)
//  107 {
SCCB_Ack:
        PUSH     {R7,LR}
//  108     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  109     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  110     
//  111     SCCB_SDA_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//  112     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  113     
//  114     SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  115     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  116     
//  117     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  118     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  119 }
        POP      {R0,PC}          ;; return
//  120 
//  121 /*!
//  122  *  @brief      SCCB无应答信号
//  123  *  @since      v5.0
//  124  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 static void SCCB_NoAck(void)
//  126 {
SCCB_NoAck:
        PUSH     {R7,LR}
//  127     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  128     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  129     
//  130     SCCB_SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//  131     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  132     
//  133     SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  134     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  135     
//  136     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  137     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  138 }
        POP      {R0,PC}          ;; return
//  139 
//  140 /*!
//  141  *  @brief      SCCB 等待应答
//  142  *  @return     应答结果（0表示无应答，1表示有应答）
//  143  *  @since      v5.0
//  144  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  145 static int SCCB_WaitAck(void)
//  146 {
SCCB_WaitAck:
        PUSH     {R7,LR}
//  147     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  148     //SCCB_SDA_H();
//  149     SCCB_SDA_DDR_IN();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//  150 
//  151     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  152     SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  153 
//  154     SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  155 
//  156     if(SCCB_SDA_IN())           //应答为高电平，异常，通信失败
        LDR.N    R0,??DataTable6_3  ;; 0x43fe0264
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??SCCB_WaitAck_0
//  157     {
//  158         SCCB_SDA_DDR_OUT();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//  159         SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  160         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_WaitAck_1
//  161     }
//  162     SCCB_SDA_DDR_OUT();
??SCCB_WaitAck_0:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//  163     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  164     return 1;
        MOVS     R0,#+1
??SCCB_WaitAck_1:
        POP      {R1,PC}          ;; return
//  165 }
//  166 
//  167 /*!
//  168  *  @brief      SCCB 发送的数据
//  169  *  @param      SendByte    需要发送的数据
//  170  *  @since      v5.0
//  171  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  172 static void SCCB_SendByte(uint8 SendByte)
//  173 {
SCCB_SendByte:
        PUSH     {R3-R5,LR}
        MOVS     R5,R0
//  174     uint8 i = 8;
        MOVS     R4,#+8
//  175     while(i--)
??SCCB_SendByte_0:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??SCCB_SendByte_1
//  176     {
//  177 
//  178         if(SendByte & 0x80)     //SDA 输出数据
        LSLS     R0,R5,#+24
        BPL.N    ??SCCB_SendByte_2
//  179         {
//  180             SCCB_SDA_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
        B.N      ??SCCB_SendByte_3
//  181         }
//  182         else
//  183         {
//  184             SCCB_SDA_L();
??SCCB_SendByte_2:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6  ;; 0x43fe0064
        STR      R0,[R1, #+0]
//  185         }
//  186         SendByte <<= 1;
??SCCB_SendByte_3:
        LSLS     R5,R5,#+1
//  187         SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  188         
//  189         SCCB_SCL_H();                //SCL 拉高，采集信号
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  190         SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  191         
//  192         SCCB_SCL_L();                //SCL 时钟线拉低
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
        B.N      ??SCCB_SendByte_0
//  193         //SCCB_DELAY();
//  194     }
//  195     //SCCB_SCL_L();
//  196 }
??SCCB_SendByte_1:
        POP      {R0,R4,R5,PC}    ;; return
//  197 
//  198 /*!
//  199  *  @brief      接收SCCB总线的数据
//  200  *  @return     接收到的数据
//  201  *  @since      v5.0
//  202  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  203 static int SCCB_ReceiveByte(void)
//  204 {
SCCB_ReceiveByte:
        PUSH     {R3-R5,LR}
//  205     uint8 i = 8;
        MOVS     R4,#+8
//  206     uint8 ReceiveByte = 0;
        MOVS     R5,#+0
//  207 
//  208     //SCCB_SDA_H();
//  209     //SCCB_DELAY();
//  210     SCCB_SDA_DDR_IN();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//  211 
//  212     while(i--)
??SCCB_ReceiveByte_0:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??SCCB_ReceiveByte_1
//  213     {
//  214         ReceiveByte <<= 1;
        LSLS     R5,R5,#+1
//  215         SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  216         SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  217         
//  218         SCCB_SCL_H();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  219         SCCB_DELAY();
        MOV      R0,#+400
        BL       SCCB_delay
//  220 
//  221         if(SCCB_SDA_IN())
        LDR.N    R0,??DataTable6_3  ;; 0x43fe0264
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??SCCB_ReceiveByte_0
//  222         {
//  223             ReceiveByte |= 0x01;
        ORRS     R5,R5,#0x1
        B.N      ??SCCB_ReceiveByte_0
//  224         }
//  225 
//  226 
//  227     }
//  228     SCCB_SDA_DDR_OUT();
??SCCB_ReceiveByte_1:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_2  ;; 0x43fe02e4
        STR      R0,[R1, #+0]
//  229     SCCB_SCL_L();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_1  ;; 0x43fe0068
        STR      R0,[R1, #+0]
//  230     return ReceiveByte;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOVS     R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  231 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x43fe0064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0x43fe0068

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x43fe02e4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x43fe0264
//  232 
//  233 /*****************************************************************************************
//  234 * 函数名：SCCB_WriteByte
//  235 * 描述  ：写一字节数据
//  236 * 输入  ：- WriteAddress: 待写入地址    - SendByte: 待写入数据  - DeviceAddress: 器件类型
//  237 * 输出  ：返回为:=1成功写入,=0失败
//  238 * 注意  ：无
//  239 *****************************************************************************************/
//  240 static int SCCB_WriteByte_one( uint16 WriteAddress , uint8 SendByte );
//  241 
//  242 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  243 int SCCB_WriteByte( uint16 WriteAddress , uint8 SendByte )            //考虑到用sccb的管脚模拟，比较容易失败，因此多试几次
//  244 {
SCCB_WriteByte:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  245     uint8 i = 0;
        MOVS     R6,#+0
//  246     while( 0 == SCCB_WriteByte_one ( WriteAddress, SendByte ) )
??SCCB_WriteByte_0:
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       SCCB_WriteByte_one
        CMP      R0,#+0
        BNE.N    ??SCCB_WriteByte_1
//  247     {
//  248         i++;
        ADDS     R6,R6,#+1
//  249         if(i == 20)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+20
        BNE.N    ??SCCB_WriteByte_0
//  250         {
//  251             return 0 ;
        MOVS     R0,#+0
        B.N      ??SCCB_WriteByte_2
//  252         }
//  253     }
//  254     return 1;
??SCCB_WriteByte_1:
        MOVS     R0,#+1
??SCCB_WriteByte_2:
        POP      {R4-R6,PC}       ;; return
//  255 }
//  256 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  257 int SCCB_WriteByte_one( uint16 WriteAddress , uint8 SendByte )
//  258 {
SCCB_WriteByte_one:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  259     if(!SCCB_Start())
        BL       SCCB_Start
        CMP      R0,#+0
        BNE.N    ??SCCB_WriteByte_one_0
//  260     {
//  261         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_WriteByte_one_1
//  262     }
//  263     SCCB_SendByte( DEV_ADR );                    /* 器件地址 */
??SCCB_WriteByte_one_0:
        MOVS     R0,#+66
        BL       SCCB_SendByte
//  264     if( !SCCB_WaitAck() )
        BL       SCCB_WaitAck
        CMP      R0,#+0
        BNE.N    ??SCCB_WriteByte_one_2
//  265     {
//  266         SCCB_Stop();
        BL       SCCB_Stop
//  267         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_WriteByte_one_1
//  268     }
//  269     SCCB_SendByte((uint8)(WriteAddress & 0x00FF));   /* 设置低起始地址 */
??SCCB_WriteByte_one_2:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCB_SendByte
//  270     SCCB_WaitAck();
        BL       SCCB_WaitAck
//  271     SCCB_SendByte(SendByte);
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCB_SendByte
//  272     SCCB_WaitAck();
        BL       SCCB_WaitAck
//  273     SCCB_Stop();
        BL       SCCB_Stop
//  274     return 1;
        MOVS     R0,#+1
??SCCB_WriteByte_one_1:
        POP      {R1,R4,R5,PC}    ;; return
//  275 }
//  276 
//  277 
//  278 
//  279 
//  280 /******************************************************************************************************************
//  281  * 函数名：SCCB_ReadByte
//  282  * 描述  ：读取一串数据
//  283  * 输入  ：- pBuffer: 存放读出数据  - length: 待读出长度    - ReadAddress: 待读出地址        - DeviceAddress: 器件类型
//  284  * 输出  ：返回为:=1成功读入,=0失败
//  285  * 注意  ：无
//  286  **********************************************************************************************************************/
//  287 static int SCCB_ReadByte_one(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress);
//  288 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  289 int SCCB_ReadByte(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress)
//  290 {
SCCB_ReadByte:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  291     uint8 i = 0;
        MOVS     R7,#+0
//  292     while( 0 == SCCB_ReadByte_one(pBuffer, length, ReadAddress) )
??SCCB_ReadByte_0:
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       SCCB_ReadByte_one
        CMP      R0,#+0
        BNE.N    ??SCCB_ReadByte_1
//  293     {
//  294         i++;
        ADDS     R7,R7,#+1
//  295         if(i == 30)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+30
        BNE.N    ??SCCB_ReadByte_0
//  296         {
//  297             return 0 ;
        MOVS     R0,#+0
        B.N      ??SCCB_ReadByte_2
//  298         }
//  299     }
//  300     return 1;
??SCCB_ReadByte_1:
        MOVS     R0,#+1
??SCCB_ReadByte_2:
        POP      {R1,R4-R7,PC}    ;; return
//  301 }
//  302 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  303 int SCCB_ReadByte_one(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress)
//  304 {
SCCB_ReadByte_one:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  305     if(!SCCB_Start())
        BL       SCCB_Start
        CMP      R0,#+0
        BNE.N    ??SCCB_ReadByte_one_0
//  306     {
//  307         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_ReadByte_one_1
//  308     }
//  309     SCCB_SendByte( DEV_ADR );         /* 器件地址 */
??SCCB_ReadByte_one_0:
        MOVS     R0,#+66
        BL       SCCB_SendByte
//  310     if( !SCCB_WaitAck() )
        BL       SCCB_WaitAck
        CMP      R0,#+0
        BNE.N    ??SCCB_ReadByte_one_2
//  311     {
//  312         SCCB_Stop();
        BL       SCCB_Stop
//  313         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_ReadByte_one_1
//  314     }
//  315     SCCB_SendByte( ReadAddress );           /* 设置低起始地址 */
??SCCB_ReadByte_one_2:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCB_SendByte
//  316     SCCB_WaitAck();
        BL       SCCB_WaitAck
//  317     SCCB_Stop();
        BL       SCCB_Stop
//  318 
//  319     if(!SCCB_Start())
        BL       SCCB_Start
        CMP      R0,#+0
        BNE.N    ??SCCB_ReadByte_one_3
//  320     {
//  321         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_ReadByte_one_1
//  322     }
//  323     SCCB_SendByte( DEV_ADR + 1 );               /* 器件地址 */
??SCCB_ReadByte_one_3:
        MOVS     R0,#+67
        BL       SCCB_SendByte
//  324 
//  325     if(!SCCB_WaitAck())
        BL       SCCB_WaitAck
        CMP      R0,#+0
        BNE.N    ??SCCB_ReadByte_one_4
//  326     {
//  327         SCCB_Stop();
        BL       SCCB_Stop
//  328         return 0;
        MOVS     R0,#+0
        B.N      ??SCCB_ReadByte_one_1
//  329     }
//  330     while(length)
??SCCB_ReadByte_one_4:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BEQ.N    ??SCCB_ReadByte_one_5
//  331     {
//  332         *pBuffer = SCCB_ReceiveByte();
        BL       SCCB_ReceiveByte
        STRB     R0,[R4, #+0]
//  333         if(length == 1)
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+1
        BNE.N    ??SCCB_ReadByte_one_6
//  334         {
//  335             SCCB_NoAck();
        BL       SCCB_NoAck
        B.N      ??SCCB_ReadByte_one_7
//  336         }
//  337         else
//  338         {
//  339             SCCB_Ack();
??SCCB_ReadByte_one_6:
        BL       SCCB_Ack
//  340         }
//  341         pBuffer++;
??SCCB_ReadByte_one_7:
        ADDS     R4,R4,#+1
//  342         length--;
        SUBS     R5,R5,#+1
        B.N      ??SCCB_ReadByte_one_4
//  343     }
//  344     SCCB_Stop();
??SCCB_ReadByte_one_5:
        BL       SCCB_Stop
//  345     return 1;
        MOVS     R0,#+1
??SCCB_ReadByte_one_1:
        POP      {R4-R6,PC}       ;; return
//  346 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  347 
//  348 
//  349 
//  350 
// 
// 866 bytes in section .text
// 
// 866 bytes of CODE memory
//
//Errors: none
//Warnings: 40
