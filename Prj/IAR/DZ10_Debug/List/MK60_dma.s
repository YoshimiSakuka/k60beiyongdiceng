///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:26
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_dma.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_dma.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_dma.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN gpio_init
        EXTERN port_init

        PUBLIC dma_portx2buff_init

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_dma.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_dma.c
//   11  * @brief      DMA������
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.1
//   14  * @date       2014-04-25
//   15  */
//   16 
//   17 
//   18 
//   19 #include "common.h"
//   20 #include "MK60_port.h"
//   21 #include "MK60_gpio.h"
//   22 #include "MK60_dma.h"
//   23 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   24 static void dma_gpio_input_init(void *SADDR,uint8 BYTEs)
//   25 {
dma_gpio_input_init:
        PUSH     {R3-R9,LR}
        MOV      R8,R0
        MOVS     R4,R1
//   26     uint8 n, tmp;
//   27     uint8 ptxn;
//   28 
//   29     //SADDR ʵ���Ͼ��� GPIO�� ����Ĵ��� PDIR �ĵ�ַ
//   30     //GPIOA��GPIOB��GPIOC��GPIOD��GPIOE �ĵ�ַ �ֱ��� 0x400FF000u ��0x400FF040u ��0x400FF080u�� 0x400FF0C0u��0x400FF100u
//   31     //sizeof(GPIO_MemMap) = 0x18
//   32     //ÿ��GPIO��ַ &0x1C0 �󣬵õ� 0x000 , 0x040 , 0x080 ,0x0C0 ,0x100
//   33     //�� /0x40 ��õ� 0 �� 1 �� 2�� 3��4 ���պþ��� PTA��PTB��PTC ��PTD ��PTE
//   34     //�� *32 �͵��� PTA0��PTB0��PTC0 ��PTD0 ��PTE0
//   35     uint8 ptx0 = ((((uint32)SADDR) & 0x1C0) / 0x40 ) * 32;
        LSRS     R0,R8,#+6
        ANDS     R0,R0,#0x7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R9,R0,#+5
//   36 
//   37     //ÿ��GPIO ��Ӧ�ļĴ�����ַ�� &0x 3F ��õ���ֵ������ͬ�ġ�
//   38     //PTA_B0_IN �� GPIOA �� ����Ĵ��� PDIR �� ��ַ
//   39     // (SADDR & 0x3f - PTA_B0_IN & 0x3f) ��Ч�� (SADDR - PTA_B0_IN) & 0x3f
//   40     //������Ҫ�ɼ���λ Ϊ 0~7��8~15��16~23��24~31 ���� ����ʽ�Ӷ�Ӧ��ֵ Ϊ 0��1��2��3
//   41     //�պ���  0~7��8~15��16~23��24~31 λ�ĵ�ַƫ�ƣ��� * 8 �ͱ�� 0��8��16��24
//   42 
//   43     n = (uint8)(((uint32)SADDR - ((uint32)(&PTA_B0_IN))) & 0x3f) * 8;       //��С�����ź�
        MOV      R0,R8
        SUBS     R0,R0,#+16
        ANDS     R0,R0,#0x3F
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+3
        MOVS     R5,R0
//   44 
//   45     ptxn = ptx0 + n;
        ADDS     R0,R5,R9
        MOVS     R7,R0
//   46     tmp = ptxn + (BYTEs * 8 ) - 1;                                          //�������ź�
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R7,R4, LSL #+3
        SUBS     R0,R0,#+1
        MOVS     R6,R0
//   47     while(ptxn <= tmp)
??dma_gpio_input_init_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R6,R7
        BCC.N    ??dma_gpio_input_init_1
//   48     {
//   49         //������� GPIO ��ʼ��Ϊ����
//   50         gpio_init((PTXn_e )ptxn, GPI, 0);               //����Ϊ����
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       gpio_init
//   51         port_init((PTXn_e )ptxn , ALT1 | PULLDOWN );    //����ԴĬ������Ϊ������Ĭ�϶�ȡ������0
        MOV      R1,#+258
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       port_init
//   52         ptxn ++;
        ADDS     R7,R7,#+1
        B.N      ??dma_gpio_input_init_0
//   53     }
//   54 }
??dma_gpio_input_init_1:
        POP      {R0,R4-R9,PC}    ;; return
//   55 
//   56 /*!
//   57  *  @brief      DMA��ʼ������IO������������˿ڵ����ݵ��ڴ�
//   58  *  @param      DMA_CHn         ͨ���ţ�DMA_CH0 ~ DMA_CH15��
//   59  *  @param      SADDR           Դ��ַ( (void * )&PTx_Bn_IN �� (void * )&PTx_Wn_IN �� (void * )&PTx_IN  )
//   60  *  @param      DADDR           Ŀ�ĵ�ַ
//   61  *  @param      PTxn            �����˿�
//   62  *  @param      DMA_BYTEn       ÿ��DMA�����ֽ���
//   63  *  @param      count           һ����ѭ�������ֽ���
//   64  *  @param      cfg             DMA�������ã���DMA_cfg��ѡ��
//   65  *  @since      v5.0
//   66  *  @note       DMA PTXn����ԴĬ�������ش������䣬�����޸ģ����ʼ������� port_init ����DMA ������ʽ
//   67                 ��ʼ������Ҫ���� DMA_EN ��ʵ��
//   68  *  Sample usage:   uint8 buff[10];
//   69                     dma_portx2buff_init(DMA_CH0, PTB_B0_IN, buff, PTA7, DMA_BYTE1, 10, DADDR_RECOVER);
//   70                     //DMA��ʼ����Դ��ַ��PTB_B0_IN��Ŀ�ĵ�ַ��buff,PTA7����(Ĭ��������)��ÿ�δ���1�ֽڣ������� 10�� �����������ָ���ַ
//   71 
//   72                     port_init(PTA7,ALT1 | DMA_FALLING);             //Ĭ�ϴ���Դ�������أ��˴���Ϊ �½��ش���
//   73 
//   74                     DMA_EN(DMA_CH0);                //��Ҫʹ�� DMA ����ܴ�������
//   75  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 void dma_portx2buff_init(DMA_CHn CHn, void *SADDR, void *DADDR, PTXn_e ptxn, DMA_BYTEn byten, uint32 count, uint32 cfg)
//   77 {
dma_portx2buff_init:
        PUSH     {R3-R11,LR}
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R7,R2
        MOV      R8,R3
        LDR      R4,[SP, #+40]
        LDR      R9,[SP, #+44]
        LDR      R10,[SP, #+48]
//   78 
//   79     uint8 BYTEs = (byten == DMA_BYTE1 ? 1 : (byten == DMA_BYTE2 ? 2 : (byten == DMA_BYTE4 ? 4 : 16 ) ) ); //���㴫���ֽ���
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dma_portx2buff_init_0
        MOVS     R11,#+1
        B.N      ??dma_portx2buff_init_1
??dma_portx2buff_init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??dma_portx2buff_init_2
        MOVS     R11,#+2
        B.N      ??dma_portx2buff_init_3
??dma_portx2buff_init_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??dma_portx2buff_init_4
        MOVS     R11,#+4
        B.N      ??dma_portx2buff_init_3
??dma_portx2buff_init_4:
        MOVS     R11,#+16
//   80 
//   81     //���ԣ���⴫�ݽ��������Ƿ���ȷ
//   82     ASSERT(                                             //�ö��Լ�� Դ��ַ��ÿ�δ����ֽ����Ƿ���ȷ
//   83         (   (byten == DMA_BYTE1)                    //����һ���ֽ�
//   84             && ( (SADDR >= &PTA_B0_IN) && (SADDR <= ( &PTE_B3_IN )))
//   85         )
//   86 
//   87         || (   (byten == DMA_BYTE2)                   //���������ֽ�(ע�⣬���ܿ�˿�)
//   88                && ( (SADDR >= &PTA_B0_IN)
//   89                     && (SADDR <= ( &PTE_W1_IN ))
//   90                     && (((uint32)SADDR & 0x03) != 0x03) )         //��֤����˿�
//   91            )
//   92 
//   93         || (   (byten == DMA_BYTE4)                   //�����ĸ��ֽ�
//   94                && ((SADDR >= &PTA_B0_IN) && (SADDR <= ( &PTE_B0_IN )))
//   95                && (((uint32)SADDR & 0x03) == 0x00)           //��֤����˿�
//   96            )
//   97     );
??dma_portx2buff_init_3:
??dma_portx2buff_init_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dma_portx2buff_init_5
        LDR.N    R0,??DataTable0  ;; 0x400ff010
        CMP      R6,R0
        BCC.N    ??dma_portx2buff_init_5
        LDR.N    R0,??DataTable0_1  ;; 0x400ff113
        CMP      R0,R6
        BCS.N    ??dma_portx2buff_init_6
??dma_portx2buff_init_5:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??dma_portx2buff_init_7
        LDR.N    R0,??DataTable0  ;; 0x400ff010
        CMP      R6,R0
        BCC.N    ??dma_portx2buff_init_7
        LDR.N    R0,??DataTable0_2  ;; 0x400ff112
        CMP      R0,R6
        BCC.N    ??dma_portx2buff_init_7
        ANDS     R0,R6,#0x3
        CMP      R0,#+3
        BNE.N    ??dma_portx2buff_init_6
??dma_portx2buff_init_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??dma_portx2buff_init_8
        LDR.N    R0,??DataTable0  ;; 0x400ff010
        CMP      R6,R0
        BCC.N    ??dma_portx2buff_init_8
        LDR.N    R0,??DataTable0_3  ;; 0x400ff110
        CMP      R0,R6
        BCC.N    ??dma_portx2buff_init_8
        ANDS     R0,R6,#0x3
        CMP      R0,#+0
        BEQ.N    ??dma_portx2buff_init_6
??dma_portx2buff_init_8:
        MOVS     R1,#+97
        LDR.N    R0,??DataTable0_4
        BL       assert_failed
//   98 
//   99     ASSERT(count < 0x8000); //���ԣ����ֻ֧��0x7FFF
??dma_portx2buff_init_6:
        CMP      R9,#+32768
        BCC.N    ??dma_portx2buff_init_9
        MOVS     R1,#+99
        LDR.N    R0,??DataTable0_4
        BL       assert_failed
//  100 
//  101     //DMA �Ĵ��� ����
//  102 
//  103     /* ����ʱ�� */
//  104     SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;                        //��DMAģ��ʱ��
??dma_portx2buff_init_9:
        LDR.N    R0,??DataTable0_5  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable0_5  ;; 0x40048040
        STR      R0,[R1, #+0]
//  105 
//  106 #if defined(MK60DZ10)
//  107     SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;                     //��DMA��·������ʱ��
        LDR.N    R0,??DataTable0_6  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable0_6  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  108 #elif defined(MK60F15)
//  109     SIM_SCGC6 |= SIM_SCGC6_DMAMUX0_MASK;                    //��DMA��·������ʱ��
//  110 #endif
//  111 
//  112     /* ���� DMA ͨ�� �� ������ƿ� TCD ( Transfer Control Descriptor ) */
//  113     DMA_SADDR(CHn) =    (uint32)SADDR;                      // ����  Դ��ַ
        LDR.N    R0,??DataTable0_7  ;; 0x40009000
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        STR      R6,[R1, R0]
//  114     DMA_DADDR(CHn) =    (uint32)DADDR;                      // ����Ŀ�ĵ�ַ
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R0,R5,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        STR      R7,[R0, #+16]
//  115     DMA_SOFF(CHn)  =    0x00u;                              // ����Դ��ַƫ�� = 0x0, ������
        MOVS     R0,#+0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+4]
//  116     DMA_DOFF(CHn)  =    BYTEs;                              // ÿ�δ����Ŀ�ĵ�ַ�� BYTEs
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R0,R5,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        STRH     R11,[R0, #+20]
//  117     DMA_ATTR(CHn)  =    (0
//  118                          | DMA_ATTR_SMOD(0x0)               // Դ��ַģ����ֹ  Source address modulo feature is disabled
//  119                          | DMA_ATTR_SSIZE(byten)            // Դ����λ�� ��DMA_BYTEn  ��    SSIZE = 0 -> 8-bit ��SSIZE = 1 -> 16-bit ��SSIZE = 2 -> 32-bit ��SSIZE = 4 -> 16-byte
//  120                          | DMA_ATTR_DMOD(0x0)               // Ŀ���ַģ����ֹ
//  121                          | DMA_ATTR_DSIZE(byten)            // Ŀ������λ�� ��DMA_BYTEn  ��  ���òο�  SSIZE
//  122                         );
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+8
        ANDS     R0,R0,#0x700
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ANDS     R1,R4,#0x7
        ORRS     R0,R1,R0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+6]
//  123 
//  124     DMA_CITER_ELINKNO(CHn)  = DMA_CITER_ELINKNO_CITER(count);   //��ǰ��ѭ������
        MOV      R0,R9
        LSLS     R0,R0,#+17       ;; ZeroExtS R0,R0,#+17,#+17
        LSRS     R0,R0,#+17
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+22]
//  125     DMA_BITER_ELINKNO(CHn)  = DMA_BITER_ELINKNO_BITER(count);   //��ʼ��ѭ������
        MOV      R0,R9
        LSLS     R0,R0,#+17       ;; ZeroExtS R0,R0,#+17,#+17
        LSRS     R0,R0,#+17
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+30]
//  126 
//  127     DMA_CR &= ~DMA_CR_EMLM_MASK;                                // CR[EMLM] = 0
        LDR.N    R0,??DataTable0_8  ;; 0x40008000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x80
        LDR.N    R1,??DataTable0_8  ;; 0x40008000
        STR      R0,[R1, #+0]
//  128 
//  129     //��CR[EMLM] = 0 ʱ:
//  130     DMA_NBYTES_MLNO(CHn) =   DMA_NBYTES_MLNO_NBYTES(BYTEs); // ͨ��ÿ�δ����ֽ�������������ΪBYTEs���ֽڡ�ע��ֵΪ0��ʾ����4GB */
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R0,R5,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        STR      R11,[R0, #+8]
//  131 
//  132     /* ���� DMA ���������Ĳ��� */
//  133     DMA_SLAST(CHn)      =   0;                              //����  Դ��ַ�ĸ���ֵ,��ѭ��������ָ�  Դ��ַ
        MOVS     R0,#+0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STR      R0,[R1, #+12]
//  134     DMA_DLAST_SGA(CHn)  =   (uint32)( (cfg & DADDR_KEEPON ) == 0 ? (-count)  : 0 ); //����Ŀ�ĵ�ַ�ĸ���ֵ,��ѭ��������ָ�Ŀ�ĵ�ַ���߱��ֵ�ַ
        LSLS     R0,R10,#+31
        BMI.N    ??dma_portx2buff_init_10
        RSBS     R0,R9,#+0
        B.N      ??dma_portx2buff_init_11
??dma_portx2buff_init_10:
        MOVS     R0,#+0
??dma_portx2buff_init_11:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STR      R0,[R1, #+24]
//  135     DMA_CSR(CHn)        =   (0
//  136                              | DMA_CSR_BWC(3)               //�������,ÿ��һ�Σ�eDMA ����ֹͣ 8 �����ڣ�0��ֹͣ��1������2ֹͣ4���ڣ�3ֹͣ8���ڣ�
//  137                              | DMA_CSR_DREQ_MASK            //��ѭ��������ֹͣӲ������
//  138                              | DMA_CSR_INTMAJOR_MASK        //��ѭ������������ж�
//  139                             );
        MOVW     R0,#+49162
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LSLS     R1,R5,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        STRH     R0,[R1, #+28]
//  140 
//  141     /* ���� DMA ����Դ */
//  142 #if defined(MK60DZ10)
//  143     DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, CHn) = (0
//  144 #elif defined(MK60F15)
//  145     DMAMUX_CHCFG_REG(DMAMUX0_BASE_PTR, CHn) = (0
//  146 #endif
//  147             | DMAMUX_CHCFG_ENBL_MASK                        /* Enable routing of DMA request */
//  148             //| DMAMUX_CHCFG_TRIG_MASK                        /* Trigger Mode: Periodic   PIT���ڴ�������ģʽ   ͨ��1��ӦPIT1������ʹ��PIT1����������Ӧ��PIT��ʱ���� */
//  149             | DMAMUX_CHCFG_SOURCE( PTX(ptxn) + DMA_PORTA) /* ͨ����������Դ:     */
//  150                                              );
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        LSRS     R0,R8,#+5
        ADDS     R0,R0,#+49
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable0_9  ;; 0x40021000
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STRB     R0,[R5, R1]
//  151 
//  152     //���ô���Դ��Ĭ���� �����ش�����
//  153     port_init(ptxn, ALT1 | DMA_RISING);
        LDR.N    R1,??DataTable0_10  ;; 0x10100
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       port_init
//  154 
//  155     /*  ��������Դ   */
//  156     dma_gpio_input_init(SADDR,BYTEs);
        MOV      R1,R11
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R6
        BL       dma_gpio_input_init
//  157 
//  158     DMA_DIS(CHn);                                    //ʹ��ͨ��CHn Ӳ������
        LDR.N    R0,??DataTable0_11  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R5
        BICS     R0,R0,R1
        LDR.N    R1,??DataTable0_11  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  159     DMA_IRQ_CLEAN(CHn);
        LDR.N    R0,??DataTable0_12  ;; 0x40008024
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R5
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable0_12  ;; 0x40008024
        STR      R0,[R1, #+0]
//  160 
//  161     /* �����ж� */
//  162     //DMA_EN(CHn);                                    //ʹ��ͨ��CHn Ӳ������
//  163     //DMA_IRQ_EN(CHn);                                //����DMAͨ������
//  164 }
        POP      {R0,R4-R11,PC}   ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0x400ff113

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0x400ff112

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     0x400ff110

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_6:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_7:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_8:
        DC32     0x40008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_9:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_10:
        DC32     0x10100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_11:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_12:
        DC32     0x40008024

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
        DC8 64H, 6DH, 61H, 2EH, 63H, 0
        DC8 0, 0

        END
// 
//  64 bytes in section .rodata
// 616 bytes in section .text
// 
// 616 bytes of CODE  memory
//  64 bytes of CONST memory
//
//Errors: none
//Warnings: 7
