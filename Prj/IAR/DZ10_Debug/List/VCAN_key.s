///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:33
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_key.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_key.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_key.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_get
        EXTERN gpio_init
        EXTERN port_init_NoALT
        EXTERN systick_delay_ms

        PUBLIC Common_Key
        PUBLIC Dial_Switch
        PUBLIC FiveDir_Key_Init
        PUBLIC KEY_PTxn
        PUBLIC get_key_msg
        PUBLIC key_IRQHandler
        PUBLIC key_check
        PUBLIC key_get
        PUBLIC key_init
        PUBLIC key_msg
        PUBLIC key_msg_flag
        PUBLIC key_msg_front
        PUBLIC key_msg_rear
        PUBLIC send_key_msg

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_key.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,ɽ��Ƽ�
//    4  *     All rights reserved.
//    5  *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6  *
//    7  *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8  *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9  *
//   10  * @file       VCAN_KEY.c
//   11  * @brief      KEY��������ʵ��
//   12  * @author     ɽ��Ƽ�
//   13  * @version    v5.0
//   14  * @date       2013-07-10
//   15  */
//   16 
//   17 
//   18 /*
//   19  * ����ͷ�ļ�
//   20  */
//   21 #include "common.h"
//   22 #include "MK60_port.h"
//   23 #include "MK60_gpio.h"
//   24 #include "VCAN_key.h"
//   25 
//   26 
//   27 /*
//   28  * ���� KEY ��Ŷ�Ӧ�Ĺܽ�
//   29  */

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   30 PTXn_e KEY_PTxn[KEY_MAX] = {PTD10, PTD14, PTD11, PTD12, PTD7, PTD13, PTC14, PTC15};
KEY_PTxn:
        DATA
        DC8 106, 110, 107, 108, 103, 109, 78, 79
//   31 
//   32 
//   33 /*!
//   34  *  @brief      ��ʼ��key�˿�(key С�� KEY_MAX ʱ��ʼ�� ��Ӧ�˿ڣ������ʼ��ȫ���˿�)
//   35  *  @param      KEY_e    KEY���
//   36  *  @since      v5.0
//   37  *  Sample usage:       key_init (KEY_U);    //��ʼ�� KEY_U
//   38  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 void    key_init(KEY_e key)
//   40 {
key_init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   41     if(key < KEY_MAX)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??key_init_0
//   42     {
//   43         gpio_init(KEY_PTxn[key], GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.N    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_init
//   44         port_init_NoALT(KEY_PTxn[key], PULLUP);         //���ָ��ò��䣬�����ı�����ѡ��
        MOVS     R1,#+3
        LDR.N    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       port_init_NoALT
        B.N      ??key_init_1
//   45     }
//   46     else
//   47     {
//   48         key = KEY_MAX;
??key_init_0:
        MOVS     R0,#+8
        MOVS     R4,R0
//   49 
//   50         //��ʼ��ȫ�� ����
//   51         while(key--)
??key_init_2:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??key_init_1
//   52         {
//   53             gpio_init(KEY_PTxn[key], GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.N    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_init
//   54             port_init_NoALT(KEY_PTxn[key], PULLUP);         //���ָ��ò��䣬�����ı�����ѡ��
        MOVS     R1,#+3
        LDR.N    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       port_init_NoALT
        B.N      ??key_init_2
//   55         }
//   56 
//   57     }
//   58 }
??key_init_1:
        POP      {R4,PC}          ;; return
//   59 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 void Dial_Switch(void)           //���뿪��
//   61 {
Dial_Switch:
        PUSH     {R7,LR}
//   62     gpio_init(Dial_1, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+140
        BL       gpio_init
//   63     gpio_init(Dial_2, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+139
        BL       gpio_init
//   64     gpio_init(Dial_3, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+152
        BL       gpio_init
//   65     gpio_init(Dial_4, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+154
        BL       gpio_init
//   66     gpio_init(Dial_5, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+153
        BL       gpio_init
//   67     gpio_init(Dial_6, GPO, 0);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+156
        BL       gpio_init
//   68  
//   69 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void Common_Key(void)            //��ͨ������ʼ��
//   71 {
Common_Key:
        PUSH     {R7,LR}
//   72         gpio_init(Key_1, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+52
        BL       gpio_init
//   73         port_init_NoALT(Key_1, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+52
        BL       port_init_NoALT
//   74         gpio_init(Key_2, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+53
        BL       gpio_init
//   75         port_init_NoALT(Key_2, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+53
        BL       port_init_NoALT
//   76         gpio_init(Key_3, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+54
        BL       gpio_init
//   77         port_init_NoALT(Key_3, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+54
        BL       port_init_NoALT
//   78         gpio_init(Key_4, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+55
        BL       gpio_init
//   79         port_init_NoALT(Key_4, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+55
        BL       port_init_NoALT
//   80 }
        POP      {R0,PC}          ;; return
//   81         
//   82         

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   83 void FiveDir_Key_Init(void)          //���򰴼���ʼ��
//   84 {
FiveDir_Key_Init:
        PUSH     {R7,LR}
//   85         gpio_init(Key_L, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       gpio_init
//   86         port_init_NoALT(Key_L, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+24
        BL       port_init_NoALT
//   87         gpio_init(Key_R, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+96
        BL       gpio_init
//   88         port_init_NoALT(Key_R, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+96
        BL       port_init_NoALT
//   89         gpio_init(Key_U, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+25
        BL       gpio_init
//   90         port_init_NoALT(Key_U, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+25
        BL       port_init_NoALT
//   91         gpio_init(Key_D, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+27
        BL       gpio_init
//   92         port_init_NoALT(Key_D, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+27
        BL       port_init_NoALT
//   93         gpio_init(Key_M, GPI, 0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+26
        BL       gpio_init
//   94         port_init_NoALT(Key_M, PULLUP);
        MOVS     R1,#+3
        MOVS     R0,#+26
        BL       port_init_NoALT
//   95 
//   96 }
        POP      {R0,PC}          ;; return
//   97 
//   98 /*!
//   99  *  @brief      ��ȡkey״̬��������ʱ������
//  100  *  @param      KEY_e           KEY���
//  101  *  @return     KEY_STATUS_e    KEY״̬��KEY_DOWN��KEY_DOWN��
//  102  *  @since      v5.0
//  103  *  Sample usage:
//  104                     if(key_get(KEY_U) ==  KEY_DOWN)
//  105                     {
//  106                         printf("\n��������")
//  107                     }
//  108  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  109 KEY_STATUS_e key_get(KEY_e key)
//  110 {
key_get:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  111     if(gpio_get(KEY_PTxn[key]) == KEY_DOWN)
        LDR.N    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        BL       gpio_get
        CMP      R0,#+0
        BNE.N    ??key_get_0
//  112     {
//  113         return KEY_DOWN;
        MOVS     R0,#+0
        B.N      ??key_get_1
//  114     }
//  115     return KEY_UP;
??key_get_0:
        MOVS     R0,#+1
??key_get_1:
        POP      {R4,PC}          ;; return
//  116 }
//  117 
//  118 
//  119 /*!
//  120  *  @brief      ���key״̬������ʱ������
//  121  *  @param      KEY_e           KEY���
//  122  *  @return     KEY_STATUS_e    KEY״̬��KEY_DOWN��KEY_DOWN��
//  123  *  @since      v5.0
//  124  *  Sample usage:
//  125                     if(key_check(KEY_U) ==  KEY_DOWN)
//  126                     {
//  127                         printf("\n��������")
//  128                     }
//  129  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  130 KEY_STATUS_e key_check(KEY_e key)
//  131 {
key_check:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  132     if(key_get(key) == KEY_DOWN)
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       key_get
        CMP      R0,#+0
        BNE.N    ??key_check_0
//  133     {
//  134         DELAY_MS(10);
        MOVS     R0,#+10
        BL       systick_delay_ms
//  135         if( key_get(key) == KEY_DOWN)
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       key_get
        CMP      R0,#+0
        BNE.N    ??key_check_0
//  136         {
//  137             return KEY_DOWN;
        MOVS     R0,#+0
        B.N      ??key_check_1
//  138         }
//  139     }
//  140     return KEY_UP;
??key_check_0:
        MOVS     R0,#+1
??key_check_1:
        POP      {R4,PC}          ;; return
//  141 }
//  142 
//  143 
//  144 /*********************  ���´�����ʵ�ְ�����ʱɨ�裬������Ϣ��FIFO  ********************/
//  145 /*
//  146  * ���尴����ϢFIFO״̬
//  147  */
//  148 typedef enum
//  149 {
//  150     KEY_MSG_EMPTY,      //û�а�����Ϣ
//  151     KEY_MSG_NORMAL,     //�������а�����Ϣ��������
//  152     KEY_MSG_FULL,       //������Ϣ��
//  153 } key_msg_e;
//  154 
//  155 /*
//  156  * ���尴����ϢFIFO��صı���
//  157  */

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  158 KEY_MSG_t           key_msg[KEY_MSG_FIFO_SIZE];             //������ϢFIFO
key_msg:
        DS8 40

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  159 volatile uint8      key_msg_front = 0, key_msg_rear = 0;    //����FIFO��ָ��
key_msg_front:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
key_msg_rear:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  160 volatile uint8      key_msg_flag = KEY_MSG_EMPTY;           //������ϢFIFO״̬
key_msg_flag:
        DS8 1
//  161 
//  162 
//  163 /*!
//  164  *  @brief      ���Ͱ�����Ϣ��FIFO
//  165  *  @param      KEY_MSG_t       ������Ϣ
//  166  *  @since      v5.0
//  167  *  Sample usage:
//  168                     KEY_MSG_t *keymsg;
//  169                     keymsg.key      = KEY_U;
//  170                     keymsg.status   = KEY_HOLD;
//  171                     send_key_msg(keymsg);                   //����
//  172  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  173 void send_key_msg(KEY_MSG_t keymsg)
//  174 {
send_key_msg:
        PUSH     {R0}
//  175     uint8 tmp;
//  176     //������FIFO��
//  177     if(key_msg_flag == KEY_MSG_FULL)
        LDR.N    R1,??DataTable4_1
        LDRB     R1,[R1, #+0]
        CMP      R1,#+2
        BEQ.N    ??send_key_msg_0
//  178     {
//  179         //����ֱ�Ӳ�����
//  180         return ;
//  181     }
//  182     key_msg[key_msg_rear].key = keymsg.key;
??send_key_msg_1:
        LDRB     R1,[SP, #+0]
        LDR.N    R2,??DataTable4_2
        LDR.N    R3,??DataTable4_3
        LDRB     R3,[R3, #+0]
        STRB     R1,[R2, R3, LSL #+1]
//  183     key_msg[key_msg_rear].status = keymsg.status;
        LDRB     R1,[SP, #+1]
        LDR.N    R2,??DataTable4_2
        LDR.N    R3,??DataTable4_3
        LDRB     R3,[R3, #+0]
        ADDS     R2,R2,R3, LSL #+1
        STRB     R1,[R2, #+1]
//  184 
//  185     key_msg_rear++;
        LDR.N    R1,??DataTable4_3
        LDRB     R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR.N    R2,??DataTable4_3
        STRB     R1,[R2, #+0]
//  186 
//  187     if(key_msg_rear >= KEY_MSG_FIFO_SIZE)
        LDR.N    R1,??DataTable4_3
        LDRB     R1,[R1, #+0]
        CMP      R1,#+20
        BLT.N    ??send_key_msg_2
//  188     {
//  189         key_msg_rear = 0;                       //��ͷ��ʼ
        MOVS     R1,#+0
        LDR.N    R2,??DataTable4_3
        STRB     R1,[R2, #+0]
//  190     }
//  191 
//  192     tmp = key_msg_rear;
??send_key_msg_2:
        LDR.N    R1,??DataTable4_3
        LDRB     R1,[R1, #+0]
        MOVS     R0,R1
//  193     if(tmp == key_msg_front)                   //׷��ƨ���ˣ�����
        LDR.N    R1,??DataTable4_4
        LDRB     R1,[R1, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,R1
        BNE.N    ??send_key_msg_3
//  194     {
//  195         key_msg_flag = KEY_MSG_FULL;
        MOVS     R1,#+2
        LDR.N    R2,??DataTable4_1
        STRB     R1,[R2, #+0]
        B.N      ??send_key_msg_4
//  196     }
//  197     else
//  198     {
//  199         key_msg_flag = KEY_MSG_NORMAL;
??send_key_msg_3:
        MOVS     R1,#+1
        LDR.N    R2,??DataTable4_1
        STRB     R1,[R2, #+0]
//  200     }
//  201 }
??send_key_msg_4:
??send_key_msg_0:
        ADD      SP,SP,#+4
        BX       LR               ;; return
//  202 
//  203 
//  204 /*!
//  205  *  @brief      ��FIFO���ȡ������Ϣ
//  206  *  @param      KEY_MSG_t       ������Ϣ
//  207  *  @return     �Ƿ��ȡ������Ϣ��1Ϊ��ȡ�ɹ���0Ϊû��ȡ��������Ϣ��
//  208  *  @since      v5.0
//  209  *  Sample usage:
//  210                     KEY_MSG_t keymsg;
//  211                     if(get_key_msg(&keymsg) == 1)
//  212                     {
//  213                         printf("\n���°���KEY%d,����Ϊ%d��0Ϊ���£�1Ϊ����2Ϊ������",keymsg.key,keymsg.status);
//  214                     }
//  215  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  216 uint8 get_key_msg(KEY_MSG_t *keymsg)
//  217 {
get_key_msg:
        MOVS     R1,R0
//  218     uint8 tmp;
//  219 
//  220     if(key_msg_flag == KEY_MSG_EMPTY)               //������ϢFIFOΪ�գ�ֱ�ӷ���0
        LDR.N    R0,??DataTable4_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??get_key_msg_0
//  221     {
//  222         return 0;
        MOVS     R0,#+0
        B.N      ??get_key_msg_1
//  223     }
//  224 
//  225     keymsg->key = key_msg[key_msg_front].key;       //��FIFO�����л�ȡ����ֵ
??get_key_msg_0:
        LDR.N    R0,??DataTable4_2
        LDR.N    R3,??DataTable4_4
        LDRB     R3,[R3, #+0]
        LDRB     R0,[R0, R3, LSL #+1]
        STRB     R0,[R1, #+0]
//  226     keymsg->status = key_msg[key_msg_front].status; //��FIFO�����л�ȡ��������
        LDR.N    R0,??DataTable4_2
        LDR.N    R3,??DataTable4_4
        LDRB     R3,[R3, #+0]
        ADDS     R0,R0,R3, LSL #+1
        LDRB     R0,[R0, #+1]
        STRB     R0,[R1, #+1]
//  227 
//  228     key_msg_front++;                                //FIFO����ָ���1��ָ����һ����Ϣ
        LDR.N    R0,??DataTable4_4
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R3,??DataTable4_4
        STRB     R0,[R3, #+0]
//  229 
//  230     if(key_msg_front >= KEY_MSG_FIFO_SIZE)          //FIFOָ�����������0��ʼ����
        LDR.N    R0,??DataTable4_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+20
        BLT.N    ??get_key_msg_2
//  231     {
//  232         key_msg_front = 0;                          //��ͷ��ʼ������ѭ���������飩
        MOVS     R0,#+0
        LDR.N    R3,??DataTable4_4
        STRB     R0,[R3, #+0]
//  233     }
//  234 
//  235     tmp = key_msg_rear;
??get_key_msg_2:
        LDR.N    R0,??DataTable4_3
        LDRB     R0,[R0, #+0]
        MOVS     R2,R0
//  236     if(key_msg_front == tmp)                        //�Ƚ϶��׺Ͷ�β�Ƿ�һ����һ�����ʾFIFO�ѿ���
        LDR.N    R0,??DataTable4_4
        LDRB     R0,[R0, #+0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R0,R2
        BNE.N    ??get_key_msg_3
//  237     {
//  238         key_msg_flag = KEY_MSG_EMPTY;
        MOVS     R0,#+0
        LDR.N    R3,??DataTable4_1
        STRB     R0,[R3, #+0]
        B.N      ??get_key_msg_4
//  239     }
//  240     else
//  241     {
//  242         key_msg_flag = KEY_MSG_NORMAL;
??get_key_msg_3:
        MOVS     R0,#+1
        LDR.N    R3,??DataTable4_1
        STRB     R0,[R3, #+0]
//  243     }
//  244 
//  245     return 1;
??get_key_msg_4:
        MOVS     R0,#+1
??get_key_msg_1:
        BX       LR               ;; return
//  246 }
//  247 
//  248 /*!
//  249  *  @brief      ��ʱ���key״̬
//  250  *  @since      v5.0
//  251  *  @note       �˺�����Ҫ���� ��ʱ�жϷ��������ʱ10msִ��һ��
//  252  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  253 void key_IRQHandler(void)
//  254 {
key_IRQHandler:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//  255 
//  256     KEY_e   keynum;
//  257     static uint8 keytime[KEY_MAX];                          //��̬���飬��������鰴��ʱ��
//  258 
//  259     KEY_MSG_t keymsg;                                       //������Ϣ
//  260 
//  261     for(keynum = (KEY_e)0 ; keynum < KEY_MAX; keynum ++)    //ÿ��������ѯ
        MOVS     R0,#+0
        MOVS     R4,R0
??key_IRQHandler_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??key_IRQHandler_1
//  262     {
//  263         if(key_get(keynum) == KEY_DOWN)                     //�жϰ����Ƿ���
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       key_get
        CMP      R0,#+0
        BNE.N    ??key_IRQHandler_2
//  264         {
//  265             keytime[keynum]++;                              //����ʱ���ۼ�
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
//  266 
//  267             if(keytime[keynum] <= KEY_DOWN_TIME)            //�ж�ʱ���Ƿ�û��������ȷ�ϰ���ʱ��
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+2
        BLT.N    ??key_IRQHandler_3
//  268             {
//  269                 continue;                                   //û�ﵽ��������ȴ�
//  270             }
//  271             else if(keytime[keynum] == KEY_DOWN_TIME + 1 )  //�ж�ʱ���Ƿ�Ϊ����ȷ�ϰ���ʱ��
??key_IRQHandler_4:
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+2
        BNE.N    ??key_IRQHandler_5
//  272             {
//  273                 //ȷ�ϰ�������
//  274                 keymsg.key = keynum;
        STRB     R4,[SP, #+0]
//  275                 keymsg.status = KEY_DOWN;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  276                 send_key_msg(keymsg);                       //�Ѱ���ֵ�Ͱ������ͷ�����Ϣ��FIFO
        LDR      R0,[SP, #+0]
        BL       send_key_msg
        B.N      ??key_IRQHandler_3
//  277             }
//  278             else if(keytime[keynum] <= KEY_HOLD_TIME)       //�Ƿ�û��������HOLD����ȷ��ʱ��
??key_IRQHandler_5:
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+51
        BLT.N    ??key_IRQHandler_3
//  279             {
//  280                 continue;                                   //û������������ȴ�
//  281             }
//  282             else if(keytime[keynum]  == KEY_HOLD_TIME + 1)  //�Ƿ�Ϊ����holdȷ��ʱ��
??key_IRQHandler_6:
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+51
        BNE.N    ??key_IRQHandler_7
//  283             {
//  284                 //ȷ�ϳ���HOLD
//  285                 keymsg.key = keynum;
        STRB     R4,[SP, #+0]
//  286                 keymsg.status = KEY_HOLD;
        MOVS     R0,#+2
        STRB     R0,[SP, #+1]
//  287                 send_key_msg(keymsg);                       //����
        LDR      R0,[SP, #+0]
        BL       send_key_msg
//  288                 keytime[keynum] = KEY_DOWN_TIME + 1;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
        B.N      ??key_IRQHandler_3
//  289             }
//  290             else
//  291             {
//  292                 keytime[keynum] = KEY_DOWN_TIME + 1;        //�����ظ���� hold ״̬
??key_IRQHandler_7:
        MOVS     R0,#+2
        LDR.N    R1,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
        B.N      ??key_IRQHandler_3
//  293             }
//  294         }
//  295         else
//  296         {
//  297             if(keytime[keynum] > KEY_DOWN_TIME)             //���ȷ�Ϲ����°���
??key_IRQHandler_2:
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        CMP      R0,#+2
        BLT.N    ??key_IRQHandler_8
//  298             {
//  299                 keymsg.key = keynum;
        STRB     R4,[SP, #+0]
//  300                 keymsg.status = KEY_UP;
        MOVS     R0,#+1
        STRB     R0,[SP, #+1]
//  301                 send_key_msg(keymsg);                       //���Ͱ���������Ϣ
        LDR      R0,[SP, #+0]
        BL       send_key_msg
//  302             }
//  303 
//  304             keytime[keynum] = 0;                            //ʱ���ۼ���0
??key_IRQHandler_8:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R4, R1]
//  305         }
//  306     }
??key_IRQHandler_3:
        ADDS     R4,R4,#+1
        B.N      ??key_IRQHandler_0
//  307 }
??key_IRQHandler_1:
        POP      {R0,R1,R4,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     KEY_PTxn

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     key_msg_flag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     key_msg

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     key_msg_rear

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     key_msg_front

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     ??keytime

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??keytime:
        DS8 8

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  308 
//  309 
//  310 
// 
//  51 bytes in section .bss
//   8 bytes in section .data
// 778 bytes in section .text
// 
// 778 bytes of CODE memory
//  59 bytes of DATA memory
//
//Errors: none
//Warnings: none
