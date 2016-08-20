///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  12:04:21
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_ftm.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_ftm.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_ftm.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN bus_clk_khz
        EXTERN port_init

        PUBLIC FTM1_Input_test_handler
        PUBLIC FTMN
        PUBLIC ftm_input_clean
        PUBLIC ftm_input_get
        PUBLIC ftm_input_init
        PUBLIC ftm_pwm_duty
        PUBLIC ftm_pwm_freq
        PUBLIC ftm_pwm_init
        PUBLIC ftm_quad_clean
        PUBLIC ftm_quad_get
        PUBLIC ftm_quad_init
        PUBLIC mod1

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_ftm.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_ftm.c
//   11  * @brief      FTM定时器函数库
//   12  * @author     山外科技
//   13  * @version    v5.2
//   14  * @date       2014-10-31
//   15  */
//   16 
//   17 
//   18 /*
//   19  * 包含头文件
//   20  */
//   21 #include "common.h"
//   22 #include  "MK60_FTM.h"
//   23 
//   24 /*
//   25  * 定义数组
//   26  */

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   27 FTM_MemMapPtr FTMN[FTM_MAX] = {FTM0_BASE_PTR, FTM1_BASE_PTR, FTM2_BASE_PTR
FTMN:
        DATA
        DC32 40038000H, 40039000H, 400B8000H
//   28 #ifdef MK60F15
//   29 , FTM3_BASE_PTR         //FX 才有FTM3
//   30 #endif
//   31 }; //定义三个指针数组保存 FTMn_e 的地址
//   32 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   33 static uint32 ftm_mod[FTM_MAX];
ftm_mod:
        DS8 12
//   34 
//   35 /*!
//   36  *  @brief      初始化FTM 的端口
//   37  *  @param      FTMn_e    模块号（FTM0、  FTM1、  FTM2）
//   38  *  @param      FTM_CHn_e     通道号（CH0~CH7）
//   39  *  @since      v5.0
//   40  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 static void FTM_port_mux(FTMn_e ftmn, FTM_CHn_e ch)
//   42 {
FTM_port_mux:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   43     /******************* 开启时钟 和 复用IO口*******************/
//   44     switch(ftmn)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??FTM_port_mux_0
        CMP      R4,#+2
        BEQ.N    ??FTM_port_mux_1
        BCC.N    ??FTM_port_mux_2
        B.N      ??FTM_port_mux_3
//   45     {
//   46     case FTM0:
//   47         SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;       //使能FTM0时钟
??FTM_port_mux_0:
        LDR.W    R0,??DataTable10  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.W    R1,??DataTable10  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   48         switch(ch)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??FTM_port_mux_4
        CMP      R5,#+2
        BEQ.N    ??FTM_port_mux_5
        BCC.N    ??FTM_port_mux_6
        CMP      R5,#+4
        BEQ.N    ??FTM_port_mux_7
        BCC.N    ??FTM_port_mux_8
        CMP      R5,#+6
        BEQ.N    ??FTM_port_mux_9
        BCC.N    ??FTM_port_mux_10
        CMP      R5,#+7
        BEQ.N    ??FTM_port_mux_11
        B.N      ??FTM_port_mux_12
//   49         {
//   50         case FTM_CH0:
//   51             if(FTM0_CH0_PIN == PTC1)
//   52             {
//   53                 port_init(FTM0_CH0_PIN, ALT4);
??FTM_port_mux_4:
        MOV      R1,#+1024
        MOVS     R0,#+65
        BL       port_init
//   54             }
//   55             else if(FTM0_CH0_PIN == PTA3)
//   56             {
//   57                 port_init(FTM0_CH0_PIN, ALT3);
//   58             }
//   59             else
//   60             {
//   61                 ASSERT(0);                      //设置管脚有误？
//   62             }
//   63             break;
        B.N      ??FTM_port_mux_13
//   64 
//   65         case FTM_CH1:
//   66             if(FTM0_CH1_PIN == PTC2)
//   67             {
//   68                 port_init(FTM0_CH1_PIN, ALT4);
//   69             }
//   70             else if(FTM0_CH1_PIN == PTA4)
//   71             {
//   72                 port_init(FTM0_CH1_PIN, ALT3);
??FTM_port_mux_6:
        MOV      R1,#+768
        MOVS     R0,#+4
        BL       port_init
//   73             }
//   74             else
//   75             {
//   76                 ASSERT(0);                      //设置管脚有误？
//   77             }
//   78             break;
        B.N      ??FTM_port_mux_13
//   79 
//   80         case FTM_CH2:
//   81             if(FTM0_CH2_PIN == PTC3)
//   82             {
//   83                 port_init(FTM0_CH2_PIN, ALT4);
//   84             }
//   85             else if(FTM0_CH2_PIN == PTA5)
//   86             {
//   87                 port_init(FTM0_CH2_PIN, ALT3);
??FTM_port_mux_5:
        MOV      R1,#+768
        MOVS     R0,#+5
        BL       port_init
//   88             }
//   89             else
//   90             {
//   91                 ASSERT(0);                      //设置管脚有误？
//   92             }
//   93             break;
        B.N      ??FTM_port_mux_13
//   94 
//   95         case FTM_CH3:
//   96             if(FTM0_CH3_PIN == PTC4)
//   97             {
//   98                 port_init(FTM0_CH3_PIN, ALT4);
//   99             }
//  100             else if(FTM0_CH3_PIN == PTA6)
//  101             {
//  102                 port_init(FTM0_CH3_PIN, ALT3);
??FTM_port_mux_8:
        MOV      R1,#+768
        MOVS     R0,#+6
        BL       port_init
//  103             }
//  104             else
//  105             {
//  106                 ASSERT(0);                      //设置管脚有误？
//  107             }
//  108             break;
        B.N      ??FTM_port_mux_13
//  109 
//  110         case FTM_CH4:
//  111             if(FTM0_CH4_PIN == PTD4)
//  112             {
//  113                 port_init(FTM0_CH4_PIN, ALT4);
??FTM_port_mux_7:
        MOV      R1,#+1024
        MOVS     R0,#+100
        BL       port_init
//  114             }
//  115             else if(FTM0_CH4_PIN == PTA7)
//  116             {
//  117                 port_init(FTM0_CH4_PIN, ALT3);
//  118             }
//  119             else
//  120             {
//  121                 ASSERT(0);                      //设置管脚有误？
//  122             }
//  123             break;
        B.N      ??FTM_port_mux_13
//  124 
//  125         case FTM_CH5:
//  126             if(FTM0_CH5_PIN == PTD5)
//  127             {
//  128                 port_init(FTM0_CH5_PIN, ALT4);
??FTM_port_mux_10:
        MOV      R1,#+1024
        MOVS     R0,#+101
        BL       port_init
//  129             }
//  130             else if(FTM0_CH5_PIN == PTA0)
//  131             {
//  132                 port_init(FTM0_CH5_PIN, ALT3);
//  133             }
//  134             else
//  135             {
//  136                 ASSERT(0);                      //设置管脚有误？
//  137             }
//  138             break;
        B.N      ??FTM_port_mux_13
//  139 
//  140         case FTM_CH6:
//  141             if(FTM0_CH6_PIN == PTD6)
//  142             {
//  143                 port_init(FTM0_CH6_PIN, ALT4);
??FTM_port_mux_9:
        MOV      R1,#+1024
        MOVS     R0,#+102
        BL       port_init
//  144             }
//  145             else if(FTM0_CH6_PIN == PTA1)
//  146             {
//  147                 port_init(FTM0_CH6_PIN, ALT3);
//  148             }
//  149             else
//  150             {
//  151                 ASSERT(0);                      //设置管脚有误？
//  152             }
//  153             break;
        B.N      ??FTM_port_mux_13
//  154 
//  155         case FTM_CH7:
//  156             if(FTM0_CH7_PIN == PTD7)
//  157             {
//  158                 port_init(FTM0_CH7_PIN, ALT4);
??FTM_port_mux_11:
        MOV      R1,#+1024
        MOVS     R0,#+103
        BL       port_init
//  159             }
//  160             else if(FTM0_CH7_PIN == PTA2)
//  161             {
//  162                 port_init(FTM0_CH7_PIN, ALT3);
//  163             }
//  164             else
//  165             {
//  166                 ASSERT(0);                      //设置管脚有误？
//  167             }
//  168             break;
        B.N      ??FTM_port_mux_13
//  169         default:
//  170             return;
??FTM_port_mux_12:
        B.N      ??FTM_port_mux_14
//  171         }
//  172         break;
??FTM_port_mux_13:
        B.N      ??FTM_port_mux_15
//  173 
//  174     case FTM1:
//  175         SIM_SCGC6 |= SIM_SCGC6_FTM1_MASK;       //使能FTM1时钟
??FTM_port_mux_2:
        LDR.W    R0,??DataTable10  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.W    R1,??DataTable10  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  176         switch(ch)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??FTM_port_mux_16
        CMP      R5,#+1
        BEQ.N    ??FTM_port_mux_17
        B.N      ??FTM_port_mux_18
//  177         {
//  178         case FTM_CH0:
//  179             if((FTM1_CH0_PIN == PTA8) || (FTM1_CH0_PIN == PTA12) || (FTM1_CH0_PIN == PTB0) )
//  180             {
//  181                 port_init(FTM1_CH0_PIN, ALT3);
??FTM_port_mux_16:
        MOV      R1,#+768
        MOVS     R0,#+32
        BL       port_init
//  182             }
//  183             else
//  184             {
//  185                 ASSERT(0);                      //设置管脚有误？
//  186             }
//  187             break;
        B.N      ??FTM_port_mux_19
//  188 
//  189 
//  190         case FTM_CH1:
//  191             if((FTM1_CH1_PIN == PTA9) || (FTM1_CH1_PIN == PTA13) || (FTM1_CH1_PIN == PTB1) )
//  192             {
//  193                 port_init(FTM1_CH1_PIN, ALT3);
??FTM_port_mux_17:
        MOV      R1,#+768
        MOVS     R0,#+13
        BL       port_init
//  194             }
//  195             else
//  196             {
//  197                 ASSERT(0);                      //设置管脚有误？
//  198             }
//  199             break;
        B.N      ??FTM_port_mux_19
//  200 
//  201         default:
//  202             return;
??FTM_port_mux_18:
        B.N      ??FTM_port_mux_14
//  203         }
//  204         break;
??FTM_port_mux_19:
        B.N      ??FTM_port_mux_15
//  205 
//  206     case FTM2:
//  207         SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;                           //使能FTM2时钟
??FTM_port_mux_1:
        LDR.W    R0,??DataTable10_1  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.W    R1,??DataTable10_1  ;; 0x40048030
        STR      R0,[R1, #+0]
//  208         switch(ch)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??FTM_port_mux_20
        CMP      R5,#+1
        BEQ.N    ??FTM_port_mux_21
        B.N      ??FTM_port_mux_22
//  209         {
//  210         case FTM_CH0:
//  211             if((FTM2_CH0_PIN == PTA10) || (FTM2_CH0_PIN == PTB18) )
//  212             {
//  213                 port_init(FTM2_CH0_PIN, ALT3);
??FTM_port_mux_20:
        MOV      R1,#+768
        MOVS     R0,#+10
        BL       port_init
//  214             }
//  215             else
//  216             {
//  217                 ASSERT(0);                      //设置管脚有误？
//  218             }
//  219             break;
        B.N      ??FTM_port_mux_23
//  220 
//  221         case FTM_CH1:
//  222             if((FTM2_CH1_PIN == PTA11) || (FTM2_CH1_PIN == PTB19))
//  223             {
//  224                 port_init(FTM2_CH1_PIN, ALT3);
??FTM_port_mux_21:
        MOV      R1,#+768
        MOVS     R0,#+11
        BL       port_init
//  225             }
//  226             else
//  227             {
//  228                 ASSERT(0);                      //设置管脚有误？
//  229             }
//  230             break;
        B.N      ??FTM_port_mux_23
//  231 
//  232         default:
//  233             return;
??FTM_port_mux_22:
        B.N      ??FTM_port_mux_14
//  234         }
//  235         break;
??FTM_port_mux_23:
        B.N      ??FTM_port_mux_15
//  236 #ifdef MK60F15
//  237     case FTM3:
//  238         SIM_SCGC3 |= SIM_SCGC3_FTM3_MASK;       //使能FTM3时钟
//  239         switch(ch)
//  240         {
//  241         case FTM_CH0:
//  242             if(FTM3_CH0_PIN == PTD0)
//  243             {
//  244                 port_init(FTM3_CH0_PIN, ALT4);
//  245             }
//  246             else if(FTM3_CH0_PIN == PTE5)
//  247             {
//  248                 port_init(FTM3_CH0_PIN, ALT6);
//  249             }
//  250             else
//  251             {
//  252                 ASSERT(0);                      //设置管脚有误？
//  253             }
//  254             break;
//  255 
//  256         case FTM_CH1:
//  257             if(FTM3_CH1_PIN == PTD1)
//  258             {
//  259                 port_init(FTM3_CH1_PIN, ALT4);
//  260             }
//  261             else if(FTM3_CH1_PIN == PTE6)
//  262             {
//  263                 port_init(FTM3_CH1_PIN, ALT6);
//  264             }
//  265             else
//  266             {
//  267                 ASSERT(0);                      //设置管脚有误？
//  268             }
//  269             break;
//  270 
//  271         case FTM_CH2:
//  272             if(FTM3_CH2_PIN == PTD2)
//  273             {
//  274                 port_init(FTM3_CH2_PIN, ALT4);
//  275             }
//  276             else if(FTM3_CH2_PIN == PTE7)
//  277             {
//  278                 port_init(FTM3_CH2_PIN, ALT6);
//  279             }
//  280             else
//  281             {
//  282                 ASSERT(0);                      //设置管脚有误？
//  283             }
//  284             break;
//  285 
//  286         case FTM_CH3:
//  287             if(FTM3_CH3_PIN == PTD3)
//  288             {
//  289                 port_init(FTM3_CH3_PIN, ALT4);
//  290             }
//  291             else if(FTM3_CH3_PIN == PTE8)
//  292             {
//  293                 port_init(FTM3_CH3_PIN, ALT6);
//  294             }
//  295             else
//  296             {
//  297                 ASSERT(0);                      //设置管脚有误？
//  298             }
//  299             break;
//  300 
//  301         case FTM_CH4:
//  302             if(FTM3_CH4_PIN == PTC8)
//  303             {
//  304                 port_init(FTM3_CH4_PIN, ALT3);
//  305             }
//  306             else if(FTM3_CH4_PIN == PTE9)
//  307             {
//  308                 port_init(FTM3_CH4_PIN, ALT6);
//  309             }
//  310             else
//  311             {
//  312                 ASSERT(0);                      //设置管脚有误？
//  313             }
//  314             break;
//  315 
//  316         case FTM_CH5:
//  317             if(FTM3_CH5_PIN == PTC9)
//  318             {
//  319                 port_init(FTM3_CH5_PIN, ALT3);
//  320             }
//  321             else if(FTM3_CH5_PIN == PTE10)
//  322             {
//  323                 port_init(FTM3_CH5_PIN, ALT6);
//  324             }
//  325             else
//  326             {
//  327                 ASSERT(0);                      //设置管脚有误？
//  328             }
//  329             break;
//  330 
//  331         case FTM_CH6:
//  332             if(FTM3_CH6_PIN == PTC10)
//  333             {
//  334                 port_init(FTM3_CH6_PIN, ALT3);
//  335             }
//  336             else if(FTM3_CH6_PIN == PTE11)
//  337             {
//  338                 port_init(FTM3_CH6_PIN, ALT6);
//  339             }
//  340             else
//  341             {
//  342                 ASSERT(0);                      //设置管脚有误？
//  343             }
//  344             break;
//  345 
//  346         case FTM_CH7:
//  347             if(FTM3_CH7_PIN == PTC11)
//  348             {
//  349                 port_init(FTM3_CH7_PIN, ALT3);
//  350             }
//  351             else if(FTM3_CH7_PIN == PTE12)
//  352             {
//  353                 port_init(FTM3_CH7_PIN, ALT6);
//  354             }
//  355             else
//  356             {
//  357                 ASSERT(0);                      //设置管脚有误？
//  358             }
//  359         }
//  360         break;
//  361 
//  362 #endif
//  363     default:
//  364         break;
//  365     }
//  366 }
??FTM_port_mux_3:
??FTM_port_mux_15:
??FTM_port_mux_14:
        POP      {R0,R4,R5,PC}    ;; return
//  367 
//  368 /*!
//  369  *  @brief      初始化FTM 的PWM 功能
//  370  *  @param      FTMn_e    模块号（FTM0、  FTM1、  FTM2）
//  371  *  @param      FTM_CHn_e     通道号（CH0~CH7）
//  372  *  @param      freq    频率（单位为Hz）
//  373  *  @param      duty    占空比分子，占空比 = duty / FTMn_PRECISON
//  374  *  @since      v5.0
//  375  *  @note       同一个FTM，PWM频率是必须一样的，但占空比可不一样。共3个FTM，即可以输出3个不同频率PWM
//  376  *  Sample usage:       ftm_pwm_init(FTM0, FTM_CH6,200, 10);    //初始化 FTM0_CH6 为 频率 200Hz 的PWM，占空比为 10/FTM0_PRECISON
//  377  */

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  378 int mod1;
mod1:
        DS8 4

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  379 void ftm_pwm_init(FTMn_e ftmn, FTM_CHn_e ch, uint32 freq, uint32 duty)
//  380 {
ftm_pwm_init:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  381     uint32 clk_hz ;
//  382     uint16 mod;
//  383     uint8  ps;
//  384     uint16 cv;
//  385 
//  386     ASSERT( (ftmn == FTM0) || ( (ftmn == FTM1 || ftmn == FTM2 ) && (ch <= FTM_CH1))
//  387 #ifdef MK60F15
//  388             || (ftmn == FTM3)       //FX  有FTM3
//  389 #endif
//  390            );  //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_pwm_init_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_pwm_init_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??ftm_pwm_init_2
??ftm_pwm_init_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BLT.N    ??ftm_pwm_init_0
??ftm_pwm_init_2:
        MOV      R1,#+390
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  391 
//  392     /******************* 开启时钟 和 复用IO口*******************/
//  393     FTM_port_mux(ftmn,ch);
??ftm_pwm_init_0:
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       FTM_port_mux
//  394 
//  395     /*       计算频率设置        */
//  396     //  若 CPWMS = 1 ，即双边捕捉脉冲，则 PMW频率 =  bus频率 /2 /(2^预分频因子)/模数
//  397     //  若 CPWMS = 0 ，即单边捕捉脉冲，则 PMW频率 =  bus频率    /(2^预分频因子)/模数
//  398     //  EPWM的周期 ：MOD - CNTIN + 0x0001   (CNTIN 设为0)
//  399     //  脉冲宽度：CnV - CNTIN
//  400 
//  401     //  模数 MOD < 0x10000
//  402     //  预分频因子 PS  < 0x07
//  403     //  预分频因子 PS 越小时，模数 mod 就越大，计数就越精准，PWM输出更为准确
//  404     //  MOD  = clk_hz/(freq*(1 << PS)) < 0x10000  ==>  clk_hz/(freq*0x10000) < (1<< PS)  ==>  (clk_hz/(freq*0x10000) >> PS) < 1
//  405     //  即 (((clk_hz/0x10000 )/ freq ) >> PS ) < 1
//  406 
//  407     // 以 CPWMS = 0 ，即单边捕捉脉冲为例
//  408     clk_hz = (bus_clk_khz * 1000) ;     // bus频率
        LDR.W    R0,??DataTable10_3
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOV      R8,R0
//  409 
//  410     mod = (clk_hz >> 16 ) / freq ;      // 临时用 mod 缓存一下
        LSRS     R0,R8,#+16
        UDIV     R0,R0,R6
        MOV      R9,R0
//  411     ps = 0;
        MOVS     R0,#+0
        MOV      R10,R0
//  412     while((mod >> ps) >= 1)             // 等 (mod >> ps) < 1 才退出 while 循环 ，即求 PS 的最小值
??ftm_pwm_init_3:
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        MOV      R0,R9
        ASRS     R0,R0,R10
        CMP      R0,#+1
        BLT.N    ??ftm_pwm_init_4
//  413     {
//  414         ps++;
        ADDS     R10,R10,#+1
        B.N      ??ftm_pwm_init_3
//  415     }
//  416 
//  417     ASSERT(ps <= 0x07);                 // 断言， PS 最大为 0x07 ，超过此值，则 PWM频率设置过低，或 Bus 频率过高
??ftm_pwm_init_4:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+8
        BLT.N    ??ftm_pwm_init_5
        MOVW     R1,#+417
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  418 
//  419     mod = (clk_hz >> ps) / freq;        // 求 MOD 的值
??ftm_pwm_init_5:
        MOV      R0,R8
        LSRS     R0,R0,R10
        UDIV     R0,R0,R6
        MOV      R9,R0
//  420 
//  421     ftm_mod[ftmn]=mod;
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        LDR.W    R0,??DataTable10_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R9,[R0, R4, LSL #+2]
//  422 
//  423     switch(ftmn)                        // 初值 CNTIN 设为0 ，脉冲宽度：CnV - CNTIN ，即 CnV 就是 脉冲宽度了。
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_pwm_init_6
        CMP      R4,#+2
        BEQ.N    ??ftm_pwm_init_7
        BCC.N    ??ftm_pwm_init_8
        B.N      ??ftm_pwm_init_9
//  424     {
//  425         // EPWM的周期 ： MOD - CNTIN + 0x0001 == MOD - 0 + 1
//  426         // 则 CnV = (MOD - 0 + 1) * 占空比 = (MOD - 0 + 1) * duty/ FTM_PRECISON
//  427     case FTM0:
//  428         cv = (duty * (mod - 0 + 1)) / FTM0_PRECISON;
??ftm_pwm_init_6:
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        ADDS     R0,R9,#+1
        MUL      R0,R0,R7
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOV      R11,R0
//  429         break;
        B.N      ??ftm_pwm_init_10
//  430 
//  431     case FTM1:
//  432         cv = (duty * (mod - 0 + 1)) / FTM1_PRECISON;
??ftm_pwm_init_8:
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        ADDS     R0,R9,#+1
        MUL      R0,R0,R7
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOV      R11,R0
//  433         break;
        B.N      ??ftm_pwm_init_10
//  434 
//  435     case FTM2:
//  436         cv = (duty * (mod - 0 + 1)) / FTM2_PRECISON;
??ftm_pwm_init_7:
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        ADDS     R0,R9,#+1
        MUL      R0,R0,R7
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOV      R11,R0
//  437         break;
        B.N      ??ftm_pwm_init_10
//  438 #ifdef MK60F15
//  439     case FTM3:
//  440         cv = (duty * (mod - 0 + 1)) / FTM3_PRECISON;
//  441         break;
//  442 #endif
//  443 
//  444     default:
//  445         break;
//  446     }
//  447 
//  448     /******************** 选择输出模式为 边沿对齐PWM *******************/
//  449     //通道状态控制，根据模式来选择 边沿或电平
//  450     FTM_CnSC_REG(FTMN[ftmn], ch) &= ~FTM_CnSC_ELSA_MASK;
??ftm_pwm_init_9:
??ftm_pwm_init_10:
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        BICS     R1,R1,#0x4
        STR      R1,[R0, #+12]
//  451     FTM_CnSC_REG(FTMN[ftmn], ch)  = FTM_CnSC_MSB_MASK | FTM_CnSC_ELSB_MASK;
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        MOVS     R1,#+40
        STR      R1,[R0, #+12]
//  452     // MSnB:MSnA = 1x       边沿对齐PWM
//  453     // ELSnB:ELSnA = 10     先高后低
//  454     // ELSnB:ELSnA = 11     先低后高
//  455 
//  456     /******************** 配置时钟和分频 ********************/
//  457     FTM_SC_REG(FTMN[ftmn])    = ( 0
//  458                                   //| FTM_SC_CPWMS_MASK         //0：上升沿计数模式 ，1： 跳变沿计数模式选择 （注释了表示 0）
//  459                                   | FTM_SC_PS(ps)             //分频因子，分频系数 = 2^PS
//  460                                   | FTM_SC_CLKS(1)            //时钟选择， 0：没选择时钟，禁用； 1：bus 时钟； 2：MCGFFCLK； 3：EXTCLK（ 由SIM_SOPT4 选择输入管脚 FTM_CLKINx）
//  461                                   //| FTM_SC_TOIE_MASK        //溢出中断使能（注释了表示 禁止溢出中断）
//  462                                 );
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R0,R10,#0x7
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  463     FTM_MOD_REG(FTMN[ftmn])   = mod;                        //模数, EPWM的周期为 ：MOD - CNTIN + 0x0001
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STR      R9,[R0, #+8]
//  464     mod1 = mod;
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        LDR.W    R0,??DataTable10_6
        STR      R9,[R0, #+0]
//  465     FTM_CNTIN_REG(FTMN[ftmn]) = 0;                          //计数器初始化值。设置脉冲宽度：(CnV - CNTIN).
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+76]
//  466     FTM_CnV_REG(FTMN[ftmn], ch) = cv;
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        UXTH     R11,R11          ;; ZeroExt  R11,R11,#+16,#+16
        STR      R11,[R0, #+16]
//  467     FTM_CNT_REG(FTMN[ftmn])   = 0;                          //计数器。只有低16位可用（写任何值到此寄存器，都会加载 CNTIN 的值）
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+4]
//  468 }
        POP      {R0,R4-R11,PC}   ;; return
//  469 
//  470 /*!
//  471  *  @brief      设置FTM 的PWM 通道占空比
//  472  *  @param      FTMn_e    模块号（FTM0、  FTM1、  FTM2）
//  473  *  @param      FTM_CHn_e     通道号（CH0~CH7）
//  474  *  @param      duty    占空比分子，占空比 = duty / FTMn_PRECISON
//  475  *  @since      v5.0
//  476  *  @note       同一个FTM，PWM频率是必须一样的，但占空比可不一样。共3个FTM，即可以输出3个不同频率PWM
//  477  *  Sample usage:       ftm_pwm_duty(FTM0, FTM_CH6, 10);    //设置 FTM0_CH6占空比为 10/FTM0_PRECISON
//  478  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  479 void ftm_pwm_duty(FTMn_e ftmn, FTM_CHn_e ch, uint32 duty)
//  480 {
ftm_pwm_duty:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  481     uint32 cv;
//  482     uint32 mod = 0;
        MOVS     R8,#+0
//  483 
//  484     ASSERT( (ftmn == FTM0) || ( (ftmn == FTM1 || ftmn == FTM2 ) && (ch <= FTM_CH1))
//  485 #ifdef MK60F15
//  486             || (ftmn == FTM3)       //FX  有FTM3
//  487 #endif
//  488            );  //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_pwm_duty_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_pwm_duty_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??ftm_pwm_duty_2
??ftm_pwm_duty_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BLT.N    ??ftm_pwm_duty_0
??ftm_pwm_duty_2:
        MOV      R1,#+488
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  489 
//  490     switch(ftmn)
??ftm_pwm_duty_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_pwm_duty_3
        CMP      R4,#+2
        BEQ.N    ??ftm_pwm_duty_4
        BCC.N    ??ftm_pwm_duty_5
        B.N      ??ftm_pwm_duty_6
//  491     {
//  492         //如果此处断言失败，说明占空比超过 100% ，务必自行检查是否出现这情况。
//  493     case FTM0:
//  494         ASSERT(duty <= FTM0_PRECISON);     //用断言检测 占空比是否合理
??ftm_pwm_duty_3:
        MOVW     R0,#+10001
        CMP      R6,R0
        BCC.N    ??ftm_pwm_duty_7
        MOV      R1,#+494
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  495         break;
??ftm_pwm_duty_7:
        B.N      ??ftm_pwm_duty_8
//  496 
//  497     case FTM1:
//  498         ASSERT(duty <= FTM1_PRECISON);     //用断言检测 占空比是否合理
??ftm_pwm_duty_5:
        MOVW     R0,#+10001
        CMP      R6,R0
        BCC.N    ??ftm_pwm_duty_9
        MOV      R1,#+498
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  499         break;
??ftm_pwm_duty_9:
        B.N      ??ftm_pwm_duty_8
//  500 
//  501     case FTM2:
//  502         ASSERT(duty <= FTM2_PRECISON);     //用断言检测 占空比是否合理
??ftm_pwm_duty_4:
        MOVW     R0,#+10001
        CMP      R6,R0
        BCC.N    ??ftm_pwm_duty_10
        MOV      R1,#+502
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  503         break;
??ftm_pwm_duty_10:
        B.N      ??ftm_pwm_duty_8
//  504 
//  505 #ifdef MK60F15
//  506     case FTM3:
//  507         ASSERT(duty <= FTM3_PRECISON);     //用断言检测 占空比是否合理
//  508         break;
//  509 #endif
//  510 
//  511     default:
//  512         break;
//  513     }
//  514 
//  515 
//  516     //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1
//  517     mod=ftm_mod[ftmn];
??ftm_pwm_duty_6:
??ftm_pwm_duty_8:
        LDR.W    R0,??DataTable10_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        MOV      R8,R0
//  518 
//  519 
//  520     switch(ftmn)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_pwm_duty_11
        CMP      R4,#+2
        BEQ.N    ??ftm_pwm_duty_12
        BCC.N    ??ftm_pwm_duty_13
        B.N      ??ftm_pwm_duty_14
//  521     {
//  522     case FTM0:
//  523         cv = (duty * (mod - 0 + 1)) / FTM0_PRECISON;
??ftm_pwm_duty_11:
        ADDS     R0,R8,#+1
        MUL      R0,R0,R6
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOVS     R7,R0
//  524         break;
        B.N      ??ftm_pwm_duty_15
//  525 
//  526     case FTM1:
//  527         cv = (duty * (mod - 0 + 1)) / FTM1_PRECISON;
??ftm_pwm_duty_13:
        ADDS     R0,R8,#+1
        MUL      R0,R0,R6
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOVS     R7,R0
//  528         break;
        B.N      ??ftm_pwm_duty_15
//  529 
//  530     case FTM2:
//  531         cv = (duty * (mod - 0 + 1)) / FTM2_PRECISON;
??ftm_pwm_duty_12:
        ADDS     R0,R8,#+1
        MUL      R0,R0,R6
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        MOVS     R7,R0
//  532         break;
        B.N      ??ftm_pwm_duty_15
//  533 
//  534 #ifdef MK60F15
//  535     case FTM3:
//  536         cv = (duty * (mod - 0 + 1)) / FTM3_PRECISON;
//  537         break;
//  538 #endif
//  539 
//  540     default:
//  541         break;
//  542     }
//  543 
//  544     // 配置FTM通道值
//  545     FTM_CnV_REG(FTMN[ftmn], ch) = cv;
??ftm_pwm_duty_14:
??ftm_pwm_duty_15:
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        STR      R7,[R0, #+16]
//  546 
//  547 }
        POP      {R4-R8,PC}       ;; return
//  548 
//  549 /*!
//  550  *  @brief      设置FTM的频率
//  551  *  @param      freq    频率（单位为Hz）
//  552  *  @since      v5.0
//  553  *  @note       修改PWM频率后，必须调用 ftm_pwm_duty 重新配置占空比。同一个模块，PWM频率必须相同。
//  554  *  Sample usage:       ftm_pwm_freq(FTM0,200);    //设置 FTM0 的 频率 为 200Hz
//  555  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  556 void ftm_pwm_freq(FTMn_e ftmn, uint32 freq)             //设置FTM的频率
//  557 {
ftm_pwm_freq:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  558     uint32 clk_hz = (bus_clk_khz * 1000) >> 1;        //bus频率/2
        LDR.W    R0,??DataTable10_3
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        ASRS     R6,R0,#+1
//  559     uint32 mod;
//  560     uint8 ps;
//  561 
//  562     /*       计算频率设置        */
//  563     // 以 CPWMS = 0 ，即单边捕捉脉冲为例
//  564     clk_hz = (bus_clk_khz * 1000) ;     // bus频率
        LDR.W    R0,??DataTable10_3
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R6,R0
//  565 
//  566     mod = (clk_hz >> 16 ) / freq ;      // 临时用 mod 缓存一下
        LSRS     R0,R6,#+16
        UDIV     R0,R0,R5
        MOVS     R7,R0
//  567     ps = 0;
        MOVS     R0,#+0
        MOV      R8,R0
//  568     while((mod >> ps) >= 1)             // 等 (mod >> ps) < 1 才退出 while 循环 ，即求 PS 的最小值
??ftm_pwm_freq_0:
        MOVS     R0,R7
        LSRS     R0,R0,R8
        CMP      R0,#+0
        BEQ.N    ??ftm_pwm_freq_1
//  569     {
//  570         ps++;
        ADDS     R8,R8,#+1
        B.N      ??ftm_pwm_freq_0
//  571     }
//  572 
//  573     ASSERT(ps <= 0x07);                 // 断言， PS 最大为 0x07 ，超过此值，则 PWM频率设置过低，或 Bus 频率过高
??ftm_pwm_freq_1:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+8
        BLT.N    ??ftm_pwm_freq_2
        MOVW     R1,#+573
        LDR.W    R0,??DataTable10_2
        BL       assert_failed
//  574 
//  575     mod = (clk_hz >> ps) / freq;        // 求 MOD 的值
??ftm_pwm_freq_2:
        MOVS     R0,R6
        LSRS     R0,R0,R8
        UDIV     R0,R0,R5
        MOVS     R7,R0
//  576 
//  577     ftm_mod[ftmn]=mod;
        LDR.W    R0,??DataTable10_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R7,[R0, R4, LSL #+2]
//  578 
//  579     /******************** 配置时钟和分频 ********************/
//  580     FTM_SC_REG(FTMN[ftmn])    = ( 0
//  581                                   //| FTM_SC_CPWMS_MASK         //0：上升沿计数模式 ，1： 跳变沿计数模式选择 （注释了表示 0）
//  582                                   | FTM_SC_PS(ps)             //分频因子，分频系数 = 2^PS
//  583                                   | FTM_SC_CLKS(1)            //时钟选择， 0：没选择时钟，禁用； 1：bus 时钟； 2：MCGFFCLK； 3：EXTCLK（ 由SIM_SOPT4 选择输入管脚 FTM_CLKINx）
//  584                                   //| FTM_SC_TOIE_MASK        //溢出中断使能（注释了表示 禁止溢出中断）
//  585                                 );
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        ANDS     R0,R8,#0x7
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  586     FTM_CNTIN_REG(FTMN[ftmn]) = 0;      //计数器初始化值。设置脉冲宽度：(CnV - CNTIN).
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+76]
//  587     FTM_MOD_REG(FTMN[ftmn])   = mod;    //模数, EPWM的周期为 ：MOD - CNTIN + 0x0001
        LDR.W    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STR      R7,[R0, #+8]
//  588     FTM_CNT_REG(FTMN[ftmn])   = 0;      //计数器。只有低16位可用（写任何值到此寄存器，都会加载 CNTIN 的值）
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+4]
//  589 }
        POP      {R4-R8,PC}       ;; return
//  590 
//  591 //////////////////////////////// 以上为输出PWM  //////////////////////////////////////////
//  592 
//  593 //////////////////////////////// 以下为输入捕捉 //////////////////////////////////////////
//  594 
//  595 /*!
//  596  *  @brief      输入捕捉初始化函数
//  597  *  @param      FTMn_e          模块号（FTM0、  FTM1、  FTM2）
//  598  *  @param      FTM_CHn_e       通道号（CH0~CH7）
//  599  *  @param      FTM_Input_cfg   输入捕捉触发条件配置
//  600  *  @param      FTM_PS_e        分频因子
//  601  *  @since      v5.0
//  602  *  @note       同一个FTM，只能干一个活，用于输入捕捉后就不要再用于其他功能，例如PWM。
//  603  *  Sample usage:       ftm_input_init(FTM0, FTM_CH0, FTM_Rising,FTM_PS_2);    //设置 FTM0_CH0上升沿触发输入捕捉，二分频
//  604  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  605 void ftm_input_init(FTMn_e ftmn, FTM_CHn_e ch, FTM_Input_cfg cfg,FTM_PS_e ps)
//  606 {
ftm_input_init:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  607     ASSERT( (ftmn == FTM0) || ( (ftmn == FTM1 || ftmn == FTM2 ) && (ch <= FTM_CH1))
//  608 #ifdef MK60F15
//  609             || (ftmn == FTM3)       //FX  有FTM3
//  610 #endif
//  611            );  //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_input_init_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_input_init_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??ftm_input_init_2
??ftm_input_init_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BLT.N    ??ftm_input_init_0
??ftm_input_init_2:
        MOVW     R1,#+611
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  612 
//  613     /******************* 开启时钟 和 复用IO口*******************/
//  614     FTM_port_mux(ftmn,ch);
??ftm_input_init_0:
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       FTM_port_mux
//  615 
//  616     /******************* 设置为输入捕捉功能 *******************/
//  617     switch(cfg)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??ftm_input_init_3
        CMP      R6,#+2
        BEQ.N    ??ftm_input_init_4
        BCC.N    ??ftm_input_init_5
        B.N      ??ftm_input_init_6
//  618     {
//  619         //输入捕捉模式下：DECAPEN = 0 ， DECAPEN = 0 ，CPWMS = 0， MSnB:MSnA = 0
//  620 
//  621         // ELSnB:ELSnA         1          10          11
//  622         // 配置             上升沿      下降沿      跳变沿
//  623 
//  624     case FTM_Rising:    //上升沿触发
//  625         FTM_CnSC_REG(FTMN[ftmn], ch) |=  ( FTM_CnSC_ELSA_MASK  | FTM_CnSC_CHIE_MASK );                   //置1
??ftm_input_init_3:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        ORRS     R1,R1,#0x44
        STR      R1,[R0, #+12]
//  626         FTM_CnSC_REG(FTMN[ftmn], ch) &= ~( FTM_CnSC_ELSB_MASK  | FTM_CnSC_MSB_MASK | FTM_CnSC_MSA_MASK); //清0
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        BICS     R1,R1,#0x38
        STR      R1,[R0, #+12]
//  627         break;
        B.N      ??ftm_input_init_6
//  628 
//  629     case FTM_Falling:   //下降沿触发
//  630         FTM_CnSC_REG(FTMN[ftmn], ch) |= (FTM_CnSC_ELSB_MASK  | FTM_CnSC_CHIE_MASK );                    //置1
??ftm_input_init_5:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        ORRS     R1,R1,#0x48
        STR      R1,[R0, #+12]
//  631         FTM_CnSC_REG(FTMN[ftmn], ch) &= ~( FTM_CnSC_ELSA_MASK | FTM_CnSC_MSB_MASK | FTM_CnSC_MSA_MASK); //清0
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        BICS     R1,R1,#0x34
        STR      R1,[R0, #+12]
//  632         break;
        B.N      ??ftm_input_init_6
//  633 
//  634     case FTM_Rising_or_Falling: //上升沿、下降沿都触发
//  635         FTM_CnSC_REG(FTMN[ftmn], ch) |=  ( FTM_CnSC_ELSB_MASK | FTM_CnSC_ELSA_MASK  | FTM_CnSC_CHIE_MASK ); //置1
??ftm_input_init_4:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        ORRS     R1,R1,#0x4C
        STR      R1,[R0, #+12]
//  636         FTM_CnSC_REG(FTMN[ftmn], ch) &= ~( FTM_CnSC_MSB_MASK  | FTM_CnSC_MSA_MASK); //清0
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R1,R1,R5, LSL #+3
        LDR      R1,[R1, #+12]
        BICS     R1,R1,#0x30
        STR      R1,[R0, #+12]
//  637         break;
//  638     }
//  639 
//  640     FTM_SC_REG(FTMN[ftmn]) = ( 0
//  641                               | FTM_SC_CLKS(0x1)       //选择 bus 时钟
//  642                               | FTM_SC_PS(ps)          //选择 分频系数
//  643                              );
??ftm_input_init_6:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        ANDS     R0,R7,#0x7
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+0]
//  644     FTM_MODE_REG(FTMN[ftmn])    |= FTM_MODE_WPDIS_MASK; //禁止写保护
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+84]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+84]
//  645     FTM_COMBINE_REG(FTMN[ftmn]) = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+100]
//  646     FTM_MODE_REG(FTMN[ftmn])    &= ~FTM_MODE_FTMEN_MASK;    //使能FTM
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+84]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+84]
//  647     FTM_CNTIN_REG(FTMN[ftmn])   = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+76]
//  648 
//  649     FTM_STATUS_REG(FTMN[ftmn])  = 0x00;               //清中断标志位
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+80]
//  650 
//  651     //开启输入捕捉中断
//  652     //enable_irq(FTM0_IRQn + ftmn);
//  653 }
        POP      {R0,R4-R7,PC}    ;; return
//  654 
//  655 /*!
//  656  *  @brief      输入捕捉初始化函数
//  657  *  @param      FTMn_e          模块号（FTM0、  FTM1、  FTM2）
//  658  *  @param      FTM_CHn_e       通道号（CH0~CH7）
//  659  *  @param      FTM_Input_cfg   输入捕捉触发条件配置
//  660  *  @return     获取捕捉事件发生时的计数器值 (根据两次捕捉之间的差值可判断周期频率)
//  661  *  @since      v5.0
//  662  *  Sample usage:       uint16 data = ftm_input_get (FTM0, FTM_CH0) ;   // 获取FTM0_CH0输入捕捉事件触发时的计数值
//  663  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  664 uint16   ftm_input_get (FTMn_e ftmn, FTM_CHn_e ch)
//  665 {
ftm_input_get:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  666         ASSERT( (ftmn == FTM0) || ( (ftmn == FTM1 || ftmn == FTM2 ) && (ch <= FTM_CH1))
//  667 #ifdef MK60F15
//  668                 || (ftmn == FTM3)       //FX  有FTM3
//  669 #endif
//  670                );  //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??ftm_input_get_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_input_get_1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??ftm_input_get_2
??ftm_input_get_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BLT.N    ??ftm_input_get_0
??ftm_input_get_2:
        MOVW     R1,#+670
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  671 
//  672     return (uint16)FTM_CnV_REG(FTMN[ftmn],ch);    //保存
??ftm_input_get_0:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+3
        LDR      R0,[R0, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R1,R4,R5,PC}    ;; return
//  673 }
//  674 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  675 void     ftm_input_clean (FTMn_e ftmn)
//  676 {
ftm_input_clean:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  677     ASSERT( ftmn < FTM_MAX);     //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BLT.N    ??ftm_input_clean_0
        MOVW     R1,#+677
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  678 
//  679     FTM_CNT_REG(FTMN[ftmn]) = 0;               //清 计数器计数值
??ftm_input_clean_0:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+4]
//  680 }
        POP      {R4,PC}          ;; return
//  681 
//  682 
//  683 /*!
//  684  *  @brief      FTM测试中断服务函数
//  685  *  @since      v5.0
//  686  *  @warning    此函数需要用户根据自己需求完成，这里仅仅是提供一个模版
//  687  *  Sample usage:       set_vector_handler(FTM0_IRQn , FTM1_Input_test_handler);    //把 FTM1_Input_test_handler 函数添加到中断向量表，不需要我们手动调用
//  688  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  689 void FTM1_Input_test_handler(void)
//  690 {
//  691     uint8 s = FTM1_STATUS;             //读取捕捉和比较状态  All CHnF bits can be checked using only one read of STATUS.
FTM1_Input_test_handler:
        LDR.N    R0,??DataTable10_7  ;; 0x40039050
        LDR      R0,[R0, #+0]
//  692     uint8 CHn;
//  693 
//  694     FTM1_STATUS = 0x00;             //清中断标志位
        MOVS     R2,#+0
        LDR.N    R3,??DataTable10_7  ;; 0x40039050
        STR      R2,[R3, #+0]
//  695 
//  696     CHn = 0;
        MOVS     R2,#+0
        MOVS     R1,R2
//  697     if( s & (1 << CHn) )
//  698     {
//  699         //FTM_IRQ_DIS(FTM1, CHn);     //禁止输入捕捉中断
//  700         /*     用户任务       */
//  701 
//  702         /*********************/
//  703         //FTM_IRQ_EN(FTM1, CHn); //开启输入捕捉中断
//  704 
//  705     }
//  706 
//  707     /* 这里添加 n=1 的模版，根据模版来添加 */
//  708     CHn = 1;
        MOVS     R2,#+1
        MOVS     R1,R2
//  709     if( s & (1 << CHn) )
//  710     {
//  711         //FTM_IRQ_EN(FTM1, CHn); //开启输入捕捉中断
//  712         /*     用户任务       */
//  713 
//  714 
//  715         /*********************/
//  716         //不建议在这里开启输入捕捉中断
//  717         //FTM_IRQ_EN(FTM1, CHn); //开启输入捕捉中断
//  718     }
//  719 }
        BX       LR               ;; return
//  720 
//  721 //////////////////////////////// 以上为输入捕捉  //////////////////////////////////////////
//  722 
//  723 //////////////////////////////// 以下为正交解码 //////////////////////////////////////////
//  724 
//  725 /*!
//  726  *  @brief      初始化FTM 的正交解码 功能
//  727  *  @param      FTMn_e    模块号（ FTM1、  FTM2）
//  728  *  @since      v5.0
//  729  *  Sample usage:       ftm_quad_init(FTM1);    //初始化 FTM1 为正交解码模式
//  730  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  731 void ftm_quad_init(FTMn_e ftmn)
//  732 {
ftm_quad_init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  733     ASSERT( (ftmn == FTM1) || (ftmn == FTM2 ) ); //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_quad_init_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BEQ.N    ??ftm_quad_init_0
        MOVW     R1,#+733
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  734 
//  735     /******************* 开启时钟 和 复用IO口*******************/
//  736     switch(ftmn)
??ftm_quad_init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R0,R4
        CMP      R0,#+1
        BEQ.N    ??ftm_quad_init_1
        CMP      R0,#+2
        BEQ.N    ??ftm_quad_init_2
        B.N      ??ftm_quad_init_3
//  737     {
//  738 
//  739     case FTM1:
//  740         SIM_SCGC6 |= SIM_SCGC6_FTM1_MASK;       //使能FTM1时钟
??ftm_quad_init_1:
        LDR.N    R0,??DataTable10  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable10  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  741         if((FTM1_QDPHA_PIN == PTA8) || (FTM1_QDPHA_PIN == PTB0) )                 //管脚复用
//  742         {
//  743             port_init(FTM1_QDPHA_PIN, ALT6);
//  744         }
//  745         else if(FTM1_QDPHA_PIN == PTA12)
//  746         {
//  747             port_init(FTM1_QDPHA_PIN, ALT7);
        MOV      R1,#+1792
        MOVS     R0,#+12
        BL       port_init
//  748         }
//  749         else
//  750         {
//  751             ASSERT(0);                          //断言，配置的管脚不符合要求
//  752         }
//  753 
//  754         if((FTM1_QDPHB_PIN == PTA9) ||(FTM1_QDPHB_PIN == PTB1))
//  755         {
//  756             port_init(FTM1_QDPHB_PIN, ALT6);
//  757         }
//  758         else if(FTM1_QDPHB_PIN == PTA13)
//  759         {
//  760             port_init(FTM1_QDPHB_PIN, ALT7);
        MOV      R1,#+1792
        MOVS     R0,#+13
        BL       port_init
//  761         }
//  762         else
//  763         {
//  764             ASSERT(0);                          //断言，配置的管脚不符合要求
//  765         }
//  766         break;
        B.N      ??ftm_quad_init_4
//  767 
//  768     case FTM2:
//  769         SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;                           //使能FTM2时钟
??ftm_quad_init_2:
        LDR.N    R0,??DataTable10_1  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.N    R1,??DataTable10_1  ;; 0x40048030
        STR      R0,[R1, #+0]
//  770         if((FTM2_QDPHA_PIN == PTA10) || (FTM2_QDPHA_PIN == PTB18))                  //管脚复用
//  771         {
//  772             port_init(FTM2_QDPHA_PIN, ALT6);
        MOV      R1,#+1536
        MOVS     R0,#+50
        BL       port_init
//  773         }
//  774         else
//  775         {
//  776             ASSERT(0);                          //断言，配置的管脚不符合要求
//  777         }
//  778 
//  779         if((FTM2_QDPHB_PIN == PTA11) || (FTM2_QDPHB_PIN == PTB19) )                 //管脚复用
//  780         {
//  781             port_init(FTM2_QDPHB_PIN, ALT6);
        MOV      R1,#+1536
        MOVS     R0,#+51
        BL       port_init
//  782         }
//  783         else
//  784         {
//  785             ASSERT(0);                          //断言，配置的管脚不符合要求
//  786         }
//  787         break;
        B.N      ??ftm_quad_init_4
//  788     default:
//  789         ASSERT(0);                              //断言，配置的模块有误
??ftm_quad_init_3:
        MOVW     R1,#+789
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  790         break;
//  791     }
//  792 
//  793     FTM_MODE_REG(FTMN[ftmn])  |=    (0
//  794                                      | FTM_MODE_WPDIS_MASK  //写保护禁止
//  795                                      | FTM_MODE_FTMEN_MASK   //使能 FTM
//  796                                     );
??ftm_quad_init_4:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+84]
        ORRS     R0,R0,#0x5
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+84]
//  797 //    FTM_QDCTRL_REG(FTMN[ftmn]) |=   (0
//  798 //                                    | FTM_QDCTRL_QUADMODE_MASK
//  799 //                                     );
//  800     FTM_QDCTRL_REG(FTMN[ftmn]) &= ~FTM_QDCTRL_QUADMODE_MASK; //选定编码模式为A相与B相编码模式
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+128]
        BICS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+128]
//  801     FTM_CNTIN_REG(FTMN[ftmn])   = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+76]
//  802     FTM_MOD_REG(FTMN[ftmn])     = 10000;//FTM_MOD_MOD_MASK;
        MOVW     R0,#+10000
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+8]
//  803     //FTM_SC_REG(FTMN[ftmn]) |= FTM_SC_CLKS(3);  //选择外部时钟
//  804     FTM_QDCTRL_REG(FTMN[ftmn]) |=   (0
//  805                                     | FTM_QDCTRL_QUADEN_MASK
//  806                                      );
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+128]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+128]
//  807     FTM_MODE_REG(FTMN[ftmn])  |= FTM_QDCTRL_QUADEN_MASK;
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+84]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+84]
//  808     FTM_CNT_REG(FTMN[ftmn])     = 0;                    //计数器。只有低16位可用（写任何值到此寄存器，都会加载 CNTIN 的值）
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+4]
//  809     
//  810 }
        POP      {R4,PC}          ;; return
//  811 
//  812 /*!
//  813  *  @brief      获取FTM 正交解码 的脉冲数
//  814  *  @param      FTMn_e    模块号（ FTM1、  FTM2）
//  815  *  @since      v5.0
//  816  *  Sample usage:       int16 count = ftm_quad_get(FTM1);    //获取  FTM1 交解码 的脉冲数
//  817  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  818 int16 ftm_quad_get(FTMn_e ftmn)
//  819 {
ftm_quad_get:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  820     int16 val;
//  821     ASSERT( (ftmn == FTM1) || (ftmn == FTM2 ) );        //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_quad_get_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BEQ.N    ??ftm_quad_get_0
        MOVW     R1,#+821
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  822     val = FTM_CNT_REG(FTMN[ftmn]);
??ftm_quad_get_0:
        LDR.N    R0,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDR      R0,[R0, #+4]
        MOVS     R5,R0
//  823 
//  824     return val;
        MOVS     R0,R5
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        POP      {R1,R4,R5,PC}    ;; return
//  825 }
//  826 
//  827 /*!
//  828  *  @brief      清 FTM 正交解码 的脉冲数
//  829  *  @param      FTMn_e    模块号（ FTM1、  FTM2）
//  830  *  @since      v5.0
//  831  *  Sample usage:       ftm_quad_clean(FTM1);    //复位 FTM1 正交解码 的脉冲数
//  832  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  833 void ftm_quad_clean(FTMn_e ftmn)
//  834 {
ftm_quad_clean:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  835     ASSERT( (ftmn == FTM1) || (ftmn == FTM2 ) ); //检查传递进来的通道是否正确
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BEQ.N    ??ftm_quad_clean_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BEQ.N    ??ftm_quad_clean_0
        MOVW     R1,#+835
        LDR.N    R0,??DataTable10_2
        BL       assert_failed
//  836 
//  837     FTM_CNT_REG(FTMN[ftmn])     = 0;             //计数器。只有低16位可用（写任何值到此寄存器，都会加载 CNTIN 的值）
??ftm_quad_clean_0:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STR      R0,[R1, #+4]
//  838 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     ftm_mod

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     FTMN

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     mod1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     0x40039050

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
        DC8 66H, 74H, 6DH, 2EH, 63H, 0
        DC8 0, 0

        END
//  839 
//  840 
//  841 
// 
//    16 bytes in section .bss
//    12 bytes in section .data
//    64 bytes in section .rodata
// 1 994 bytes in section .text
// 
// 1 994 bytes of CODE  memory
//    64 bytes of CONST memory
//    28 bytes of DATA  memory
//
//Errors: none
//Warnings: none
