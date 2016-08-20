///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:26
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_flash.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_flash.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_flash.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1
        #define SHF_WRITE 0x1
        #define SHF_EXECINSTR 0x4

        EXTERN systick_delay_ms

        PUBLIC flash_cmd
        PUBLIC flash_erase_sector
        PUBLIC flash_init
        PUBLIC flash_write
        PUBLIC flash_write_buf

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_flash.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_flash.c
//   11  * @brief      flash������
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.2
//   14  * @date       2014-10-09
//   15  */
//   16 
//   17 
//   18 //����ͷ�ļ�
//   19 
//   20 #include "MK60_flash.h"
//   21 
//   22 //�궨�� FCCOB Number
//   23 #if defined(MK60DZ10)
//   24 #define     FCMD        FTFL_FCCOB0         //FTFL ����
//   25 
//   26 #define     FADDR2      FTFL_FCCOB1         //Flash address [23:16]
//   27 #define     FADDR1      FTFL_FCCOB2         //Flash address [15:8]
//   28 #define     FADDR0      FTFL_FCCOB3         //Flash address [7:0]
//   29 
//   30 #define     FDATA0      FTFL_FCCOB4         //Data Byte 0       //ע��һ�㣬4�ֽ�����FDATA3�����λ��FDATA0�����λ
//   31 #define     FDATA1      FTFL_FCCOB5         //Data Byte 1
//   32 #define     FDATA2      FTFL_FCCOB6         //Data Byte 2
//   33 #define     FDATA3      FTFL_FCCOB7         //Data Byte 3
//   34 #define     FDATA4      FTFL_FCCOB8         //Data Byte 4
//   35 #define     FDATA5      FTFL_FCCOB9         //Data Byte 5
//   36 #define     FDATA6      FTFL_FCCOBA         //Data Byte 6
//   37 #define     FDATA7      FTFL_FCCOBB         //Data Byte 7
//   38 
//   39 //FCMD ����
//   40 #define     RD1BLK    0x00   // ������Flash
//   41 #define     RD1SEC    0x01   // ����������
//   42 #define     PGMCHK    0x02   // д����
//   43 #define     RDRSRC    0x03   // ��Ŀ������(4�ֽ�)
//   44 #define     PGM4      0x06   // д�볤��(4�ֽ�)
//   45 #define     ERSBLK    0x08   // ��������Flash
//   46 #define     ERSSCR    0x09   // ����Flash����
//   47 #define     PGMSEC    0x0B   // д������
//   48 #define     RD1ALL    0x40   // �����еĿ�
//   49 #define     RDONCE    0x41   // ֻ��һ��
//   50 #define     PGMONCE   0x43   // ֻдһ��
//   51 #define     ERSALL    0x44   // �������п�
//   52 #define     VFYKEY    0x45   // ��֤���ŷ���Կ��
//   53 #define     PGMPART   0x80   // д�����
//   54 #define     SETRAM    0x81   // �趨FlexRAM����
//   55 
//   56 #elif defined(MK60F15)
//   57 #define     FCMD        FTFE_FCCOB0         //FTFL ����
//   58 
//   59 #define     FADDR2      FTFE_FCCOB1         //Flash address [23:16]
//   60 #define     FADDR1      FTFE_FCCOB2         //Flash address [15:8]
//   61 #define     FADDR0      FTFE_FCCOB3         //Flash address [7:0]
//   62 //Must be 64-bit aligned (Flash address [2:0] = 000)  8�ֽڶ���
//   63 
//   64 #define     FDATA0      FTFE_FCCOB4         //Data Byte 0       //ע��һ�㣬4�ֽ�����FDATA3�����λ��FDATA0�����λ
//   65 #define     FDATA1      FTFE_FCCOB5         //Data Byte 1
//   66 #define     FDATA2      FTFE_FCCOB6         //Data Byte 2
//   67 #define     FDATA3      FTFE_FCCOB7         //Data Byte 3
//   68 #define     FDATA4      FTFE_FCCOB8         //Data Byte 4
//   69 #define     FDATA5      FTFE_FCCOB9         //Data Byte 5
//   70 #define     FDATA6      FTFE_FCCOBA         //Data Byte 6
//   71 #define     FDATA7      FTFE_FCCOBB         //Data Byte 7
//   72 
//   73 //FCMD ����
//   74 #define     RD1BLK    0x00   // ������Flash
//   75 #define     RD1SEC    0x01   // ����������
//   76 #define     PGMCHK    0x02   // д����
//   77 #define     RDRSRC    0x03   // ��Ŀ������(8�ֽ�)
//   78 #define     PGM8      0x07   // д�볤��(8�ֽ�)
//   79 #define     ERSBLK    0x08   // ��������Flash
//   80 #define     ERSSCR    0x09   // ����Flash����
//   81 #define     PGMSEC    0x0B   // д������
//   82 #define     RD1ALL    0x40   // �����еĿ�
//   83 #define     RDONCE    0x41   // ֻ��һ��
//   84 #define     PGMONCE   0x43   // ֻдһ��
//   85 #define     ERSALL    0x44   // �������п�
//   86 #define     VFYKEY    0x45   // ��֤���ŷ���Կ��
//   87 #define     PGMPART   0x80   // д�����
//   88 #define     SETRAM    0x81   // �趨FlexRAM����
//   89 
//   90 #endif
//   91 
//   92 
//   93 
//   94 /*!
//   95  *  @brief      Flash����
//   96  *  @return     ����ִ�н��(1�ɹ���0ʧ��)
//   97  *  @since      v5.0
//   98  */

        SECTION `.textrw`:CODE:NOROOT(1)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//   99 __RAMFUNC uint8 flash_cmd()
//  100 {
//  101     //д FTFL_FSTAT ���� Flash����
//  102 #if defined(MK60DZ10)
//  103     FTFL_FSTAT =    (0
//  104                      |  FTFL_FSTAT_CCIF_MASK        // ָ����ɱ�־(д1��0)
//  105                      |  FTFL_FSTAT_RDCOLERR_MASK    // ����ͻ�����־(д1��0)
//  106                      |  FTFL_FSTAT_ACCERR_MASK      // ���ʴ����־λ(д1��0)
//  107                      |  FTFL_FSTAT_FPVIOL_MASK      // �Ƿ����ʱ�����־λ(д1��0)
//  108                     );
flash_cmd:
        MOVS     R0,#+240
        LDR.N    R1,??DataTable4  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  109 
//  110     while(!(FTFL_FSTAT & FTFL_FSTAT_CCIF_MASK));    // �ȴ��������
??flash_cmd_0:
        LDR.N    R0,??DataTable4  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??flash_cmd_0
//  111 
//  112     // �������־
//  113     if( FTFL_FSTAT & (FTFL_FSTAT_ACCERR_MASK | FTFL_FSTAT_RDCOLERR_MASK | FTFL_FSTAT_FPVIOL_MASK | FTFL_FSTAT_MGSTAT0_MASK))
        LDR.N    R0,??DataTable4  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+113
        TST      R0,R1
        BEQ.N    ??flash_cmd_1
//  114     {
//  115         return 0 ;                                  //ִ���������
        MOVS     R0,#+0
        B.N      ??flash_cmd_2
//  116     }
//  117     else
//  118     {
//  119         return 1;                                   //ִ������ɹ�
??flash_cmd_1:
        MOVS     R0,#+1
??flash_cmd_2:
        BX       LR               ;; return
//  120     }
//  121 
//  122 #elif defined(MK60F15)
//  123     FTFE_FSTAT =    (0
//  124                      |  FTFE_FSTAT_CCIF_MASK        // ָ����ɱ�־(д1��0)
//  125                      |  FTFE_FSTAT_RDCOLERR_MASK    // ����ͻ�����־(д1��0)
//  126                      |  FTFE_FSTAT_ACCERR_MASK      // ���ʴ����־λ(д1��0)
//  127                      |  FTFE_FSTAT_FPVIOL_MASK      // �Ƿ����ʱ�����־λ(д1��0)
//  128                     );
//  129 
//  130     while(!(FTFE_FSTAT & FTFE_FSTAT_CCIF_MASK));    // �ȴ��������
//  131 
//  132     // �������־
//  133     if( FTFE_FSTAT & (FTFE_FSTAT_ACCERR_MASK | FTFE_FSTAT_RDCOLERR_MASK | FTFE_FSTAT_FPVIOL_MASK | FTFE_FSTAT_MGSTAT0_MASK))
//  134     {
//  135         return 0 ;                                  //ִ���������
//  136     }
//  137     else
//  138     {
//  139         return 1;                                   //ִ������ɹ�
//  140     }
//  141 
//  142 #endif
//  143 }
//  144 
//  145 
//  146 /*!
//  147  *  @brief      ��ʼ��flash
//  148  *  @since      v5.0
//  149  */

        SECTION `.textrw`:CODE:NOROOT(1)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//  150 __RAMFUNC void flash_init(void)
//  151 {
flash_init:
        PUSH     {R7,LR}
//  152 #if defined( MK60DZ10)
//  153     // ���FlashԤ��ȡ������
//  154     FMC_PFB0CR |= FMC_PFB0CR_S_B_INV_MASK;      //
        LDR.N    R0,??DataTable4_1  ;; 0x4001f004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80000
        LDR.N    R1,??DataTable4_1  ;; 0x4001f004
        STR      R0,[R1, #+0]
//  155     FMC_PFB1CR |= FMC_PFB0CR_S_B_INV_MASK;
        LDR.N    R0,??DataTable4_2  ;; 0x4001f008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80000
        LDR.N    R1,??DataTable4_2  ;; 0x4001f008
        STR      R0,[R1, #+0]
//  156 
//  157     while(!(FTFL_FSTAT & FTFL_FSTAT_CCIF_MASK));    // �ȴ��������
??flash_init_0:
        LDR.N    R0,??DataTable4  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??flash_init_0
//  158 
//  159     FTFL_FSTAT =    (0
//  160                      |  FTFL_FSTAT_CCIF_MASK        // ָ����ɱ�־(д1��0)
//  161                      |  FTFL_FSTAT_RDCOLERR_MASK    // ����ͻ�����־(д1��0)
//  162                      |  FTFL_FSTAT_ACCERR_MASK      // ���ʴ����־λ(д1��0)
//  163                      |  FTFL_FSTAT_FPVIOL_MASK      // �Ƿ����ʱ�����־λ(д1��0)
//  164                     );
        MOVS     R0,#+240
        LDR.N    R1,??DataTable4  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  165 
//  166 #elif defined(MK60F15)
//  167     // ���FlashԤ��ȡ������
//  168     FMC_PFB01CR |= FMC_PFB01CR_S_B_INV_MASK;      //
//  169     //FMC_PFB23CR |= FMC_PFB23CR_S_B_INV_MASK;
//  170 
//  171     while(!(FTFE_FSTAT & FTFE_FSTAT_CCIF_MASK));    // �ȴ��������
//  172 
//  173     FTFE_FSTAT =    (0
//  174                      |  FTFE_FSTAT_CCIF_MASK        // ָ����ɱ�־(д1��0)
//  175                      |  FTFE_FSTAT_RDCOLERR_MASK    // ����ͻ�����־(д1��0)
//  176                      |  FTFE_FSTAT_ACCERR_MASK      // ���ʴ����־λ(д1��0)
//  177                      |  FTFE_FSTAT_FPVIOL_MASK      // �Ƿ����ʱ�����־λ(д1��0)
//  178                     );
//  179 #endif
//  180     DELAY_MS(10);
        MOVS     R0,#+10
        BL       systick_delay_ms
//  181 }
        POP      {R0,PC}          ;; return
//  182 
//  183 /*!
//  184  *  @brief      ����ָ��flash����
//  185  *  @param      sector_num    �����ţ�K60N512ʵ��ʹ��0~255��
//  186  *  @return     ִ�н��(1�ɹ���0ʧ��)
//  187  *  @since      v5.0
//  188  *  Sample usage:       flash_erase_sector(127);        //��������127
//  189  */

        SECTION `.textrw`:CODE:NOROOT(1)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//  190 __RAMFUNC uint8 flash_erase_sector(uint16 sector_num)
//  191 {
flash_erase_sector:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  192     uint32 addr = sector_num * FLASH_SECTOR_SIZE;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOV      R0,#+2048
        MUL      R0,R0,R4
        STR      R0,[SP, #+0]
//  193 
//  194     // ���ò�������
//  195     FCMD = ERSSCR;
        MOVS     R0,#+9
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//  196 
//  197     // ����Ŀ���ַ
//  198     FADDR2 = ((Dtype *)&addr)->B[2];
        LDRB     R0,[SP, #+2]
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//  199     FADDR1 = ((Dtype *)&addr)->B[1];
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//  200     FADDR0 = ((Dtype *)&addr)->B[0];
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//  201 
//  202     if(flash_cmd() == 0)
        BL       flash_cmd
        CMP      R0,#+0
        BNE.N    ??flash_erase_sector_0
//  203     {
//  204         return 0;
        MOVS     R0,#+0
        B.N      ??flash_erase_sector_1
//  205     }
//  206 
//  207     if(sector_num == 0)
??flash_erase_sector_0:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BNE.N    ??flash_erase_sector_2
//  208     {
//  209 #if defined(MK60DZ10)
//  210         return flash_write(sector_num,0x00040C,0xFFFFFFFE);
        MVNS     R2,#+1
        MOVW     R1,#+1036
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       flash_write
        B.N      ??flash_erase_sector_1
//  211 #elif defined(MK60F15)
//  212         return flash_write(sector_num,0x000408,0xFFFFFFFEFFFFFFFF );
//  213 #endif
//  214     }
//  215 
//  216     return 1;
??flash_erase_sector_2:
        MOVS     R0,#+1
??flash_erase_sector_1:
        POP      {R1,R2,R4,PC}    ;; return
//  217 }
//  218 
//  219 
//  220 /*!
//  221  *  @brief      д�볤�ֽ����ݵ� flashָ����ַ
//  222  *  @param      sector_num      �����ţ�0 ~ FLASH_SECTOR_NUM��
//  223  *  @param      offset          д�������ڲ�ƫ�Ƶ�ַ��0~2043 �� 4�ı�����
//  224  *  @param      data            ��Ҫд�������
//  225  *  @return     ִ�н��(1�ɹ���0ʧ��)
//  226  *  @since      v5.0
//  227  *  Sample usage:       flash_write(127,0,0xFFFFFFFE);        //����127,ƫ�Ƶ�ַΪ0,д������:0xFFFFFFFE
//  228  */

        SECTION `.textrw`:CODE:NOROOT(1)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//  229 __RAMFUNC uint8 flash_write(uint16 sector_num, uint16 offset, FLASH_WRITE_TYPE data)
//  230 {
flash_write:
        PUSH     {R2-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  231     uint32 addr = sector_num * FLASH_SECTOR_SIZE  + offset ;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOV      R0,#+2048
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MLA      R0,R0,R4,R5
        STR      R0,[SP, #+4]
//  232     uint32 tmpdata;
//  233 
//  234     //ASSERT(offset % FLASH_ALIGN_ADDR == 0);             //ƫ��������Ϊ4�ı���
//  235     //�˴���ʾ���棬���ǰ�ȫ�ġ���
//  236     //ASSERT(offset <= FLASH_SECTOR_SIZE);                //������СΪ2K����ƫ�������벻���� 0x800
//  237     //�˴���ʾ���棬���ǰ�ȫ�ġ���
//  238 
//  239     // ����Ŀ���ַ
//  240     FADDR2 = ((Dtype *)&addr)->B[2];
        LDRB     R0,[SP, #+6]
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//  241     FADDR1 = ((Dtype *)&addr)->B[1];
        LDRB     R0,[SP, #+5]
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//  242     FADDR0 = ((Dtype *)&addr)->B[0];
        LDRB     R0,[SP, #+4]
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//  243 
//  244     // ���� ��32λ����
//  245     tmpdata = (uint32)data;
        STR      R6,[SP, #+0]
//  246 
//  247     FDATA0 = ((Dtype *)&tmpdata)->B[3];                    // ����д������
        LDRB     R0,[SP, #+3]
        LDR.N    R1,??DataTable4_7  ;; 0x4002000b
        STRB     R0,[R1, #+0]
//  248     FDATA1 = ((Dtype *)&tmpdata)->B[2];
        LDRB     R0,[SP, #+2]
        LDR.N    R1,??DataTable4_8  ;; 0x4002000a
        STRB     R0,[R1, #+0]
//  249     FDATA2 = ((Dtype *)&tmpdata)->B[1];
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable4_9  ;; 0x40020009
        STRB     R0,[R1, #+0]
//  250     FDATA3 = ((Dtype *)&tmpdata)->B[0];
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable4_10  ;; 0x40020008
        STRB     R0,[R1, #+0]
//  251 
//  252 #if defined(MK60DZ10)
//  253 
//  254     // ���ò�������
//  255     FCMD = PGM4;
        MOVS     R0,#+6
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//  256 
//  257 #elif defined(MK60F15)
//  258 
//  259     // ���ò�������
//  260     FCMD = PGM8;
//  261 
//  262     // ���� ��32λ����
//  263     tmpdata = (uint32)(data>>32);
//  264 
//  265     FDATA4 = ((Dtype *)&tmpdata)->B[3];                 // ����д������
//  266     FDATA5 = ((Dtype *)&tmpdata)->B[2];
//  267     FDATA6 = ((Dtype *)&tmpdata)->B[1];
//  268     FDATA7 = ((Dtype *)&tmpdata)->B[0];
//  269 #endif
//  270 
//  271     if(flash_cmd() == 0)
        BL       flash_cmd
        CMP      R0,#+0
        BNE.N    ??flash_write_0
//  272     {
//  273         return 0;
        MOVS     R0,#+0
        B.N      ??flash_write_1
//  274     }
//  275 
//  276     return 1;  //�ɹ�ִ��
??flash_write_0:
        MOVS     R0,#+1
??flash_write_1:
        POP      {R1,R2,R4-R6,PC}  ;; return
//  277 
//  278 }
//  279 
//  280 
//  281 /*!
//  282  *  @brief      д�����ݻ������� flashָ����ַ
//  283  *  @param      sector_num      �����ţ�K60N512ʵ��ʹ��0~255��
//  284  *  @param      offset          д�������ڲ�ƫ�Ƶ�ַ��0~2043 �� 4�ı�����
//  285  *  @param      buf             ��Ҫд������ݻ������׵�ַ
//  286  *  @return     ִ�н��(1�ɹ���0ʧ��)
//  287  *  @since      v5.0
//  288  *  Sample usage:           uint32 buff[10];
//  289                             flash_write_buf(127,0,sizeof(buff),buff);        //����127,ƫ�Ƶ�ַΪ0,д������Դ��ַ:buff,��Ŀsizeof(buff)
//  290  */
//  291 

        SECTION `.textrw`:CODE:NOROOT(1)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//  292 __RAMFUNC uint8 flash_write_buf(uint16 sector_num, uint16 offset, uint16 cnt, uint8 *buf)
//  293 {
flash_write_buf:
        PUSH     {R2-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  294     uint32  size;
//  295 
//  296     uint32  addr;
//  297     uint32  data;
//  298 
//  299     //ASSERT(offset % FLASH_ALIGN_ADDR == 0);                    //ƫ��������Ϊ4�ı���
//  300     //�˴���ʾ���棬���ǰ�ȫ��(ram��������rom�������𾯸�)
//  301     //ASSERT(offset <= FLASH_SECTOR_SIZE );                    //������СΪ2K����ƫ�������벻���� 0x800
//  302     //�˴���ʾ���棬���ǰ�ȫ��(ram��������rom�������𾯸�)
//  303 
//  304     addr = sector_num * FLASH_SECTOR_SIZE  + offset;      //�����ַ
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOV      R0,#+2048
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MLA      R0,R0,R4,R5
        STR      R0,[SP, #+0]
//  305 
//  306     // ����д������
//  307 #if defined(MK60DZ10)
//  308     FCMD = PGM4;
        MOVS     R0,#+6
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//  309 #elif defined(MK60F15)
//  310     FCMD = PGM8;
//  311 #endif
//  312 
//  313     for(size = 0; size < cnt; size += FLASH_ALIGN_ADDR )
        MOVS     R0,#+0
        MOV      R8,R0
??flash_write_buf_0:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R8,R6
        BCS.N    ??flash_write_buf_1
//  314     {
//  315 
//  316         // ����Ŀ���ַ
//  317         FADDR2 = ((Dtype *)&addr)->B[2];
        LDRB     R0,[SP, #+2]
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//  318         FADDR1 = ((Dtype *)&addr)->B[1];
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//  319         FADDR0 = ((Dtype *)&addr)->B[0];
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//  320 
//  321         // ���� ��32λ����
//  322         data =  *(uint32 *)buf;
        LDR      R0,[R7, #+0]
        STR      R0,[SP, #+4]
//  323 
//  324         FDATA0 = ((Dtype *)&data)->B[3];                    // ����д������
        LDRB     R0,[SP, #+7]
        LDR.N    R1,??DataTable4_7  ;; 0x4002000b
        STRB     R0,[R1, #+0]
//  325         FDATA1 = ((Dtype *)&data)->B[2];
        LDRB     R0,[SP, #+6]
        LDR.N    R1,??DataTable4_8  ;; 0x4002000a
        STRB     R0,[R1, #+0]
//  326         FDATA2 = ((Dtype *)&data)->B[1];
        LDRB     R0,[SP, #+5]
        LDR.N    R1,??DataTable4_9  ;; 0x40020009
        STRB     R0,[R1, #+0]
//  327         FDATA3 = ((Dtype *)&data)->B[0];
        LDRB     R0,[SP, #+4]
        LDR.N    R1,??DataTable4_10  ;; 0x40020008
        STRB     R0,[R1, #+0]
//  328 
//  329 #if defined(MK60F15)
//  330         // ���� ��32λ����
//  331         data = *(uint32 *)(buf+4);
//  332 
//  333         FDATA4 = ((Dtype *)&data)->B[3];                    // ����д������
//  334         FDATA5 = ((Dtype *)&data)->B[2];
//  335         FDATA6 = ((Dtype *)&data)->B[1];
//  336         FDATA7 = ((Dtype *)&data)->B[0];
//  337 #endif
//  338 
//  339         if(flash_cmd() == 0)
        BL       flash_cmd
        CMP      R0,#+0
        BNE.N    ??flash_write_buf_2
//  340         {
//  341             return 0;
        MOVS     R0,#+0
        B.N      ??flash_write_buf_3
//  342         }
//  343 
//  344         addr += FLASH_ALIGN_ADDR;
??flash_write_buf_2:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+0]
//  345         buf += FLASH_ALIGN_ADDR;
        ADDS     R7,R7,#+4
//  346     }
        ADDS     R8,R8,#+4
        B.N      ??flash_write_buf_0
//  347     return 1;  //�ɹ�ִ��
??flash_write_buf_1:
        MOVS     R0,#+1
??flash_write_buf_3:
        POP      {R1,R2,R4-R8,PC}  ;; return
//  348 }

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4:
        DC32     0x40020000

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_1:
        DC32     0x4001f004

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_2:
        DC32     0x4001f008

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_3:
        DC32     0x40020007

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_4:
        DC32     0x40020006

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_5:
        DC32     0x40020005

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_6:
        DC32     0x40020004

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_7:
        DC32     0x4002000b

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_8:
        DC32     0x4002000a

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_9:
        DC32     0x40020009

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE
        DATA
??DataTable4_10:
        DC32     0x40020008

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  349 
// 
// 448 bytes in section .textrw
// 
// 448 bytes of CODE memory
//
//Errors: none
//Warnings: 1
