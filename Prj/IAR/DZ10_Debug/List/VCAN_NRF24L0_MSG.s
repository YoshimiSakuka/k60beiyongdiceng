///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:36
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0_MSG.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0_MSG.c
//        -D DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_NRF24L0_MSG.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN last_tab
        EXTERN nrf_rx
        EXTERN nrf_rx_fifo_check
        EXTERN nrf_tx
        EXTERN save_var
        EXTERN var_display

        PUBLIC nrf_com_size
        PUBLIC nrf_com_totalsize
        PUBLIC nrf_msg_init
        PUBLIC nrf_msg_rx
        PUBLIC nrf_msg_tx
        PUBLIC rxbuflen

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0_MSG.c
//    1 #include "common.h"
//    2 #include "MK60_gpio.h"
//    3 #include "MK60_port.h"
//    4 #include "MK60_spi.h"
//    5 #include "VCAN_camera.h"
//    6 #include "VCAN_NRF24L0.h"
//    7 #include "VCAN_NRF24L0_MSG.h"
//    8 #include "VCAN_TSL1401.h"
//    9 
//   10 /**************************** ���������뷢�� **********************************/
//   11 
//   12 
//   13 
//   14 
//   15 /**************************** ���������뷢�� **********************************/
//   16 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   17 uint32 rxbuflen = 0;           //���ڽ��շ����ؽ��յ��������ݡ���������һ�δ��ݽ�ȥ���Ǹ�����С��
rxbuflen:
        DS8 4

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 44H, 3AH, 5CH, 53H, 74H, 75H, 64H, 79H
        DC8 5CH, 32H, 30H, 31H, 36H, 0B5H, 0E7H, 0D7H
        DC8 0D3H, 0C9H, 0E8H, 0BCH, 0C6H, 0B4H, 0F3H, 0C8H
        DC8 0FCH, 5CH, 54H, 69H, 5CH, 0B5H, 0E7H, 0C8H
        DC8 0FCH, 0B1H, 0B8H, 0D3H, 0C3H, 0B5H, 0D7H, 0B2H
        DC8 0E3H, 5CH, 42H, 6FH, 61H, 72H, 64H, 5CH
        DC8 73H, 72H, 63H, 5CH, 56H, 43H, 41H, 4EH
        DC8 5FH, 4EH, 52H, 46H, 32H, 34H, 4CH, 30H
        DC8 5FH, 4DH, 53H, 47H, 2EH, 63H, 0
        DC8 0
//   18 
//   19 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   20 const uint32 nrf_com_size[COM_MAX] = {CAMERA_SIZE , TSL1401_MAX *TSL1401_SIZE , 8, 0};
nrf_com_size:
        DATA
        DC32 600, 384, 8, 0
//   21 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 uint32 nrf_com_totalsize[COM_MAX];                                                                  // ��ռ�� �� �� �� ռ�ÿռ�
nrf_com_totalsize:
        DS8 16
//   23 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   24 void nrf_msg_init()
//   25 {
//   26     uint32 i = COM_MAX;
nrf_msg_init:
        MOVS     R0,#+4
//   27 
//   28     while(i--)
??nrf_msg_init_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BEQ.N    ??nrf_msg_init_1
//   29     {
//   30         nrf_com_totalsize[i] = (( nrf_com_size[i] + 2 * COM_LEN + DATA_PACKET - 1 ) / DATA_PACKET)  //��ð�����Ŀ
//   31                                *DATA_PACKET;                                                      //�ܹ�ռ�õĿռ�
        LDR.N    R1,??DataTable2
        LDR      R1,[R1, R0, LSL #+2]
        ADDS     R1,R1,#+35
        LSRS     R1,R1,#+5
        LSLS     R1,R1,#+5
        LDR.N    R2,??DataTable2_1
        STR      R1,[R2, R0, LSL #+2]
        B.N      ??nrf_msg_init_0
//   32     }
//   33 
//   34 }
??nrf_msg_init_1:
        BX       LR               ;; return
//   35 
//   36 
//   37 //�������ǰ�����ֽ���������ʶ�𣬺��������Ҫ���������

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   38 nrf_result_e nrf_msg_tx(com_e  com, uint8 *sendbuf)
//   39 {
nrf_msg_tx:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   40     ASSERT(com < COM_MAX);          //����ܳ���������Ŀ
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BLT.N    ??nrf_msg_tx_0
        MOVS     R1,#+40
        LDR.N    R0,??DataTable2_2
        BL       assert_failed
//   41 
//   42     //������д�����ݻ�����
//   43     sendbuf[0] =  com;
??nrf_msg_tx_0:
        STRB     R4,[R5, #+0]
//   44     sendbuf[1] = ~com;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MVNS     R0,R4
        STRB     R0,[R5, #+1]
//   45     sendbuf[nrf_com_size[com] + 2 * COM_LEN - 2] = ~com;
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        ADDS     R0,R0,R5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MVNS     R1,R4
        STRB     R1,[R0, #+2]
//   46     sendbuf[nrf_com_size[com] + 2 * COM_LEN - 1] = com;
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        ADDS     R0,R0,R5
        STRB     R4,[R0, #+3]
//   47 
//   48     while( !nrf_tx(sendbuf , nrf_com_size[com] + 2 * COM_LEN)); //��������
??nrf_msg_tx_1:
        LDR.N    R0,??DataTable2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        ADDS     R1,R0,#+4
        MOVS     R0,R5
        BL       nrf_tx
        CMP      R0,#+0
        BEQ.N    ??nrf_msg_tx_1
//   49 
//   50     return NRF_RESULT_NULL;
        MOVS     R0,#+3
        POP      {R1,R4,R5,PC}    ;; return
//   51 }
//   52 
//   53 //��ѯ�Ƿ��н������ݣ������д���rebuf Ϊ�ɹ�ʹ�õĻ�����
//   54 //

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   55 nrf_result_e nrf_msg_rx(com_e  *com, uint8 *rebuf)
//   56 {
nrf_msg_rx:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   57     com_e   comtmp;
//   58     uint32  len;
//   59     uint32  tmplen;
//   60     uint32  relen;                              //���յ������ݳ���
//   61     uint8   *buftemp;
//   62 
//   63     uint32  totallen ;                          //����Ҫ���հ�����Ŀ(����������)
//   64     uint16  tmpcheck;
//   65 
//   66 RE_LOOP:
//   67     buftemp = rebuf;                            //������ʼ��ַ
??nrf_msg_rx_0:
        MOV      R10,R5
//   68 
//   69     relen = nrf_rx(buftemp, DATA_PACKET);       //���� ��һ����
        MOVS     R1,#+32
        MOV      R0,R10
        BL       nrf_rx
        MOV      R9,R0
//   70     if(relen == 0)
        CMP      R9,#+0
        BNE.N    ??nrf_msg_rx_1
//   71     {
//   72         //����� ԤУ�� ʧ�ܣ���ô �϶����Խ��յ����ݣ��������˴�
//   73 
//   74         //ֻ�� һ��ʼ ���뺯�� ��һ�ν��յ�ʱ�򣬲ų��ֽ���ʧ��
//   75 
//   76         return NRF_RESULT_RX_NO;                //û���յ�����
        MOVS     R0,#+4
        B.N      ??nrf_msg_rx_2
//   77     }
//   78 
//   79     comtmp = (com_e)buftemp[0];
??nrf_msg_rx_1:
        LDRB     R0,[R10, #+0]
        MOVS     R6,R0
//   80     if(((uint8)comtmp < (uint8)COM_MAX) && (buftemp[1] ==  (uint8)~comtmp) && (comtmp != COM_RETRAN) )
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BGE.N    ??nrf_msg_rx_3
        LDRB     R0,[R10, #+1]
        MVNS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BNE.N    ??nrf_msg_rx_3
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BEQ.N    ??nrf_msg_rx_3
//   81     {
//   82         //У����ȷ,��������ʣ�� ������
//   83 
//   84         totallen = nrf_com_totalsize[comtmp];   //�ܽ��ղ���
        LDR.N    R0,??DataTable2_1
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        MOV      R11,R0
//   85 
//   86         if(totallen > relen )                   //���ݳ��� ���� �ѽ��ճ���
        CMP      R9,R11
        BCS.N    ??nrf_msg_rx_4
//   87         {
//   88             //��Ҫ��������
//   89             len = totallen - relen;             //ʣ����յ� ����
        SUBS     R0,R11,R9
        MOVS     R7,R0
//   90 
//   91             //�ȴ�����FIFO�������У����ȷ�Ž���
//   92             while( !nrf_rx_fifo_check(nrf_com_size[comtmp] + 2 * COM_LEN - relen,&tmpcheck)  );   //�ȴ�����
??nrf_msg_rx_5:
        ADD      R1,SP,#+0
        LDR.N    R0,??DataTable2
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        ADDS     R0,R0,#+4
        SUBS     R0,R0,R9
        BL       nrf_rx_fifo_check
        CMP      R0,#+0
        BEQ.N    ??nrf_msg_rx_5
//   93             if( tmpcheck !=  (uint16)((uint8)~comtmp + (comtmp<<8)))
        LDRH     R0,[SP, #+0]
        MVNS     R1,R6
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LSLS     R2,R6,#+8
        UXTAB    R1,R2,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R0,R1
        BNE.N    ??nrf_msg_rx_0
//   94             {
//   95                 goto RE_LOOP;                   //У��ʧ�� �������ղŽ��յ� ��һ�� �� �����½������ݣ�
//   96             }
//   97 
//   98             tmplen = relen;
??nrf_msg_rx_6:
        MOV      R8,R9
//   99             do
//  100             {
//  101                 buftemp += tmplen;              //�ƶ�����δ�������ݵĻ�����
??nrf_msg_rx_7:
        ADDS     R10,R8,R10
//  102                 tmplen = nrf_rx(buftemp, len);  //��������
        MOVS     R1,R7
        MOV      R0,R10
        BL       nrf_rx
        MOV      R8,R0
//  103                 //relen += tmplen;
//  104                 len -= tmplen;
        SUBS     R7,R7,R8
//  105             }
//  106             while(len);
        CMP      R7,#+0
        BNE.N    ??nrf_msg_rx_7
//  107         }
//  108 
//  109         //У��β�������Ƿ���ȷ
//  110         if(
//  111             (rebuf[nrf_com_size[comtmp] + 2 * COM_LEN - 2] ==   (uint8)~comtmp)
//  112             &&  (rebuf[nrf_com_size[comtmp] + 2 * COM_LEN - 1] ==   (uint8) comtmp)   )
??nrf_msg_rx_4:
        LDR.N    R0,??DataTable2
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        ADDS     R0,R0,R5
        LDRB     R0,[R0, #+2]
        MVNS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R0,R1
        BNE.N    ??nrf_msg_rx_3
        LDR.N    R0,??DataTable2
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        ADDS     R0,R0,R5
        LDRB     R0,[R0, #+3]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R0,R6
        BNE.N    ??nrf_msg_rx_3
//  113         {
//  114             *com = comtmp;                          //�洢����
        STRB     R6,[R4, #+0]
//  115 
//  116             //�� ���� ���ݽ��� ����
//  117             switch(*com)
        LDRB     R0,[R4, #+0]
        CMP      R0,#+2
        BNE.N    ??nrf_msg_rx_8
//  118             {
//  119             case COM_VAR:
//  120                 last_tab = *((uint32 *)&rebuf[COM_LEN]);                                    //��ȡ�������
        LDR      R0,[R5, #+2]
        LDR.N    R1,??DataTable2_3
        STR      R0,[R1, #+0]
//  121                 if(last_tab < VAR_MAX)
        LDR.N    R0,??DataTable2_3
        LDR      R0,[R0, #+0]
        CMP      R0,#+7
        BCS.N    ??nrf_msg_rx_9
//  122                 {
//  123                     save_var((var_tab_e)last_tab, *((uint32 *)&rebuf[COM_LEN + sizeof(uint32)]));          //�洢 ����
        LDR      R1,[R5, #+6]
        LDR.N    R0,??DataTable2_3
        LDR      R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       save_var
//  124                     var_display(last_tab);                                                  //��ʾ ����
        LDR.N    R0,??DataTable2_3
        LDR      R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       var_display
//  125                 }
//  126                 else
//  127                 {
//  128                     return NRF_RESULT_RX_NOVALID;
//  129                 }
//  130                 break;
        B.N      ??nrf_msg_rx_10
??nrf_msg_rx_9:
        MOVS     R0,#+6
        B.N      ??nrf_msg_rx_2
//  131             default:
//  132                 break;
//  133             }
//  134 
//  135             return NRF_RESULT_RX_VALID;             //������Ч����
??nrf_msg_rx_8:
??nrf_msg_rx_10:
        MOVS     R0,#+5
        B.N      ??nrf_msg_rx_2
//  136         }
//  137     }
//  138 
//  139     //�н��յ����ݣ�������������Ч
//  140     return NRF_RESULT_RX_NOVALID;
??nrf_msg_rx_3:
        MOVS     R0,#+6
??nrf_msg_rx_2:
        POP      {R1,R4-R11,PC}   ;; return
//  141 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     nrf_com_size

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     nrf_com_totalsize

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     last_tab

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  142 
//  143 
//  144 
// 
//  20 bytes in section .bss
//  88 bytes in section .rodata
// 378 bytes in section .text
// 
// 378 bytes of CODE  memory
//  88 bytes of CONST memory
//  20 bytes of DATA  memory
//
//Errors: none
//Warnings: none
