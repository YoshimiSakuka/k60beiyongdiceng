///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:20
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_UI_VAR.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_UI_VAR.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_UI_VAR.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN LCD_num_BC
        EXTERN assert_failed
        EXTERN nrf_msg_tx
        EXTERN nrf_tx_state
        EXTERN var1
        EXTERN var2
        EXTERN var3
        EXTERN var4
        EXTERN var5
        EXTERN var6

        PUBLIC car_ctrl_get
        PUBLIC car_ctrl_syn
        PUBLIC get_var
        PUBLIC last_tab
        PUBLIC new_tab
        PUBLIC num_info
        PUBLIC save_var
        PUBLIC save_var2buff
        PUBLIC updata_var
        PUBLIC val_cancel
        PUBLIC var_addr
        PUBLIC var_display
        PUBLIC var_init
        PUBLIC var_ok
        PUBLIC var_select
        PUBLIC var_syn
        PUBLIC var_value

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_UI_VAR.c
//    1 #include "common.h"
//    2 #include "VCAN_LCD.h"
//    3 #include "VCAN_UI_VAR.h"
//    4 #include "VCAN_NRF24L0_MSG.h"
//    5 
//    6 
//    7 
//    8 #define VAR_VALUE(var_tab)      num_info[var_tab].val       //ָ����ŵı�����ֵ
//    9 #define VAR_OLDVALUE(var_tab)   num_info[var_tab].oldval    //ָ����ŵı��������ȷ��ֵ
//   10 #define VAR_MAXVALUE(var_tab)   num_info[var_tab].maxval
//   11 #define VAR_MINVALUE(var_tab)   num_info[var_tab].minval
//   12 #define VAR_SITE(var_tab)       num_info[var_tab].site
//   13 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   14 static uint8  car_ctrl = CAR_NULL;
car_ctrl:
        DS8 1
//   15 
//   16 extern uint8  var1, var2;
//   17 extern uint16 var3, var4;
//   18 extern uint32 var5, var6;
//   19 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20 uint32 *var_addr[VAR_MAX] = {(uint32 *)&car_ctrl,(uint32 *)&var1, (uint32 *)&var2, (uint32 *)&var3, (uint32 *)&var4, (uint32 *)&var5, (uint32 *)&var6};
var_addr:
        DATA
        DC32 car_ctrl, var1, var2, var3, var4, var5, var6
//   21 
//   22 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   23 ui_var_info_t  num_info[VAR_MAX] =
num_info:
        DATA
        DC32 0, 0, 0, 11
        DC16 90, 102
        DC32 0, 0, 0, 100
        DC16 90, 0
        DC32 0, 0, 0, 100
        DC16 90, 17
        DC32 0, 0, 0, 300
        DC16 90, 34
        DC32 0, 0, 0, 300
        DC16 90, 51
        DC32 0, 0, 0, 65540
        DC16 90, 68
        DC32 0, 0, 0, 65540
        DC16 90, 85
//   24 {
//   25     //  {val,oldval,minval,maxval,{x,y}}
//   26     //val,oldval,���ڵ���key_event_init��ʱ������Ӧ�����︳ֵ���������������ֵ��������д
//   27     //��Ҫ����minval,maxval,{x,y}
//   28     //���ע����Сֵ��Ҫ�������ֵ
//   29     {0, 0, 0, CAR_CTRL_MAX, {90,102}},      //���� car_ctrl��
//   30     {0, 0, 0, 100, {90, 0}},                //���� var1��
//   31     {0, 0, 0, 100, {90, 17}},               //���� var2��
//   32     {0, 0, 0, 300, {90, 34}},               //���� var3��
//   33     {0, 0, 0, 300, {90, 51}},               //���� var4��
//   34     {0, 0, 0, 65540, {90, 68}},             //���� var5��
//   35     {0, 0, 0, 65540, {90, 85}}              //���� var6��
//   36 };
//   37 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   38 uint8   new_tab = 0;        //��ǰѡ��ı������
new_tab:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   39 uint32  last_tab;           //�����յ��ı������
last_tab:
        DS8 4
//   40 
//   41 
//   42 
//   43 //ͬ��ָ����ֵ��tab Ϊ VAR_NUM ʱ��ʾȫ��ͬ����С����ͬ����Ӧ��
//   44 //������ͬ������ʾȫ������Ϊ�п���ͬ��ʧ�ܡ�
//   45 //static uint8 var_syn(uint8 tab);         //ͬ�����ݣ�1��ʾ�ɹ���0��ʾʧ��
//   46 
//   47 void save_var2buff(var_tab_e var_num, uint8 *sendbuf);              //����Ҫ���͵ı���������д�뵽������
//   48 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void var_init()
//   50 {
var_init:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//   51     uint8   var_num;
//   52     uint32  vartemp;
//   53 
//   54     for(var_num = 0; var_num < VAR_MAX; var_num++)
        MOVS     R0,#+0
        MOVS     R4,R0
??var_init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+7
        BGE.N    ??var_init_1
//   55     {
//   56         get_var((var_tab_e)var_num, &vartemp);
        ADD      R1,SP,#+0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       get_var
//   57         num_info[var_num].val       = vartemp;
        LDR      R0,[SP, #+0]
        LDR.W    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        STR      R0,[R1, #+0]
//   58         num_info[var_num].oldval    = vartemp;
        LDR      R0,[SP, #+0]
        LDR.W    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        STR      R0,[R1, #+4]
//   59 
//   60         //�����Сֵ�����ֵ
//   61         ASSERT(num_info[var_num].maxval  >=  num_info[var_num].minval );
        LDR.W    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R0,[R0, #+12]
        LDR.W    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        LDR      R1,[R1, #+8]
        CMP      R0,R1
        BCS.N    ??var_init_2
        MOVS     R1,#+61
        LDR.W    R0,??DataTable11_1
        BL       assert_failed
//   62     }
??var_init_2:
        ADDS     R4,R4,#+1
        B.N      ??var_init_0
//   63 }
??var_init_1:
        POP      {R0,R1,R4,PC}    ;; return
//   64 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   65 void save_var(var_tab_e var_tal, uint32 var_data)
//   66 {
//   67     if(var_tal <= VAR_8BIT)
save_var:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+3
        BGE.N    ??save_var_0
//   68     {
//   69         *((uint8 *)(var_addr[var_tal])) = var_data;
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRB     R1,[R2, #+0]
        B.N      ??save_var_1
//   70     }
//   71     else if(var_tal <= VAR_16BIT)
??save_var_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+5
        BGE.N    ??save_var_2
//   72     {
//   73         *((uint16 *)(var_addr[var_tal])) = var_data;
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STRH     R1,[R2, #+0]
        B.N      ??save_var_1
//   74     }
//   75     else if(var_tal <= VAR_32BIT)
??save_var_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+7
        BGE.N    ??save_var_1
//   76     {
//   77         *((uint32 *)(var_addr[var_tal])) = var_data;
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        STR      R1,[R2, #+0]
//   78     }
//   79 
//   80     VAR_VALUE(var_tal) = var_data;
??save_var_1:
        LDR.W    R2,??DataTable11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+20
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+0]
//   81     VAR_OLDVALUE(var_tal) = var_data;
        LDR.W    R2,??DataTable11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+20
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+4]
//   82 }
        BX       LR               ;; return
//   83 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void get_var(var_tab_e var_tal, uint32 *var_data)
//   85 {
//   86     if(var_tal <= VAR_8BIT)
get_var:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+3
        BGE.N    ??get_var_0
//   87     {
//   88         *var_data = (uint32) * ((uint8 *)(var_addr[var_tal]));
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDRB     R2,[R2, #+0]
        STR      R2,[R1, #+0]
        B.N      ??get_var_1
//   89     }
//   90     else if(var_tal <= VAR_16BIT)
??get_var_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+5
        BGE.N    ??get_var_2
//   91     {
//   92         *var_data = (uint32) * ((uint16 *)(var_addr[var_tal])) ;
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDRH     R2,[R2, #+0]
        STR      R2,[R1, #+0]
        B.N      ??get_var_1
//   93     }
//   94     else if(var_tal <= VAR_32BIT)
??get_var_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+7
        BGE.N    ??get_var_1
//   95     {
//   96         *var_data = (uint32) * ((uint32 *)(var_addr[var_tal]));
        LDR.W    R2,??DataTable11_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR      R2,[R2, #+0]
        STR      R2,[R1, #+0]
//   97     }
//   98 }
??get_var_1:
        BX       LR               ;; return
//   99 
//  100 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  101 void updata_var(var_tab_e var_tal)
//  102 {
updata_var:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  103     uint32 vartemp;
//  104 
//  105     get_var(var_tal, &vartemp);
        ADD      R1,SP,#+0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       get_var
//  106 
//  107     VAR_VALUE(var_tal) = vartemp;
        LDR      R0,[SP, #+0]
        LDR.W    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        STR      R0,[R1, #+0]
//  108 }
        POP      {R0,R1,R4,PC}    ;; return
//  109 
//  110 //�Ա����ļӼ����д���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  111 void var_value(ui_var_event_e ctrl)
//  112 {
var_value:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  113     ASSERT(new_tab < VAR_MAX);
        LDR.W    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_value_0
        MOVS     R1,#+113
        LDR.W    R0,??DataTable11_1
        BL       assert_failed
//  114 
//  115 
//  116     //�޸ĵ�ǰ������ֵ
//  117     switch(ctrl)
??var_value_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BEQ.N    ??var_value_1
        BCC.W    ??var_value_2
        CMP      R4,#+6
        BEQ.N    ??var_value_3
        BCC.N    ??var_value_4
        CMP      R4,#+7
        BEQ.W    ??var_value_5
        B.N      ??var_value_2
//  118     {
//  119     case VAR_ADD:
//  120         if(VAR_VALUE(new_tab) < VAR_MAXVALUE(new_tab))
??var_value_1:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, #+12]
        CMP      R0,R1
        BCS.N    ??var_value_6
//  121         {
//  122             VAR_VALUE(new_tab)++;
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
        B.N      ??var_value_7
//  123         }
//  124         else
//  125         {
//  126             VAR_VALUE(new_tab) = VAR_MINVALUE(new_tab);
??var_value_6:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+8]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
//  127         }
//  128         break;
??var_value_7:
        B.N      ??var_value_8
//  129 
//  130     case VAR_SUB:
//  131         if(VAR_VALUE(new_tab) > VAR_MINVALUE(new_tab))
??var_value_4:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+8]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??var_value_9
//  132         {
//  133             VAR_VALUE(new_tab)--;
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
        B.N      ??var_value_10
//  134         }
//  135         else
//  136         {
//  137             VAR_VALUE(new_tab) = VAR_MAXVALUE(new_tab) ;//��Сֵ��һΪ���ֵ
??var_value_9:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+12]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
//  138         }
//  139         break;
??var_value_10:
        B.N      ??var_value_8
//  140 
//  141     case VAR_ADD_HOLD:
//  142         if(   (VAR_MAXVALUE(new_tab) - VAR_VALUE(new_tab))  >  VAR_VALUE_HOLE_OFFSET )
??var_value_3:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+12]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        CMP      R0,#+11
        BCC.N    ??var_value_11
//  143         {
//  144             VAR_VALUE(new_tab) += VAR_VALUE_HOLE_OFFSET;
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+10
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
        B.N      ??var_value_12
//  145         }
//  146         else
//  147         {
//  148             VAR_VALUE(new_tab) = VAR_MINVALUE(new_tab);
??var_value_11:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+8]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
//  149         }
//  150         break;
??var_value_12:
        B.N      ??var_value_8
//  151 
//  152     case VAR_SUB_HOLD:
//  153         if( ( VAR_VALUE(new_tab) - VAR_MINVALUE(new_tab)) > VAR_VALUE_HOLE_OFFSET  )
??var_value_5:
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable11
        LDR.W    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, #+8]
        SUBS     R0,R0,R1
        CMP      R0,#+11
        BCC.N    ??var_value_13
//  154         {
//  155             VAR_VALUE(new_tab) -= VAR_VALUE_HOLE_OFFSET;
        LDR.W    R0,??DataTable11
        LDR.W    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+10
        LDR.N    R1,??DataTable11
        LDR.N    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
        B.N      ??var_value_14
//  156         }
//  157         else
//  158         {
//  159             VAR_VALUE(new_tab) = VAR_MAXVALUE(new_tab) ;//��Сֵ��һΪ���ֵ
??var_value_13:
        LDR.N    R0,??DataTable11
        LDR.N    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+12]
        LDR.N    R1,??DataTable11
        LDR.N    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
//  160         }
//  161         break;
??var_value_14:
        B.N      ??var_value_8
//  162 
//  163     default:                        //��Чѡ�񣬲���Ҫ�л�
//  164         break;
//  165     }
//  166 
//  167     var_display(new_tab);
??var_value_2:
??var_value_8:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        BL       var_display
//  168 }
        POP      {R4,PC}          ;; return
//  169 
//  170 //�Ա�������ѡ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  171 void var_select(ui_var_event_e  ctrl)
//  172 {
var_select:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  173     ASSERT(new_tab < VAR_MAX);
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_select_0
        MOVS     R1,#+173
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  174 
//  175     uint8 old_tab = new_tab;       //�ȱ��ݵ�ǰ�������
??var_select_0:
        LDR.N    R0,??DataTable11_3
        LDRB     R5,[R0, #+0]
//  176 
//  177     //�л�����һ������
//  178     switch(ctrl)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??var_select_1
        CMP      R4,#+2
        BEQ.N    ??var_select_2
        BCC.N    ??var_select_3
        CMP      R4,#+3
        BEQ.N    ??var_select_4
        B.N      ??var_select_5
//  179     {
//  180     case VAR_NEXT:                      //��һ��
//  181         new_tab++;
??var_select_1:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  182         if(new_tab >= (VAR_MAX) )
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_select_6
//  183         {
//  184             new_tab = 0;               //��ͷ��ʼ
        MOVS     R0,#+0
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  185         }
//  186         break;
??var_select_6:
        B.N      ??var_select_7
//  187 
//  188     case VAR_PREV:                      //��һ��
//  189         new_tab--;
??var_select_3:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  190         if(new_tab >= (VAR_MAX) )
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_select_8
//  191         {
//  192             new_tab = VAR_MAX - 1;     //��β��ʼ
        MOVS     R0,#+6
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  193         }
//  194         break;
??var_select_8:
        B.N      ??var_select_7
//  195 
//  196     case VAR_NEXT_HOLD:                 //����
//  197         new_tab += VAR_SELECT_HOLD_OFFSET;
??var_select_2:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+2
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  198         if(new_tab >= (VAR_MAX) )
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_select_9
//  199         {
//  200             new_tab = 0;               //��ͷ��ʼ
        MOVS     R0,#+0
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  201         }
//  202         break;
??var_select_9:
        B.N      ??var_select_7
//  203 
//  204     case VAR_PREV_HOLD:                 //����
//  205         new_tab -= VAR_SELECT_HOLD_OFFSET;
??var_select_4:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+2
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  206         if(new_tab >= (VAR_MAX) )
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_select_10
//  207         {
//  208             new_tab = VAR_MAX - 1;     //��β��ʼ
        MOVS     R0,#+6
        LDR.N    R1,??DataTable11_3
        STRB     R0,[R1, #+0]
//  209         }
//  210         break;
??var_select_10:
        B.N      ??var_select_7
//  211 
//  212     default:                        //��Чѡ�񣬲���Ҫ�л�
//  213         return;
??var_select_5:
        B.N      ??var_select_11
//  214     }
//  215 
//  216     var_display(old_tab);               //������һ������
??var_select_7:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       var_display
//  217 
//  218     var_display(new_tab);              //����ǰ������
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        BL       var_display
//  219 
//  220 }
??var_select_11:
        POP      {R0,R4,R5,PC}    ;; return
//  221 
//  222 
//  223 //ȷ�ϵ�ǰѡ���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 void var_ok()
//  225 {
var_ok:
        PUSH     {R7,LR}
//  226     ASSERT(new_tab < VAR_MAX);
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??var_ok_0
        MOVS     R1,#+226
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  227 
//  228     //�Ƚ��Ƿ��иı�ֵ
//  229     if(VAR_VALUE(new_tab) != VAR_OLDVALUE(new_tab))   //ֵ�ı��ˣ�����Ҫ����
??var_ok_0:
        LDR.N    R0,??DataTable11
        LDR.N    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable11
        LDR.N    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, #+4]
        CMP      R0,R1
        BEQ.N    ??var_ok_1
//  230     {
//  231         var_syn(new_tab);          //ͬ���µ�ֵ
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        BL       var_syn
//  232     }
//  233 
//  234     var_display(new_tab);
??var_ok_1:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        BL       var_display
//  235 }
        POP      {R0,PC}          ;; return
//  236 
//  237 //ȡ����ǰѡ���ֵ  OK

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  238 void val_cancel()
//  239 {
val_cancel:
        PUSH     {R7,LR}
//  240     ASSERT(new_tab < VAR_MAX);
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BLT.N    ??val_cancel_0
        MOVS     R1,#+240
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  241 
//  242     //ֱ�ӻ�ԭ��ǰֵ
//  243     VAR_VALUE(new_tab) = VAR_OLDVALUE(new_tab);
??val_cancel_0:
        LDR.N    R0,??DataTable11
        LDR.N    R1,??DataTable11_3
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+20
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, #+4]
        LDR.N    R1,??DataTable11
        LDR.N    R2,??DataTable11_3
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+20
        MLA      R1,R3,R2,R1
        STR      R0,[R1, #+0]
//  244 
//  245     var_display(new_tab);
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        BL       var_display
//  246 }
        POP      {R0,PC}          ;; return
//  247 
//  248 
//  249 
//  250 //��ʾָ����ֵ��tab Ϊ VAR_MAX ʱ��ʾȫ����ʾ��С������ʾ��Ӧ��
//  251 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  252 void var_display(uint8 tab)
//  253 {
var_display:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
//  254 #if UI_VAR_USE_LCD
//  255 
//  256     //���屳����ʱ
//  257 #define SELECT_NO_CHANGE_BG         WHITE   //��ǰѡ�У�����û�иı�
//  258 #define SELECT_CHANGE_BG            WHITE   //��ǰѡ�У����Ҹı���
//  259 #define NO_SELECT_NO_CHANGE_BG      RED     //û��ѡ�У�����û�иı䣨��ͨ�ľ���������
//  260 #define NO_SELECT_CHANGE_BG         RED     //û��ѡ�У����Ҹı���
//  261 
//  262     //����������ɫ
//  263 #define SELECT_NO_CHANGE            BLUE    //��ǰѡ�У�����û�иı�
//  264 #define SELECT_CHANGE               GREEN   //��ǰѡ�У����Ҹı���
//  265 #define NO_SELECT_NO_CHANGE         BLUE    //û��ѡ�У�����û�иı䣨��ͨ�ľ���������
//  266 #define NO_SELECT_CHANGE            GREEN   //û��ѡ�У����Ҹı���
//  267 
//  268     uint8  i = 0;
        MOVS     R5,#+0
//  269     uint16 bkColor;
//  270     uint16 Color;
//  271 
//  272     ASSERT((new_tab < VAR_MAX) && (tab <= VAR_MAX));
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BGE.N    ??var_display_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BLT.N    ??var_display_1
??var_display_0:
        MOV      R1,#+272
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  273 
//  274     if(tab == VAR_MAX)      //��ʾȫ��
??var_display_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+7
        BNE.N    ??var_display_2
//  275     {
//  276         i = VAR_MAX - 1;    //ѭ���Ĵ���
        MOVS     R0,#+6
        MOVS     R5,R0
//  277         tab = 0;
        MOVS     R0,#+0
        MOVS     R4,R0
//  278     }
//  279 
//  280     do
//  281     {
//  282         if(tab == new_tab)
??var_display_2:
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R0
        BNE.N    ??var_display_3
//  283         {
//  284             //��ʾ��ǰ��ֵ���ж�ֵ�Ƿ�ı�
//  285             if(VAR_VALUE(tab) == VAR_OLDVALUE(tab)) //ֵû�ı䣬����Ҫ����
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        LDR      R1,[R1, #+4]
        CMP      R0,R1
        BNE.N    ??var_display_4
//  286             {
//  287                 Color   =  SELECT_NO_CHANGE;
        MOVS     R0,#+31
        MOVS     R7,R0
//  288                 bkColor =  SELECT_NO_CHANGE_BG;
        MOVW     R0,#+65535
        MOVS     R6,R0
        B.N      ??var_display_5
//  289             }
//  290             else
//  291             {
//  292                 Color   =  SELECT_CHANGE;
??var_display_4:
        MOV      R0,#+2016
        MOVS     R7,R0
//  293                 bkColor =  SELECT_CHANGE_BG;
        MOVW     R0,#+65535
        MOVS     R6,R0
        B.N      ??var_display_5
//  294             }
//  295         }
//  296         else
//  297         {
//  298             //��ʾ�ǵ�ǰ��ֵ
//  299             if(VAR_VALUE(tab) == VAR_OLDVALUE(tab)) //ֵû�ı䣬����Ҫ����
??var_display_3:
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+20
        MLA      R1,R2,R4,R1
        LDR      R1,[R1, #+4]
        CMP      R0,R1
        BNE.N    ??var_display_6
//  300             {
//  301                 Color   =  NO_SELECT_NO_CHANGE;
        MOVS     R0,#+31
        MOVS     R7,R0
//  302                 bkColor =  NO_SELECT_NO_CHANGE_BG;
        MOV      R0,#+63488
        MOVS     R6,R0
        B.N      ??var_display_5
//  303 
//  304             }
//  305             else
//  306             {
//  307                 Color   =  NO_SELECT_CHANGE;
??var_display_6:
        MOV      R0,#+2016
        MOVS     R7,R0
//  308                 bkColor =  NO_SELECT_CHANGE_BG;
        MOV      R0,#+63488
        MOVS     R6,R0
??var_display_5:
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R0,[R0, #+16]
        STR      R0,[SP, #+4]
//  309             }
//  310         }
//  311 
//  312         //��ʾ����
//  313         LCD_num_C(VAR_SITE(tab), VAR_VALUE(tab), Color, bkColor);
        MOVS     R0,R6
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STR      R0,[SP, #+0]
        MOVS     R3,R7
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,#+5
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R1,[R0, #+0]
        LDR      R0,[SP, #+4]
        BL       LCD_num_BC
//  314 
//  315         tab++;
        ADDS     R4,R4,#+1
//  316     }
//  317     while(i--);         //tab != VAR_MAX ��ʱ��ִ��һ�ξ�����
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??var_display_2
//  318 #else
//  319     tab = tab;          //�������뾯��
//  320 #endif
//  321 }
        POP      {R0-R2,R4-R7,PC}  ;; return
//  322 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  323 void save_var2buff(var_tab_e var_num, uint8 *sendbuf)
//  324 {
save_var2buff:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  325     uint32 temp;
//  326     get_var(var_num, &temp);
        ADD      R1,SP,#+0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       get_var
//  327     *((uint32 *)&sendbuf[COM_LEN]) = (uint32)var_num;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R4,[R5, #+2]
//  328     *((uint32 *)&sendbuf[COM_LEN + sizeof(uint32)]) = temp;
        LDR      R0,[SP, #+0]
        STR      R0,[R5, #+6]
//  329 }
        POP      {R0,R4,R5,PC}    ;; return
//  330 
//  331 //ͬ��ָ����ֵ��tab Ϊ VAR_MAX ʱ��ʾȫ��ͬ����С����ͬ����Ӧ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  332 uint8 var_syn(uint8 tab)
//  333 {
var_syn:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+32
        MOVS     R4,R0
//  334     ASSERT((new_tab < VAR_MAX) && (tab <= VAR_MAX));
        LDR.N    R0,??DataTable11_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BGE.N    ??var_syn_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BLT.N    ??var_syn_1
??var_syn_0:
        MOV      R1,#+334
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  335 
//  336     uint8  i = 0;
??var_syn_1:
        MOVS     R5,#+0
//  337     uint8 tempbuff[DATA_PACKET];
//  338     uint32 oldvalue;
//  339 
//  340     if(tab == VAR_MAX)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+7
        BNE.N    ??var_syn_2
//  341     {
//  342         i = VAR_MAX - 1;
        MOVS     R0,#+6
        MOVS     R5,R0
//  343         tab = 0;
        MOVS     R0,#+0
        MOVS     R4,R0
//  344     }
//  345 
//  346     do
//  347     {
//  348         oldvalue = VAR_OLDVALUE(tab);                   //���ݾɵ�ֵ
??var_syn_2:
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R0,[R0, #+4]
        MOVS     R6,R0
//  349 
//  350         //��ֵ���Ƶ���Ӧ�ı���
//  351         save_var((var_tab_e)tab, VAR_VALUE(tab));
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        LDR      R1,[R0, #+0]
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       save_var
//  352 
//  353         //�����µ�ֵ
//  354         save_var2buff((var_tab_e)tab, tempbuff);        //�ѱ���д�� tempbuff ��
        ADD      R1,SP,#+0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       save_var2buff
//  355         nrf_msg_tx(COM_VAR, tempbuff);                //��������
        ADD      R1,SP,#+0
        MOVS     R0,#+2
        BL       nrf_msg_tx
//  356 
//  357         while(nrf_tx_state() == NRF_TXING);             //�ȴ��������
??var_syn_3:
        BL       nrf_tx_state
        CMP      R0,#+0
        BEQ.N    ??var_syn_3
//  358 
//  359         if(NRF_TX_ERROR == nrf_tx_state())             //����ʧ��
        BL       nrf_tx_state
        CMP      R0,#+1
        BNE.N    ??var_syn_4
//  360         {
//  361             VAR_OLDVALUE(tab) = oldvalue;               //��ԭ�ɵ�ֵ
        LDR.N    R0,??DataTable11
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+20
        MLA      R0,R1,R4,R0
        STR      R6,[R0, #+4]
//  362 
//  363             //����ͬ��
//  364             return 0;
        MOVS     R0,#+0
        B.N      ??var_syn_5
//  365         }
//  366         tab++;
??var_syn_4:
        ADDS     R4,R4,#+1
//  367     }
//  368     while(i--);
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??var_syn_2
//  369 
//  370     return 1;
        MOVS     R0,#+1
??var_syn_5:
        ADD      SP,SP,#+32
        POP      {R4-R6,PC}       ;; return
//  371 }
//  372 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  373 uint8    car_ctrl_get()
//  374 {
//  375     return  car_ctrl;
car_ctrl_get:
        LDR.N    R0,??DataTable11_4
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  376 }
//  377 
//  378 
//  379 //��״̬����

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  380 uint8 car_ctrl_syn(CAR_CTRL_MODE_e mode)
//  381 {
car_ctrl_syn:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  382     uint8 ret;
//  383     ASSERT(mode < CAR_CTRL_MAX);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+11
        BLT.N    ??car_ctrl_syn_0
        MOVW     R1,#+383
        LDR.N    R0,??DataTable11_1
        BL       assert_failed
//  384 
//  385     VAR_VALUE(CAR_CTRL) =  mode;
??car_ctrl_syn_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable11
        STR      R4,[R0, #+0]
//  386 
//  387     ret =  var_syn(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_syn
        MOVS     R5,R0
//  388 
//  389     var_display(CAR_CTRL);
        MOVS     R0,#+0
        BL       var_display
//  390 
//  391     return ret;
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  392 };

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     num_info

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     var_addr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_3:
        DC32     new_tab

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_4:
        DC32     car_ctrl

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
        DC8 0E3H, 5CH, 42H, 6FH, 61H, 72H, 64H, 5CH
        DC8 73H, 72H, 63H, 5CH, 56H, 43H, 41H, 4EH
        DC8 5FH, 55H, 49H, 5FH, 56H, 41H, 52H, 2EH
        DC8 63H, 0
        DC8 0, 0

        END
//  393 
//  394 
//  395 
// 
//     6 bytes in section .bss
//   168 bytes in section .data
//    68 bytes in section .rodata
// 1 574 bytes in section .text
// 
// 1 574 bytes of CODE  memory
//    68 bytes of CONST memory
//   174 bytes of DATA  memory
//
//Errors: none
//Warnings: none
