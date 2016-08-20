///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:31
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_uart.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_uart.c -D
//        DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\
//        -lB
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\ -o
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\Obj\
//        --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa
//        --no_clustering --no_scheduling --debug --endian=little
//        --cpu=Cortex-M4 -e --fpu=None --dlib_config "E:\IAR for
//        ARM\arm\INC\c\DLib_Config_Full.h" -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\App\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\App\Inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\ -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\IAR\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Chip\inc\kinetis\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\CMSIS\Inc\
//        -I D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\FatFs\
//        -I D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Lib\USB\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\MPU6050\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\IMU\
//        -I
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\..\..\Board\Accessories\Driver\
//        -On
//    List file    =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_uart.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN bus_clk_khz
        EXTERN core_clk_khz
        EXTERN port_init

        PUBLIC UARTN
        PUBLIC uart3_test_handler
        PUBLIC uart_getchar
        PUBLIC uart_init
        PUBLIC uart_putbuff
        PUBLIC uart_putchar
        PUBLIC uart_putstr
        PUBLIC uart_query
        PUBLIC uart_querybuff
        PUBLIC uart_querychar
        PUBLIC uart_querystr
        PUBLIC uart_rx_irq_dis
        PUBLIC uart_rx_irq_en
        PUBLIC uart_tx_irq_dis
        PUBLIC uart_tx_irq_en
        PUBLIC uart_txc_irq_dis
        PUBLIC uart_txc_irq_en

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_uart.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_uart.c
//   11  * @brief      uart���ں���
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.2
//   14  * @date       2014-10-09
//   15  */
//   16 
//   17 
//   18 #include "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.W    R2,??DataTable13  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R3,R0,#+5
        STR      R1,[R2, R3, LSL #+2]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_DisableIRQ(IRQn_Type)
NVIC_DisableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.W    R2,??DataTable13_1  ;; 0xe000e180
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R3,R0,#+5
        STR      R1,[R2, R3, LSL #+2]
        BX       LR               ;; return
//   19 #include "MK60_uart.h"
//   20 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   21 UART_MemMapPtr UARTN[UART_MAX] = {UART0_BASE_PTR, UART1_BASE_PTR, UART2_BASE_PTR, UART3_BASE_PTR, UART4_BASE_PTR, UART5_BASE_PTR}; //�������ָ�����鱣�� UARTN �ĵ�ַ
UARTN:
        DATA
        DC32 4006A000H, 4006B000H, 4006C000H, 4006D000H, 400EA000H, 400EB000H
//   22 
//   23 
//   24 /*!
//   25  *  @brief      ��ʼ�����ڣ����ò�����
//   26  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//   27  *  @param      baud        �����ʣ���9600��19200��56000��115200��
//   28  *  @since      v5.0
//   29  *  @note       UART���õĹܽ��� App\Inc\PORT_cfg.h ��������ã�
//   30                 printf���õĹܽźͲ������� App\Inc\MK60_conf.h ���������
//   31  *  Sample usage:       uart_init (UART3, 9600);        //��ʼ������3��������Ϊ9600
//   32  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void uart_init (UARTn_e uratn, uint32 baud)
//   34 {
uart_init:
        PUSH     {R3-R9,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   35     register uint16 sbr, brfa;
//   36     uint8 temp;
//   37     uint32 sysclk;     //ʱ��
//   38 
//   39     /* ���� UART���ܵ� ���ùܽ� */
//   40     switch(uratn)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??uart_init_0
        CMP      R4,#+2
        BEQ.N    ??uart_init_1
        BCC.N    ??uart_init_2
        CMP      R4,#+4
        BEQ.N    ??uart_init_3
        BCC.N    ??uart_init_4
        CMP      R4,#+5
        BEQ.N    ??uart_init_5
        B.N      ??uart_init_6
//   41     {
//   42     case UART0:
//   43         SIM_SCGC4 |= SIM_SCGC4_UART0_MASK;      //ʹ�� UART0 ʱ��
??uart_init_0:
        LDR.W    R0,??DataTable13_2  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R1,??DataTable13_2  ;; 0x40048034
        STR      R0,[R1, #+0]
//   44 
//   45         if(UART0_RX_PIN == PTA1)
//   46         {
//   47             port_init( UART0_RX_PIN, ALT2);
//   48         }
//   49         else if((UART0_RX_PIN == PTA15) || (UART0_RX_PIN == PTB16) || (UART0_RX_PIN == PTD6)  )
//   50         {
//   51             port_init( UART0_RX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+102
        BL       port_init
//   52         }
//   53         else
//   54         {
//   55             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//   56         }
//   57 
//   58         if(UART0_TX_PIN == PTA2)
//   59         {
//   60             port_init( UART0_TX_PIN, ALT2);
//   61         }
//   62         else if((UART0_TX_PIN == PTA14) || (UART0_TX_PIN == PTB17) || (UART0_TX_PIN == PTD7) )
//   63         {
//   64             port_init( UART0_TX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+103
        BL       port_init
//   65         }
//   66         else
//   67         {
//   68             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//   69         }
//   70 
//   71         break;
        B.N      ??uart_init_7
//   72 
//   73     case UART1:
//   74         SIM_SCGC4 |= SIM_SCGC4_UART1_MASK;
??uart_init_2:
        LDR.W    R0,??DataTable13_2  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800
        LDR.W    R1,??DataTable13_2  ;; 0x40048034
        STR      R0,[R1, #+0]
//   75 
//   76         if((UART1_RX_PIN == PTC3) || (UART1_RX_PIN == PTE1))
//   77         {
//   78             port_init( UART1_RX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+67
        BL       port_init
//   79         }
//   80         else
//   81         {
//   82             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//   83         }
//   84 
//   85         if((UART1_TX_PIN == PTC4) || (UART1_TX_PIN == PTE0))
//   86         {
//   87             port_init( UART1_TX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+68
        BL       port_init
//   88         }
//   89         else
//   90         {
//   91             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//   92         }
//   93 
//   94         break;
        B.N      ??uart_init_7
//   95 
//   96     case UART2:
//   97         SIM_SCGC4 |= SIM_SCGC4_UART2_MASK;
??uart_init_1:
        LDR.W    R0,??DataTable13_2  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.W    R1,??DataTable13_2  ;; 0x40048034
        STR      R0,[R1, #+0]
//   98         if(UART2_TX_PIN == PTD3)
//   99         {
//  100             port_init( UART2_TX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+99
        BL       port_init
//  101         }
//  102         else
//  103         {
//  104             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  105         }
//  106 
//  107 
//  108         if(UART2_RX_PIN == PTD2)
//  109         {
//  110             port_init( UART2_RX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+98
        BL       port_init
//  111         }
//  112         else
//  113         {
//  114             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  115         }
//  116 
//  117         break;
        B.N      ??uart_init_7
//  118 
//  119     case UART3:
//  120         SIM_SCGC4 |= SIM_SCGC4_UART3_MASK;
??uart_init_4:
        LDR.W    R0,??DataTable13_2  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.W    R1,??DataTable13_2  ;; 0x40048034
        STR      R0,[R1, #+0]
//  121 
//  122         if((UART3_RX_PIN == PTB10)|| (UART3_RX_PIN == PTC16) || (UART3_RX_PIN == PTE5) )
//  123         {
//  124             port_init( UART3_RX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+80
        BL       port_init
//  125         }
//  126         else
//  127         {
//  128             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  129         }
//  130 
//  131         if((UART3_TX_PIN == PTB11) || (UART3_TX_PIN == PTC17) || (UART3_TX_PIN == PTE4) )
//  132         {
//  133             port_init( UART3_TX_PIN, ALT3);             //��PTB11��ʹ��UART3_RXD
        MOV      R1,#+768
        MOVS     R0,#+81
        BL       port_init
//  134         }
//  135         else
//  136         {
//  137             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  138         }
//  139         break;
        B.N      ??uart_init_7
//  140 
//  141     case UART4:
//  142         SIM_SCGC1 |= SIM_SCGC1_UART4_MASK;
??uart_init_3:
        LDR.W    R0,??DataTable13_3  ;; 0x40048028
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R1,??DataTable13_3  ;; 0x40048028
        STR      R0,[R1, #+0]
//  143 
//  144         if((UART4_RX_PIN == PTC14) || (UART4_RX_PIN == PTE25)  )
//  145         {
//  146             port_init( UART4_RX_PIN, ALT3);            //��PTC14��ʹ��UART4_RXD
        MOV      R1,#+768
        MOVS     R0,#+78
        BL       port_init
//  147         }
//  148         else
//  149         {
//  150             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  151         }
//  152 
//  153         if((UART4_TX_PIN == PTC15) || (UART4_TX_PIN == PTE24)  )
//  154         {
//  155             port_init( UART4_TX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+79
        BL       port_init
//  156         }
//  157         else
//  158         {
//  159             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  160         }
//  161         break;
        B.N      ??uart_init_7
//  162 
//  163     case UART5:
//  164         SIM_SCGC1 |= SIM_SCGC1_UART5_MASK;
??uart_init_5:
        LDR.W    R0,??DataTable13_3  ;; 0x40048028
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800
        LDR.W    R1,??DataTable13_3  ;; 0x40048028
        STR      R0,[R1, #+0]
//  165 
//  166         if((UART5_RX_PIN == PTD8) || (UART5_RX_PIN == PTE9))
//  167         {
//  168             port_init( UART5_RX_PIN, ALT3);
        MOV      R1,#+768
        MOVS     R0,#+137
        BL       port_init
//  169         }
//  170         else
//  171         {
//  172             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  173         }
//  174 
//  175         if((UART5_TX_PIN == PTD9) ||(UART5_TX_PIN == PTE8))
//  176         {
//  177             port_init( UART5_TX_PIN, ALT3);             //��PTD9��ʹ��UART5_RXD
        MOV      R1,#+768
        MOVS     R0,#+136
        BL       port_init
//  178         }
//  179         else
//  180         {
//  181             ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
//  182         }
//  183         break;
        B.N      ??uart_init_7
//  184     default:
//  185         break;
//  186     }
//  187 
//  188     //���õ�ʱ��Ӧ�ý�ֹ���ͽ���
//  189     UART_C2_REG(UARTN[uratn]) &= ~(0
//  190                                    | UART_C2_TE_MASK
//  191                                    | UART_C2_RE_MASK
//  192                                   );
??uart_init_6:
??uart_init_7:
        LDR.W    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ANDS     R0,R0,#0xF3
        LDR.W    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  193 
//  194 
//  195     //���ó�8λ��У��ģʽ
//  196     //���� UART ���ݸ�ʽ��У�鷽ʽ��ֹͣλλ����ͨ������ UART ģ����ƼĴ��� C1 ʵ�֣�
//  197     UART_C1_REG(UARTN[uratn]) |= (0
//  198                                   //| UART_C1_M_MASK                    //9 λ�� 8 λģʽѡ�� : 0 Ϊ 8λ ��1 Ϊ 9λ��ע���˱�ʾ0����8λ�� �������9λ��λ8��UARTx_C3�
//  199                                   //| UART_C1_PE_MASK                   //��żУ��ʹ�ܣ�ע���˱�ʾ���ã�
//  200                                   //| UART_C1_PT_MASK                   //У��λ���� : 0 Ϊ żУ�� ��1 Ϊ ��У��
//  201                                  );
        LDR.W    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  202 
//  203     //���㲨���ʣ�����0��1ʹ���ں�ʱ�ӣ���������ʹ��busʱ��
//  204     if ((uratn == UART0) || (uratn == UART1))
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??uart_init_8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??uart_init_9
//  205     {
//  206         sysclk = core_clk_khz * 1000;                                   //�ں�ʱ��
??uart_init_8:
        LDR.W    R0,??DataTable13_5
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOV      R9,R0
        B.N      ??uart_init_10
//  207     }
//  208     else
//  209     {
//  210         sysclk = bus_clk_khz * 1000;                                    //busʱ��
??uart_init_9:
        LDR.N    R0,??DataTable13_6
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOV      R9,R0
//  211     }
//  212 
//  213     //UART ������ = UART ģ��ʱ�� / (16 �� (SBR[12:0] + BRFA))
//  214     //������ BRFA ������£� SBR = UART ģ��ʱ�� / (16 * UART ������)
//  215     sbr = (uint16)(sysclk / (baud * 16));
??uart_init_10:
        LSLS     R0,R5,#+4
        UDIV     R0,R9,R0
        MOVS     R6,R0
//  216     if(sbr > 0x1FFF)sbr = 0x1FFF;                                       //SBR �� 13bit�����Ϊ 0x1FFF
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+8192
        BLT.N    ??uart_init_11
        MOVW     R0,#+8191
        MOVS     R6,R0
//  217 
//  218     //��֪ SBR ���� BRFA =  = UART ģ��ʱ�� / UART ������ - 16 ��SBR[12:0]
//  219     brfa = (sysclk / baud)  - (sbr * 16);
??uart_init_11:
        UDIV     R0,R9,R5
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        SUBS     R0,R0,R6, LSL #+4
        MOVS     R7,R0
//  220     ASSERT( brfa <= 0x1F);                  //���ԣ������ֵ�����������������õ�����������Ĵ���������
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BLT.N    ??uart_init_12
        MOVS     R1,#+220
        LDR.N    R0,??DataTable13_7
        BL       assert_failed
//  221                                             //����ͨ����������������������
//  222 
//  223     //д SBR
//  224     temp = UART_BDH_REG(UARTN[uratn]) & (~UART_BDH_SBR_MASK);           //���� ��� SBR �� UARTx_BDH��ֵ
??uart_init_12:
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xE0
        MOV      R8,R0
//  225     UART_BDH_REG(UARTN[uratn]) = temp |  UART_BDH_SBR(sbr >> 8);        //��д��SBR��λ
        UBFX     R0,R6,#+8,#+5
        ORRS     R0,R0,R8
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+0]
//  226     UART_BDL_REG(UARTN[uratn]) = UART_BDL_SBR(sbr);                     //��д��SBR��λ
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STRB     R6,[R0, #+1]
//  227 
//  228     //д BRFD
//  229     temp = UART_C4_REG(UARTN[uratn]) & (~UART_C4_BRFA_MASK) ;           //���� ��� BRFA �� UARTx_C4 ��ֵ
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+10]
        ANDS     R0,R0,#0xE0
        MOV      R8,R0
//  230     UART_C4_REG(UARTN[uratn]) = temp |  UART_C4_BRFA(brfa);             //д��BRFA
        ANDS     R0,R7,#0x1F
        ORRS     R0,R0,R8
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+10]
//  231 
//  232 
//  233 
//  234     //����FIFO(FIFO���������Ӳ�������ģ������������)
//  235     UART_PFIFO_REG(UARTN[uratn]) |= (0
//  236                                      | UART_PFIFO_TXFE_MASK               //ʹ��TX FIFO(ע�ͱ�ʾ��ֹ)
//  237                                      //| UART_PFIFO_TXFIFOSIZE(0)         //��ֻ����TX FIFO ��С��0Ϊ1�ֽڣ�1~6Ϊ 2^(n+1)�ֽ�
//  238                                      | UART_PFIFO_RXFE_MASK               //ʹ��RX FIFO(ע�ͱ�ʾ��ֹ)
//  239                                      //| UART_PFIFO_RXFIFOSIZE(0)         //��ֻ����RX FIFO ��С��0Ϊ1�ֽڣ�1~6Ϊ 2^(n+1)�ֽ�
//  240                                     );
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+16]
        ORRS     R0,R0,#0x88
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+16]
//  241 
//  242     /* �����ͺͽ��� */
//  243     UART_C2_REG(UARTN[uratn]) |= (0
//  244                                   | UART_C2_TE_MASK                     //����ʹ��
//  245                                   | UART_C2_RE_MASK                     //����ʹ��
//  246                                   //| UART_C2_TIE_MASK                  //�����жϻ�DMA��������ʹ�ܣ�ע���˱�ʾ���ã�
//  247                                   //| UART_C2_TCIE_MASK                 //��������ж�ʹ�ܣ�ע���˱�ʾ���ã�
//  248                                   //| UART_C2_RIE_MASK                  //�������жϻ�DMA��������ʹ�ܣ�ע���˱�ʾ���ã�
//  249                                  );
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0xC
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  250 
//  251     //�����Ƿ�������պͷ����жϡ�ͨ������ UART ģ��� C2 �Ĵ�����
//  252     //RIE �� TIE λʵ�֡����ʹ���жϣ���������ʵ���жϷ������
//  253 }
        POP      {R0,R4-R9,PC}    ;; return
//  254 
//  255 /*!
//  256  *  @brief      �ȴ�����1���ֽ�
//  257  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  258  *  @param      ch          ���յ�ַ
//  259  *  @since      v5.0
//  260  *  @note       �����Ҫ��ѯ����״̬������ uart_query ��
//  261                 �����Ҫ��ѯ�������ݣ����� uart_querychar
//  262  *  Sample usage:
//  263                         char ch;
//  264                         uart_getchar (UART3,&ch);   //�ȴ�����1���ֽڣ����浽 ch��
//  265  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  266 void uart_getchar (UARTn_e uratn, char *ch)
//  267 {
//  268     //�ȴ����յ����ݣ�ʹ����FIFO���������ַ��������У�����һ������˼��
//  269     //while( !UART_RCFIFO_REG(UARTN[uratn]) );                                //�ȴ����յ�����������0
//  270     //while( (UART_SFIFO_REG(UARTN[uratn]) & UART_SFIFO_RXEMPT_MASK)) ;     //�ȴ����ջ�����/FIFO �ǿյ�
//  271 
//  272     //���·����Ƿ�˼�����ٷ������ṩ�ķ���
//  273     while (!(UART_S1_REG(UARTN[uratn]) & UART_S1_RDRF_MASK));       //�ȴ���������
uart_getchar:
??uart_getchar_0:
        LDR.N    R2,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDRB     R2,[R2, #+4]
        LSLS     R2,R2,#+26
        BPL.N    ??uart_getchar_0
//  274 
//  275     // ��ȡ���յ���8λ����
//  276     *ch =  UART_D_REG(UARTN[uratn]);
        LDR.N    R2,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDRB     R2,[R2, #+7]
        STRB     R2,[R1, #+0]
//  277 
//  278     // ��ȡ 9λ���ݣ�Ӧ���ǣ���Ҫ�޸ĺ����ķ������ͣ���
//  279     // *ch =   ((( UARTx_C3_REG(UARTN[uratn]) & UART_C3_R8_MASK ) >> UART_C3_R8_SHIFT ) << 8)   |   UART_D_REG(UARTN[uratn]);  //����9bit
//  280 
//  281 }
        BX       LR               ;; return
//  282 
//  283 
//  284 /*!
//  285  *  @brief      ��ѯ����1���ַ�
//  286  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  287  *  @param      ch          ���յ�ַ
//  288  *  @return     1Ϊ���ճɹ���0Ϊ����ʧ��
//  289  *  @since      v5.0
//  290  *  @note       �����Ҫ�ȴ����գ����� uart_getchar
//  291  *  Sample usage:       char ch ;
//  292                         if( uart_querychar (UART3,&ch) == 1)     //��ѯ����1���ַ������浽 ch��
//  293                         {
//  294                             printf("�ɹ����յ�һ���ֽ�");
//  295                         }
//  296  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  297 char uart_querychar (UARTn_e uratn, char *ch)
//  298 {
uart_querychar:
        MOVS     R2,R0
//  299     if( UART_RCFIFO_REG(UARTN[uratn]) )         //��ѯ�Ƿ���ܵ�����
        LDR.N    R0,??DataTable13_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R0,[R0, R2, LSL #+2]
        LDRB     R0,[R0, #+22]
        CMP      R0,#+0
        BEQ.N    ??uart_querychar_0
//  300     {
//  301         *ch  =   UART_D_REG(UARTN[uratn]);      //���ܵ�8λ������
        LDR.N    R0,??DataTable13_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R0,[R0, R2, LSL #+2]
        LDRB     R0,[R0, #+7]
        STRB     R0,[R1, #+0]
//  302         return  1;                              //���� 1 ��ʾ���ճɹ�
        MOVS     R0,#+1
        B.N      ??uart_querychar_1
//  303     }
//  304 
//  305     *ch = 0;                                    //���ղ�����Ӧ������˽�����
??uart_querychar_0:
        MOVS     R0,#+0
        STRB     R0,[R1, #+0]
//  306     return 0;                                   //����0��ʾ����ʧ��
        MOVS     R0,#+0
??uart_querychar_1:
        BX       LR               ;; return
//  307 }
//  308 
//  309 /*!
//  310  *  @brief      ��ѯ�����ַ���
//  311  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  312  *  @param      str         ���յ�ַ
//  313  *  @param      max_len     �����ճ���
//  314  *  @return     ���յ����ֽ���Ŀ
//  315  *  @since      v5.0
//  316  *  Sample usage:       char str[100];
//  317                         uint32 num;
//  318                         num = uart_querystr (UART3,&str,100);
//  319                         if( num != 0 )
//  320                         {
//  321                             printf("�ɹ����յ�%d���ֽ�:%s",num,str);
//  322                         }
//  323  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  324 uint32 uart_querystr (UARTn_e uratn, char *str, uint32 max_len)
//  325 {
uart_querystr:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  326     uint32 i = 0,j;
        MOVS     R8,#+0
//  327 
//  328     for(j=0;j<10000;j++)                 // 10000 ����������ʱ�������и�������޸�
        MOVS     R0,#+0
        MOVS     R7,R0
??uart_querystr_0:
        MOVW     R0,#+10000
        CMP      R7,R0
        BCS.N    ??uart_querystr_1
//  329     {
//  330         while(uart_querychar(uratn, str + i)  )
??uart_querystr_2:
        ADDS     R1,R8,R5
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       uart_querychar
        CMP      R0,#+0
        BEQ.N    ??uart_querystr_3
//  331         {
//  332             j=0;
        MOVS     R0,#+0
        MOVS     R7,R0
//  333             if( *(str + i) == NULL )    //���յ��ַ���������
        LDRB     R0,[R8, R5]
        CMP      R0,#+0
        BNE.N    ??uart_querystr_4
//  334             {
//  335                 return i;
        MOV      R0,R8
        B.N      ??uart_querystr_5
//  336             }
//  337 
//  338             i++;
??uart_querystr_4:
        ADDS     R8,R8,#+1
//  339             if(i >= max_len)            //�����趨�����ֵ���˳�
        CMP      R8,R6
        BCC.N    ??uart_querystr_2
//  340             {
//  341                 *(str + i) = 0;     //ȷ���ַ�����β��0x00
        MOVS     R0,#+0
        STRB     R0,[R8, R5]
//  342                 return i;
        MOV      R0,R8
        B.N      ??uart_querystr_5
//  343             }
//  344         }
//  345     }
??uart_querystr_3:
        ADDS     R7,R7,#+1
        B.N      ??uart_querystr_0
//  346 
//  347     *(str + i) = 0;                     //ȷ���ַ�����β��0x00
??uart_querystr_1:
        MOVS     R0,#+0
        STRB     R0,[R8, R5]
//  348     return i;
        MOV      R0,R8
??uart_querystr_5:
        POP      {R4-R8,PC}       ;; return
//  349 }
//  350 
//  351 
//  352 /*!
//  353  *  @brief      ��ѯ����buff
//  354  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  355  *  @param      str         ���յ�ַ
//  356  *  @param      max_len     �����ճ���
//  357  *  @return     ���յ����ֽ���Ŀ
//  358  *  @since      v5.0
//  359  *  Sample usage:       char buff[100];
//  360                         uint32 num;
//  361                         num = uart_querybuff (UART3,&buff,100);
//  362                         if( num != 0 )
//  363                         {
//  364                             printf("�ɹ����յ�%d���ֽ�:%s",num,buff);
//  365                         }
//  366  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  367 uint32 uart_querybuff (UARTn_e uratn, char *buff, uint32 max_len)
//  368 {
uart_querybuff:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  369     uint32 i = 0,j;
        MOVS     R7,#+0
//  370     for(j=0;j<10000;j++)                 // 10000 ����������ʱ�������и�������޸�
        MOVS     R0,#+0
        MOV      R8,R0
??uart_querybuff_0:
        MOVW     R0,#+10000
        CMP      R8,R0
        BCS.N    ??uart_querybuff_1
//  371     {
//  372         while(uart_querychar(uratn, buff + i)  )
??uart_querybuff_2:
        ADDS     R1,R7,R5
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       uart_querychar
        CMP      R0,#+0
        BEQ.N    ??uart_querybuff_3
//  373         {
//  374             i++;
        ADDS     R7,R7,#+1
//  375             if(i >= max_len)            //�����趨�����ֵ���˳�
        CMP      R7,R6
        BCC.N    ??uart_querybuff_2
//  376             {
//  377                 return i;
        MOVS     R0,R7
        B.N      ??uart_querybuff_4
//  378             }
//  379         }
//  380     }
??uart_querybuff_3:
        ADDS     R8,R8,#+1
        B.N      ??uart_querybuff_0
//  381 
//  382     return i;
??uart_querybuff_1:
        MOVS     R0,R7
??uart_querybuff_4:
        POP      {R4-R8,PC}       ;; return
//  383 }
//  384 
//  385 
//  386 /*!
//  387  *  @brief      ���ڷ���һ���ֽ�
//  388  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  389  *  @param      ch          ��Ҫ���͵��ֽ�
//  390  *  @since      v5.0
//  391  *  @note       printf��Ҫ�õ��˺���
//  392  *  @see        fputc
//  393  *  Sample usage:       uart_putchar (UART3, 'A');  //�����ֽ�'A'
//  394  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  395 void uart_putchar (UARTn_e uratn, char ch)
//  396 {
//  397     //�ȴ����ͻ�������
//  398     while(!(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK));
uart_putchar:
??uart_putchar_0:
        LDR.N    R2,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDRB     R2,[R2, #+4]
        LSLS     R2,R2,#+24
        BPL.N    ??uart_putchar_0
//  399 
//  400     //��������
//  401     UART_D_REG(UARTN[uratn]) = (uint8)ch;
        LDR.N    R2,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+7]
//  402 }
        BX       LR               ;; return
//  403 
//  404 /*!
//  405  *  @brief      ��ѯ�Ƿ���ܵ�һ���ֽ�
//  406  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  407  *  @return     ���յ����ݷ���1��û���յ����ݷ���0
//  408  *  @since      v5.0
//  409  *  Sample usage:       char ch;
//  410                         if(uart_query (UART3) == 1)     //��ѯ�Ƿ���յ�����
//  411                         {
//  412                             ch = uart_getchar (UART3);  //�ȴ�����һ�����ݣ����浽 ch��
//  413                         }
//  414  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  415 char uart_query (UARTn_e uratn)
//  416 {
uart_query:
        MOVS     R1,R0
//  417     if(UART_RCFIFO_REG(UARTN[uratn]))                 //���յ�����������0
        LDR.N    R0,??DataTable13_4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR      R0,[R0, R1, LSL #+2]
        LDRB     R0,[R0, #+22]
        CMP      R0,#+0
        BEQ.N    ??uart_query_0
//  418         //if(!(UART_SFIFO_REG(UARTN[uratn]) & UART_SFIFO_RXEMPT_MASK))
//  419         //if(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK)
//  420     {
//  421         return 1;
        MOVS     R0,#+1
        B.N      ??uart_query_1
//  422     }
//  423     else
//  424     {
//  425         return 0;
??uart_query_0:
        MOVS     R0,#+0
??uart_query_1:
        BX       LR               ;; return
//  426     }
//  427     //return UART_RCFIFO_REG(UARTN[uratn]);
//  428 }
//  429 
//  430 /*!
//  431  *  @brief      ����ָ��len���ֽڳ������� ������ NULL Ҳ�ᷢ�ͣ�
//  432  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  433  *  @param      buff        �����ַ
//  434  *  @param      len         ��������ĳ���
//  435  *  @since      v5.0
//  436  *  Sample usage:       uart_putbuff (UART3,"1234567", 3); //ʵ�ʷ�����3���ֽ�'1','2','3'
//  437  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  438 void uart_putbuff (UARTn_e uratn, uint8 *buff, uint32 len)
//  439 {
uart_putbuff:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  440     while(len--)
??uart_putbuff_0:
        MOVS     R0,R6
        SUBS     R6,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??uart_putbuff_1
//  441     {
//  442         uart_putchar(uratn, *buff);
        LDRB     R1,[R5, #+0]
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       uart_putchar
//  443         buff++;
        ADDS     R5,R5,#+1
        B.N      ??uart_putbuff_0
//  444     }
//  445 }
??uart_putbuff_1:
        POP      {R4-R6,PC}       ;; return
//  446 
//  447 
//  448 /*!
//  449  *  @brief      �����ַ���(�� NULL ֹͣ����)
//  450  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  451  *  @param      str         �ַ�����ַ
//  452  *  @since      v5.0
//  453  *  Sample usage:       uart_putstr (UART3,"1234567"); //ʵ�ʷ�����7���ֽ�
//  454  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  455 void uart_putstr (UARTn_e uratn, const uint8 *str)
//  456 {
uart_putstr:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  457     while(*str)
??uart_putstr_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??uart_putstr_1
//  458     {
//  459         uart_putchar(uratn, *str++);
        LDRB     R1,[R5, #+0]
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       uart_putchar
        ADDS     R5,R5,#+1
        B.N      ??uart_putstr_0
//  460     }
//  461 }
??uart_putstr_1:
        POP      {R0,R4,R5,PC}    ;; return
//  462 
//  463 /*!
//  464  *  @brief      �����ڽ����ж�
//  465  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  466  *  @since      v5.0
//  467  *  Sample usage:       uart_rx_irq_en(UART3);         //������3�����ж�
//  468  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  469 void uart_rx_irq_en(UARTn_e uratn)
//  470 {
uart_rx_irq_en:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  471     UART_C2_REG(UARTN[uratn]) |= UART_C2_RIE_MASK;                          //ʹ��UART�����ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  472     enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  473 }
        POP      {R4,PC}          ;; return
//  474 
//  475 /*!
//  476  *  @brief      �����ڷ����ж�
//  477  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  478  *  @since      v5.0
//  479  *  Sample usage:       uart_tx_irq_en(UART3);         //������3�����ж�
//  480  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  481 void uart_tx_irq_en(UARTn_e uratn)
//  482 {
uart_tx_irq_en:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  483     UART_C2_REG(UARTN[uratn]) |= UART_C2_TIE_MASK;                          //ʹ��UART�����ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  484     enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  485 }
        POP      {R4,PC}          ;; return
//  486 
//  487 /*!
//  488  *  @brief      �����ڷ�������ж�
//  489  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  490  *  @since      v5.0
//  491  *  Sample usage:       uart_tx_irq_en(UART3);         //������3�����ж�
//  492  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  493 void uart_txc_irq_en(UARTn_e uratn)
//  494 {
uart_txc_irq_en:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  495     UART_C2_REG(UARTN[uratn]) |= UART_C2_TCIE_MASK;                         //ʹ��UART�����ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  496     enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_EnableIRQ
//  497 }
        POP      {R4,PC}          ;; return
//  498 
//  499 /*!
//  500  *  @brief      �ش��ڽ����ж�
//  501  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  502  *  @since      v5.0
//  503  *  Sample usage:       uart_rx_irq_dis(UART3);         //�ش���3�����ж�
//  504  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  505 void uart_rx_irq_dis(UARTn_e uratn)
//  506 {
uart_rx_irq_dis:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  507     UART_C2_REG(UARTN[uratn]) &= ~UART_C2_RIE_MASK;                         //��ֹUART�����ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ANDS     R0,R0,#0xDF
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  508 
//  509     //��������жϻ�û�йأ��򲻹ر�IRQ
//  510     if(!(UART_C2_REG(UARTN[uratn]) & (UART_C2_TIE_MASK | UART_C2_TCIE_MASK)) )
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        MOVS     R1,#+192
        TST      R0,R1
        BNE.N    ??uart_rx_irq_dis_0
//  511     {
//  512         disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  513     }
//  514 }
??uart_rx_irq_dis_0:
        POP      {R4,PC}          ;; return
//  515 
//  516 /*!
//  517  *  @brief      �ش��ڷ����ж�
//  518  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  519  *  @since      v5.0
//  520  *  Sample usage:       uart_tx_irq_dis(UART3);         //�ش���3�����ж�
//  521  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  522 void uart_txc_irq_dis(UARTn_e uratn)
//  523 {
uart_txc_irq_dis:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  524     UART_C2_REG(UARTN[uratn]) &= ~UART_C2_TCIE_MASK;                        //��ֹUART��������ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ANDS     R0,R0,#0xBF
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  525 
//  526     //��������жϻ�û�йأ��򲻹ر�IRQ
//  527     if(!(UART_C2_REG(UARTN[uratn]) & UART_C2_RIE_MASK) )
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+26
        BMI.N    ??uart_txc_irq_dis_0
//  528     {
//  529         disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  530     }
//  531 }
??uart_txc_irq_dis_0:
        POP      {R4,PC}          ;; return
//  532 
//  533 /*!
//  534  *  @brief      �ش��ڷ����ж�
//  535  *  @param      UARTn_e       ģ��ţ�UART0~UART5��
//  536  *  @since      v5.0
//  537  *  Sample usage:       uart_tx_irq_dis(UART3);         //�ش���3�����ж�
//  538  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  539 void uart_tx_irq_dis(UARTn_e uratn)
//  540 {
uart_tx_irq_dis:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  541     UART_C2_REG(UARTN[uratn]) &= ~UART_C2_TIE_MASK;                         //��ֹUART�����ж�
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ANDS     R0,R0,#0x7F
        LDR.N    R1,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  542 
//  543     //��������жϻ�û�йأ��򲻹ر�IRQ
//  544     if(!(UART_C2_REG(UARTN[uratn]) & UART_C2_RIE_MASK) )
        LDR.N    R0,??DataTable13_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+26
        BMI.N    ??uart_tx_irq_dis_0
//  545     {
//  546         disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+1
        ADDS     R0,R0,#+45
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BL       NVIC_DisableIRQ
//  547     }
//  548 }
??uart_tx_irq_dis_0:
        POP      {R4,PC}          ;; return
//  549 
//  550 /*!
//  551  *  @brief      UART3�����жϷ�����
//  552  *  @since      v5.0
//  553  *  @warning    �˺�����Ҫ�û������Լ�������ɣ�����������ṩһ��ģ��
//  554  *  Sample usage:       set_vector_handler(UART3_RX_TX_VECTORn , uart3_test_handler);    //�� uart3_handler ������ӵ��ж�����������Ҫ�����ֶ�����
//  555  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  556 void uart3_test_handler(void)
//  557 {
//  558     UARTn_e uratn = UART3;
uart3_test_handler:
        MOVS     R0,#+3
//  559 
//  560     if(UART_S1_REG(UARTN[uratn]) & UART_S1_RDRF_MASK)   //�������ݼĴ�����
        LDR.N    R1,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R1,[R1, R0, LSL #+2]
        LDRB     R1,[R1, #+4]
//  561     {
//  562         //�û���Ҫ�����������
//  563 
//  564     }
//  565 
//  566     if(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK )  //�������ݼĴ�����
        LDR.N    R1,??DataTable13_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R1,[R1, R0, LSL #+2]
        LDRB     R1,[R1, #+4]
//  567     {
//  568         //�û���Ҫ����������
//  569 
//  570     }
//  571 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_1:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_2:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_3:
        DC32     0x40048028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_4:
        DC32     UARTN

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_5:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_6:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_7:
        DC32     ?_0

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
        DC8 44H, 3AH, 5CH, 53H, 74H, 75H, 64H, 79H
        DC8 5CH, 32H, 30H, 31H, 36H, 0B5H, 0E7H, 0D7H
        DC8 0D3H, 0C9H, 0E8H, 0BCH, 0C6H, 0B4H, 0F3H, 0C8H
        DC8 0FCH, 5CH, 54H, 69H, 5CH, 0B5H, 0E7H, 0C8H
        DC8 0FCH, 0B1H, 0B8H, 0D3H, 0C3H, 0B5H, 0D7H, 0B2H
        DC8 0E3H, 5CH, 43H, 68H, 69H, 70H, 5CH, 73H
        DC8 72H, 63H, 5CH, 4DH, 4BH, 36H, 30H, 5FH
        DC8 75H, 61H, 72H, 74H, 2EH, 63H, 0
        DC8 0

        END
// 
//    24 bytes in section .data
//    64 bytes in section .rodata
// 1 256 bytes in section .text
// 
// 1 256 bytes of CODE  memory
//    64 bytes of CONST memory
//    24 bytes of DATA  memory
//
//Errors: none
//Warnings: none
