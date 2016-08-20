///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:30
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_spi.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_spi.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_spi.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN __aeabi_memcpy4
        EXTERN abs
        EXTERN assert_failed
        EXTERN bus_clk_khz
        EXTERN port_init

        PUBLIC SPIN
        PUBLIC spi_init
        PUBLIC spi_mosi
        PUBLIC spi_mosi_cmd

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_spi.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_spi.c
//   11  * @brief      SPI��������
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.0
//   14  * @date       2013-07-16
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_port.h"
//   19 #include "MK60_spi.h"
//   20 
//   21 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   22 SPI_MemMapPtr SPIN[3] = {SPI0_BASE_PTR, SPI1_BASE_PTR, SPI2_BASE_PTR}; //��������ָ�����鱣�� SPIx �ĵ�ַ
SPIN:
        DATA
        DC32 4002C000H, 4002D000H, 400AC000H
//   23 
//   24 
//   25 
//   26 #define SPI_TX_WAIT(SPIn)     while(  ( SPI_SR_REG(SPIN[SPIn]) & SPI_SR_TXRXS_MASK ) == 1 ) //�ȴ����� ���
//   27 #define SPI_RX_WAIT(SPIn)     while(  ( SPI_SR_REG(SPIN[SPIn]) & SPI_SR_RFDF_MASK ) == 0 )  //�ȴ����� FIFOΪ�ǿ�
//   28 #define SPI_EOQF_WAIT(SPIn)   while(  (SPI_SR_REG(SPIN[SPIn]) & SPI_SR_EOQF_MASK ) == 0 )   //�ȴ��������
//   29 
//   30 
//   31 /*!
//   32  *  @brief      SPI��ʼ��������ģʽ
//   33  *  @param      SPIn_e          SPIģ��(SPI0��SPI1��SPI2)
//   34  *  @param      SPIn_PCSn_e     Ƭѡ�ܽű��
//   35  *  @param      SPI_CFG         SPI���ӻ�ģʽѡ��
//   36  *  @since      v5.0
//   37  *  Sample usage:       uint32 baud = spi_init(SPI0,SPIn_PCS0, MASTER,10*1000*1000);              //��ʼ��SPI,ѡ��CS0,����ģʽ, ������Ϊ1M ,������ʵ�����ʵ�baud����
//   38  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 uint32 spi_init(SPIn_e spin, SPI_PCSn_e pcs, SPI_CFG master,uint32 baud)
//   40 {
spi_init:
        PUSH     {R2-R11,LR}
        SUB      SP,SP,#+92
        MOVS     R4,R0
        MOVS     R5,R1
//   41     uint8  br,pbr;
//   42     uint32 clk = bus_clk_khz*1000/baud;
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        LDR      R1,[SP, #+96]
        UDIV     R0,R0,R1
        STR      R0,[SP, #+4]
//   43     uint32 Scaler[] = {2,4,6,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768};
        ADD      R0,SP,#+24
        LDR.W    R1,??DataTable2_1
        MOVS     R2,#+64
        BL       __aeabi_memcpy4
//   44     uint8  Prescaler[] = {2,3,5,7};
        ADD      R0,SP,#+20
        LDR.W    R1,??DataTable2_2
        LDR      R2,[R1, #0]
        STR      R2,[R0, #+0]
//   45     uint32 fit_clk,fit_br=0,fit_pbr,min_diff =~0,diff;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
        MOVS     R9,#-1
//   46     uint32 tmp;
//   47 
//   48     //����CS����һ��SCK��ʱ��
//   49     uint8 pcssck,cssck,fit_pcssck,fit_cssck;
//   50 
//   51     //ʹ��SPIģ��ʱ�ӣ�����SPI���Ź���
//   52     if(spin == SPI0)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??spi_init_0
//   53     {
//   54         SIM_SCGC6 |= SIM_SCGC6_DSPI0_MASK;
        LDR.W    R0,??DataTable2_3  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.W    R1,??DataTable2_3  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   55 
//   56         //���йܽŸ���
//   57         port_init(SPI0_SCK_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+15
        BL       port_init
//   58         port_init(SPI0_SOUT_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+16
        BL       port_init
//   59         port_init(SPI0_SIN_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+17
        BL       port_init
//   60 
//   61         if(pcs & SPI_PCS0)
        LSLS     R0,R5,#+31
        BPL.N    ??spi_init_1
//   62             port_init(SPI0_PCS0_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+14
        BL       port_init
//   63 
//   64         if(pcs & SPI_PCS1)
??spi_init_1:
        LSLS     R0,R5,#+30
        BPL.N    ??spi_init_2
//   65             port_init(SPI0_PCS1_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+67
        BL       port_init
//   66 
//   67         if(pcs & SPI_PCS2)
??spi_init_2:
        LSLS     R0,R5,#+29
        BPL.N    ??spi_init_3
//   68             port_init(SPI0_PCS2_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+66
        BL       port_init
//   69 
//   70         if(pcs & SPI_PCS3)
??spi_init_3:
        LSLS     R0,R5,#+28
        BPL.N    ??spi_init_4
//   71             port_init(SPI0_PCS3_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+65
        BL       port_init
//   72 
//   73         if(pcs & SPI_PCS4)
??spi_init_4:
        LSLS     R0,R5,#+27
        BPL.N    ??spi_init_5
//   74             port_init(SPI0_PCS4_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+64
        BL       port_init
//   75 
//   76         if(pcs & SPI_PCS5)
??spi_init_5:
        LSLS     R0,R5,#+26
        BPL.N    ??spi_init_6
//   77             port_init(SPI0_PCS5_PIN, ALT3  );
        MOV      R1,#+768
        MOVS     R0,#+55
        BL       port_init
        B.N      ??spi_init_6
//   78     }
//   79     else if(spin == SPI1)
??spi_init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??spi_init_7
//   80     {
//   81 #if defined(MK60DZ10)
//   82         SIM_SCGC6 |= SIM_SCGC6_SPI1_MASK;
        LDR.W    R0,??DataTable2_3  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.W    R1,??DataTable2_3  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   83 #elif defined(MK60F15)
//   84         SIM_SCGC6 |= SIM_SCGC6_DSPI1_MASK;
//   85 #endif
//   86         port_init(SPI1_SCK_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+130
        BL       port_init
//   87         port_init(SPI1_SOUT_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+129
        BL       port_init
//   88         port_init(SPI1_SIN_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+131
        BL       port_init
//   89 
//   90         if(pcs & SPI_PCS0)
        LSLS     R0,R5,#+31
        BPL.N    ??spi_init_8
//   91             port_init(SPI1_PCS0_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+132
        BL       port_init
//   92 
//   93         if(pcs & SPI_PCS1)
??spi_init_8:
        LSLS     R0,R5,#+30
        BPL.N    ??spi_init_9
//   94             port_init(SPI1_PCS1_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+128
        BL       port_init
//   95 
//   96         if(pcs & SPI_PCS2)
??spi_init_9:
        LSLS     R0,R5,#+29
        BPL.N    ??spi_init_10
//   97             port_init(SPI1_PCS2_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+133
        BL       port_init
//   98 
//   99         if(pcs & SPI_PCS3)
??spi_init_10:
        LSLS     R0,R5,#+28
        BPL.N    ??spi_init_6
//  100             port_init(SPI1_PCS3_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+134
        BL       port_init
        B.N      ??spi_init_6
//  101     }
//  102     else if(spin == SPI2)
??spi_init_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??spi_init_11
//  103     {
//  104 #if defined(MK60DZ10)
//  105         SIM_SCGC3 |= SIM_SCGC3_SPI2_MASK;
        LDR.W    R0,??DataTable2_4  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.W    R1,??DataTable2_4  ;; 0x40048030
        STR      R0,[R1, #+0]
//  106 #elif defined(MK60F15)
//  107         SIM_SCGC3 |= SIM_SCGC3_DSPI2_MASK;
//  108 #endif
//  109 
//  110         port_init(SPI2_SCK_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+53
        BL       port_init
//  111         port_init(SPI2_SOUT_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+54
        BL       port_init
//  112         port_init(SPI2_SIN_PIN , ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+55
        BL       port_init
//  113 
//  114         if(pcs & SPI_PCS0)
        LSLS     R0,R5,#+31
        BPL.N    ??spi_init_12
//  115             port_init(SPI2_PCS0_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+52
        BL       port_init
//  116 
//  117         if(pcs & SPI_PCS1)
??spi_init_12:
        LSLS     R0,R5,#+30
        BPL.N    ??spi_init_6
//  118             port_init(SPI2_PCS1_PIN, ALT2  );
        MOV      R1,#+512
        MOVS     R0,#+111
        BL       port_init
        B.N      ??spi_init_6
//  119     }
//  120     else
//  121     {
//  122         //���ݽ����� spi ģ������ֱ���ж϶���ʧ��
//  123         ASSERT(0);
??spi_init_11:
        MOVS     R1,#+123
        LDR.W    R0,??DataTable2_5
        BL       assert_failed
//  124     }
//  125 
//  126     SPI_MCR_REG(SPIN[spin]) = ( 0
//  127                                 | SPI_MCR_CLR_TXF_MASK     //��� Tx FIFO ������
//  128                                 | SPI_MCR_CLR_RXF_MASK     //��� Rx FIFO ������
//  129                                 | SPI_MCR_HALT_MASK        //ֹͣSPI����
//  130                               );
??spi_init_6:
        MOVW     R0,#+3073
        LDR.W    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  131 
//  132     /*************  ���־λ  ***************/
//  133     SPI_SR_REG(SPIN[spin]) = (0
//  134                               | SPI_SR_EOQF_MASK    //���Ͷ��п��ˣ��������
//  135                               | SPI_SR_TFUF_MASK    //����FIFO�����־λ��SPIΪ�ӻ�ģʽ��Tx FIFOΪ�գ����ⲿSPI����ģʽ�������䣬��־λ�ͻ���1��д1��0
//  136                               | SPI_SR_TFFF_MASK    //����FIFO����־λ�� д1����DMA���������ִ���FIFO���˾ͻ���0�� 0��ʾTx FIFO����
//  137                               | SPI_SR_RFOF_MASK    //����FIFO�����־λ��
//  138                               | SPI_SR_RFDF_MASK    //����FIFO��ı�־λ��д1����DMA���������ִ���FIFO���˾ͻ���0��0��ʾRx FIFO��
//  139                              );
        LDR.W    R0,??DataTable2_7  ;; 0x1a0a0000
        LDR.W    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+44]
//  140 
//  141 
//  142     //�������ӻ�ģʽ���ù���ģʽ��MCU�ṩ�������Ƶ����1/2��Ƶ�����ӻ�Ƶ����1/4��Ƶ
//  143     if(master == MASTER)
        LDRB     R0,[SP, #+92]
        CMP      R0,#+0
        BNE.W    ??spi_init_13
//  144     {
//  145         SPI_MCR_REG(SPIN[spin]) =  (0
//  146                                     |  SPI_MCR_MSTR_MASK        //Master,����ģʽ
//  147                                     |  SPI_MCR_PCSIS(pcs)
//  148                                     |  SPI_MCR_PCSIS_MASK
//  149                                    );
        LDR.W    R0,??DataTable2_8  ;; 0x803f0000
        LDR.W    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  150 
//  151 
//  152         for(br = 0;br < 0x10;br++)
        MOVS     R0,#+0
        MOVS     R6,R0
??spi_init_14:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+16
        BGE.N    ??spi_init_15
//  153         {
//  154             for(pbr = 0;pbr < 4;pbr++)
        MOVS     R0,#+0
        MOVS     R7,R0
??spi_init_16:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+4
        BGE.N    ??spi_init_17
//  155             {
//  156                 tmp = Scaler[br] * Prescaler[pbr];
        ADD      R0,SP,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        ADD      R1,SP,#+20
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        LDRB     R1,[R7, R1]
        MULS     R0,R1,R0
        MOV      R10,R0
//  157                 diff = abs(tmp - clk);
        LDR      R0,[SP, #+4]
        SUBS     R0,R10,R0
        BL       abs
        MOV      R8,R0
//  158                 if(min_diff > diff)
        CMP      R8,R9
        BCS.N    ??spi_init_18
//  159                 {
//  160                     //��ס �������
//  161                     min_diff = diff;
        MOV      R9,R8
//  162                     fit_br = br;
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        STR      R6,[SP, #+8]
//  163                     fit_pbr = pbr;
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        STR      R7,[SP, #+12]
//  164    
//  165                     if(min_diff == 0)
        CMP      R9,#+0
        BEQ.N    ??spi_init_15
//  166                     {
//  167                         //�պ�ƥ��
//  168 
//  169                         goto SPI_CLK_EXIT;
//  170                     }
//  171 
//  172                 }
//  173 
//  174             }
??spi_init_18:
        ADDS     R7,R7,#+1
        B.N      ??spi_init_16
//  175         }
??spi_init_17:
        ADDS     R6,R6,#+1
        B.N      ??spi_init_14
//  176 
//  177 SPI_CLK_EXIT:
//  178         fit_clk =  bus_clk_khz *1000 /(Scaler[fit_br] * Prescaler[fit_pbr]);
??spi_init_15:
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        ADD      R1,SP,#+24
        LDR      R2,[SP, #+8]
        LDR      R1,[R1, R2, LSL #+2]
        ADD      R2,SP,#+20
        LDR      R3,[SP, #+12]
        LDRB     R2,[R3, R2]
        MULS     R1,R2,R1
        UDIV     R0,R0,R1
        STR      R0,[SP, #+16]
//  179 
//  180         //��Ҫ��һ�� CS �� CLK ��ʱ�䣨�����ʵİ����ڣ�,���������� (1<<(CSSCK + 1 ))*( 2*PCSSCK+1) = fclk /(2*  baud)
//  181         clk =  bus_clk_khz*1000/fit_clk/2;
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        LDR      R1,[SP, #+16]
        UDIV     R0,R0,R1
        LSRS     R0,R0,#+1
        STR      R0,[SP, #+4]
//  182         min_diff = ~0;
        MOVS     R0,#-1
        MOV      R9,R0
//  183         fit_cssck = 0x0F;
        MOVS     R0,#+15
        STRB     R0,[SP, #+1]
//  184         fit_pcssck = 3;
        MOVS     R0,#+3
        STRB     R0,[SP, #+2]
//  185         for(cssck = 0;cssck<=0x0F;cssck++)
        MOVS     R0,#+0
        MOV      R11,R0
??spi_init_19:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+16
        BGE.N    ??spi_init_20
//  186         {
//  187             tmp = 1<<(cssck+1) ;
        MOVS     R0,#+1
        ADDS     R1,R11,#+1
        LSLS     R0,R0,R1
        MOV      R10,R0
//  188             pcssck = (clk/tmp-1)/2;
        LDR      R0,[SP, #+4]
        UDIV     R0,R0,R10
        SUBS     R0,R0,#+1
        LSRS     R0,R0,#+1
        STRB     R0,[SP, #+0]
//  189             if(pcssck>3)continue;       //���ܳ��� 3
        LDRB     R0,[SP, #+0]
        CMP      R0,#+4
        BGE.N    ??spi_init_21
//  190             tmp = tmp * (2*pcssck+1);
??spi_init_22:
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+1
        MUL      R10,R0,R10
//  191             diff = abs(tmp-clk);
        LDR      R0,[SP, #+4]
        SUBS     R0,R10,R0
        BL       abs
        MOV      R8,R0
//  192             if(min_diff > diff)
        CMP      R8,R9
        BCS.N    ??spi_init_21
//  193             {
//  194                 //��ס �������
//  195                 min_diff = diff;
        MOV      R9,R8
//  196                 fit_cssck = cssck;
        STRB     R11,[SP, #+1]
//  197                 fit_pcssck = pcssck;
        LDRB     R0,[SP, #+0]
        STRB     R0,[SP, #+2]
//  198 
//  199                 if(min_diff == 0)
        CMP      R9,#+0
        BEQ.N    ??spi_init_20
//  200                 {
//  201                     //�պ�ƥ��
//  202                     goto SPI_CSSCK_EXIT;
//  203                 }
//  204             }
//  205         }
??spi_init_21:
        ADDS     R11,R11,#+1
        B.N      ??spi_init_19
//  206 
//  207 SPI_CSSCK_EXIT:
//  208 
//  209         SPI_CTAR_REG(SPIN[spin], 0) = (0
//  210                                        //| SPI_CTAR_DBR_MASK    //˫������ ������ DBR=1��CPHA=1��PBR=00����SCK Duty Cycle Ϊ 50/50
//  211                                        //| SPI_CTAR_CPHA_MASK   //������SCK�����ظı䣨����������½��ر���׽�������ȡ���������0����֮��  w25x16�������ض�ȡ���ݣ�NRF24L01�������ض�ȡ����
//  212                                        | SPI_CTAR_PBR(fit_pbr)        //�����ʷ�Ƶ�� ��0~3 ��Ӧ�ķ�ƵֵPrescalerΪ 2��3��5��7
//  213 
//  214                                        | SPI_CTAR_PDT(0x00)     //��ʱ����Ϊ PDT*2+1 ������PDTΪ3������ʱ����Ϊ7��PDTΪ2bit
//  215                                        | SPI_CTAR_BR(fit_br)         //�����ʼ�����ֵ ,��BR<=3,��ƵScaler Ϊ 2*��BR+1�� ����BR>=3����ƵScaler Ϊ 2^BR  ��BRΪ4bit
//  216                                        //SCK ������ = (Bus clk/Prescaler) x [(1+DBR)/Scaler ]          fSYS Ϊ Bus clock
//  217                                        //              50M / 2         x [ 1  /  2  ] = 25M   ��������������
//  218 
//  219                                        //| SPI_CTAR_CPOL_MASK   //ʱ�Ӽ��ԣ�1��ʾ SCK ����Ծ״̬Ϊ�ߵ�ƽ,   NRF24L01 ����ԾΪ�͵�ƽ
//  220                                        | SPI_CTAR_FMSZ(0x07)    //ÿ֡���� 7bit+1 ����8bit ��FMSZĬ�Ͼ���8��
//  221                                        // | SPI_CTAR_LSBFE_MASK //1Ϊ��λ��ǰ��
//  222 
//  223                                        // �������������ǵ��� CS �ź����˵���һ��CLK��ʱ��
//  224                                        | SPI_CTAR_CSSCK(fit_cssck)    // x ��0~0x0F
//  225                                        | SPI_CTAR_PCSSCK(fit_pcssck)    //����Ƭѡ�ź���Ч��ʱ�ӵ�һ�����س��ֵ���ʱ��Ԥ��Ƶֵ��tcsc��ʱԤ��Ƶ 2*x+1�� x 0~3
//  226                                       );
??spi_init_20:
        LDR      R0,[SP, #+12]
        LSLS     R0,R0,#+16
        ANDS     R0,R0,#0x30000
        LDR      R1,[SP, #+8]
        ANDS     R1,R1,#0xF
        ORRS     R0,R1,R0
        LDRB     R1,[SP, #+1]
        LSLS     R1,R1,#+12
        ANDS     R1,R1,#0xF000
        ORRS     R0,R1,R0
        LDRB     R1,[SP, #+2]
        LSLS     R1,R1,#+22
        ANDS     R1,R1,#0xC00000
        ORRS     R0,R1,R0
        ORRS     R0,R0,#0x38000000
        LDR.N    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+12]
        B.N      ??spi_init_23
//  227     }
//  228     else
//  229     {
//  230         //Ĭ�ϴӻ�ģʽ
//  231         SPI_CTAR_SLAVE_REG(SPIN[spin], 0) = (0
//  232                                              | SPI_CTAR_SLAVE_FMSZ(0x07)
//  233                                              | SPI_CTAR_SLAVE_CPOL_MASK
//  234                                              | SPI_CTAR_SLAVE_CPHA_MASK
//  235                                             );
??spi_init_13:
        MOVS     R0,#+1040187392
        LDR.N    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+12]
//  236     }
//  237 
//  238 
//  239     SPI_MCR_REG(SPIN[spin]) &= ~SPI_MCR_HALT_MASK;     //����SPI���䡣1Ϊ��ͣ��0Ϊ����
??spi_init_23:
        LDR.N    R0,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  240 
//  241     return fit_clk;
        LDR      R0,[SP, #+16]
        ADD      SP,SP,#+100
        POP      {R4-R11,PC}      ;; return
//  242 
//  243 }
//  244 
//  245 /*!
//  246  *  @brief      SPI���ͽ��պ���
//  247  *  @param      SPIn_e          SPIģ��(SPI0��SPI1��SPI2)
//  248  *  @param      SPIn_PCSn_e     Ƭѡ�ܽű��
//  249  *  @param      modata          ���͵����ݻ�������ַ(����Ҫ������ NULL)
//  250  *  @param      midata          ��������ʱ���յ������ݵĴ洢��ַ(����Ҫ������ NULL)
//  251  *  @since      v5.0
//  252  *  Sample usage:           spi_mosi(SPI0,SPIn_PCS0,buff,buff,2);    //����buff�����ݣ������յ�buff�����Ϊ2�ֽ�
//  253  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  254 void spi_mosi(SPIn_e spin, SPI_PCSn_e pcs, uint8 *modata, uint8 *midata, uint32 len)
//  255 {
spi_mosi:
        PUSH     {R4-R7}
        LDR      R4,[SP, #+16]
//  256     uint32 i = 0;
        MOVS     R5,#+0
//  257     do
//  258     {
//  259         /*************  ���־λ  ***************/
//  260         SPI_SR_REG(SPIN[spin]) = (0
//  261                                   | SPI_SR_EOQF_MASK    //���Ͷ��п��ˣ�������ϱ�־
//  262                                   | SPI_SR_TFUF_MASK    //����FIFO�����־λ��SPIΪ�ӻ�ģʽ��Tx FIFOΪ�գ����ⲿSPI����ģʽ�������䣬��־λ�ͻ���1��д1��0
//  263                                   | SPI_SR_TFFF_MASK    //����FIFO����־λ�� д1����DMA���������ִ���FIFO���˾ͻ���0�� 0��ʾTx FIFO����
//  264                                   | SPI_SR_RFOF_MASK    //����FIFO�����־λ��
//  265                                   | SPI_SR_RFDF_MASK    //����FIFO��ı�־λ��д1����DMA���������ִ���FIFO���˾ͻ���0��0��ʾRx FIFO��
//  266                                  );
??spi_mosi_0:
        LDR.N    R6,??DataTable2_7  ;; 0x1a0a0000
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+44]
//  267 
//  268 
//  269         /************** ��FIFO������ **************/
//  270         SPI_MCR_REG(SPIN[spin])    |=  (0
//  271                                         | SPI_MCR_CLR_TXF_MASK  //д1�� Tx FIFO ������
//  272                                         | SPI_MCR_CLR_RXF_MASK  //д1�� Rx FIFO ������
//  273                                        );
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+0]
        ORRS     R6,R6,#0xC00
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+0]
//  274 
//  275     }
//  276     while( (SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));            //��� Rx FIFO �ǿգ�����FIFO.
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        LSLS     R6,R6,#+14
        BMI.N    ??spi_mosi_0
//  277 
//  278     /***************** ����len-1������ *******************/                                                ;
//  279     for(i = 0; i < (len - 1); i++)
        MOVS     R6,#+0
        MOVS     R5,R6
??spi_mosi_1:
        SUBS     R6,R4,#+1
        CMP      R5,R6
        BCS.N    ??spi_mosi_2
//  280     {
//  281         SPI_PUSHR_REG(SPIN[spin]) = (0
//  282                                      | SPI_PUSHR_CTAS(0)             //ѡ��CTAR0�Ĵ���
//  283                                      | SPI_PUSHR_CONT_MASK           //1Ϊ �����ڼ䱣��PCSn�ź� ����������������
//  284                                      | SPI_PUSHR_PCS(pcs)
//  285                                      | SPI_PUSHR_TXDATA(modata[i])     //Ҫ���������
//  286                                     );
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R6,R1,#+16
        ANDS     R6,R6,#0x3F0000
        LDRB     R7,[R5, R2]
        ORRS     R6,R7,R6
        ORRS     R6,R6,#0x80000000
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+52]
//  287 
//  288         while(!(SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));        //RFDFΪ1��Rx FIFO is not empty.
??spi_mosi_3:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        LSLS     R6,R6,#+14
        BPL.N    ??spi_mosi_3
//  289         if(midata != NULL)
        CMP      R3,#+0
        BEQ.N    ??spi_mosi_4
//  290         {
//  291             midata[i] = (uint8)SPI_POPR_REG(SPIN[spin]);                  //������յ�������
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+56]
        STRB     R6,[R5, R3]
        B.N      ??spi_mosi_5
//  292         }
//  293         else
//  294         {
//  295             SPI_POPR_REG(SPIN[spin]);
??spi_mosi_4:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+56]
//  296         }
//  297         SPI_SR_REG(SPIN[spin]) |= SPI_SR_RFDF_MASK;
??spi_mosi_5:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        ORRS     R6,R6,#0x20000
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+44]
//  298     }
        ADDS     R5,R5,#+1
        B.N      ??spi_mosi_1
//  299 
//  300     /***************** �������һ������ *******************/
//  301     SPI_PUSHR_REG(SPIN[spin]) = (0
//  302                                  | SPI_PUSHR_CTAS(0)                 //ѡ��CTAR0�Ĵ���
//  303                                  | SPI_PUSHR_PCS(pcs)
//  304                                  | SPI_PUSHR_EOQ_MASK                //1Ϊ ����SPI��������
//  305                                  | SPI_PUSHR_TXDATA(modata[i])
//  306                                 );
??spi_mosi_2:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R6,R1,#+16
        ANDS     R6,R6,#0x3F0000
        LDRB     R7,[R5, R2]
        ORRS     R6,R7,R6
        ORRS     R6,R6,#0x8000000
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+52]
//  307 
//  308     SPI_EOQF_WAIT(spin);                                            //�ȴ�������ɡ�(Ҫ��ʱ��RX FIFO�Ķ����������Ȼ��������޵ȴ�)
??spi_mosi_6:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        LSLS     R6,R6,#+3
        BPL.N    ??spi_mosi_6
//  309 
//  310     while( !(SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));           //RFDFΪ1��Rx FIFO is not empty.
??spi_mosi_7:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        LSLS     R6,R6,#+14
        BPL.N    ??spi_mosi_7
//  311     if(midata != NULL)
        CMP      R3,#+0
        BEQ.N    ??spi_mosi_8
//  312     {
//  313         midata[i] = (uint8)SPI_POPR_REG(SPIN[spin]);                  //������յ�������
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+56]
        STRB     R6,[R5, R3]
        B.N      ??spi_mosi_9
//  314     }
//  315     else
//  316     {
//  317         SPI_POPR_REG(SPIN[spin]);
??spi_mosi_8:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+56]
//  318     }
//  319     SPI_SR_REG(SPIN[spin]) |= SPI_SR_RFDF_MASK;                     //д1���RFDF�����Rx FIFO �ǿյ�
??spi_mosi_9:
        LDR.N    R6,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R6,[R6, R0, LSL #+2]
        LDR      R6,[R6, #+44]
        ORRS     R6,R6,#0x20000
        LDR.N    R7,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R7,[R7, R0, LSL #+2]
        STR      R6,[R7, #+44]
//  320 }
        POP      {R4-R7}
        BX       LR               ;; return
//  321 
//  322 /*!
//  323  *  @brief      SPI���ͽ��պ���
//  324  *  @param      SPIn_e          SPIģ��(SPI0��SPI1��SPI2)
//  325  *  @param      SPIn_PCSn_e     Ƭѡ�ܽű��
//  326  *  @param      mocmd           ���͵����������ַ(����Ҫ������ NULL)
//  327  *  @param      micmd           ��������ʱ���յ������ݵĴ洢��ַ(����Ҫ������ NULL)
//  328  *  @param      modata          ���͵����ݻ�������ַ(����Ҫ������ NULL)
//  329  *  @param      midata          ��������ʱ���յ������ݵĴ洢��ַ(����Ҫ������ NULL)
//  330  *  @since      v5.0
//  331  *  Sample usage:           spi_mosi_cmd(SPI0,SPIn_PCS0,cmd,NULL,buff,buff,1,2);    //����cmd/buff�����ݣ�������cmd����ʱ�����ݣ�����buff����ʱ�����ݵ�buff����ȷֱ�Ϊ1��2�ֽ�
//  332  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  333 void spi_mosi_cmd(SPIn_e spin, SPI_PCSn_e pcs, uint8 *mocmd , uint8 *micmd , uint8 *modata , uint8 *midata, uint32 cmdlen , uint32 len)
//  334 {
spi_mosi_cmd:
        PUSH     {R4-R8,LR}
        LDR      R4,[SP, #+24]
        LDR      R5,[SP, #+28]
        LDR      R6,[SP, #+32]
        LDR      R7,[SP, #+36]
//  335     uint32 i = 0;
        MOVS     R12,#+0
//  336     do
//  337     {
//  338         /*************  ���־λ  ***************/
//  339         SPI_SR_REG(SPIN[spin]) = (0
//  340                                   | SPI_SR_EOQF_MASK    //���Ͷ��п��ˣ�������ϱ�־
//  341                                   | SPI_SR_TFUF_MASK    //����FIFO�����־λ��SPIΪ�ӻ�ģʽ��Tx FIFOΪ�գ����ⲿSPI����ģʽ�������䣬��־λ�ͻ���1��д1��0
//  342                                   | SPI_SR_TFFF_MASK    //����FIFO����־λ�� д1����DMA���������ִ���FIFO���˾ͻ���0�� 0��ʾTx FIFO����
//  343                                   | SPI_SR_RFOF_MASK    //����FIFO�����־λ��
//  344                                   | SPI_SR_RFDF_MASK    //����FIFO��ı�־λ��д1����DMA���������ִ���FIFO���˾ͻ���0��0��ʾRx FIFO��
//  345                                  );
??spi_mosi_cmd_0:
        LDR.W    LR,??DataTable2_7  ;; 0x1a0a0000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+44]
//  346 
//  347         /************** ��FIFO������ **************/
//  348         SPI_MCR_REG(SPIN[spin])    |=  (0
//  349                                         | SPI_MCR_CLR_TXF_MASK      //д1�� Tx FIFO ������
//  350                                         | SPI_MCR_CLR_RXF_MASK      //д1�� Rx FIFO ������
//  351                                        );
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+0]
        ORRS     LR,LR,#0xC00
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+0]
//  352 
//  353     }
//  354     while( (SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));            //��� Rx FIFO �ǿգ�����FIFO.
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        LSLS     LR,LR,#+14
        BMI.N    ??spi_mosi_cmd_0
//  355 
//  356     /***************** ����cmdlen������ *******************/                                                ;
//  357     for(i = 0; i < cmdlen; i++)
        MOVS     LR,#+0
        MOV      R12,LR
??spi_mosi_cmd_1:
        CMP      R12,R6
        BCS.N    ??spi_mosi_cmd_2
//  358     {
//  359         SPI_PUSHR_REG(SPIN[spin]) = (0
//  360                                      | SPI_PUSHR_CTAS(0)             //ѡ��CTAR0�Ĵ���
//  361                                      | SPI_PUSHR_CONT_MASK           //1Ϊ �����ڼ䱣��PCSn�ź� ����������������
//  362                                      | SPI_PUSHR_PCS(pcs)
//  363                                      | SPI_PUSHR_TXDATA(mocmd[i])    //Ҫ���������
//  364                                     );
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     LR,R1,#+16
        ANDS     LR,LR,#0x3F0000
        LDRB     R8,[R12, R2]
        ORRS     LR,R8,LR
        ORRS     LR,LR,#0x80000000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+52]
//  365 
//  366         while(!(SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));        //RFDFΪ1��Rx FIFO is not empty.
??spi_mosi_cmd_3:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        LSLS     LR,LR,#+14
        BPL.N    ??spi_mosi_cmd_3
//  367         if(micmd != NULL)
        CMP      R3,#+0
        BEQ.N    ??spi_mosi_cmd_4
//  368         {
//  369             micmd[i] = (uint8)SPI_POPR_REG(SPIN[spin]);             //������յ�������
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
        STRB     LR,[R12, R3]
        B.N      ??spi_mosi_cmd_5
//  370         }
//  371         else
//  372         {
//  373             SPI_POPR_REG(SPIN[spin]);                               //��ȡFIFO����(������ȡ��������)
??spi_mosi_cmd_4:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
//  374         }
//  375         SPI_SR_REG(SPIN[spin]) |= SPI_SR_RFDF_MASK;
??spi_mosi_cmd_5:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        ORRS     LR,LR,#0x20000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+44]
//  376     }
        ADDS     R12,R12,#+1
        B.N      ??spi_mosi_cmd_1
//  377 
//  378     /***************** ����len-1������ *******************/                                                ;
//  379     for(i = 0; i < (len - 1); i++)
??spi_mosi_cmd_2:
        MOVS     LR,#+0
        MOV      R12,LR
??spi_mosi_cmd_6:
        SUBS     LR,R7,#+1
        CMP      R12,LR
        BCS.N    ??spi_mosi_cmd_7
//  380     {
//  381         SPI_PUSHR_REG(SPIN[spin]) = (0
//  382                                      | SPI_PUSHR_CTAS(0)             //ѡ��CTAR0�Ĵ���
//  383                                      | SPI_PUSHR_CONT_MASK           //1Ϊ �����ڼ䱣��PCSn�ź� ����������������
//  384                                      | SPI_PUSHR_PCS(pcs)
//  385                                      | SPI_PUSHR_TXDATA(modata[i])     //Ҫ���������
//  386                                     );
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     LR,R1,#+16
        ANDS     LR,LR,#0x3F0000
        LDRB     R8,[R12, R4]
        ORRS     LR,R8,LR
        ORRS     LR,LR,#0x80000000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+52]
//  387 
//  388         while(!(SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));        //RFDFΪ1��Rx FIFO is not empty.
??spi_mosi_cmd_8:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        LSLS     LR,LR,#+14
        BPL.N    ??spi_mosi_cmd_8
//  389 
//  390         if(midata != NULL)
        CMP      R5,#+0
        BEQ.N    ??spi_mosi_cmd_9
//  391         {
//  392             midata[i] = (uint8)SPI_POPR_REG(SPIN[spin]);             //������յ�������
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
        STRB     LR,[R12, R5]
        B.N      ??spi_mosi_cmd_10
//  393         }
//  394         else
//  395         {
//  396             SPI_POPR_REG(SPIN[spin]);                               //��ȡFIFO����(������ȡ��������)
??spi_mosi_cmd_9:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
//  397         }
//  398         SPI_SR_REG(SPIN[spin]) |= SPI_SR_RFDF_MASK;
??spi_mosi_cmd_10:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        ORRS     LR,LR,#0x20000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+44]
//  399     }
        ADDS     R12,R12,#+1
        B.N      ??spi_mosi_cmd_6
//  400     /***************** �������һ������ *******************/
//  401     SPI_PUSHR_REG(SPIN[spin]) = (0
//  402                                  | SPI_PUSHR_CTAS(0)          //ѡ��CTAR0�Ĵ���
//  403                                  | SPI_PUSHR_PCS(pcs)
//  404                                  | SPI_PUSHR_EOQ_MASK         //End Of Queue��1Ϊ ����SPI��������
//  405                                  | SPI_PUSHR_TXDATA(modata[i])
//  406                                 );
??spi_mosi_cmd_7:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     LR,R1,#+16
        ANDS     LR,LR,#0x3F0000
        LDRB     R8,[R12, R4]
        ORRS     LR,R8,LR
        ORRS     LR,LR,#0x8000000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+52]
//  407 
//  408     SPI_EOQF_WAIT(spin);    //Ҫ��ʱ��RX FIFO�Ķ����������Ȼ��������޵ȴ�
??spi_mosi_cmd_11:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        LSLS     LR,LR,#+3
        BPL.N    ??spi_mosi_cmd_11
//  409 
//  410     while( !(SPI_SR_REG(SPIN[spin]) & SPI_SR_RFDF_MASK));    //RFDFΪ1��Rx FIFO is not empty.
??spi_mosi_cmd_12:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        LSLS     LR,LR,#+14
        BPL.N    ??spi_mosi_cmd_12
//  411     if(midata != NULL)
        CMP      R5,#+0
        BEQ.N    ??spi_mosi_cmd_13
//  412     {
//  413         midata[i] = (uint8)SPI_POPR_REG(SPIN[spin]);             //������յ�������
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
        STRB     LR,[R12, R5]
        B.N      ??spi_mosi_cmd_14
//  414     }
//  415     else
//  416     {
//  417         SPI_POPR_REG(SPIN[spin]);                               //��ȡFIFO����(������ȡ��������)
??spi_mosi_cmd_13:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+56]
//  418     }
//  419     SPI_SR_REG(SPIN[spin]) |= SPI_SR_RFDF_MASK;
??spi_mosi_cmd_14:
        LDR.W    LR,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      LR,[LR, R0, LSL #+2]
        LDR      LR,[LR, #+44]
        ORRS     LR,LR,#0x20000
        LDR.W    R8,??DataTable2_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R8,[R8, R0, LSL #+2]
        STR      LR,[R8, #+44]
//  420 }
        POP      {R4-R8,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     SPIN

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     0x1a0a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     0x803f0000

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
        DC32 2, 4, 6, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192
        DC32 16384, 32768

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 2, 3, 5, 7

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 44H, 3AH, 5CH, 53H, 74H, 75H, 64H, 79H
        DC8 5CH, 32H, 30H, 31H, 36H, 0B5H, 0E7H, 0D7H
        DC8 0D3H, 0C9H, 0E8H, 0BCH, 0C6H, 0B4H, 0F3H, 0C8H
        DC8 0FCH, 5CH, 54H, 69H, 5CH, 0B5H, 0E7H, 0C8H
        DC8 0FCH, 0B1H, 0B8H, 0D3H, 0C3H, 0B5H, 0D7H, 0B2H
        DC8 0E3H, 5CH, 43H, 68H, 69H, 70H, 5CH, 73H
        DC8 72H, 63H, 5CH, 4DH, 4BH, 36H, 30H, 5FH
        DC8 73H, 70H, 69H, 2EH, 63H, 0
        DC8 0, 0

        END
//  421 
//  422 
// 
//    12 bytes in section .data
//   132 bytes in section .rodata
// 1 644 bytes in section .text
// 
// 1 644 bytes of CODE  memory
//   132 bytes of CONST memory
//    12 bytes of DATA  memory
//
//Errors: none
//Warnings: none
