///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:29
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_PIT.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_PIT.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\MK60_PIT.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC pit_close
        PUBLIC pit_delay
        PUBLIC pit_init
        PUBLIC pit_time_get
        PUBLIC pit_time_start

// D:\Study\2016������ƴ���\Ti\�������õײ�\Chip\src\MK60_PIT.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       MK60_pit.c
//   11  * @brief      pit��ʱ��������
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.0
//   14  * @date       2013-08-23
//   15  */
//   16 #include "common.h"
//   17 #include  "MK60_PIT.h"     //�����жϼ�ʱ��
//   18 
//   19 /*!
//   20  *  @brief      PITn��ʱ�ж�
//   21  *  @param      PITn        ģ��ţ�PIT0~PIT3��
//   22  *  @param      cnt         ��ʱ�ж�ʱ��(��λΪbusʱ������)
//   23  *  @since      v5.0
//   24  *  Sample usage:
//   25                 pit_init(PIT0, 1000);                          //��ʱ 1000 ��busʱ�� ���ж�
//   26                 set_vector_handler(PIT0_VECTORn,pit_hander);   // �����жϷ��������ж���������
//   27                 enable_irq(PIT0_IRQn);                         // ʹ��PIT�ж�
//   28  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 void pit_init(PITn_e pitn, uint32 cnt)
//   30 {
pit_init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   31     //PIT �õ��� Bus Clock ����Ƶ��
//   32     //������� = ����Ƶ�� * ʱ��
//   33 
//   34     ASSERT( cnt > 0 );                          //�ö��Լ�� ʱ����벻��Ϊ 0
        CMP      R5,#+0
        BNE.N    ??pit_init_0
        MOVS     R1,#+34
        LDR.N    R0,??DataTable4
        BL       assert_failed
//   35 
//   36     SIM_SCGC6       |= SIM_SCGC6_PIT_MASK;          //ʹ��PITʱ��
??pit_init_0:
        LDR.N    R0,??DataTable4_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable4_1  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   37 
//   38     PIT_MCR         = (0
//   39                        //| PIT_MCR_MDIS_MASK       //����PIT��ʱ��ʱ��ѡ��0��ʾʹ��PIT��1��ʾ��ֹPIT��
//   40                        //| PIT_MCR_FRZ_MASK        //����ģʽ��ֹͣ���У�0��ʾ�������У�1��ʾֹͣ���У�
//   41                       );
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_2  ;; 0x40037000
        STR      R0,[R1, #+0]
//   42 
//   43     PIT_LDVAL(pitn)  = cnt - 1 ;                    //��������ж�ʱ��
        SUBS     R0,R5,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R2,R4,#+4
        STR      R0,[R2, R1]
//   44 
//   45     PIT_Flag_Clear(pitn);                           //���жϱ�־λ
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+12]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+12]
//   46 
//   47     PIT_TCTRL(pitn) &= ~ PIT_TCTRL_TEN_MASK;        //��ֹPITn��ʱ����������ռ���ֵ��
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+8]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   48     PIT_TCTRL(pitn)  = ( 0
//   49                          | PIT_TCTRL_TEN_MASK        //ʹ�� PITn��ʱ��
//   50                          | PIT_TCTRL_TIE_MASK        //��PITn�ж�
//   51                        );
        MOVS     R0,#+3
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   52 
//   53     //enable_irq((int)pitn + PIT0_IRQn);            //���ж�
//   54 }
        POP      {R0,R4,R5,PC}    ;; return
//   55 
//   56 /*!
//   57  *  @brief      PITn��ʱ
//   58  *  @param      PITn        ģ��ţ�PIT0~PIT3��
//   59  *  @param      cnt         ��ʱʱ��(��λΪbusʱ������)
//   60  *  @since      v5.0
//   61  *  Sample usage:
//   62                     pit_delay(PIT0, 1000);                         //��ʱ 1000 ��busʱ��
//   63  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 void pit_delay(PITn_e pitn, uint32 cnt)
//   65 {
pit_delay:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   66     //PIT �õ��� Bus Clock ����Ƶ��
//   67     //������� = ����Ƶ�� * ʱ��
//   68 
//   69     ASSERT( cnt > 0 );              //�ö��Լ�� ʱ����벻��Ϊ 0
        CMP      R5,#+0
        BNE.N    ??pit_delay_0
        MOVS     R1,#+69
        LDR.N    R0,??DataTable4
        BL       assert_failed
//   70 
//   71     SIM_SCGC6       |= SIM_SCGC6_PIT_MASK;                          //ʹ��PITʱ��
??pit_delay_0:
        LDR.N    R0,??DataTable4_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable4_1  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   72 
//   73     PIT_MCR         &= ~(PIT_MCR_MDIS_MASK | PIT_MCR_FRZ_MASK );    //ʹ��PIT��ʱ��ʱ�� ������ģʽ�¼�������
        LDR.N    R0,??DataTable4_2  ;; 0x40037000
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+2
        LSLS     R0,R0,#+2
        LDR.N    R1,??DataTable4_2  ;; 0x40037000
        STR      R0,[R1, #+0]
//   74 
//   75     PIT_TCTRL(pitn) &= ~( PIT_TCTRL_TEN_MASK );                     //����PIT ���Ա����ü���ֵ��Ч
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+8]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   76 
//   77     PIT_LDVAL(pitn)  = cnt - 1;                                     //��������ж�ʱ��
        SUBS     R0,R5,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R2,R4,#+4
        STR      R0,[R2, R1]
//   78 
//   79     PIT_Flag_Clear(pitn);                                           //���жϱ�־λ
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+12]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+12]
//   80 
//   81     PIT_TCTRL(pitn) &= ~ PIT_TCTRL_TEN_MASK;                        //��ֹPITn��ʱ����������ռ���ֵ��
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+8]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   82     PIT_TCTRL(pitn)  = ( 0
//   83                          | PIT_TCTRL_TEN_MASK                        //ʹ�� PITn��ʱ��
//   84                          //| PIT_TCTRL_TIE_MASK                      //��PITn�ж�
//   85                        );
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   86 
//   87     while( !(PIT_TFLG(pitn)& PIT_TFLG_TIF_MASK));
??pit_delay_1:
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+12]
        LSLS     R0,R0,#+31
        BPL.N    ??pit_delay_1
//   88 
//   89     PIT_Flag_Clear(pitn);                                           //���жϱ�־λ
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+12]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+12]
//   90 }
        POP      {R0,R4,R5,PC}    ;; return
//   91 
//   92 /*!
//   93  *  @brief      PITn��ʱ��ʼ
//   94  *  @param      PITn        ģ��ţ�PIT0~PIT3��
//   95  *  @since      v5.0
//   96  *  Sample usage:
//   97                     pit_time_start(PIT0);                          //PIT0��ʱ��ʼ
//   98  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   99 void pit_time_start(PITn_e pitn)
//  100 {
//  101     //PIT �õ��� Bus Clock ����Ƶ��
//  102     //������� = ����Ƶ�� * ʱ��
//  103 
//  104     SIM_SCGC6       |= SIM_SCGC6_PIT_MASK;                          //ʹ��PITʱ��
pit_time_start:
        LDR.N    R1,??DataTable4_1  ;; 0x4004803c
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x800000
        LDR.N    R2,??DataTable4_1  ;; 0x4004803c
        STR      R1,[R2, #+0]
//  105 
//  106     PIT_MCR         &= ~(PIT_MCR_MDIS_MASK | PIT_MCR_FRZ_MASK );    //ʹ��PIT��ʱ��ʱ�� ������ģʽ�¼�������
        LDR.N    R1,??DataTable4_2  ;; 0x40037000
        LDR      R1,[R1, #+0]
        LSRS     R1,R1,#+2
        LSLS     R1,R1,#+2
        LDR.N    R2,??DataTable4_2  ;; 0x40037000
        STR      R1,[R2, #+0]
//  107 
//  108     PIT_TCTRL(pitn) &= ~( PIT_TCTRL_TEN_MASK );                     //����PIT ���Ա����ü���ֵ��Ч
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//  109 
//  110     PIT_LDVAL(pitn)  = ~0;                                          //��������ж�ʱ��
        MOVS     R1,#-1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R3,R0,#+4
        STR      R1,[R3, R2]
//  111 
//  112     PIT_Flag_Clear(pitn);                                           //���жϱ�־λ
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+12]
        ORRS     R1,R1,#0x1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+12]
//  113 
//  114     PIT_TCTRL(pitn) &= ~ PIT_TCTRL_TEN_MASK;                        //��ֹPITn��ʱ����������ռ���ֵ��
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//  115     PIT_TCTRL(pitn)  = ( 0
//  116                          | PIT_TCTRL_TEN_MASK                        //ʹ�� PITn��ʱ��
//  117                          //| PIT_TCTRL_TIE_MASK                      //��PITn�ж�
//  118                        );
        MOVS     R1,#+1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//  119 }
        BX       LR               ;; return
//  120 
//  121 /*!
//  122  *  @brief      ��ȡ PITn��ʱʱ��(��ʱʱ��ر� ��ʱ��)
//  123  *  @param      PITn        ģ��ţ�PIT0~PIT3��
//  124  *  @since      v5.0
//  125  *  Sample usage:
//  126                         uint32 time = pit_time_get(PIT0);                         //��ȡ PITn��ʱʱ��
//  127                         if(time != ~0)       //û��ʱ
//  128                         {
//  129                             printf("\n��ʱʱ��Ϊ��%d us",time*1000/bus_clk_khz);
//  130                         }
//  131  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 uint32 pit_time_get(PITn_e pitn)
//  133 {
pit_time_get:
        MOVS     R1,R0
//  134     uint32 val;
//  135 
//  136     val = (~0) - PIT_CVAL(pitn);
        MOVS     R0,#-1
        LDR.N    R3,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R3,R3,R1, LSL #+4
        LDR      R3,[R3, #+4]
        SUBS     R0,R0,R3
        MOVS     R2,R0
//  137 
//  138     if(PIT_TFLG(pitn)& PIT_TFLG_TIF_MASK)                           //�ж��Ƿ�ʱ�䳬ʱ
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R0,R0,R1, LSL #+4
        LDR      R0,[R0, #+12]
        LSLS     R0,R0,#+31
        BPL.N    ??pit_time_get_0
//  139     {
//  140         PIT_Flag_Clear(pitn);                                       //���жϱ�־λ
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R0,R0,R1, LSL #+4
        LDR      R0,[R0, #+12]
        ORRS     R0,R0,#0x1
        LDR.N    R3,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R3,R3,R1, LSL #+4
        STR      R0,[R3, #+12]
//  141         PIT_TCTRL(pitn) &= ~ PIT_TCTRL_TEN_MASK;                    //��ֹPITn��ʱ����������ռ���ֵ��
        LDR.N    R0,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R0,R0,R1, LSL #+4
        LDR      R0,[R0, #+8]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R3,??DataTable4_3  ;; 0x40037100
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R3,R3,R1, LSL #+4
        STR      R0,[R3, #+8]
//  142         return ~0;
        MOVS     R0,#-1
        B.N      ??pit_time_get_1
//  143     }
//  144 
//  145     if(val == (~0))
??pit_time_get_0:
        CMN      R2,#+1
        BNE.N    ??pit_time_get_2
//  146     {
//  147         val--;              //ȷ�� ������ ~0
        SUBS     R2,R2,#+1
//  148     }
//  149     return val;
??pit_time_get_2:
        MOVS     R0,R2
??pit_time_get_1:
        BX       LR               ;; return
//  150 }
//  151 
//  152 /*!
//  153  *  @brief      �ر� pit
//  154  *  @param      PITn        ģ��ţ�PIT0~PIT3��
//  155  *  @since      v5.0
//  156  *  Sample usage:
//  157                         pit_close(PIT0);                         //�ر�PIT
//  158  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  159 void pit_close(PITn_e pitn)
//  160 {
//  161     PIT_Flag_Clear(pitn);                                       //���жϱ�־λ
pit_close:
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+12]
        ORRS     R1,R1,#0x1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+12]
//  162     PIT_TCTRL(pitn) &= ~ PIT_TCTRL_TEN_MASK;                    //��ֹPITn��ʱ����������ռ���ֵ��
        LDR.N    R1,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        LDR.N    R2,??DataTable4_3  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//  163 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40037000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40037100

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
        DC8 50H, 49H, 54H, 2EH, 63H, 0
        DC8 0, 0

        END
// 
//  64 bytes in section .rodata
// 572 bytes in section .text
// 
// 572 bytes of CODE  memory
//  64 bytes of CONST memory
//
//Errors: none
//Warnings: none
