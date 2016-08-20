///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:34
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_key_event.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_key_event.c
//        -D DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_key_event.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN get_key_msg
        EXTERN key_init
        EXTERN save_var
        EXTERN val_cancel
        EXTERN var_display
        EXTERN var_init
        EXTERN var_ok
        EXTERN var_select
        EXTERN var_syn
        EXTERN var_value

        PUBLIC deal_key_event
        PUBLIC key_event_init

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_key_event.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       VCAN_key_event.h
//   11  * @brief      KEY 事件函数实现
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2014-01-04
//   15  */
//   16 
//   17 #include "VCAN_key_event.h"
//   18 #include "VCAN_UI_VAR.h"
//   19 //#include "NRF24L0.h"
//   20 //#include "NRF24L0_MSG.h"
//   21 
//   22 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   23 void key_event_init()
//   24 {
key_event_init:
        PUSH     {R7,LR}
//   25     //初始化 全部 按键
//   26     key_init(KEY_MAX);
        MOVS     R0,#+8
        BL       key_init
//   27 
//   28     //初始化临时变量
//   29     var_init();
        BL       var_init
//   30 
//   31     //同步全部数据并显示
//   32     var_syn(VAR_MAX);       //同步全部 ,必须先同步再显示全部，因为有可能同步失败。
        MOVS     R0,#+7
        BL       var_syn
//   33     var_display(VAR_MAX);   //显示全部
        MOVS     R0,#+7
        BL       var_display
//   34 }
        POP      {R0,PC}          ;; return
//   35 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   36 void deal_key_event()
//   37 {
deal_key_event:
        PUSH     {R7,LR}
//   38     KEY_MSG_t keymsg;
//   39 
//   40     while(get_key_msg(& keymsg))     //获得按键就进行处理
??deal_key_event_0:
        ADD      R0,SP,#+0
        BL       get_key_msg
        CMP      R0,#+0
        BEQ.W    ??deal_key_event_1
//   41     {
//   42         if(keymsg.status == KEY_DOWN)
        LDRB     R0,[SP, #+1]
        CMP      R0,#+0
        BNE.N    ??deal_key_event_2
//   43         {
//   44             switch(keymsg.key)
        LDRB     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??deal_key_event_3
        CMP      R0,#+2
        BEQ.N    ??deal_key_event_4
        BCC.N    ??deal_key_event_5
        CMP      R0,#+4
        BEQ.N    ??deal_key_event_6
        BCC.N    ??deal_key_event_7
        CMP      R0,#+6
        BEQ.N    ??deal_key_event_8
        BCC.N    ??deal_key_event_9
        CMP      R0,#+7
        BEQ.N    ??deal_key_event_10
        B.N      ??deal_key_event_11
//   45             {
//   46             case KEY_U:
//   47                 var_value(VAR_ADD);
??deal_key_event_3:
        MOVS     R0,#+4
        BL       var_value
//   48                 break;
        B.N      ??deal_key_event_0
//   49 
//   50             case KEY_D:
//   51                 var_value(VAR_SUB);
??deal_key_event_5:
        MOVS     R0,#+5
        BL       var_value
//   52                 break;
        B.N      ??deal_key_event_0
//   53 
//   54             case KEY_L:
//   55                 var_select(VAR_PREV);
??deal_key_event_4:
        MOVS     R0,#+1
        BL       var_select
//   56                 break;
        B.N      ??deal_key_event_0
//   57 
//   58             case KEY_R:
//   59                 var_select(VAR_NEXT);
??deal_key_event_7:
        MOVS     R0,#+0
        BL       var_select
//   60                 break;
        B.N      ??deal_key_event_0
//   61 
//   62             case KEY_B:
//   63                 var_ok();
??deal_key_event_9:
        BL       var_ok
//   64                 break;
        B.N      ??deal_key_event_0
//   65 
//   66             case KEY_A:
//   67                 val_cancel();
??deal_key_event_6:
        BL       val_cancel
//   68                 break;
        B.N      ??deal_key_event_0
//   69 
//   70             case KEY_START:
//   71                 save_var(CAR_CTRL,CAR_START);
??deal_key_event_8:
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       save_var
//   72                 var_syn(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_syn
//   73                 var_display(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_display
//   74                 break;
        B.N      ??deal_key_event_0
//   75             case KEY_STOP:
//   76                 save_var(CAR_CTRL,CAR_STOP);
??deal_key_event_10:
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       save_var
//   77                 var_syn(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_syn
//   78                 var_display(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_display
//   79                 break;
        B.N      ??deal_key_event_0
//   80 
//   81             default:
//   82                 break;
??deal_key_event_11:
        B.N      ??deal_key_event_0
//   83             }
//   84         }
//   85         else if(keymsg.status == KEY_HOLD)
??deal_key_event_2:
        LDRB     R0,[SP, #+1]
        CMP      R0,#+2
        BNE.N    ??deal_key_event_0
//   86         {
//   87             switch(keymsg.key)
        LDRB     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??deal_key_event_12
        CMP      R0,#+1
        BEQ.N    ??deal_key_event_13
        CMP      R0,#+2
        BEQ.N    ??deal_key_event_14
        CMP      R0,#+3
        BEQ.N    ??deal_key_event_15
        CMP      R0,#+5
        BEQ.N    ??deal_key_event_16
        CMP      R0,#+6
        BEQ.N    ??deal_key_event_17
        CMP      R0,#+7
        BEQ.N    ??deal_key_event_18
        B.N      ??deal_key_event_19
//   88             {
//   89             case KEY_U:
//   90                 var_value(VAR_ADD_HOLD);
??deal_key_event_12:
        MOVS     R0,#+6
        BL       var_value
//   91                 break;
        B.N      ??deal_key_event_0
//   92 
//   93             case KEY_D:
//   94                 var_value(VAR_SUB_HOLD);
??deal_key_event_13:
        MOVS     R0,#+7
        BL       var_value
//   95                 break;
        B.N      ??deal_key_event_0
//   96 
//   97             case KEY_L:
//   98                 var_select(VAR_PREV_HOLD);
??deal_key_event_14:
        MOVS     R0,#+3
        BL       var_select
//   99                 break;
        B.N      ??deal_key_event_0
//  100 
//  101             case KEY_R:
//  102                 var_select(VAR_NEXT_HOLD);
??deal_key_event_15:
        MOVS     R0,#+2
        BL       var_select
//  103                 break;
        B.N      ??deal_key_event_0
//  104 
//  105             case KEY_B:                //长按 OK 键 同步全部数据并显示
//  106                 var_syn(VAR_MAX);       //同步全部 ,必须先同步再显示全部，因为有可能同步失败。
??deal_key_event_16:
        MOVS     R0,#+7
        BL       var_syn
//  107                 var_display(VAR_MAX);   //显示全部
        MOVS     R0,#+7
        BL       var_display
//  108                 break;
        B.N      ??deal_key_event_0
//  109 
//  110             case KEY_START:
//  111                 save_var(CAR_CTRL,CAR_START);
??deal_key_event_17:
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       save_var
//  112                 while(var_syn(CAR_CTRL)==0);
??deal_key_event_20:
        MOVS     R0,#+0
        BL       var_syn
        CMP      R0,#+0
        BEQ.N    ??deal_key_event_20
//  113                 var_display(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_display
//  114                 break;
        B.N      ??deal_key_event_0
//  115 
//  116             case KEY_STOP:
//  117                 save_var(CAR_CTRL,CAR_STOP);
??deal_key_event_18:
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       save_var
//  118                 while(var_syn(CAR_CTRL)==0);
??deal_key_event_21:
        MOVS     R0,#+0
        BL       var_syn
        CMP      R0,#+0
        BEQ.N    ??deal_key_event_21
//  119                 var_display(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_display
//  120 
//  121             default:            //不需要处理 cancel
//  122                 break;
??deal_key_event_19:
        B.N      ??deal_key_event_0
//  123             }
//  124         }
//  125         else
//  126         {
//  127             //KEY_UP ,不进行处理
//  128         }
//  129     }
//  130 }
??deal_key_event_1:
        POP      {R0,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  131 
//  132 
//  133 
//  134 
//  135 
// 
// 312 bytes in section .text
// 
// 312 bytes of CODE memory
//
//Errors: none
//Warnings: none
