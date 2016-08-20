///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:28
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_i2c.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_i2c.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\MK60_i2c.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN __aeabi_memcpy4
        EXTERN abs
        EXTERN assert_failed
        EXTERN bus_clk_khz
        EXTERN port_init

        PUBLIC I2CN
        PUBLIC MasterTransmission
        PUBLIC SlaveID
        PUBLIC i2c_delay
        PUBLIC i2c_init
        PUBLIC i2c_read_reg
        PUBLIC i2c_write_lendata
        PUBLIC i2c_write_reg

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Chip\src\MK60_i2c.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       MK60_i2c.c
//   11  * @brief      i2c驱动函数
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-07-12
//   15  */
//   16 
//   17 #include "common.h"
//   18 #include "MK60_port.h"
//   19 #include "MK60_i2c.h"
//   20 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   21 unsigned char MasterTransmission;
MasterTransmission:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   22 unsigned char SlaveID;
SlaveID:
        DS8 1
//   23 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   24 I2C_MemMapPtr I2CN[2] = {I2C0_BASE_PTR, I2C1_BASE_PTR}; //定义两个指针数组保存 I2CN 的地址
I2CN:
        DATA
        DC32 40066000H, 40067000H
//   25 
//   26 
//   27 /*
//   28  *  把I2C通信的每个小步骤都用宏定义来实现，方便编写顶层函数
//   29  *  此宏定义参考飞思卡尔公司例程修改所得
//   30  */
//   31 //启动信号
//   32 #define i2c_Start(I2Cn)             I2C_C1_REG(I2CN[I2Cn]) |= (I2C_C1_TX_MASK | I2C_C1_MST_MASK)    //MST 由0变1，产生起始信号，TX = 1 进入发送模式
//   33 
//   34 //停止信号
//   35 #define i2c_Stop(I2Cn)              I2C_C1_REG(I2CN[I2Cn]) &= ~(I2C_C1_MST_MASK | I2C_C1_TX_MASK)   //MST 由1变0，产生停止信号，TX = 0 进入接收模式
//   36 
//   37 //重复启动
//   38 #define i2c_RepeatedStart(I2Cn)     I2C_C1_REG(I2CN[I2Cn]) |= I2C_C1_RSTA_MASK
//   39 
//   40 //进入接收模式(应答,需要接收多个数据，接收最后一个字节前需要禁用应答i2c_DisableAck)
//   41 #define i2c_EnterRxMode(I2Cn)       I2C_C1_REG(I2CN[I2Cn]) &= ~(I2C_C1_TX_MASK | I2C_C1_TXAK_MASK)  //
//   42 
//   43 //进入接收模式(不应答,只接收一个字节)
//   44 #define i2c_PutinRxMode(I2Cn)       I2C_C1_REG(I2CN[I2Cn]) &= ~I2C_C1_TX_MASK;I2C_C1_REG(I2CN[I2Cn]) |= I2C_C1_TXAK_MASK
//   45 
//   46 //禁用应答(接收最后一个字节)
//   47 #define i2c_DisableAck(I2Cn)        I2C_C1_REG(I2CN[I2Cn]) |= I2C_C1_TXAK_MASK
//   48 
//   49 //等待 I2C_S
//   50 #define i2c_Wait(I2Cn)              while(( I2C_S_REG(I2CN[I2Cn]) & I2C_S_IICIF_MASK)==0) {} \ 
//   51                                     I2C_S_REG(I2CN[I2Cn]) |= I2C_S_IICIF_MASK;
//   52 
//   53 //写一个字节
//   54 #define i2c_write_byte(I2Cn,data)   (I2C_D_REG(I2CN[I2Cn]) = (data));i2c_Wait(I2Cn)
//   55 
//   56 /*!
//   57  *  @brief      I2C初始化，设置波特率
//   58  *  @param      I2Cn_e      I2C模块(I2C0、I2C1)
//   59  *  @param      baud        期待的波特率
//   60  *  @return                 实际的波特率
//   61  *  @since      v5.0
//   62  *  Sample usage:       i2c_init(I2C0,400*1000);     // 初始化I2C0，期待的波特率为400k
//   63  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 uint32 i2c_init(I2Cn_e i2cn, uint32 baud)
//   65 {
i2c_init:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+132
        MOVS     R4,R0
        MOVS     R5,R1
//   66     if(i2cn == I2C0)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??i2c_init_0
//   67     {
//   68         /* 开启时钟 */
//   69 #if defined(MK60DZ10)
//   70         SIM_SCGC4 |= SIM_SCGC4_I2C0_MASK;           //开启 I2C0时钟
        LDR.W    R0,??DataTable3  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.W    R1,??DataTable3  ;; 0x40048034
        STR      R0,[R1, #+0]
//   71 #elif defined( MK60F15)
//   72         SIM_SCGC4 |= SIM_SCGC4_IIC0_MASK;           //开启 I2C0时钟
//   73 #endif
//   74 
//   75         /* 配置 I2C0功能的 GPIO 接口 */
//   76         if((I2C0_SCL_PIN == PTB0) || (I2C0_SCL_PIN == PTB2) || (I2C0_SCL_PIN == PTD8) )
//   77         {
//   78             port_init (I2C0_SCL_PIN, ALT2 | ODO | PULLUP );
        MOVW     R1,#+547
        MOVS     R0,#+104
        BL       port_init
//   79         }
//   80         else
//   81             ASSERT(0);                              //上诉条件都不满足，直接断言失败了，设置管脚有误？
//   82 
//   83         if((I2C0_SDA_PIN == PTB1) || (I2C0_SDA_PIN == PTB3) || (I2C0_SDA_PIN == PTD9) )
//   84             port_init (I2C0_SDA_PIN, ALT2 | ODO | PULLUP );
        MOVW     R1,#+547
        MOVS     R0,#+105
        BL       port_init
        B.N      ??i2c_init_1
//   85         else
//   86             ASSERT(0);                              //上诉条件都不满足，直接断言失败了，设置管脚有误？
//   87     }
//   88     else
//   89     {
//   90         /* 开启时钟 */
//   91 #if defined(MK60DZ10)
//   92         SIM_SCGC4 |= SIM_SCGC4_I2C1_MASK;           //开启 I2C1时钟
??i2c_init_0:
        LDR.W    R0,??DataTable3  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable3  ;; 0x40048034
        STR      R0,[R1, #+0]
//   93 #elif defined(MK60F15)
//   94         SIM_SCGC4 |= SIM_SCGC4_IIC1_MASK;           //开启 I2C1时钟
//   95 #endif
//   96         /* 配置 I2C1功能的 GPIO 接口 */
//   97         if(I2C1_SCL_PIN == PTE1)
//   98             port_init (I2C1_SCL_PIN, ALT6 | ODO | PULLUP );
//   99         else if(I2C1_SCL_PIN == PTC10)
//  100             port_init (I2C1_SCL_PIN, ALT2 | ODO | PULLUP );
        MOVW     R1,#+547
        MOVS     R0,#+74
        BL       port_init
//  101         else
//  102             ASSERT(0);                          //上诉条件都不满足，直接断言失败了，设置管脚有误？
//  103 
//  104         if(I2C1_SDA_PIN == PTE0)
//  105             port_init (I2C1_SDA_PIN, ALT6 | ODO | PULLUP );
//  106         else if (I2C1_SDA_PIN == PTC11)
//  107             port_init (I2C1_SDA_PIN, ALT2 | ODO | PULLUP );
        MOVW     R1,#+547
        MOVS     R0,#+75
        BL       port_init
//  108         else
//  109             ASSERT(0);                          //上诉条件都不满足，直接断言失败了，设置管脚有误？
//  110     }
//  111 
//  112     /* 设置频率 */
//  113 
//  114     // I2C baud rate = bus speed (Hz)/(mul × SCL divider)  即这里 50MHz/(1 ×128)=390.625kHz
//  115     // SDA hold time = bus period (s) × mul × SDA hold value
//  116     // SCL start hold time = bus period (s) × mul × SCL start hold value
//  117     // SCL stop hold time = bus period (s) × mul × SCL stop hold value
//  118 
//  119     //查表 ICR 对应的  SCL_divider ，见 《K60P144M100SF2RM.pdf》第1468页的 I2C Divider and Hold Values
//  120     uint16 ICR_2_SCL_divider[0x40]  =
//  121     {
//  122         20, 22, 24, 26, 28, 30, 34, 40, 28, 32, 36, 40, 44, 48, 56, 68,
//  123         48, 56, 64, 72, 80, 88, 104, 128, 80, 96, 112, 128, 144, 160, 192, 240,
//  124         160, 192, 224, 256, 288, 320, 384, 480, 320, 384, 448, 512, 576, 640, 768, 960,
//  125         640, 768, 896, 1024, 1152, 1280, 1536, 1920, 1280, 1536, 1792, 2048, 2304, 2560, 3072, 3840
//  126     };
??i2c_init_1:
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable3_1
        MOVS     R2,#+128
        BL       __aeabi_memcpy4
//  127 
//  128     uint8 mult;
//  129     if(bus_clk_khz <= 50000)mult = 0;         //bus 一分频
        LDR.W    R0,??DataTable3_2
        LDR      R0,[R0, #+0]
        MOVW     R1,#+50001
        CMP      R0,R1
        BGE.N    ??i2c_init_2
        MOVS     R0,#+0
        MOVS     R6,R0
        B.N      ??i2c_init_3
//  130     else  if(bus_clk_khz <= 100000)mult = 1;  //bus 二分频
??i2c_init_2:
        LDR.W    R0,??DataTable3_2
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_3  ;; 0x186a1
        CMP      R0,R1
        BGE.N    ??i2c_init_4
        MOVS     R0,#+1
        MOVS     R6,R0
        B.N      ??i2c_init_3
//  131     else      mult = 2;                       //bus 四分频
??i2c_init_4:
        MOVS     R0,#+2
        MOVS     R6,R0
//  132 
//  133     uint16 scldiv =  bus_clk_khz * 1000 / ( (1<<mult) * baud );  //最佳的分频系数
??i2c_init_3:
        LDR.W    R0,??DataTable3_2
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+1
        LSLS     R1,R1,R6
        MULS     R1,R5,R1
        UDIV     R7,R0,R1
//  134 
//  135     //需要从 ICR_2_SCL_divider 里找到 与最佳分频系数scldiv最相近的 分频系数
//  136     uint8 icr, n = 0x40;
        MOVS     R11,#+64
//  137     uint16 min_Dvalue = ~0, Dvalue;
        MOVW     R10,#+65535
//  138 
//  139     while(n)                                            //循环里逐个扫描，找出最接近的 分频系数
??i2c_init_5:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+0
        BEQ.N    ??i2c_init_6
//  140     {
//  141         n--;
        SUBS     R11,R11,#+1
//  142         Dvalue = abs(scldiv - ICR_2_SCL_divider[n]);
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        ADD      R0,SP,#+0
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        LDRH     R0,[R0, R11, LSL #+1]
        SUBS     R0,R7,R0
        BL       abs
        MOV      R9,R0
//  143         if(Dvalue == 0)
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        CMP      R9,#+0
        BNE.N    ??i2c_init_7
//  144         {
//  145             icr = n;
        MOV      R8,R11
//  146             break;                                      //退出while循环
        B.N      ??i2c_init_6
//  147         }
//  148 
//  149         if(Dvalue < min_Dvalue)
??i2c_init_7:
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        UXTH     R10,R10          ;; ZeroExt  R10,R10,#+16,#+16
        CMP      R9,R10
        BCS.N    ??i2c_init_5
//  150         {
//  151             icr = n;
        MOV      R8,R11
//  152             min_Dvalue = Dvalue;
        MOV      R10,R9
        B.N      ??i2c_init_5
//  153         }
//  154     }
//  155 
//  156     I2C_F_REG(I2CN[i2cn])  = ( 0                        // I2C Frequency Divider register (I2Cx_F)  I2C分频寄存器   I2C最大波特率为 400k
//  157                                | I2C_F_MULT(mult)        // 乘数因子 mul =  1<<MULT
//  158                                | I2C_F_ICR(icr)          // 时钟速率 = ICR_2_SCL_divider[ICR] ，查表获得 ICR 与 SCL_divider 映射关系
//  159                              );
??i2c_init_6:
        ANDS     R0,R8,#0x3F
        ORRS     R0,R0,R6, LSL #+6
        LDR.W    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+1]
//  160 
//  161     /* 使能 I2C */
//  162     I2C_C1_REG(I2CN[i2cn]) = ( 0
//  163                                | I2C_C1_IICEN_MASK       //使能I2C
//  164                                //| I2C_C1_IICIE_MASK       //使能中断
//  165                              );
        MOVS     R0,#+128
        LDR.W    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  166 
//  167     return (  bus_clk_khz * 1000 / ( (1<<mult) * ICR_2_SCL_divider[icr])  );
        LDR.W    R0,??DataTable3_2
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+1
        LSLS     R1,R1,R6
        ADD      R2,SP,#+0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        LDRH     R2,[R2, R8, LSL #+1]
        MULS     R1,R2,R1
        SDIV     R0,R0,R1
        ADD      SP,SP,#+132
        POP      {R4-R11,PC}      ;; return
//  168 }
//  169 
//  170 
//  171 /*!
//  172  *  @brief      I2C通信结束后需要调用的函数函数
//  173  *  @since      v5.0
//  174  *  @note       如果通信失败，可尝试增大此延时值，确认是否延时导致的
//  175  */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  176 void i2c_delay(void)
//  177 {
i2c_delay:
        SUB      SP,SP,#+4
//  178     volatile uint16 n = 80;     //注意，这个数据太小，会导致读取错误。
        MOVS     R0,#+80
        STRH     R0,[SP, #+0]
//  179 
//  180     while(n--)
??i2c_delay_0:
        LDRH     R0,[SP, #+0]
        SUBS     R1,R0,#+1
        STRH     R1,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??i2c_delay_1
//  181     {
//  182         asm("nop");
        nop
        B.N      ??i2c_delay_0
//  183     }
//  184 }
??i2c_delay_1:
        ADD      SP,SP,#+4
        BX       LR               ;; return
//  185 
//  186 /*!
//  187  *  @brief      读取I2C设备指定地址寄存器的数据
//  188  *  @param      I2Cn_e        I2C模块(I2C0、I2C1)
//  189  *  @param      SlaveID     从机地址(7位地址)
//  190  *  @param      reg         从机寄存器地址
//  191  *  @return                 读取的寄存器值
//  192  *  @since      v5.0
//  193  *  Sample usage:       uint8 value = i2c_read_reg(I2C0, 0x1D, 1);
//  194  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  195 uint8 i2c_read_reg(I2Cn_e i2cn, uint8 SlaveID, uint8 reg)
//  196 {
i2c_read_reg:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  197 
//  198     //先写入寄存器地址,再读取数据,因此此过程是 I2C 的复合格式,改变数据方向时需要重新启动
//  199     uint8 result;
//  200 
//  201     ASSERT((SlaveID & 0x80) == 0);                      //断言，我们要求的7位地址的值仅仅是7bit,不是通信时要求的高7位
        LSLS     R0,R5,#+24
        BPL.N    ??i2c_read_reg_0
        MOVS     R1,#+201
        LDR.N    R0,??DataTable3_5
        BL       assert_failed
//  202     //有些手册，给出的7位地址指的是8bit里的高7位
//  203     //有些手册，给出的7位地址指的是7bit
//  204     //请自行确认，可以尝试是否通信正常来确认
//  205 
//  206     i2c_Start(i2cn);                                    //发送启动信号
??i2c_read_reg_0:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ORRS     R0,R0,#0x30
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  207 
//  208     i2c_write_byte(i2cn, ( SlaveID << 1 ) | MWSR);      //发送从机地址和写位
        LSLS     R0,R5,#+1
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+4]
??i2c_read_reg_1:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_read_reg_1
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  209 
//  210     i2c_write_byte(i2cn, reg);                          //发送从机里的寄存器地址
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STRB     R6,[R0, #+4]
??i2c_read_reg_2:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_read_reg_2
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  211 
//  212     i2c_RepeatedStart(i2cn);                            //复合格式，发送重新启动信号
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  213 
//  214     i2c_write_byte(i2cn, ( SlaveID << 1) | MRSW );      //发送从机地址和读位
        LSLS     R0,R5,#+1
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+4]
??i2c_read_reg_3:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_read_reg_3
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  215 
//  216     i2c_PutinRxMode(i2cn);                              //进入接收模式(不应答,只接收一个字节)
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ANDS     R0,R0,#0xEF
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  217     result = I2C_D_REG(I2CN[i2cn]);                     //虚假读取一次，启动接收数据
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+4]
        MOVS     R7,R0
//  218     i2c_Wait(i2cn);                                     //等待接收完成
??i2c_read_reg_4:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_read_reg_4
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  219 
//  220     i2c_Stop(i2cn);                                     //发送停止信号
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ANDS     R0,R0,#0xCF
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  221 
//  222     result = I2C_D_REG(I2CN[i2cn]);                     //读取数据
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+4]
        MOVS     R7,R0
//  223 
//  224     i2c_delay();                                        //必须延时一下，否则出错
        BL       i2c_delay
//  225 
//  226     return result;
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  227 }
//  228 
//  229 
//  230 /*!
//  231  *  @brief      写入一个字节数据到I2C设备指定寄存器地址
//  232  *  @param      I2Cn_e        I2C模块(I2C0、I2C1)
//  233  *  @param      SlaveID     从机地址(7位地址)
//  234  *  @param      reg         从机寄存器地址
//  235  *  @param      Data        数据
//  236  *  @since      v5.0
//  237  *  Sample usage:       i2c_write_reg(I2C0, 0x1D, 1,2);     //向从机0x1D 的寄存器 1 写入数据 2
//  238  */
//  239 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  240 void i2c_write_reg(I2Cn_e i2cn, uint8 SlaveID, uint8 reg, uint8 Data)
//  241 {
i2c_write_reg:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  242 
//  243     i2c_Start(i2cn);                                    //发送启动信号
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ORRS     R0,R0,#0x30
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  244 
//  245     i2c_write_byte(i2cn, ( SlaveID << 1 ) | MWSR);      //发送从机地址和写位
        LSLS     R0,R5,#+1
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+4]
??i2c_write_reg_0:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_reg_0
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  246 
//  247     i2c_write_byte(i2cn, reg);                          //发送从机里的寄存器地址
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STRB     R6,[R0, #+4]
??i2c_write_reg_1:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_reg_1
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  248 
//  249     i2c_write_byte(i2cn, Data);                         //发送需要写入的数据
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        STRB     R7,[R0, #+4]
??i2c_write_reg_2:
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_reg_2
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+3]
//  250 
//  251     i2c_Stop(i2cn);
        LDR.N    R0,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LDRB     R0,[R0, #+2]
        ANDS     R0,R0,#0xCF
        LDR.N    R1,??DataTable3_4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+2]
//  252 
//  253     i2c_delay();                                        //延时太短的话，可能写出错
        BL       i2c_delay
//  254 }
        POP      {R0,R4-R7,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  255 void i2c_write_lendata(I2Cn_e i2cn, uint8 SlaveID, uint8 reg, uint8 *ptr, uint8 len)
//  256 {
i2c_write_lendata:
        PUSH     {R4-R8,LR}
        MOVS     R5,R0
        MOVS     R6,R1
        MOVS     R7,R2
        MOV      R8,R3
        LDR      R4,[SP, #+24]
//  257 
//  258     i2c_Start(i2cn);                                    //发送启动信号
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+2]
        ORRS     R0,R0,#0x30
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+2]
//  259 
//  260     i2c_write_byte(i2cn, ( SlaveID << 1 ) | MWSR);      //发送从机地址和写位
        LSLS     R0,R6,#+1
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+4]
??i2c_write_lendata_0:
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_lendata_0
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+3]
//  261 
//  262     i2c_write_byte(i2cn, reg);                          //发送从机里的寄存器地址
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        STRB     R7,[R0, #+4]
??i2c_write_lendata_1:
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_lendata_1
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+3]
//  263 
//  264     for(;len > 0;len--)
??i2c_write_lendata_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??i2c_write_lendata_3
//  265     {
//  266       i2c_write_byte(i2cn, *ptr++);                         //发送需要写入的数据
        LDRB     R0,[R8, #+0]
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+4]
        ADDS     R8,R8,#+1
??i2c_write_lendata_4:
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        LSLS     R0,R0,#+30
        BPL.N    ??i2c_write_lendata_4
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+3]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+3]
//  267     }
        SUBS     R4,R4,#+1
        B.N      ??i2c_write_lendata_2
//  268     i2c_Stop(i2cn);
??i2c_write_lendata_3:
        LDR.N    R0,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRB     R0,[R0, #+2]
        ANDS     R0,R0,#0xCF
        LDR.N    R1,??DataTable3_4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R1,[R1, R5, LSL #+2]
        STRB     R0,[R1, #+2]
//  269 
//  270     i2c_delay();                                        //延时太短的话，可能写出错
        BL       i2c_delay
//  271 }
        POP      {R4-R8,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     bus_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x186a1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     I2CN

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
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
        DC8 69H, 32H, 63H, 2EH, 63H, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC16 20, 22, 24, 26, 28, 30, 34, 40, 28, 32, 36, 40, 44, 48, 56, 68, 48
        DC16 56, 64, 72, 80, 88, 104, 128, 80, 96, 112, 128, 144, 160, 192, 240
        DC16 160, 192, 224, 256, 288, 320, 384, 480, 320, 384, 448, 512, 576
        DC16 640, 768, 960, 640, 768, 896, 1024, 1152, 1280, 1536, 1920, 1280
        DC16 1536, 1792, 2048, 2304, 2560, 3072, 3840

        END
//  272 
//  273 //uint8 i2c_read_reg(I2Cn_e i2cn, uint8 SlaveID, uint8 reg, uint8 *ptr, uint8 len)
//  274 //{
//  275 //
//  276 //    //先写入寄存器地址,再读取数据,因此此过程是 I2C 的复合格式,改变数据方向时需要重新启动
//  277 //    uint8 result;
//  278 //
//  279 //    ASSERT((SlaveID & 0x80) == 0);                      //断言，我们要求的7位地址的值仅仅是7bit,不是通信时要求的高7位
//  280 //    //有些手册，给出的7位地址指的是8bit里的高7位
//  281 //    //有些手册，给出的7位地址指的是7bit
//  282 //    //请自行确认，可以尝试是否通信正常来确认
//  283 //
//  284 //    i2c_Start(i2cn);                                    //发送启动信号
//  285 //
//  286 //    i2c_write_byte(i2cn, ( SlaveID << 1 ) | MWSR);      //发送从机地址和写位
//  287 //
//  288 //    i2c_write_byte(i2cn, reg);                          //发送从机里的寄存器地址    i2c_RepeatedStart(i2cn);
//  289 //    
//  290 //    i2c_RepeatedStart(i2cn);                            //复合格式，发送重新启动信号
//  291 //
//  292 //    i2c_write_byte(i2cn, ( SlaveID << 1) | MRSW );      //发送从机地址和读位
//  293 //
//  294 //    for{;len > 1;len--}
//  295 //    {
//  296 //    
//  297 //    
//  298 //    
//  299 //    *ptr++= I2C_D_REG(I2CN[i2cn]);}
//  300 //    i2c_Wait(i2cn);  
//  301 //    }
//  302     
//  303     
//  304 //
//  305 //    i2c_PutinRxMode(i2cn);                              //进入接收模式(不应答,只接收一个字节)
//  306 //    result = I2C_D_REG(I2CN[i2cn]);                     //虚假读取一次，启动接收数据
//  307 //    i2c_Wait(i2cn);                                     //等待接收完成
//  308 //
//  309 //    i2c_Stop(i2cn);                                     //发送停止信号
//  310 //
//  311 //    result = I2C_D_REG(I2CN[i2cn]);                     //读取数据
//  312 //
//  313 //    i2c_delay();                                        //必须延时一下，否则出错
//  314 //
//  315 //    return result;
//  316 //}
// 
//     2 bytes in section .bss
//     8 bytes in section .data
//   192 bytes in section .rodata
// 1 178 bytes in section .text
// 
// 1 178 bytes of CODE  memory
//   192 bytes of CONST memory
//    10 bytes of DATA  memory
//
//Errors: none
//Warnings: none
