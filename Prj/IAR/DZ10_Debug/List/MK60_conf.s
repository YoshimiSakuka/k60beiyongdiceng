///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:25
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\Study\2016������ƴ���\Ti\�������õײ�\App\MK60_conf.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\App\MK60_conf.c -D DEBUG -D
//        ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_conf.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN flash_erase_sector
        EXTERN flash_init
        EXTERN key_check
        EXTERN key_init
        EXTERN led_init
        EXTERN led_turn
        EXTERN printf
        EXTERN systick_delay_ms
        EXTERN uart_putchar

        PUBLIC ASSERT_FAILED_STR
        PUBLIC assert_failed
        PUBLIC default_isr
        PUBLIC fputc
        PUBLIC start_check
        PUBLIC vector_str

// D:\Study\2016������ƴ���\Ti\�������õײ�\App\MK60_conf.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_conf.c
//   11  * @brief      ɽ��K60 ƽ̨���ù���ʵ���ļ�
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.1
//   14  * @date       2013-06-26
//   15  */
//   16 
//   17 #include    "common.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_SystemReset(void)
NVIC_SystemReset:
        DSB      
        LDR.N    R0,??DataTable3  ;; 0xe000ed0c
        LDR      R0,[R0, #+0]
        ANDS     R0,R0,#0x700
        LDR.N    R1,??DataTable3_1  ;; 0x5fa0004
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable3  ;; 0xe000ed0c
        STR      R0,[R1, #+0]
        DSB      
??NVIC_SystemReset_0:
        B.N      ??NVIC_SystemReset_0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "\012\275\370\310\353\313\300\321\255\273\267\265\310\264\375\243\241"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "\012\275\370\320\320\275\342\313\370\262\331\327\367\243\254\307\353\326\330\320\302\313\242\310\353\271\314\274\376"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 0AH, 2AH, 2AH, 2AH, 2AH, 64H, 65H, 66H
        DC8 61H, 75H, 6CH, 74H, 5FH, 69H, 73H, 72H
        DC8 20H, 65H, 6EH, 74H, 65H, 72H, 65H, 64H
        DC8 20H, 6FH, 6EH, 20H, 76H, 65H, 63H, 74H
        DC8 6FH, 72H, 20H, 25H, 64H, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 0AH, 0AH, 25H, 73H, 20H, 49H
        DC8 6EH, 74H, 65H, 72H, 72H, 75H, 70H, 74H
        DC8 0
        DC8 0, 0, 0
//   18 #include    "stdio.h"
//   19 #include    "MK60_uart.h"
//   20 #include    "VCAN_KEY.h"
//   21 #include    "VCAN_LED.h"
//   22 #include    "MK60_flash.h"
//   23 
//   24 
//   25 /*!
//   26  *  @brief      ����ʧ����ִ�еĺ���
//   27  *  @param      file    �ļ�·����ַ
//   28  *  @param      line    ����
//   29  *  @since      v5.0
//   30  *  Sample usage:       assert_failed(__FILE__, __LINE__);
//   31  */

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   32 const char ASSERT_FAILED_STR[] = "Assertion failed in %s at line %d\n";
ASSERT_FAILED_STR:
        DATA
        DC8 "Assertion failed in %s at line %d\012"
        DC8 0
//   33 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 void assert_failed(char *file, int line)
//   35 {
assert_failed:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   36     led_init(LED0);
        MOVS     R0,#+0
        BL       led_init
//   37     while (1)
//   38     {
//   39 
//   40         DEBUG_PRINTF(ASSERT_FAILED_STR, file, line);      //ͨ��������ʾ����ʧ��
??assert_failed_0:
        MOVS     R2,R5
        MOVS     R1,R4
        LDR.N    R0,??DataTable3_2
        BL       printf
//   41 
//   42         //��ѭ���ȴ�����Ա���Ϊ�ζ���ʧ��
//   43         led_turn(LED0);
        MOVS     R0,#+0
        BL       led_turn
//   44         DELAY_MS(1000);
        MOV      R0,#+1000
        BL       systick_delay_ms
        B.N      ??assert_failed_0
//   45 
//   46     }
//   47 }
//   48 
//   49 /*!
//   50  *  @brief      �ض���printf ������
//   51  *  @param      ch      ��Ҫ��ӡ���ֽ�
//   52  *  @param      stream  ������
//   53  *  @since      v5.0
//   54  *  @note       �˺����ɱ������Դ������printf������
//   55  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 int fputc(int ch, FILE *stream)
//   57 {
fputc:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   58     uart_putchar(VCAN_PORT, (char)ch);
        MOVS     R1,R4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+1
        BL       uart_putchar
//   59     return(ch);
        MOVS     R0,R4
        POP      {R1,R4,R5,PC}    ;; return
//   60 }
//   61 
//   62 /*!
//   63  *  @brief      ����ǰ���м�⣨��ⰴ���Ƿ��£������������ѭ������ֹ���� main ����,�ɿ��������ٰ�������н�����
//   64  *  @since      v5.0
//   65  *  @note       �˺����ɱ��� ���ؿ��� main ǰ �����˵����޷����ص�����
//   66  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void start_check()
//   68 {
start_check:
        PUSH     {R4,LR}
//   69     uint8 flag = 0;
        MOVS     R4,#+0
//   70 
//   71     key_init(KEY_A);
        MOVS     R0,#+4
        BL       key_init
//   72 
//   73     if(key_check(KEY_A) == KEY_DOWN )
        MOVS     R0,#+4
        BL       key_check
        CMP      R0,#+0
        BNE.N    ??start_check_0
//   74     {
//   75         //��������
//   76 
//   77         led_init(LED0);
        MOVS     R0,#+0
        BL       led_init
//   78 
//   79         while(1)
//   80         {
//   81 
//   82             if(key_check(KEY_A) == KEY_UP)
??start_check_1:
        MOVS     R0,#+4
        BL       key_check
        CMP      R0,#+1
        BNE.N    ??start_check_2
//   83             {
//   84                 flag = 1;
        MOVS     R0,#+1
        MOVS     R4,R0
//   85             }
//   86 
//   87             led_turn(LED0);
??start_check_2:
        MOVS     R0,#+0
        BL       led_turn
//   88             printf("\n������ѭ���ȴ���");
        LDR.N    R0,??DataTable3_3
        BL       printf
//   89             DELAY_MS(500);                          //�˴�����ʱ������ ���� �����Ĺ���
        MOV      R0,#+500
        BL       systick_delay_ms
//   90 
//   91             //��� �Ϳ��������ٰ��� �������� ���н��� ����
//   92             if((flag == 1)  && (key_check(KEY_A) == KEY_DOWN ))
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??start_check_1
        MOVS     R0,#+4
        BL       key_check
        CMP      R0,#+0
        BNE.N    ??start_check_1
//   93             {
//   94                 while(key_check(KEY_A) == KEY_DOWN)         //�ȴ����� ����
??start_check_3:
        MOVS     R0,#+4
        BL       key_check
        CMP      R0,#+0
        BNE.N    ??start_check_4
//   95                 {
//   96                     led_turn(LED0);
        MOVS     R0,#+0
        BL       led_turn
//   97                     DELAY_MS(100);                          //�˴�����ʱ������ ���� �����Ĺ���
        MOVS     R0,#+100
        BL       systick_delay_ms
        B.N      ??start_check_3
//   98                 }
//   99 
//  100                 while(key_check(KEY_A) == KEY_UP)         //�ȴ����� ����� �� ���н���
??start_check_4:
        MOVS     R0,#+4
        BL       key_check
        CMP      R0,#+1
        BNE.N    ??start_check_5
//  101                 {
//  102                     led_turn(LED0);
        MOVS     R0,#+0
        BL       led_turn
//  103                     DELAY_MS(50);                          //�˴�����ʱ������ ���� �����Ĺ���
        MOVS     R0,#+50
        BL       systick_delay_ms
        B.N      ??start_check_4
//  104                 }
//  105 
//  106                 printf("\n���н���������������ˢ��̼�");
??start_check_5:
        LDR.N    R0,??DataTable3_4
        BL       printf
//  107 
//  108                 //������Ƭ��
//  109                 flash_init();
        BL       flash_init
//  110                 DELAY_MS(100);
        MOVS     R0,#+100
        BL       systick_delay_ms
//  111                 flash_erase_sector(0);        //�������� 0  (����)
        MOVS     R0,#+0
        BL       flash_erase_sector
//  112                 NVIC_SystemReset();           //��λ��Ƭ��
        BL       NVIC_SystemReset
        B.N      ??start_check_1
//  113 
//  114             }
//  115         }
//  116     }
//  117 }
??start_check_0:
        POP      {R4,PC}          ;; return
//  118 
//  119 #ifdef  DEBUG
//  120 // VECTOR_TABLE end
//  121 static char vector_str[][15];
//  122 #endif
//  123 
//  124 /*!
//  125  *  @brief      Ĭ���жϷ�����
//  126  *  @since      v5.0
//  127  *  @note       �˺���д���ж������������Ҫ�û�ִ��
//  128  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 void default_isr(void)
//  130 {
default_isr:
        PUSH     {R4,LR}
//  131 
//  132 
//  133 #ifdef  DEBUG
//  134 #define VECTORNUM    ((SCB_ICSR & SCB_ICSR_VECTACTIVE_MASK)>>SCB_ICSR_VECTACTIVE_SHIFT)
//  135                             //��Ч�� (*(volatile uint8_t*)(0xE000ED04))
//  136     uint8 vtr = VECTORNUM;
        LDR.N    R0,??DataTable3_5  ;; 0xe000ed04
        LDR      R4,[R0, #+0]
//  137     led_init(LED1);
        MOVS     R0,#+1
        BL       led_init
//  138 
//  139     while(1)
//  140     {
//  141         led_turn(LED1);
??default_isr_0:
        MOVS     R0,#+1
        BL       led_turn
//  142         DEBUG_PRINTF("\n****default_isr entered on vector %d*****\n\n%s Interrupt", vtr, vector_str[vtr]);
        LDR.N    R0,??DataTable3_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+15
        MLA      R2,R1,R4,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,R4
        LDR.N    R0,??DataTable3_7
        BL       printf
//  143 
//  144         DELAY_MS(1000);
        MOV      R0,#+1000
        BL       systick_delay_ms
        B.N      ??default_isr_0
//  145     }
//  146 #else
//  147     return;
//  148 #endif
//  149 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0xe000ed0c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x5fa0004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     ASSERT_FAILED_STR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     vector_str

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     ?_2
//  150 
//  151 #ifdef DEBUG
//  152 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  153 char vector_str[][15] =
vector_str:
        DATA
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "NonMaskable"
        DC8 0, 0, 0
        DC8 "HardFault"
        DC8 0, 0, 0, 0, 0
        DC8 "MemManagement"
        DC8 0
        DC8 "BusFault"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "UsageFault"
        DC8 0, 0, 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SVCall"
        DC8 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DebugMonitor"
        DC8 0, 0
        DC8 ""
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PendSV"
        DC8 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SysTick"
        DC8 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA2"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA3"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA4"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA5"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA6"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA7"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA8"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA9"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA10"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA11"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA12"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA13"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA14"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA15"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DMA_Error"
        DC8 0, 0, 0, 0, 0
        DC8 "MCM"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "FTFL"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "Read_Collision"
        DC8 "LVD_LVW"
        DC8 0, 0, 0, 0, 0, 0, 0
        DC8 "LLW"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "Watchdog"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "RNG"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "I2C0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "I2C1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SPI0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SPI1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SPI2"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "CAN0_OR_MB_buf"
        DC8 "CAN0_Bus_Off"
        DC8 0, 0
        DC8 "CAN0_Error"
        DC8 0, 0, 0, 0
        DC8 43H, 41H, 4EH, 30H, 5FH, 54H, 78H, 5FH
        DC8 57H, 61H, 72H, 6EH, 69H, 6EH, 67H
        DC8 43H, 41H, 4EH, 30H, 5FH, 52H, 78H, 5FH
        DC8 57H, 61H, 72H, 6EH, 69H, 6EH, 67H
        DC8 "CAN0_Wake_Up"
        DC8 0, 0
        DC8 "Reserved51"
        DC8 0, 0, 0, 0
        DC8 "Reserved52"
        DC8 0, 0, 0, 0
        DC8 "CAN1_OR_MB_buf"
        DC8 "CAN1_Bus_Off"
        DC8 0, 0
        DC8 "CAN1_Error"
        DC8 0, 0, 0, 0
        DC8 43H, 41H, 4EH, 31H, 5FH, 54H, 78H, 5FH
        DC8 57H, 61H, 72H, 6EH, 69H, 6EH, 67H
        DC8 43H, 41H, 4EH, 31H, 5FH, 52H, 78H, 5FH
        DC8 57H, 61H, 72H, 6EH, 69H, 6EH, 67H
        DC8 "CAN1_Wake_Up"
        DC8 0, 0
        DC8 "Reserved59"
        DC8 0, 0, 0, 0
        DC8 "Reserved60"
        DC8 0, 0, 0, 0
        DC8 "UART0_RX_TX"
        DC8 0, 0, 0
        DC8 "UART0_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "UART1_RX_TX"
        DC8 0, 0, 0
        DC8 "UART1_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "UART2_RX_TX"
        DC8 0, 0, 0
        DC8 "UART2_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "UART3_RX_TX"
        DC8 0, 0, 0
        DC8 "UART3_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "UART4_RX_TX"
        DC8 0, 0, 0
        DC8 "UART4_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "UART5_RX_TX"
        DC8 0, 0, 0
        DC8 "UART5_ERR"
        DC8 0, 0, 0, 0, 0
        DC8 "ADC0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "ADC1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "CMP0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "CMP1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "CMP2"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "FTM0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "FTM1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "FTM2"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "CMT"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "RTC"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "Reserved83"
        DC8 0, 0, 0, 0
        DC8 "PIT0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PIT1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PIT2"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PIT3"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PDB0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "USB0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "USBDCD"
        DC8 0, 0, 0, 0, 0, 0, 0, 0
        DC8 45H, 4EH, 45H, 54H, 5FH, 31H, 35H, 38H
        DC8 38H, 5FH, 54H, 69H, 6DH, 65H, 72H
        DC8 "ENET_Transmit"
        DC8 0
        DC8 "ENET_Receive"
        DC8 0, 0
        DC8 "ENET_Error"
        DC8 0, 0, 0, 0
        DC8 "I2S0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "SDHC"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DAC0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "DAC1"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "TSI0"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "MCG"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "LPTimer"
        DC8 0, 0, 0, 0, 0, 0, 0
        DC8 "Reserved102"
        DC8 0, 0, 0
        DC8 "PORTA"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PORTB"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PORTC"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PORTD"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "PORTE"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "Reserved108"
        DC8 0, 0, 0
        DC8 "Reserved109"
        DC8 0, 0, 0
        DC8 "Reserved110"
        DC8 0, 0, 0
        DC8 "Reserved111"
        DC8 0, 0, 0
        DC8 "Reserved112"
        DC8 0, 0, 0
        DC8 "Reserved113"
        DC8 0, 0, 0
        DC8 "Reserved114"
        DC8 0, 0, 0
        DC8 "Reserved115"
        DC8 0, 0, 0
        DC8 "Reserved116"
        DC8 0, 0, 0
        DC8 "Reserved117"
        DC8 0, 0, 0
        DC8 "Reserved118"
        DC8 0, 0, 0
        DC8 "Reserved119"
        DC8 0, 0, 0

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  154 {
//  155     /******  Cortex-M4 Processor Exceptions Numbers ****************************************************************/
//  156     "",                         //0
//  157     "",
//  158     "NonMaskable"               , /*!< 2 Non Maskable Interrupt                              */
//  159     "HardFault"                 , /*!< 3 Hard Fault                                          */
//  160     "MemManagement"             , /*!< 4 Cortex-M4 Memory Management Interrupt               */
//  161     "BusFault"                  , /*!< 5 Cortex-M4 Bus Fault Interrupt                       */
//  162     "UsageFault"                , /*!< 6 Cortex-M4 Usage Fault Interrupt                     */
//  163     "",                         //7
//  164     "",
//  165     "",                         //9
//  166     "",
//  167     "SVCall"                    , /*!< 11 Cortex-M4 SV Call Interrupt                        */
//  168     "DebugMonitor"              , /*!< 12 Cortex-M4 Debug Monitor Interrupt                  */
//  169     "",
//  170     "PendSV"                    , /*!< 14 Cortex-M4 Pend SV Interrupt                        */
//  171     "SysTick"                   , /*!< 15 Cortex-M4 System Tick Interrupt                    */
//  172     /******  Kinetis 60 specific Interrupt Numbers **********************************************************************/
//  173     "DMA0"                      , // DMA Channel 0 Transfer Complete
//  174     "DMA1"                      , // DMA Channel 1 Transfer Complete
//  175     "DMA2"                      , // DMA Channel 2 Transfer Complete
//  176     "DMA3"                      , // DMA Channel 3 Transfer Complete
//  177     "DMA4"                      , // DMA Channel 4 Transfer Complete
//  178     "DMA5"                      , // DMA Channel 5 Transfer Complete
//  179     "DMA6"                      , // DMA Channel 6 Transfer Complete
//  180     "DMA7"                      , // DMA Channel 7 Transfer Complete
//  181     "DMA8"                      , // DMA Channel 8 Transfer Complete
//  182     "DMA9"                      , // DMA Channel 9 Transfer Complete
//  183     "DMA10"                     , // DMA Channel 10 Transfer Complete
//  184     "DMA11"                     , // DMA Channel 11 Transfer Complete
//  185     "DMA12"                     , // DMA Channel 12 Transfer Complete
//  186     "DMA13"                     , // DMA Channel 13 Transfer Complete
//  187     "DMA14"                     , // DMA Channel 14 Transfer Complete
//  188     "DMA15"                     , // DMA Channel 15 Transfer Complete
//  189     "DMA_Error"                 , // DMA Error Interrupt
//  190     "MCM"                       , // Normal Interrupt
//  191     "FTFL"                      , // FTFL Interrupt
//  192     "Read_Collision"            , // Read Collision Interrupt
//  193     "LVD_LVW"                   , // Low Voltage Detect, Low Voltage Warning
//  194     "LLW"                       , // Low Leakage Wakeup
//  195     "Watchdog"                  , // WDOG Interrupt
//  196     "RNG"                       , // RNGB Interrupt
//  197     "I2C0"                      , // I2C0 interrupt
//  198     "I2C1"                      , // I2C1 interrupt
//  199     "SPI0"                      , // SPI0 Interrupt
//  200     "SPI1"                      , // SPI1 Interrupt
//  201     "SPI2"                      , // SPI2 Interrupt
//  202     "CAN0_OR_MB_buf"            , // CAN0 OR'd Message Buffers Interrupt
//  203     "CAN0_Bus_Off"              , // CAN0 Bus Off Interrupt
//  204     "CAN0_Error"                , // CAN0 Error Interrupt
//  205     "CAN0_Tx_Warning"           , // CAN0 Tx Warning Interrupt
//  206     "CAN0_Rx_Warning"           , // CAN0 Rx Warning Interrupt
//  207     "CAN0_Wake_Up"              , // CAN0 Wake Up Interrupt
//  208     "Reserved51"                , // ���� interrupt 51
//  209     "Reserved52"                , // ���� interrupt 52
//  210     "CAN1_OR_MB_buf"            , // CAN1 OR'd Message Buffers Interrupt
//  211     "CAN1_Bus_Off"              , // CAN1 Bus Off Interrupt
//  212     "CAN1_Error"                , // CAN1 Error Interrupt
//  213     "CAN1_Tx_Warning"           , // CAN1 Tx Warning Interrupt
//  214     "CAN1_Rx_Warning"           , // CAN1 Rx Warning Interrupt
//  215     "CAN1_Wake_Up"              , // CAN1 Wake Up Interrupt
//  216     "Reserved59"                , // ���� interrupt 59
//  217     "Reserved60"                , // ���� interrupt 60
//  218     "UART0_RX_TX"               , // UART0 Receive/Transmit interrupt
//  219     "UART0_ERR"                 , // UART0 Error interrupt
//  220     "UART1_RX_TX"               , // UART1 Receive/Transmit interrupt
//  221     "UART1_ERR"                 , // UART1 Error interrupt
//  222     "UART2_RX_TX"               , // UART2 Receive/Transmit interrupt
//  223     "UART2_ERR"                 , // UART2 Error interrupt
//  224     "UART3_RX_TX"               , // UART3 Receive/Transmit interrupt
//  225     "UART3_ERR"                 , // UART3 Error interrupt
//  226     "UART4_RX_TX"               , // UART4 Receive/Transmit interrupt
//  227     "UART4_ERR"                 , // UART4 Error interrupt
//  228     "UART5_RX_TX"               , // UART5 Receive/Transmit interrupt
//  229     "UART5_ERR"                 , // UART5 Error interrupt
//  230     "ADC0"                      , // ADC0 interrupt
//  231     "ADC1"                      , // ADC1 interrupt
//  232     "CMP0"                      , // CMP0 interrupt
//  233     "CMP1"                      , // CMP1 interrupt
//  234     "CMP2"                      , // CMP2 interrupt
//  235     "FTM0"                      , // FTM0 fault, overflow and channels interrupt
//  236     "FTM1"                      , // FTM1 fault, overflow and channels interrupt
//  237     "FTM2"                      , // FTM2 fault, overflow and channels interrupt
//  238     "CMT"                       , // CMT interrupt
//  239     "RTC"                       , // RTC interrupt
//  240     "Reserved83"                , // ���� interrupt 83
//  241     "PIT0"                      , // PIT timer channel 0 interrupt
//  242     "PIT1"                      , // PIT timer channel 1 interrupt
//  243     "PIT2"                      , // PIT timer channel 2 interrupt
//  244     "PIT3"                      , // PIT timer channel 3 interrupt
//  245     "PDB0"                      , // PDB0 Interrupt
//  246     "USB0"                      , // USB0 interrupt
//  247     "USBDCD"                    , // USBDCD Interrupt
//  248     "ENET_1588_Timer"           , // Ethernet MAC IEEE 1588 Timer Interrupt
//  249     "ENET_Transmit"             , // Ethernet MAC Transmit Interrupt
//  250     "ENET_Receive"              , // Ethernet MAC Receive Interrupt
//  251     "ENET_Error"                , // Ethernet MAC Error and miscelaneous Interrupt
//  252     "I2S0"                      , // I2S0 Interrupt
//  253     "SDHC"                      , // SDHC Interrupt
//  254     "DAC0"                      , // DAC0 interrupt
//  255     "DAC1"                      , // DAC1 interrupt
//  256     "TSI0"                      , // TSI0 Interrupt
//  257     "MCG"                       , // MCG Interrupt
//  258     "LPTimer"                   , // LPTimer interrupt
//  259     "Reserved102"               , // ���� interrupt 102
//  260     "PORTA"                     , // Port A interrupt
//  261     "PORTB"                     , // Port B interrupt
//  262     "PORTC"                     , // Port C interrupt
//  263     "PORTD"                     , // Port D interrupt
//  264     "PORTE"                     , // Port E interrupt
//  265     "Reserved108"               , // ���� interrupt 108
//  266     "Reserved109"               , // ���� interrupt 109
//  267     "Reserved110"               , // ���� interrupt 110
//  268     "Reserved111"               , // ���� interrupt 111
//  269     "Reserved112"               , // ���� interrupt 112
//  270     "Reserved113"               , // ���� interrupt 113
//  271     "Reserved114"               , // ���� interrupt 114
//  272     "Reserved115"               , // ���� interrupt 115
//  273     "Reserved116"               , // ���� interrupt 116
//  274     "Reserved117"               , // ���� interrupt 117
//  275     "Reserved118"               , // ���� interrupt 118
//  276     "Reserved119"               , // ���� interrupt 119
//  277 };
//  278 #endif
// 
// 1 800 bytes in section .data
//   148 bytes in section .rodata
//   318 bytes in section .text
// 
//   318 bytes of CODE  memory
//   148 bytes of CONST memory
// 1 800 bytes of DATA  memory
//
//Errors: none
//Warnings: none
