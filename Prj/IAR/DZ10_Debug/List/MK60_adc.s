///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:25
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_adc.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_adc.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_adc.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN port_init

        PUBLIC ADCN
        PUBLIC adc_init
        PUBLIC adc_once
        PUBLIC adc_stop

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_adc.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_adc.c
//   11  * @brief      ADC函数
//   12  * @author     山外科技
//   13  * @version    v5.1
//   14  * @date       2014-01-16
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_adc.h"
//   19 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20 ADC_MemMapPtr ADCN[2] = {ADC0_BASE_PTR, ADC1_BASE_PTR}; //定义两个指针数组保存 ADCN 的地址
ADCN:
        DATA
        DC32 4003B000H, 400BB000H
//   21 
//   22 static void     adc_start   (ADCn_Ch_e, ADC_nbit);    //开始adc转换
//   23 
//   24 /*!
//   25  *  @brief      ADC初始化
//   26  *  @param      ADCn_Ch_e    ADC通道
//   27  *  @since      v5.0
//   28  *  @note       此初始化仅支持软件触发，不是每个通道都支持ADC 软件触发，
//   29                 具体说明见 ADCn_Ch_e 的注释说明
//   30  *  Sample usage:       adc_init (ADC0_SE10 );    //初始化 ADC0_SE10 ，使用 PTA7 管脚
//   31  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   32 void adc_init(ADCn_Ch_e adcn_ch)
//   33 {
adc_init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   34 
//   35     uint8 adcn = adcn_ch >> 5 ;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSRS     R5,R4,#+5
//   36     //uint8 ch = adcn_ch & 0x1F;
//   37 
//   38     switch(adcn)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??adc_init_0
        CMP      R5,#+1
        BEQ.N    ??adc_init_1
        B.N      ??adc_init_2
//   39     {
//   40     case ADC0:       /*   ADC0  */
//   41         SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK );        //开启ADC0时钟
??adc_init_0:
        LDR.N    R0,??DataTable3  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable3  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   42         SIM_SOPT7 &= ~(SIM_SOPT7_ADC0ALTTRGEN_MASK  | SIM_SOPT7_ADC0PRETRGSEL_MASK);
        LDR.N    R0,??DataTable3_1  ;; 0x40048018
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x90
        LDR.N    R1,??DataTable3_1  ;; 0x40048018
        STR      R0,[R1, #+0]
//   43         SIM_SOPT7 |= SIM_SOPT7_ADC0TRGSEL(0);  // PDB 外部触发引脚输入 (PDB0_EXTRG)
        LDR.N    R0,??DataTable3_1  ;; 0x40048018
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_1  ;; 0x40048018
        STR      R0,[R1, #+0]
//   44 
//   45         break;
        B.N      ??adc_init_3
//   46     case ADC1:       /*   ADC1    */
//   47         SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK );
??adc_init_1:
        LDR.N    R0,??DataTable3_2  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable3_2  ;; 0x40048030
        STR      R0,[R1, #+0]
//   48         SIM_SOPT7 &= ~(SIM_SOPT7_ADC1ALTTRGEN_MASK  | SIM_SOPT7_ADC1PRETRGSEL_MASK) ;
        LDR.N    R0,??DataTable3_1  ;; 0x40048018
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x9000
        LDR.N    R1,??DataTable3_1  ;; 0x40048018
        STR      R0,[R1, #+0]
//   49         SIM_SOPT7 |= SIM_SOPT7_ADC1TRGSEL(0);
        LDR.N    R0,??DataTable3_1  ;; 0x40048018
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_1  ;; 0x40048018
        STR      R0,[R1, #+0]
//   50         break;
        B.N      ??adc_init_3
//   51     default:
//   52         ASSERT(0);
??adc_init_2:
        MOVS     R1,#+52
        LDR.N    R0,??DataTable3_3
        BL       assert_failed
//   53     }
//   54 
//   55     switch(adcn_ch)
??adc_init_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R0,R4
        CMP      R0,#+0
        BEQ.W    ??adc_init_4
        CMP      R0,#+1
        BEQ.W    ??adc_init_4
        CMP      R0,#+3
        BEQ.W    ??adc_init_4
        CMP      R0,#+8
        BEQ.N    ??adc_init_5
        CMP      R0,#+9
        BEQ.N    ??adc_init_6
        CMP      R0,#+10
        BEQ.N    ??adc_init_7
        CMP      R0,#+11
        BEQ.N    ??adc_init_8
        CMP      R0,#+12
        BEQ.N    ??adc_init_9
        CMP      R0,#+13
        BEQ.N    ??adc_init_10
        CMP      R0,#+14
        BEQ.N    ??adc_init_11
        CMP      R0,#+15
        BEQ.N    ??adc_init_12
        CMP      R0,#+16
        BEQ.N    ??adc_init_4
        CMP      R0,#+17
        BEQ.N    ??adc_init_13
        CMP      R0,#+18
        BEQ.N    ??adc_init_14
        CMP      R0,#+19
        BEQ.N    ??adc_init_4
        CMP      R0,#+20
        BEQ.N    ??adc_init_4
        CMP      R0,#+26
        BEQ.N    ??adc_init_4
        CMP      R0,#+29
        BEQ.N    ??adc_init_4
        CMP      R0,#+30
        BEQ.N    ??adc_init_4
        CMP      R0,#+32
        BEQ.N    ??adc_init_15
        CMP      R0,#+33
        BEQ.N    ??adc_init_15
        CMP      R0,#+35
        BEQ.N    ??adc_init_15
        CMP      R0,#+36
        BEQ.N    ??adc_init_16
        CMP      R0,#+37
        BEQ.N    ??adc_init_17
        CMP      R0,#+38
        BEQ.N    ??adc_init_18
        CMP      R0,#+39
        BEQ.N    ??adc_init_19
        CMP      R0,#+40
        BEQ.N    ??adc_init_20
        CMP      R0,#+41
        BEQ.N    ??adc_init_21
        CMP      R0,#+42
        BEQ.N    ??adc_init_22
        CMP      R0,#+43
        BEQ.N    ??adc_init_23
        CMP      R0,#+44
        BEQ.N    ??adc_init_24
        CMP      R0,#+45
        BEQ.N    ??adc_init_25
        CMP      R0,#+46
        BEQ.N    ??adc_init_26
        CMP      R0,#+47
        BEQ.N    ??adc_init_27
        CMP      R0,#+48
        BEQ.W    ??adc_init_28
        CMP      R0,#+49
        BEQ.N    ??adc_init_29
        CMP      R0,#+50
        BEQ.W    ??adc_init_28
        CMP      R0,#+51
        BEQ.N    ??adc_init_28
        CMP      R0,#+52
        BEQ.N    ??adc_init_28
        CMP      R0,#+58
        BEQ.N    ??adc_init_28
        CMP      R0,#+61
        BEQ.N    ??adc_init_28
        CMP      R0,#+62
        BEQ.N    ??adc_init_28
        B.N      ??adc_init_30
//   56     {
//   57     case ADC0_SE8:       // PTB0
//   58         port_init(PTB0, ALT0);
??adc_init_5:
        MOVS     R1,#+0
        MOVS     R0,#+32
        BL       port_init
//   59         break;
        B.N      ??adc_init_31
//   60     case ADC0_SE9:       // PTB1
//   61         port_init(PTB1, ALT0);
??adc_init_6:
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       port_init
//   62         break;
        B.N      ??adc_init_31
//   63     case ADC0_SE10:      // PTA7
//   64         port_init(PTA7, ALT0);
??adc_init_7:
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       port_init
//   65         break;
        B.N      ??adc_init_31
//   66     case ADC0_SE11:      // PTA8
//   67         port_init(PTA8, ALT0);
??adc_init_8:
        MOVS     R1,#+0
        MOVS     R0,#+8
        BL       port_init
//   68         break;
        B.N      ??adc_init_31
//   69     case ADC0_SE12:      // PTB2
//   70         port_init(PTB2, ALT0);
??adc_init_9:
        MOVS     R1,#+0
        MOVS     R0,#+34
        BL       port_init
//   71         break;
        B.N      ??adc_init_31
//   72     case ADC0_SE13:      // PTB3
//   73         port_init(PTB3, ALT0);
??adc_init_10:
        MOVS     R1,#+0
        MOVS     R0,#+35
        BL       port_init
//   74         break;
        B.N      ??adc_init_31
//   75     case ADC0_SE14:      // PTC0
//   76         port_init(PTC0, ALT0);
??adc_init_11:
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       port_init
//   77         break;
        B.N      ??adc_init_31
//   78     case ADC0_SE15:      // PTC1
//   79         port_init(PTC1, ALT0);
??adc_init_12:
        MOVS     R1,#+0
        MOVS     R0,#+65
        BL       port_init
//   80         break;
        B.N      ??adc_init_31
//   81     case ADC0_SE17:      // PTE24
//   82         port_init(PTE24, ALT0);
??adc_init_13:
        MOVS     R1,#+0
        MOVS     R0,#+152
        BL       port_init
//   83         break;
        B.N      ??adc_init_31
//   84     case ADC0_SE18:      // PTE25
//   85         port_init(PTE25, ALT0);
??adc_init_14:
        MOVS     R1,#+0
        MOVS     R0,#+153
        BL       port_init
//   86         break;
        B.N      ??adc_init_31
//   87 
//   88     case ADC0_DP0:
//   89     case ADC0_DP1:
//   90     case ADC0_DP3:
//   91     case ADC0_DM0:       // ADC0_DM0
//   92     case ADC0_DM1:       // ADC0_DM1
//   93     case ADC0_SE16:      // ADC0_SE16
//   94     case Temp0_Sensor:   // Temperature Sensor,内部温度测量，可用ADC函数
//   95     case VREFH0:         // 参考高电压,可用ADC函数 ,结果恒为 2^n-1
//   96     case VREFL0:         // 参考低电压,可用ADC函数 ,结果恒为 0
//   97         break;          //这部分管脚不用配置复用
??adc_init_4:
        B.N      ??adc_init_31
//   98 
//   99         // ---------------------------------ADC1-------------------------
//  100     case ADC1_DP0:
//  101     case ADC1_DP1:
//  102     case ADC1_DP3:
//  103         break;
??adc_init_15:
        B.N      ??adc_init_31
//  104     case ADC1_SE4a:      // PTE0
//  105         port_init(PTE0, ALT0);
??adc_init_16:
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       port_init
//  106         break;
        B.N      ??adc_init_31
//  107     case ADC1_SE5a:      // PTE1
//  108         port_init(PTE1, ALT0);
??adc_init_17:
        MOVS     R1,#+0
        MOVS     R0,#+129
        BL       port_init
//  109         break;
        B.N      ??adc_init_31
//  110     case ADC1_SE6a:      // PTE2
//  111         port_init(PTE2, ALT0);
??adc_init_18:
        MOVS     R1,#+0
        MOVS     R0,#+130
        BL       port_init
//  112         break;
        B.N      ??adc_init_31
//  113     case ADC1_SE7a:      // PTE3
//  114         port_init(PTE3, ALT0);
??adc_init_19:
        MOVS     R1,#+0
        MOVS     R0,#+131
        BL       port_init
//  115         break;
        B.N      ??adc_init_31
//  116 
//  117     case ADC1_SE8:       // PTB0
//  118         port_init(PTB0, ALT0);
??adc_init_20:
        MOVS     R1,#+0
        MOVS     R0,#+32
        BL       port_init
//  119         break;
        B.N      ??adc_init_31
//  120     case ADC1_SE9:       // PTB1
//  121         port_init(PTB1, ALT0);
??adc_init_21:
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       port_init
//  122         break;
        B.N      ??adc_init_31
//  123     case ADC1_SE10:      // PTB4
//  124         port_init(PTB4, ALT0);
??adc_init_22:
        MOVS     R1,#+0
        MOVS     R0,#+36
        BL       port_init
//  125         break;
        B.N      ??adc_init_31
//  126     case ADC1_SE11:      // PTB5
//  127         port_init(PTB5, ALT0);
??adc_init_23:
        MOVS     R1,#+0
        MOVS     R0,#+37
        BL       port_init
//  128         break;
        B.N      ??adc_init_31
//  129     case ADC1_SE12:      // PTB6
//  130         port_init(PTB6, ALT0);
??adc_init_24:
        MOVS     R1,#+0
        MOVS     R0,#+38
        BL       port_init
//  131         break;
        B.N      ??adc_init_31
//  132     case ADC1_SE13:      // PTB7
//  133         port_init(PTB7, ALT0);
??adc_init_25:
        MOVS     R1,#+0
        MOVS     R0,#+39
        BL       port_init
//  134         break;
        B.N      ??adc_init_31
//  135     case ADC1_SE14:      // PTB10
//  136         port_init(PTB10, ALT0);
??adc_init_26:
        MOVS     R1,#+0
        MOVS     R0,#+42
        BL       port_init
//  137         break;
        B.N      ??adc_init_31
//  138     case ADC1_SE15:      // PTB11
//  139         port_init(PTB11, ALT0);
??adc_init_27:
        MOVS     R1,#+0
        MOVS     R0,#+43
        BL       port_init
//  140         break;
        B.N      ??adc_init_31
//  141     case ADC1_SE17:      // PTA17
//  142         port_init(PTA17, ALT0);
??adc_init_29:
        MOVS     R1,#+0
        MOVS     R0,#+17
        BL       port_init
//  143         break;
        B.N      ??adc_init_31
//  144 
//  145     case ADC1_SE16:      // ADC1_SE16
//  146     case VREF_OUTPUT:    // VREF Output
//  147     case ADC1_DM0:       // ADC1_DM0
//  148     case ADC1_DM1:       // ADC1_DM1
//  149     case Temp1_Sensor:
//  150     case VREFH1:         // 参考高电压,可用ADC函数 ,结果恒为 2^n-1
//  151     case VREFL1:         // 参考低电压,可用ADC函数 ,结果恒为 0
//  152         break;
??adc_init_28:
        B.N      ??adc_init_31
//  153 
//  154     default:
//  155         ASSERT(0);      //断言，传递的管脚不支持 ADC 单端软件触发，请换 其他管脚
??adc_init_30:
        MOVS     R1,#+155
        LDR.N    R0,??DataTable3_3
        BL       assert_failed
//  156         break;
//  157     }
//  158 }
??adc_init_31:
        POP      {R0,R4,R5,PC}    ;; return
//  159 
//  160 /*!
//  161  *  @brief      获取ADC采样值(不支持B通道)
//  162  *  @param      ADCn_Ch_e    ADC通道
//  163  *  @param      ADC_nbit     ADC精度（ ADC_8bit,ADC_12bit, ADC_10bit, ADC_16bit ）
//  164  *  @return     采样值
//  165  *  @since      v5.0
//  166  *  Sample usage:       uint16 var = adc_once(ADC0_SE10, ADC_8bit);
//  167  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  168 uint16 adc_once(ADCn_Ch_e adcn_ch, ADC_nbit bit) //采集某路模拟量的AD值
//  169 {
adc_once:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  170     ADCn_e adcn = (ADCn_e)(adcn_ch >> 5) ;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSRS     R6,R4,#+5
//  171 
//  172     uint16 result = 0;
        MOVS     R7,#+0
//  173 
//  174     adc_start(adcn_ch, bit);      //启动ADC转换
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       adc_start
//  175 
//  176     while (( ADC_SC1_REG(ADCN[adcn], 0 ) & ADC_SC1_COCO_MASK ) != ADC_SC1_COCO_MASK);   //只支持 A通道
??adc_once_0:
        LDR.N    R0,??DataTable3_4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??adc_once_0
//  177     result = ADC_R_REG(ADCN[adcn], 0);
        LDR.N    R0,??DataTable3_4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        LDR      R0,[R0, #+16]
        MOVS     R7,R0
//  178     ADC_SC1_REG(ADCN[adcn], 0) &= ~ADC_SC1_COCO_MASK;
        LDR.N    R0,??DataTable3_4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R0,[R0, R6, LSL #+2]
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x80
        LDR.N    R1,??DataTable3_4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDR      R1,[R1, R6, LSL #+2]
        STR      R0,[R1, #+0]
//  179     return result;
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R1,R4-R7,PC}    ;; return
//  180 }
//  181 
//  182 /*!
//  183  *  @brief      启动ADC软件采样(不支持B通道)
//  184  *  @param      ADCn_Ch_e    ADC通道
//  185  *  @param      ADC_nbit     ADC精度（ ADC_8bit,ADC_12bit, ADC_10bit, ADC_16bit ）
//  186  *  @since      v5.0
//  187  *  @note       此函数内部调用，启动后即可等待数据采集完成
//  188  *  Sample usage:       adc_start(ADC0_SE10, ADC_8bit);
//  189  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  190 void adc_start(ADCn_Ch_e adcn_ch, ADC_nbit bit)
//  191 {
adc_start:
        PUSH     {R4,R5}
//  192     ADCn_e adcn = (ADCn_e)(adcn_ch >> 5) ;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R2,R0,#+5
//  193     uint8 ch = (uint8)(adcn_ch & 0x1F);
        ANDS     R3,R0,#0x1F
//  194 
//  195     //初始化ADC默认配置
//  196     ADC_CFG1_REG(ADCN[adcn]) = (0
//  197                                 //| ADC_CFG1_ADLPC_MASK         //ADC功耗配置，0为正常功耗，1为低功耗
//  198                                 | ADC_CFG1_ADIV(2)              //时钟分频选择,分频系数为 2^n,2bit
//  199                                 | ADC_CFG1_ADLSMP_MASK          //采样时间配置，0为短采样时间，1 为长采样时间
//  200                                 | ADC_CFG1_MODE(bit)
//  201                                 | ADC_CFG1_ADICLK(0)            //0为总线时钟,1为总线时钟/2,2为交替时钟（ALTCLK），3为 异步时钟（ADACK）。
//  202                                );
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R4,R1,#+2
        ANDS     R4,R4,#0xC
        ORRS     R4,R4,#0x50
        LDR.N    R5,??DataTable3_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R5,[R5, R2, LSL #+2]
        STR      R4,[R5, #+8]
//  203 
//  204 
//  205     ADC_CFG2_REG(ADCN[adcn])  = (0
//  206                                  //| ADC_CFG2_MUXSEL_MASK       //ADC复用选择,0为a通道，1为b通道。
//  207                                  //| ADC_CFG2_ADACKEN_MASK      //异步时钟输出使能,0为禁止，1为使能。
//  208                                  | ADC_CFG2_ADHSC_MASK          //高速配置,0为正常转换序列，1为高速转换序列
//  209                                  | ADC_CFG2_ADLSTS(0)           //长采样时间选择，ADCK为4+n个额外循环，额外循环，0为20，1为12，2为6，3为2
//  210                                 );
        MOVS     R4,#+4
        LDR.N    R5,??DataTable3_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R5,[R5, R2, LSL #+2]
        STR      R4,[R5, #+12]
//  211 
//  212     //写入 SC1A 启动转换
//  213     ADC_SC1_REG(ADCN[adcn], 0 ) = (0
//  214                                    | ADC_SC1_AIEN_MASK          // 转换完成中断,0为禁止，1为使能
//  215                                    //| ADC_SC1_DIFF_MASK        // 差分模式使能,0为单端，1为差分
//  216                                    | ADC_SC1_ADCH( ch )
//  217                                   );
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        ANDS     R4,R3,#0x1F
        ORRS     R4,R4,#0x40
        LDR.N    R5,??DataTable3_4
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R5,[R5, R2, LSL #+2]
        STR      R4,[R5, #+0]
//  218 
//  219 }
        POP      {R4,R5}
        BX       LR               ;; return
//  220 
//  221 /*!
//  222  *  @brief      停止ADC软件采样
//  223  *  @param      ADCn_e       ADC模块号（ ADC0、 ADC1）
//  224  *  @since      v5.0
//  225  *  Sample usage:       adc_stop(ADC0);
//  226  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  227 void adc_stop(ADCn_e adcn)
//  228 {
//  229     ADC_SC1_REG(ADCN[adcn], 0) = (0
//  230                                   | ADC_SC1_AIEN_MASK                       // 转换完成中断,0为禁止，1为使能
//  231                                   //| ADC_SC1_DIFF_MASK                     // 差分模式使能,0为单端，1为差分
//  232                                   | ADC_SC1_ADCH(Module0_Dis)               //输入通道选择,此处选择禁止通道
//  233                                  );
adc_stop:
        MOVS     R1,#+95
        LDR.N    R2,??DataTable3_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STR      R1,[R2, #+0]
//  234 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x40048018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     ADCN

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
        DC8 61H, 64H, 63H, 2EH, 63H, 0
        DC8 0, 0

        END
//  235 
// 
//   8 bytes in section .data
//  64 bytes in section .rodata
// 708 bytes in section .text
// 
// 708 bytes of CODE  memory
//  64 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
