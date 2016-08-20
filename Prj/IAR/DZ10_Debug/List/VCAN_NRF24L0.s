///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:36
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_NRF24L0.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init
        EXTERN port_init_NoALT
        EXTERN spi_init
        EXTERN spi_mosi
        EXTERN spi_mosi_cmd
        EXTERN vcan_cpy

        PUBLIC NRF24L01_RXDATA
        PUBLIC NRF24L01_TXDATA
        PUBLIC NRF_ISR_RX_FIFO
        PUBLIC NRF_Send_Data
        PUBLIC RX_ADDRESS
        PUBLIC TX_ADDRESS
        PUBLIC nrf_handler
        PUBLIC nrf_init
        PUBLIC nrf_irq_tx_addr
        PUBLIC nrf_irq_tx_flag
        PUBLIC nrf_irq_tx_pnum
        PUBLIC nrf_link_check
        PUBLIC nrf_mode
        PUBLIC nrf_rx
        PUBLIC nrf_rx_fifo_check
        PUBLIC nrf_rx_flag
        PUBLIC nrf_rx_front
        PUBLIC nrf_rx_rear
        PUBLIC nrf_tx
        PUBLIC nrf_tx_state

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_NRF24L0.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       VCAN_NRF24L0.c
//   11  * @brief      NRF24L0��������ʵ��
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.0
//   14  * @date       2013-07-9
//   15  */
//   16 
//   17 
//   18 #include "common.h"
//   19 #include "MK60_port.h"
//   20 #include "MK60_gpio.h"
//   21 #include "MK60_spi.h"
//   22 
//   23 #include "VCAN_NRF24L0.h"
//   24 
//   25 //NRF24L01+״̬
//   26 typedef enum
//   27 {
//   28     NOT_INIT = 0,
//   29     TX_MODE,
//   30     RX_MODE,
//   31 } nrf_mode_e;
//   32 
//   33 typedef enum
//   34 {
//   35     QUEUE_EMPTY = 0,        //���п�ģʽ��ֻ�������
//   36     QUEUE_NORMAL,           //����ģʽ��������������У������в��ղ���
//   37     QUEUE_FULL,             //������ģʽ������������ӣ�����������
//   38 } nrf_rx_queueflag_e; //�жϽ���ʱ������״̬���λ
//   39 
//   40 
//   41 //gpio����CE��IRQ
//   42 #define NRF_CE_HIGH()       GPIO_SET(NRF_CE_PTXn,1)
//   43 #define NRF_CE_LOW()        GPIO_SET(NRF_CE_PTXn,0)           //CE�õ�
//   44 #define NRF_Read_IRQ()      GPIO_SET(NRF_IRQ_PTXn)
//   45 
//   46 
//   47 // �û����� ���ͺ� ���յ�ַ��Ƶ��
//   48 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   49 uint8 TX_ADDRESS[5] = {0x62, 0xA7, 0x31, 0xDB, 0x11};   // ����һ����̬���͵�ַ
TX_ADDRESS:
        DATA
        DC8 98, 167, 49, 219, 17, 0, 0, 0

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   50 uint8 RX_ADDRESS[5] = {0x62, 0xA7, 0x31, 0xDB, 0x11};
RX_ADDRESS:
        DATA
        DC8 98, 167, 49, 219, 17, 0, 0, 0
//   51 
//   52 #define CHANAL          25                              // Ƶ��ѡ�� λ�� 0~255
//   53 
//   54 
//   55 // �ڲ����ò���
//   56 #define TX_ADR_WIDTH    ADR_WIDTH                       // �����ַ���
//   57 #define TX_PLOAD_WIDTH  DATA_PACKET                     // ��������ͨ����Ч���ݿ��0~32Byte
//   58 
//   59 #define RX_ADR_WIDTH    ADR_WIDTH                       // ���յ�ַ���
//   60 #define RX_PLOAD_WIDTH  DATA_PACKET                     // ��������ͨ����Ч���ݿ��0~32Byte
//   61 
//   62 /******************************** NRF24L01+ �Ĵ������� �궨��***************************************/
//   63 
//   64 // SPI(nRF24L01) commands , NRF��SPI����궨�壬���NRF����ʹ���ĵ�
//   65 #define NRF_READ_REG    0x00    // Define read command to register
//   66 #define NRF_WRITE_REG   0x20    // Define write command to register
//   67 #define RD_RX_PLOAD     0x61    // Define RX payload register address
//   68 #define WR_TX_PLOAD     0xA0    // Define TX payload register address
//   69 #define FLUSH_TX        0xE1    // Define flush TX register command
//   70 #define FLUSH_RX        0xE2    // Define flush RX register command
//   71 #define REUSE_TX_PL     0xE3    // Define reuse TX payload register command
//   72 #define NOP             0xFF    // Define No Operation, might be used to read status register
//   73 
//   74 // SPI(nRF24L01) registers(addresses) ��NRF24L01 ��ؼĴ�����ַ�ĺ궨��
//   75 #define CONFIG      0x00        // 'Config' register address
//   76 #define EN_AA       0x01        // 'Enable Auto Acknowledgment' register address
//   77 #define EN_RXADDR   0x02        // 'Enabled RX addresses' register address
//   78 #define SETUP_AW    0x03        // 'Setup address width' register address
//   79 #define SETUP_RETR  0x04        // 'Setup Auto. Retrans' register address
//   80 #define RF_CH       0x05        // 'RF channel' register address
//   81 #define RF_SETUP    0x06        // 'RF setup' register address
//   82 #define STATUS      0x07        // 'Status' register address
//   83 #define OBSERVE_TX  0x08        // 'Observe TX' register address
//   84 #define CD          0x09        // 'Carrier Detect' register address
//   85 #define RX_ADDR_P0  0x0A        // 'RX address pipe0' register address
//   86 #define RX_ADDR_P1  0x0B        // 'RX address pipe1' register address
//   87 #define RX_ADDR_P2  0x0C        // 'RX address pipe2' register address
//   88 #define RX_ADDR_P3  0x0D        // 'RX address pipe3' register address
//   89 #define RX_ADDR_P4  0x0E        // 'RX address pipe4' register address
//   90 #define RX_ADDR_P5  0x0F        // 'RX address pipe5' register address
//   91 #define TX_ADDR     0x10        // 'TX address' register address
//   92 #define RX_PW_P0    0x11        // 'RX payload width, pipe0' register address
//   93 #define RX_PW_P1    0x12        // 'RX payload width, pipe1' register address
//   94 #define RX_PW_P2    0x13        // 'RX payload width, pipe2' register address
//   95 #define RX_PW_P3    0x14        // 'RX payload width, pipe3' register address
//   96 #define RX_PW_P4    0x15        // 'RX payload width, pipe4' register address
//   97 #define RX_PW_P5    0x16        // 'RX payload width, pipe5' register address
//   98 #define FIFO_STATUS 0x17        // 'FIFO Status Register' register address
//   99 
//  100 
//  101 //������Ҫ��״̬���
//  102 #define TX_FULL     0x01        //TX FIFO �Ĵ�������־�� 1 Ϊ ����0Ϊ ����
//  103 #define MAX_RT      0x10        //�ﵽ����ط������жϱ�־λ
//  104 #define TX_DS       0x20        //��������жϱ�־λ
//  105 #define RX_DR       0x40        //���յ������жϱ�־λ
//  106 
//  107 
//  108 
//  109 //�ڲ��Ĵ���������������
//  110 static  uint8   nrf_writereg(uint8 reg, uint8 dat);
//  111 static  uint8   nrf_readreg (uint8 reg, uint8 *dat);
//  112 
//  113 static  uint8   nrf_writebuf(uint8 reg , uint8 *pBuf, uint32 len);
//  114 static  uint8   nrf_readbuf (uint8 reg, uint8 *pBuf, uint32  len);
//  115 
//  116 
//  117 static  void    nrf_rx_mode(void);           //�������ģʽ
//  118 static  void    nrf_tx_mode(void);           //���뷢��ģʽ
//  119 
//  120 /*!
//  121  *  @brief      NRF24L01+ ģʽ���
//  122  */

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  123 volatile uint8  nrf_mode = NOT_INIT;
nrf_mode:
        DS8 1
//  124 
//  125 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  126 volatile uint8  nrf_rx_front = 0, nrf_rx_rear = 0;              //����FIFO��ָ��
nrf_rx_front:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
nrf_rx_rear:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  127 volatile uint8  nrf_rx_flag = QUEUE_EMPTY;
nrf_rx_flag:
        DS8 1
//  128 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  129 uint8 NRF_ISR_RX_FIFO[RX_FIFO_PACKET_NUM][DATA_PACKET];         //�жϽ��յ�FIFO
NRF_ISR_RX_FIFO:
        DS8 2560
//  130 
//  131 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  132 volatile uint8    *nrf_irq_tx_addr      = NULL;
nrf_irq_tx_addr:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  133 volatile uint32    nrf_irq_tx_pnum      = 0;                    //pnum = (len+MAX_ONCE_TX_NUM -1)  / MAX_ONCE_TX_NUM
nrf_irq_tx_pnum:
        DS8 4
//  134 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  135 volatile uint8      nrf_irq_tx_flag  = 0;                     //0 ��ʾ�ɹ� ��1 ��ʾ ����ʧ��
nrf_irq_tx_flag:
        DS8 1
//  136 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  137 uint8 NRF24L01_RXDATA[DATA_PACKET];//nrf24l01���յ�������
NRF24L01_RXDATA:
        DS8 32

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  138 uint8 NRF24L01_TXDATA[DATA_PACKET];//nrf24l01��Ҫ���͵�����
NRF24L01_TXDATA:
        DS8 32
//  139 
//  140 /*!
//  141  *  @brief      NRF24L01+��ʼ����Ĭ�Ͻ������ģʽ
//  142  *  @return     ��ʼ���ɹ���ǣ�0Ϊ��ʼ��ʧ�ܣ�1Ϊ��ʼ���ɹ�
//  143  *  @since      v5.0
//  144  *  Sample usage:
//  145                         while(!nrf_init())                                     //��ʼ��NRF24L01+ ,�ȴ���ʼ���ɹ�Ϊֹ
//  146                         {
//  147                             printf("\n  NRF��MCU����ʧ�ܣ������¼����ߡ�\n");
//  148                         }
//  149 
//  150                         printf("\n      NRF��MCU���ӳɹ���\n");
//  151  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  152 uint8 nrf_init(void)
//  153 {
nrf_init:
        PUSH     {R7,LR}
//  154     //����NRF�ܽŸ���
//  155     spi_init(NRF_SPI, NRF_CS, MASTER,10*1000*1000);                     //��ʼ��SPI,����ģʽ
        LDR.W    R3,??DataTable9  ;; 0x989680
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_init
//  156 
//  157     gpio_init(NRF_CE_PTXn, GPO, LOW);                               //��ʼ��CE��Ĭ�Ͻ������ģʽ
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+9
        BL       gpio_init
//  158 
//  159     gpio_init(NRF_IRQ_PTXn, GPI, LOW);                              //��ʼ��IRQ�ܽ�Ϊ����
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+155
        BL       gpio_init
//  160     port_init_NoALT(NRF_IRQ_PTXn, IRQ_FALLING | PULLUP);            //��ʼ��IRQ�ܽ�Ϊ�½��� �����ж�
        LDR.W    R1,??DataTable9_1  ;; 0xa0003
        MOVS     R0,#+155
        BL       port_init_NoALT
//  161 
//  162     //����NRF�Ĵ���
//  163     NRF_CE_LOW();
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  164 
//  165     nrf_writereg(NRF_WRITE_REG + SETUP_AW, ADR_WIDTH - 2);          //���õ�ַ����Ϊ TX_ADR_WIDTH
        MOVS     R1,#+3
        MOVS     R0,#+35
        BL       nrf_writereg
//  166 
//  167     nrf_writereg(NRF_WRITE_REG + RF_CH, CHANAL);                    //����RFͨ��ΪCHANAL
        MOVS     R1,#+25
        MOVS     R0,#+37
        BL       nrf_writereg
//  168     nrf_writereg(NRF_WRITE_REG + RF_SETUP, 0x0f);                   //����TX�������,0db����,2Mbps,���������濪��
        MOVS     R1,#+15
        MOVS     R0,#+38
        BL       nrf_writereg
//  169 
//  170     nrf_writereg(NRF_WRITE_REG + EN_AA, 0x01);                      //ʹ��ͨ��0���Զ�Ӧ��
        MOVS     R1,#+1
        MOVS     R0,#+33
        BL       nrf_writereg
//  171 
//  172     nrf_writereg(NRF_WRITE_REG + EN_RXADDR, 0x01);                  //ʹ��ͨ��0�Ľ��յ�ַ
        MOVS     R1,#+1
        MOVS     R0,#+34
        BL       nrf_writereg
//  173 
//  174     //RXģʽ����
//  175     nrf_writebuf(NRF_WRITE_REG + RX_ADDR_P0, RX_ADDRESS, RX_ADR_WIDTH); //дRX�ڵ��ַ
        MOVS     R2,#+5
        LDR.W    R1,??DataTable9_3
        MOVS     R0,#+42
        BL       nrf_writebuf
//  176 
//  177     nrf_writereg(NRF_WRITE_REG + RX_PW_P0, RX_PLOAD_WIDTH);         //ѡ��ͨ��0����Ч���ݿ��
        MOVS     R1,#+32
        MOVS     R0,#+49
        BL       nrf_writereg
//  178 
//  179     nrf_writereg(FLUSH_RX, NOP);                                    //���RX FIFO�Ĵ���
        MOVS     R1,#+255
        MOVS     R0,#+226
        BL       nrf_writereg
//  180 
//  181     //TXģʽ����
//  182     nrf_writebuf(NRF_WRITE_REG + TX_ADDR, TX_ADDRESS, TX_ADR_WIDTH); //дTX�ڵ��ַ
        MOVS     R2,#+5
        LDR.W    R1,??DataTable9_4
        MOVS     R0,#+48
        BL       nrf_writebuf
//  183 
//  184     nrf_writereg(NRF_WRITE_REG + SETUP_RETR, 0x0F);                 //�����Զ��ط����ʱ��:250us + 86us;����Զ��ط�����:15��
        MOVS     R1,#+15
        MOVS     R0,#+36
        BL       nrf_writereg
//  185 
//  186     nrf_writereg(FLUSH_TX, NOP);                                    //���TX FIFO�Ĵ���
        MOVS     R1,#+255
        MOVS     R0,#+225
        BL       nrf_writereg
//  187 
//  188     nrf_rx_mode();                                                  //Ĭ�Ͻ������ģʽ
        BL       nrf_rx_mode
//  189 
//  190     NRF_CE_HIGH();
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  191 
//  192     return nrf_link_check();
        BL       nrf_link_check
        POP      {R1,PC}          ;; return
//  193 
//  194 }
//  195 
//  196 /*!
//  197  *  @brief      NRF24L01+д�Ĵ���
//  198  *  @param      reg         �Ĵ���
//  199  *  @param      dat         ��Ҫд�������
//  200  *  @return     NRF24L01+ ״̬
//  201  *  @since      v5.0
//  202  *  Sample usage:    nrf_writereg(NRF_WRITE_REG + RF_CH, CHANAL);   //����RFͨ��ΪCHANAL
//  203  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  204 uint8 nrf_writereg(uint8 reg, uint8 dat)
//  205 {
nrf_writereg:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R1
//  206     uint8 buff[2];
//  207 
//  208     buff[0] = reg;          //�ȷ��ͼĴ���
        STRB     R4,[SP, #+4]
//  209     buff[1] = dat;          //�ٷ�������
        STRB     R5,[SP, #+5]
//  210 
//  211     spi_mosi(NRF_SPI, NRF_CS, buff, buff, 2); //����buff�����ݣ����ɼ��� buff��
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        ADD      R2,SP,#+4
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi
//  212 
//  213     /*����״̬�Ĵ�����ֵ*/
//  214     return buff[0];
        LDRB     R0,[SP, #+4]
        POP      {R1-R5,PC}       ;; return
//  215 }
//  216 
//  217 /*!
//  218  *  @brief      NRF24L01+���Ĵ���
//  219  *  @param      reg         �Ĵ���
//  220  *  @param      dat         ��Ҫ��ȡ�����ݵĴ�ŵ�ַ
//  221  *  @return     NRF24L01+ ״̬
//  222  *  @since      v5.0
//  223  *  Sample usage:
//  224                     uint8 data;
//  225                     nrf_readreg(STATUS,&data);
//  226  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  227 uint8 nrf_readreg(uint8 reg, uint8 *dat)
//  228 {
nrf_readreg:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R1
//  229 
//  230     uint8 buff[2];
//  231 
//  232     buff[0] = reg;          //�ȷ��ͼĴ���
        STRB     R4,[SP, #+4]
//  233 
//  234     spi_mosi(NRF_SPI, NRF_CS, buff, buff, 2); //����buff���ݣ������浽buff��
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        ADD      R2,SP,#+4
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi
//  235 
//  236     *dat = buff[1];                         //��ȡ�ڶ�������
        LDRB     R0,[SP, #+5]
        STRB     R0,[R5, #+0]
//  237 
//  238     /*����״̬�Ĵ�����ֵ*/
//  239     return buff[0];
        LDRB     R0,[SP, #+4]
        POP      {R1-R5,PC}       ;; return
//  240 }
//  241 
//  242 /*!
//  243  *  @brief      NRF24L01+д�Ĵ���һ������
//  244  *  @param      reg         �Ĵ���
//  245  *  @param      pBuf        ��Ҫд������ݻ�����
//  246  *  @param      len         ��Ҫд�����ݳ���
//  247  *  @return     NRF24L01+ ״̬
//  248  *  @since      v5.0
//  249  *  Sample usage:    nrf_writebuf(NRF_WRITE_REG+TX_ADDR,TX_ADDRESS,TX_ADR_WIDTH);    //дTX�ڵ��ַ
//  250  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  251 uint8 nrf_writebuf(uint8 reg , uint8 *pBuf, uint32 len)
//  252 {
nrf_writebuf:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R1
        MOVS     R5,R2
//  253     spi_mosi_cmd(NRF_SPI, NRF_CS, &reg , &reg, pBuf, NULL, 1 , len); //���� reg ��pBuf ���ݣ�������
        STR      R5,[SP, #+12]
        MOVS     R0,#+1
        STR      R0,[SP, #+8]
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
        STR      R4,[SP, #+0]
        ADD      R3,SP,#+16
        ADD      R2,SP,#+16
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi_cmd
//  254     return reg;    //����NRF24L01��״̬
        LDRB     R0,[SP, #+16]
        ADD      SP,SP,#+20
        POP      {R4,R5,PC}       ;; return
//  255 }
//  256 
//  257 
//  258 /*!
//  259  *  @brief      NRF24L01+���Ĵ���һ������
//  260  *  @param      reg         �Ĵ���
//  261  *  @param      dat         ��Ҫ��ȡ�����ݵĴ�ŵ�ַ
//  262  *  @param      len         ��Ҫ��ȡ�����ݳ���
//  263  *  @return     NRF24L01+ ״̬
//  264  *  @since      v5.0
//  265  *  Sample usage:
//  266                     uint8 data;
//  267                     nrf_readreg(STATUS,&data);
//  268  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  269 uint8 nrf_readbuf(uint8 reg, uint8 *pBuf, uint32 len)
//  270 {
nrf_readbuf:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R1
        MOVS     R5,R2
//  271     spi_mosi_cmd(NRF_SPI, NRF_CS, &reg , &reg, NULL, pBuf, 1 , len); //����reg�����յ�buff
        STR      R5,[SP, #+12]
        MOVS     R0,#+1
        STR      R0,[SP, #+8]
        STR      R4,[SP, #+4]
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+16
        ADD      R2,SP,#+16
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi_cmd
//  272 
//  273     return reg;    //����NRF24L01��״̬
        LDRB     R0,[SP, #+16]
        ADD      SP,SP,#+20
        POP      {R4,R5,PC}       ;; return
//  274 }
//  275 
//  276 /*!
//  277  *  @brief      ���NRF24L01+��MCU�Ƿ���������
//  278  *  @return     NRF24L01+ ��ͨ��״̬��0��ʾͨ�Ų�������1��ʾ����
//  279  *  @since      v5.0
//  280  *  Sample usage:
//  281                     while(nrf_link_check() == 0)
//  282                     {
//  283                         printf("\nͨ��ʧ��");
//  284                     }
//  285  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 uint8 nrf_link_check(void)
//  287 {
nrf_link_check:
        PUSH     {R4,LR}
        SUB      SP,SP,#+32
//  288 #define NRF_CHECH_DATA  0xC2        //��ֵΪУ������ʱʹ�ã����޸�Ϊ����ֵ
//  289 
//  290     uint8 reg;
//  291 
//  292     uint8 buff[5] = {NRF_CHECH_DATA, NRF_CHECH_DATA, NRF_CHECH_DATA, NRF_CHECH_DATA, NRF_CHECH_DATA};
        ADD      R0,SP,#+20
        LDR.W    R1,??DataTable9_5
        LDM      R1!,{R2,R3}
        STM      R0!,{R2,R3}
        SUBS     R1,R1,#+8
        SUBS     R0,R0,#+8
//  293     uint8 i;
//  294 
//  295 
//  296     reg = NRF_WRITE_REG + TX_ADDR;
        MOVS     R0,#+48
        STRB     R0,[SP, #+16]
//  297     spi_mosi_cmd(NRF_SPI, NRF_CS, &reg, NULL , buff, NULL, 1 , 5); //д��У������
        MOVS     R0,#+5
        STR      R0,[SP, #+12]
        MOVS     R0,#+1
        STR      R0,[SP, #+8]
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+20
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        ADD      R2,SP,#+16
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi_cmd
//  298 
//  299     reg = TX_ADDR;
        MOVS     R0,#+16
        STRB     R0,[SP, #+16]
//  300     spi_mosi_cmd(NRF_SPI, NRF_CS, &reg, NULL , NULL, buff, 1 , 5); //��ȡУ������
        MOVS     R0,#+5
        STR      R0,[SP, #+12]
        MOVS     R0,#+1
        STR      R0,[SP, #+8]
        ADD      R0,SP,#+20
        STR      R0,[SP, #+4]
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        ADD      R2,SP,#+16
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       spi_mosi_cmd
//  301 
//  302 
//  303     /*�Ƚ�*/
//  304     for(i = 0; i < 5; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??nrf_link_check_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BGE.N    ??nrf_link_check_1
//  305     {
//  306         if(buff[i] != NRF_CHECH_DATA)
        ADD      R0,SP,#+20
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+194
        BEQ.N    ??nrf_link_check_2
//  307         {
//  308             return 0 ;        //MCU��NRF����������
        MOVS     R0,#+0
        B.N      ??nrf_link_check_3
//  309         }
//  310     }
??nrf_link_check_2:
        ADDS     R4,R4,#+1
        B.N      ??nrf_link_check_0
//  311     return 1 ;             //MCU��NRF�ɹ�����
??nrf_link_check_1:
        MOVS     R0,#+1
??nrf_link_check_3:
        ADD      SP,SP,#+32
        POP      {R4,PC}          ;; return
//  312 }
//  313 
//  314 /*!
//  315 *  @brief      NRF24L01+�������ģʽ
//  316 *  @since      v5.0
//  317 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  318 void nrf_rx_mode(void)
//  319 {
nrf_rx_mode:
        PUSH     {R7,LR}
//  320     NRF_CE_LOW();
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  321 
//  322     nrf_writereg(NRF_WRITE_REG + EN_AA, 0x01);          //ʹ��ͨ��0���Զ�Ӧ��
        MOVS     R1,#+1
        MOVS     R0,#+33
        BL       nrf_writereg
//  323 
//  324     nrf_writereg(NRF_WRITE_REG + EN_RXADDR, 0x01);      //ʹ��ͨ��0�Ľ��յ�ַ
        MOVS     R1,#+1
        MOVS     R0,#+34
        BL       nrf_writereg
//  325 
//  326     nrf_writebuf(NRF_WRITE_REG + RX_ADDR_P0, RX_ADDRESS, RX_ADR_WIDTH); //дRX�ڵ��ַ
        MOVS     R2,#+5
        LDR.W    R1,??DataTable9_3
        MOVS     R0,#+42
        BL       nrf_writebuf
//  327 
//  328 
//  329     nrf_writereg(NRF_WRITE_REG + CONFIG, 0x0B | (IS_CRC16 << 2));       //���û�������ģʽ�Ĳ���;PWR_UP,EN_CRC,16BIT_CRC,����ģʽ
        MOVS     R1,#+15
        MOVS     R0,#+32
        BL       nrf_writereg
//  330 
//  331     /* ����жϱ�־*/
//  332     nrf_writereg(NRF_WRITE_REG + STATUS, 0xff);
        MOVS     R1,#+255
        MOVS     R0,#+39
        BL       nrf_writereg
//  333 
//  334     nrf_writereg(FLUSH_RX, NOP);                    //���RX FIFO�Ĵ���
        MOVS     R1,#+255
        MOVS     R0,#+226
        BL       nrf_writereg
//  335 
//  336     /*CE���ߣ��������ģʽ*/
//  337     NRF_CE_HIGH();
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  338 
//  339     nrf_mode = RX_MODE;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable9_6
        STRB     R0,[R1, #+0]
//  340 }
        POP      {R0,PC}          ;; return
//  341 
//  342 /*!
//  343 *  @brief      NRF24L01+���뷢��ģʽ
//  344 *  @since      v5.0
//  345 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  346 void nrf_tx_mode(void)
//  347 {
nrf_tx_mode:
        PUSH     {R7,LR}
//  348     volatile uint32 i;
//  349 
//  350     NRF_CE_LOW();
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  351     //DELAY_MS(1);
//  352 
//  353     nrf_writebuf(NRF_WRITE_REG + TX_ADDR, TX_ADDRESS, TX_ADR_WIDTH); //дTX�ڵ��ַ
        MOVS     R2,#+5
        LDR.W    R1,??DataTable9_4
        MOVS     R0,#+48
        BL       nrf_writebuf
//  354 
//  355     nrf_writebuf(NRF_WRITE_REG + RX_ADDR_P0, RX_ADDRESS, RX_ADR_WIDTH); //����RX�ڵ��ַ ,��ҪΪ��ʹ��ACK
        MOVS     R2,#+5
        LDR.W    R1,??DataTable9_3
        MOVS     R0,#+42
        BL       nrf_writebuf
//  356 
//  357     nrf_writereg(NRF_WRITE_REG + CONFIG, 0x0A | (IS_CRC16 << 2)); //���û�������ģʽ�Ĳ���;PWR_UP,EN_CRC,16BIT_CRC,����ģʽ,���������ж�
        MOVS     R1,#+14
        MOVS     R0,#+32
        BL       nrf_writereg
//  358 
//  359 
//  360     /*CE���ߣ����뷢��ģʽ*/
//  361     NRF_CE_HIGH();
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  362 
//  363     nrf_mode = TX_MODE;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_6
        STRB     R0,[R1, #+0]
//  364 
//  365     i = 0x0fff;
        MOVW     R0,#+4095
        STR      R0,[SP, #+0]
//  366     while(i--);         //CEҪ����һ��ʱ��Ž��뷢��ģʽ
??nrf_tx_mode_0:
        LDR      R0,[SP, #+0]
        SUBS     R1,R0,#+1
        STR      R1,[SP, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_tx_mode_0
//  367 
//  368     //DELAY_MS(1);
//  369 
//  370 
//  371 }
        POP      {R0,PC}          ;; return
//  372 
//  373 /*!
//  374  *  @brief      NRF24L01+���ݽ���
//  375  *  @param      rxbuf       ���ջ�������ַ
//  376  *  @param      len         �����ճ���
//  377  *  @return     ʵ�ʽ��յ����ݳ���
//  378  *  Sample usage:
//  379             relen = nrf_rx(buff,DATA_PACKET);               //�ȴ�����һ�����ݰ������ݴ洢��buff��
//  380             if(relen != 0)
//  381             {
//  382                 printf("\n���յ�����:%s",buff);             //��ӡ���յ������� ��������յ������ַ����ſ�����printfŶ����
//  383             }
//  384 
//  385  *  @since      v5.0
//  386  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  387 uint32  nrf_rx(uint8 *rxbuf, uint32 len)
//  388 {
nrf_rx:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  389     uint32 tmplen = 0;
        MOVS     R6,#+0
//  390     uint8 tmp;
//  391 
//  392     while( (nrf_rx_flag != QUEUE_EMPTY) && (len != 0) )
??nrf_rx_0:
        LDR.W    R0,??DataTable9_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??nrf_rx_1
        CMP      R5,#+0
        BEQ.N    ??nrf_rx_1
//  393     {
//  394         if(len < DATA_PACKET)
        CMP      R5,#+32
        BCS.N    ??nrf_rx_2
//  395         {
//  396             vcan_cpy(rxbuf, (uint8 *)&(NRF_ISR_RX_FIFO[nrf_rx_front]), len);
        MOVS     R2,R5
        LDR.W    R0,??DataTable9_8
        LDR.W    R1,??DataTable9_9
        LDRB     R1,[R1, #+0]
        ADDS     R1,R0,R1, LSL #+5
        MOVS     R0,R4
        BL       vcan_cpy
//  397 
//  398             NRF_CE_LOW();           //�������״̬
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  399 
//  400             nrf_rx_front++;                //���ڷǿգ����Կ���ֱ�ӳ�����
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable9_9
        STRB     R0,[R1, #+0]
//  401 
//  402             if(nrf_rx_front >= RX_FIFO_PACKET_NUM)
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+80
        BLT.N    ??nrf_rx_3
//  403             {
//  404                 nrf_rx_front = 0;          //��ͷ��ʼ
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_9
        STRB     R0,[R1, #+0]
//  405             }
//  406             tmp =  nrf_rx_rear;
??nrf_rx_3:
        LDR.W    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        MOVS     R7,R0
//  407             if(nrf_rx_front == tmp)       //׷��ƨ���ˣ����ն��п�
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R0,R7
        BNE.N    ??nrf_rx_4
//  408             {
//  409                 nrf_rx_flag = QUEUE_EMPTY;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_7
        STRB     R0,[R1, #+0]
//  410             }
//  411             NRF_CE_HIGH();          //�������ģʽ
??nrf_rx_4:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  412 
//  413             tmplen += len;
        ADDS     R6,R5,R6
//  414             return tmplen;
        MOVS     R0,R6
        B.N      ??nrf_rx_5
//  415         }
//  416 
//  417         vcan_cpy(rxbuf, (uint8 *)&(NRF_ISR_RX_FIFO[nrf_rx_front]), DATA_PACKET);
??nrf_rx_2:
        MOVS     R2,#+32
        LDR.W    R0,??DataTable9_8
        LDR.W    R1,??DataTable9_9
        LDRB     R1,[R1, #+0]
        ADDS     R1,R0,R1, LSL #+5
        MOVS     R0,R4
        BL       vcan_cpy
//  418         rxbuf   += DATA_PACKET;
        ADDS     R4,R4,#+32
//  419         len     -= DATA_PACKET;
        SUBS     R5,R5,#+32
//  420         tmplen  += DATA_PACKET;
        ADDS     R6,R6,#+32
//  421 
//  422         NRF_CE_LOW();           //�������״̬
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  423 
//  424         nrf_rx_front++;                //���ڷǿգ����Կ���ֱ�ӳ�����
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable9_9
        STRB     R0,[R1, #+0]
//  425 
//  426         if(nrf_rx_front >= RX_FIFO_PACKET_NUM)
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+80
        BLT.N    ??nrf_rx_6
//  427         {
//  428             nrf_rx_front = 0;          //��ͷ��ʼ
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_9
        STRB     R0,[R1, #+0]
//  429         }
//  430         tmp  = nrf_rx_rear;
??nrf_rx_6:
        LDR.W    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        MOVS     R7,R0
//  431         if(nrf_rx_front == tmp)       //׷��ƨ���ˣ����ն��п�
        LDR.W    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R0,R7
        BNE.N    ??nrf_rx_7
//  432         {
//  433             nrf_rx_flag = QUEUE_EMPTY;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_7
        STRB     R0,[R1, #+0]
        B.N      ??nrf_rx_8
//  434         }
//  435         else
//  436         {
//  437             nrf_rx_flag = QUEUE_NORMAL;
??nrf_rx_7:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_7
        STRB     R0,[R1, #+0]
//  438         }
//  439         NRF_CE_HIGH();          //�������ģʽ
??nrf_rx_8:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
        B.N      ??nrf_rx_0
//  440     }
//  441 
//  442     return tmplen;
??nrf_rx_1:
        MOVS     R0,R6
??nrf_rx_5:
        POP      {R1,R4-R7,PC}    ;; return
//  443 }
//  444 
//  445 /*!
//  446  *  @brief      NRF24L01+���ݷ���
//  447  *  @param      rxbuf       ���ͻ�������ַ
//  448  *  @param      len         ���ͳ���
//  449  *  @return     ���ͽ����0��ʾ����ʧ�ܣ�1Ϊ�����С����շ��ͽ����Ҫ����nrf_tx_state()�жϡ�
//  450  *  Sample usage:
//  451                     if(nrf_tx(buff,DATA_PACKET) == 1 );         //����һ�����ݰ���buff����Ϊ32�ֽڣ�
//  452                     {
//  453                         //�ȴ����͹����У��˴����Լ��봦������
//  454 
//  455                         while(nrf_tx_state() == NRF_TXING);         //�ȴ��������
//  456 
//  457                         if( NRF_TX_OK == nrf_tx_state () )
//  458                         {
//  459                             printf("\n���ͳɹ�:%d",i);
//  460                             i++;                                    //���ͳɹ����1������֤�Ƿ�©��
//  461                         }
//  462                         else
//  463                         {
//  464                             printf("\n����ʧ��:%d",i);
//  465                         }
//  466                     }
//  467                     else
//  468                     {
//  469                         printf("\n����ʧ��:%d",i);
//  470                     }
//  471 
//  472  *  @since      v5.0
//  473  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  474 uint8    nrf_tx(uint8 *txbuf, uint32 len)
//  475 {
nrf_tx:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  476     nrf_irq_tx_flag = 0;        //��λ��־λ
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_11
        STRB     R0,[R1, #+0]
//  477 
//  478     if((txbuf == 0 ) || (len == 0))
        CMP      R4,#+0
        BEQ.N    ??nrf_tx_0
        CMP      R5,#+0
        BNE.N    ??nrf_tx_1
//  479     {
//  480         return 0;
??nrf_tx_0:
        MOVS     R0,#+0
        B.N      ??nrf_tx_2
//  481     }
//  482 
//  483     if(nrf_irq_tx_addr == 0 )
??nrf_tx_1:
        LDR.W    R0,??DataTable9_12
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_tx_3
//  484     {
//  485         //
//  486         nrf_irq_tx_pnum = (len - 1) / DATA_PACKET;        // �� 1 ��� �� ����Ŀ
        SUBS     R0,R5,#+1
        LSRS     R0,R0,#+5
        LDR.W    R1,??DataTable9_13
        STR      R0,[R1, #+0]
//  487         nrf_irq_tx_addr = txbuf;
        LDR.W    R0,??DataTable9_12
        STR      R4,[R0, #+0]
//  488 
//  489         if( nrf_mode != TX_MODE)
        LDR.W    R0,??DataTable9_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??nrf_tx_4
//  490         {
//  491             nrf_tx_mode();
        BL       nrf_tx_mode
//  492         }
//  493 
//  494         //��Ҫ �ȷ���һ�����ݰ������ �жϷ���
//  495 
//  496         /*ceΪ�ͣ��������ģʽ1*/
//  497         NRF_CE_LOW();
??nrf_tx_4:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  498 
//  499         /*д���ݵ�TX BUF ��� 32���ֽ�*/
//  500         nrf_writebuf(WR_TX_PLOAD, txbuf, DATA_PACKET);
        MOVS     R2,#+32
        MOVS     R1,R4
        MOVS     R0,#+160
        BL       nrf_writebuf
//  501 
//  502         /*CEΪ�ߣ�txbuf�ǿգ��������ݰ� */
//  503         NRF_CE_HIGH();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  504 
//  505         return 1;
        MOVS     R0,#+1
        B.N      ??nrf_tx_2
//  506     }
//  507     else
//  508     {
//  509         return 0;
??nrf_tx_3:
        MOVS     R0,#+0
??nrf_tx_2:
        POP      {R1,R4,R5,PC}    ;; return
//  510     }
//  511 }
//  512 
//  513 
//  514 /*!
//  515  *  @brief      ���NRF24L01+����״̬
//  516  *  @return     ���ͽ�����ο� nrf_tx_state_e ö�ٵĶ��塣
//  517  *  Sample usage:
//  518                     if(nrf_tx(buff,DATA_PACKET) == 1 );         //����һ�����ݰ���buff����Ϊ32�ֽڣ�
//  519                     {
//  520                         //�ȴ����͹����У��˴����Լ��봦������
//  521 
//  522                         while(nrf_tx_state() == NRF_TXING);         //�ȴ��������
//  523 
//  524                         if( NRF_TX_OK == nrf_tx_state () )
//  525                         {
//  526                             printf("\n���ͳɹ�:%d",i);
//  527                             i++;                                    //���ͳɹ����1������֤�Ƿ�©��
//  528                         }
//  529                         else
//  530                         {
//  531                             printf("\n����ʧ��:%d",i);
//  532                         }
//  533                     }
//  534                     else
//  535                     {
//  536                         printf("\n����ʧ��:%d",i);
//  537                     }
//  538 
//  539  *  @since      v5.0
//  540  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  541 nrf_tx_state_e nrf_tx_state ()
//  542 {
//  543     /*
//  544     if(nrf_mode != TX_MODE)
//  545     {
//  546         return NRF_NOT_TX;
//  547     }
//  548     */
//  549 
//  550     if((nrf_irq_tx_addr == 0) && (nrf_irq_tx_pnum == 0))
nrf_tx_state:
        LDR.N    R0,??DataTable9_12
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_tx_state_0
        LDR.N    R0,??DataTable9_13
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_tx_state_0
//  551     {
//  552         //�������
//  553         if(nrf_irq_tx_flag)
        LDR.N    R0,??DataTable9_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??nrf_tx_state_1
//  554         {
//  555             return NRF_TX_ERROR;
        MOVS     R0,#+1
        B.N      ??nrf_tx_state_2
//  556         }
//  557         else
//  558         {
//  559             return NRF_TX_OK;
??nrf_tx_state_1:
        MOVS     R0,#+2
        B.N      ??nrf_tx_state_2
//  560         }
//  561     }
//  562     else
//  563     {
//  564         return NRF_TXING;
??nrf_tx_state_0:
        MOVS     R0,#+0
??nrf_tx_state_2:
        BX       LR               ;; return
//  565     }
//  566 }
//  567 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  568 void nrf_handler(void)
//  569 {
nrf_handler:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//  570     uint8 state;
//  571     uint8 tmp;
//  572     /*��ȡstatus�Ĵ�����ֵ  */
//  573     nrf_readreg(STATUS, &state);
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        BL       nrf_readreg
//  574 
//  575     /* ����жϱ�־*/
//  576     nrf_writereg(NRF_WRITE_REG + STATUS, state);
        LDRB     R1,[SP, #+0]
        MOVS     R0,#+39
        BL       nrf_writereg
//  577 
//  578     if(state & RX_DR) //���յ�����
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??nrf_handler_0
//  579     {
//  580         NRF_CE_LOW();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  581 
//  582         if(nrf_rx_flag != QUEUE_FULL)
        LDR.N    R0,??DataTable9_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??nrf_handler_1
//  583         {
//  584             //��û�������������
//  585             //printf("+");
//  586             nrf_readbuf(RD_RX_PLOAD, (uint8 *)&(NRF_ISR_RX_FIFO[nrf_rx_rear]), RX_PLOAD_WIDTH); //��ȡ����
        MOVS     R2,#+32
        LDR.N    R0,??DataTable9_8
        LDR.N    R1,??DataTable9_10
        LDRB     R1,[R1, #+0]
        ADDS     R1,R0,R1, LSL #+5
        MOVS     R0,#+97
        BL       nrf_readbuf
//  587 
//  588             nrf_rx_rear++;
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9_10
        STRB     R0,[R1, #+0]
//  589 
//  590             if(nrf_rx_rear >= RX_FIFO_PACKET_NUM)
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        CMP      R0,#+80
        BLT.N    ??nrf_handler_2
//  591             {
//  592                 nrf_rx_rear = 0;                            //��ͷ��ʼ
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_10
        STRB     R0,[R1, #+0]
//  593             }
//  594             tmp = nrf_rx_front;
??nrf_handler_2:
        LDR.N    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        MOVS     R4,R0
//  595             if(nrf_rx_rear == tmp)                 //׷��ƨ���ˣ�����
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R0,R4
        BNE.N    ??nrf_handler_3
//  596             {
//  597                 nrf_rx_flag = QUEUE_FULL;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable9_7
        STRB     R0,[R1, #+0]
        B.N      ??nrf_handler_4
//  598             }
//  599             else
//  600             {
//  601                 nrf_rx_flag = QUEUE_NORMAL;
??nrf_handler_3:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_7
        STRB     R0,[R1, #+0]
        B.N      ??nrf_handler_4
//  602             }
//  603         }
//  604         else
//  605         {
//  606             nrf_writereg(FLUSH_RX, NOP);                    //���RX FIFO�Ĵ���
??nrf_handler_1:
        MOVS     R1,#+255
        MOVS     R0,#+226
        BL       nrf_writereg
//  607         }
//  608         NRF_CE_HIGH();                                      //�������ģʽ
??nrf_handler_4:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  609     }
//  610 
//  611     if(state & TX_DS) //����������
??nrf_handler_0:
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??nrf_handler_5
//  612     {
//  613         if(nrf_irq_tx_pnum == 0)
        LDR.N    R0,??DataTable9_13
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_handler_6
//  614         {
//  615             nrf_irq_tx_addr = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_12
        STR      R0,[R1, #+0]
//  616 
//  617             // ע��: nrf_irq_tx_pnum == 0 ��ʾ ���� �Ѿ�ȫ�����͵�FIFO �� nrf_irq_tx_addr == 0 ���� ȫ����������
//  618 
//  619             //������ɺ� Ĭ�� ���� ����ģʽ
//  620 #if 1
//  621             if( nrf_mode != RX_MODE)
        LDR.N    R0,??DataTable9_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??nrf_handler_5
//  622             {
//  623                 nrf_rx_mode();
        BL       nrf_rx_mode
        B.N      ??nrf_handler_5
//  624             }
//  625 #endif
//  626 
//  627             //���ͳ��� Ϊ 0���������������
//  628             //nrf_writereg(FLUSH_TX, NOP);                        //���TX FIFO�Ĵ���
//  629         }
//  630         else
//  631         {
//  632             if( nrf_mode != TX_MODE)
??nrf_handler_6:
        LDR.N    R0,??DataTable9_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BEQ.N    ??nrf_handler_7
//  633             {
//  634                 nrf_tx_mode();
        BL       nrf_tx_mode
//  635             }
//  636 
//  637             //��û������ɣ��ͼ�������
//  638             nrf_irq_tx_addr += DATA_PACKET;    //ָ����һ����ַ
??nrf_handler_7:
        LDR.N    R0,??DataTable9_12
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+32
        LDR.N    R1,??DataTable9_12
        STR      R0,[R1, #+0]
//  639             nrf_irq_tx_pnum --;                 //����Ŀ����
        LDR.N    R0,??DataTable9_13
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable9_13
        STR      R0,[R1, #+0]
//  640 
//  641             /*ceΪ�ͣ��������ģʽ1*/
//  642             NRF_CE_LOW();
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  643 
//  644             /*д���ݵ�TX BUF ��� 32���ֽ�*/
//  645             nrf_writebuf(WR_TX_PLOAD, (uint8 *)nrf_irq_tx_addr, DATA_PACKET);
        MOVS     R2,#+32
        LDR.N    R0,??DataTable9_12
        LDR      R1,[R0, #+0]
        MOVS     R0,#+160
        BL       nrf_writebuf
//  646 
//  647             /*CEΪ�ߣ�txbuf�ǿգ��������ݰ� */
//  648             NRF_CE_HIGH();
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_2  ;; 0x43fe0024
        STR      R0,[R1, #+0]
//  649         }
//  650     }
//  651 
//  652     if(state & MAX_RT)      //���ͳ�ʱ
??nrf_handler_5:
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+27
        BPL.N    ??nrf_handler_8
//  653     {
//  654         nrf_irq_tx_flag = 1;                            //��Ƿ���ʧ��
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_11
        STRB     R0,[R1, #+0]
//  655         nrf_writereg(FLUSH_TX, NOP);                    //���TX FIFO�Ĵ���
        MOVS     R1,#+255
        MOVS     R0,#+225
        BL       nrf_writereg
//  656 
//  657 
//  658         //�п����� �Է�Ҳ���� ����״̬
//  659 
//  660         //�������η���
//  661         nrf_irq_tx_addr = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_12
        STR      R0,[R1, #+0]
//  662         nrf_irq_tx_pnum = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_13
        STR      R0,[R1, #+0]
//  663 
//  664         nrf_rx_mode();                                  //���� ����״̬
        BL       nrf_rx_mode
//  665 
//  666 
//  667         //printf("\nMAX_RT");
//  668     }
//  669 
//  670     if(state & TX_FULL) //TX FIFO ��
//  671     {
//  672         //printf("\nTX_FULL");
//  673 
//  674     }
//  675 }
??nrf_handler_8:
        POP      {R0,R1,R4,PC}    ;; return
//  676 
//  677 
//  678 //��� ����FIFO ������  (0 û���չ� ��1 Ϊ������ȷ)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  679 uint8  nrf_rx_fifo_check(uint32 offset,uint16 * val)
//  680 {
nrf_rx_fifo_check:
        PUSH     {R4-R6}
        MOVS     R2,R0
//  681     uint8 rx_num = (offset + 1 + DATA_PACKET - 1 ) / DATA_PACKET;   //��1 ����Ϊ����2���ֽڣ����һ���Լ����ڵİ�����
        ADDS     R0,R2,#+32
        LSRS     R4,R0,#+5
//  682                                                                     //+ DATA_PACKET - 1 ����������
//  683     uint8 tmp;
//  684     if(nrf_rx_flag == QUEUE_EMPTY)
        LDR.N    R0,??DataTable9_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??nrf_rx_fifo_check_0
//  685     {
//  686         return 0;
        MOVS     R0,#+0
        B.N      ??nrf_rx_fifo_check_1
//  687     }
//  688 
//  689     if(rx_num > RX_FIFO_PACKET_NUM)                                 //ƫ��̫�󣬳��� FIFO ����
??nrf_rx_fifo_check_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+81
        BLT.N    ??nrf_rx_fifo_check_2
//  690     {
//  691         return 0;
        MOVS     R0,#+0
        B.N      ??nrf_rx_fifo_check_1
//  692     }
//  693 
//  694     rx_num = nrf_rx_front + rx_num - 1;                             //Ŀ���ѯ�� ����λ��
??nrf_rx_fifo_check_2:
        LDR.N    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        ADDS     R4,R0,R4
//  695     tmp =  nrf_rx_rear;
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        MOVS     R3,R0
//  696     if(nrf_rx_front <  tmp)                                 //���������� һȦ֮��
        LDR.N    R0,??DataTable9_9
        LDRB     R0,[R0, #+0]
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R0,R3
        BCS.N    ??nrf_rx_fifo_check_3
//  697     {
//  698         if(rx_num >= nrf_rx_rear )                                  //û�����㹻������
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R0
        BCC.N    ??nrf_rx_fifo_check_4
//  699         {
//  700             return 0;
        MOVS     R0,#+0
        B.N      ??nrf_rx_fifo_check_1
//  701         }
//  702 
//  703         //��ȡ����
//  704 
//  705     }
//  706     else                                                            //Խ��һȦ
//  707     {
//  708         if(rx_num >= RX_FIFO_PACKET_NUM)                            //����һȦ
??nrf_rx_fifo_check_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+80
        BLT.N    ??nrf_rx_fifo_check_4
//  709         {
//  710             rx_num -= RX_FIFO_PACKET_NUM;
        SUBS     R4,R4,#+80
//  711 
//  712             if( rx_num >= nrf_rx_rear )                             //��û���չ�
        LDR.N    R0,??DataTable9_10
        LDRB     R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R0
        BCC.N    ??nrf_rx_fifo_check_4
//  713             {
//  714                 return 0;
        MOVS     R0,#+0
        B.N      ??nrf_rx_fifo_check_1
//  715             }
//  716         }
//  717         //��ȡ����
//  718     }
//  719 
//  720     //��ȡ����
//  721     *val = *(uint16 *)((char *)&NRF_ISR_RX_FIFO + ( rx_num*DATA_PACKET + (offset % DATA_PACKET - 2) )) ;
??nrf_rx_fifo_check_4:
        LDR.N    R0,??DataTable9_8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R5,#+32
        UDIV     R6,R2,R5
        MLS      R6,R6,R5,R2
        ADDS     R5,R6,R4, LSL #+5
        ADDS     R0,R5,R0
        LDRH     R0,[R0, #-2]
        STRH     R0,[R1, #+0]
//  722     return 1;
        MOVS     R0,#+1
??nrf_rx_fifo_check_1:
        POP      {R4-R6}
        BX       LR               ;; return
//  723 
//  724 }
//  725 
//  726 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  727 int NRF_Send_Data(void)
//  728 {
NRF_Send_Data:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//  729         int i = 1225;               //ʵ��ʹ��ʱ��ɾȥ
        MOVW     R0,#+1225
        STR      R0,[SP, #+0]
//  730 	NRF24L01_TXDATA[0]  = 0x8A;
        MOVS     R0,#+138
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+0]
//  731 	NRF24L01_TXDATA[1]  = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+1]
//  732 	NRF24L01_TXDATA[2]  = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+2]
//  733 	NRF24L01_TXDATA[3]  = BYTE1(i);//ʵ���ٶ�
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+3]
//  734 	NRF24L01_TXDATA[4]  = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+4]
//  735 	NRF24L01_TXDATA[5]  = BYTE1(i);  //�ٶ����
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+5]
//  736 	NRF24L01_TXDATA[6]  = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+6]
//  737 	NRF24L01_TXDATA[7]  = BYTE1(i);   //�������
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+7]
//  738 	NRF24L01_TXDATA[8]  = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+8]
//  739 	NRF24L01_TXDATA[9]  = BYTE1(i); //������
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+9]
//  740 	NRF24L01_TXDATA[10] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+10]
//  741 	NRF24L01_TXDATA[11] = BYTE1(i);//�ٶȻ����
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+11]
//  742 	NRF24L01_TXDATA[12] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+12]
//  743 	NRF24L01_TXDATA[13] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+13]
//  744 	NRF24L01_TXDATA[14] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+14]
//  745 	NRF24L01_TXDATA[15] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+15]
//  746 	NRF24L01_TXDATA[16] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+16]
//  747 	NRF24L01_TXDATA[17] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+17]
//  748 	NRF24L01_TXDATA[18] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+18]
//  749 	NRF24L01_TXDATA[19] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+19]
//  750 	NRF24L01_TXDATA[20] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+20]
//  751         NRF24L01_TXDATA[21] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+21]
//  752 	NRF24L01_TXDATA[22] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+22]
//  753         NRF24L01_TXDATA[23] = BYTE1(i);
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+23]
//  754         NRF24L01_TXDATA[24] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+24]
//  755         NRF24L01_TXDATA[25] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+25]
//  756         NRF24L01_TXDATA[26] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+26]
//  757         NRF24L01_TXDATA[27] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+27]
//  758         NRF24L01_TXDATA[28] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+28]
//  759         NRF24L01_TXDATA[29] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+29]
//  760         NRF24L01_TXDATA[30] = BYTE0(i);
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable9_14
        STRB     R0,[R1, #+30]
//  761 
//  762 	uint8 sum = 0;
        MOVS     R4,#+0
//  763 	for(i=0;i<31;i++)
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
??NRF_Send_Data_0:
        LDR      R0,[SP, #+0]
        CMP      R0,#+31
        BGE.N    ??NRF_Send_Data_1
//  764 		sum += NRF24L01_TXDATA[i];
        LDR.N    R0,??DataTable9_14
        LDR      R1,[SP, #+0]
        LDRB     R0,[R1, R0]
        ADDS     R4,R0,R4
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        B.N      ??NRF_Send_Data_0
//  765 	NRF24L01_TXDATA[31] = sum;
??NRF_Send_Data_1:
        LDR.N    R0,??DataTable9_14
        STRB     R4,[R0, #+31]
//  766 	if(nrf_tx(NRF24L01_TXDATA,DATA_PACKET) == 1)
        MOVS     R1,#+32
        LDR.N    R0,??DataTable9_14
        BL       nrf_tx
        CMP      R0,#+1
        BNE.N    ??NRF_Send_Data_2
//  767 		return 1;
        MOVS     R0,#+1
        B.N      ??NRF_Send_Data_3
//  768 	else 
//  769                 return 0;
??NRF_Send_Data_2:
        MOVS     R0,#+0
??NRF_Send_Data_3:
        POP      {R1,R2,R4,PC}    ;; return
//  770 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0x989680

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0xa0003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x43fe0024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     RX_ADDRESS

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     TX_ADDRESS

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     nrf_mode

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     nrf_rx_flag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     NRF_ISR_RX_FIFO

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     nrf_rx_front

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC32     nrf_rx_rear

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC32     nrf_irq_tx_flag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC32     nrf_irq_tx_addr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_13:
        DC32     nrf_irq_tx_pnum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_14:
        DC32     NRF24L01_TXDATA

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
        DC8 194, 194, 194, 194, 194, 0, 0, 0

        END
// 
// 2 637 bytes in section .bss
//    16 bytes in section .data
//     8 bytes in section .rodata
// 1 740 bytes in section .text
// 
// 1 740 bytes of CODE  memory
//     8 bytes of CONST memory
// 2 653 bytes of DATA  memory
//
//Errors: none
//Warnings: 16
