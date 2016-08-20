///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       27/Jul/2016  11:28:36
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_RTC_count.C
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_RTC_count.C
//        -D DEBUG -D ARM_MATH_CM4 -D MK60DZ10 -lCN
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\VCAN_RTC_count.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC Is_LeapYear
        PUBLIC momoff2_t
        PUBLIC momoff_t
        PUBLIC mon2_t
        PUBLIC mon_t
        PUBLIC sec2time
        PUBLIC time2sec
        PUBLIC year2day


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
        DC8 5FH, 52H, 54H, 43H, 5FH, 63H, 6FH, 75H
        DC8 6EH, 74H, 2EH, 43H, 0
        DC8 0, 0, 0
// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\VCAN_RTC_count.C
//    1  /*!
//    2   *     COPYRIGHT NOTICE
//    3   *     Copyright (c) 2013,ɽ��Ƽ�
//    4   *     All rights reserved.
//    5   *     �������ۣ�ɽ����̳ http://www.vcan123.com
//    6   *
//    7   *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
//    8   *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
//    9   *
//   10   * @file       VCAN_RTC_count.c
//   11   * @brief      rtc���ݼ��㺯��ʵ��(��1970-01-01 Ϊ��׼����2099-12-31)
//   12   * @author     ɽ��Ƽ�
//   13   * @version    v5.1
//   14   * @date       2014-01-12
//   15   */
//   16 
//   17 
//   18 /*
//   19  * ����ͷ�ļ�
//   20  */
//   21 #include "common.h"
//   22 #include "VCAN_RTC_count.h"
//   23 
//   24 
//   25 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   26 const uint8     mon_t[12]   ={ 31,28,31,30,31,30,31,31,30,31,30,31};                //ƽ����·�
mon_t:
        DATA
        DC8 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   27 const uint8     mon2_t[12]  ={ 31,29,31,30,31,30,31,31,30,31,30,31};
mon2_t:
        DATA
        DC8 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
//   28 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   29 const uint16    momoff_t[]  ={ 0,31,59,90,120,151,181,212,243,273,304,334,365 };    //ƽ���ÿ��1�յ��ۼ�����
momoff_t:
        DATA
        DC16 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   30 const uint16    momoff2_t[] ={ 0,31,60,91,121,152,182,213,244,274,305,335,366 };    //�����ÿ��1�յ��ۼ�����
momoff2_t:
        DATA
        DC16 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366
        DC8 0, 0
//   31 
//   32 
//   33 /*!
//   34  *  @brief      ����Ƿ�Ϊ����
//   35  *  @param      year    ���
//   36  *  @return     �Ƿ�Ϊ����(0��ʾƽ�꣬1��ʾ����)
//   37  *  @since      v5.0
//   38  *  Sample usage:       if( Is_LeapYear(2013) )         //��� 2013 �Ƿ�Ϊ����
//   39                         {
//   40                             printf("\n����!");          //
//   41                         }else
//   42                         {
//   43                             printf("\n�������꣡");
//   44                         }
//   45  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   46 uint8 Is_LeapYear(uint32 year)
//   47 {
Is_LeapYear:
        MOVS     R1,R0
//   48     if(year%4 == 0)
        MOVS     R0,#+4
        UDIV     R2,R1,R0
        MLS      R2,R2,R0,R1
        CMP      R2,#+0
        BNE.N    ??Is_LeapYear_0
//   49     {
//   50         if((year%100 != 0) || (year%400 == 0))
        MOVS     R0,#+100
        UDIV     R2,R1,R0
        MLS      R0,R0,R2,R1
        CMP      R0,#+0
        BNE.N    ??Is_LeapYear_1
        MOV      R0,#+400
        UDIV     R2,R1,R0
        MLS      R0,R0,R2,R1
        CMP      R0,#+0
        BNE.N    ??Is_LeapYear_0
//   51         {
//   52             //����
//   53             return 1;
??Is_LeapYear_1:
        MOVS     R0,#+1
        B.N      ??Is_LeapYear_2
//   54         }
//   55     }
//   56 
//   57     //��������
//   58     return 0;
??Is_LeapYear_0:
        MOVS     R0,#+0
??Is_LeapYear_2:
        BX       LR               ;; return
//   59 }
//   60 
//   61 /*!
//   62  *  @brief      ����ݵ�����
//   63  *  @param      year    ���
//   64  *  @return     ָ����ݵ�����
//   65  *  @since      v5.0
//   66  *  Sample usage:       uint32 days = year2day(2013);
//   67                         printf("2013�깲%d��!",days);
//   68  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 uint32 year2day(uint32 year)
//   70 {
year2day:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   71     return (365 + Is_LeapYear(year));
        MOVS     R0,R4
        BL       Is_LeapYear
        ADDW     R0,R0,#+365
        POP      {R4,PC}          ;; return
//   72 }
//   73 
//   74 /*!
//   75  *  @brief      ��1970-01-01 0:0:0 �� ָ��ʱ���������ʱ�����ʽתΪ������
//   76  *  @param      time    ʱ��ṹ��
//   77  *  @return     ��1970-01-01 0:0:0 �� ָ��ʱ���������
//   78  *  @since      v5.0
//   79  *  Sample usage:       time_s time = {2013,9,1,0,0,0};  //ʱ��Ϊ 2013-09-01 0:0:0
//   80                         printf("��%d��!",time2sec(time));
//   81  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   82 uint32 time2sec(time_s time)
//   83 {
time2sec:
        PUSH     {R0,R1,LR}
        SUB      SP,SP,#+4
//   84     //�ο� linux�ں˴��� include/linux/time.h ��ĺ��� mktime()
//   85     //���ݸ�˹�㷨����year/mon/day/hour/min/sec����1980��12��31 23��59��59��
//   86     //��ʽ��ʾ��ʱ��ת��Ϊ�����1970��01��01 00��00��00
//   87     //���UNIXʱ���׼�������������
//   88 
//   89     //ע��һ�㣬����Ķ��·���29�죬��������Ϊ28��
//   90     //����һ�򣬰��겻���İ�������
//   91 
//   92     //���ʱ���Ƿ���Ч
//   93     ASSERT(time.year >= 1970);     //���ԣ��� 1970 Ϊ��׼�������СΪ 1970
        LDRH     R0,[SP, #+4]
        MOVW     R1,#+1970
        CMP      R0,R1
        BGE.N    ??time2sec_0
        MOVS     R1,#+93
        LDR.N    R0,??DataTable1
        BL       assert_failed
//   94     ASSERT(time.year < 2100);      //���ԣ�32λ����������ɱ���136���ʱ�䣬���Ǵ˴��޶�������Ϊ2099��ʵ�����ǿɼ�ʱ�� 2105��12��31��
??time2sec_0:
        LDRH     R0,[SP, #+4]
        MOVW     R1,#+2100
        CMP      R0,R1
        BLT.N    ??time2sec_1
        MOVS     R1,#+94
        LDR.N    R0,??DataTable1
        BL       assert_failed
//   95     ASSERT(time.mon  <= 12);       //���ԣ��·����Ϊ12��
??time2sec_1:
        LDRB     R0,[SP, #+6]
        CMP      R0,#+13
        BLT.N    ??time2sec_2
        MOVS     R1,#+95
        LDR.N    R0,??DataTable1
        BL       assert_failed
//   96     ASSERT(     ((Is_LeapYear(time.year) == 0) &&                    (time.day <= mon_t[time.mon-1])) //ƽ��
//   97            ||   ((Is_LeapYear(time.year) == 1) && (time.mon != 2) && (time.day <= mon_t[time.mon-1]))               //����ķ�2��
//   98            ||   ((Is_LeapYear(time.year) == 1) && (time.mon == 2) && (time.day <= 29))
//   99            );
??time2sec_2:
        LDRH     R0,[SP, #+4]
        BL       Is_LeapYear
        CMP      R0,#+0
        BNE.N    ??time2sec_3
        LDR.N    R0,??DataTable1_1
        LDRB     R1,[SP, #+6]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #-1]
        LDRB     R1,[SP, #+7]
        CMP      R0,R1
        BCS.N    ??time2sec_4
??time2sec_3:
        LDRH     R0,[SP, #+4]
        BL       Is_LeapYear
        CMP      R0,#+1
        BNE.N    ??time2sec_5
        LDRB     R0,[SP, #+6]
        CMP      R0,#+2
        BEQ.N    ??time2sec_5
        LDR.N    R0,??DataTable1_1
        LDRB     R1,[SP, #+6]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #-1]
        LDRB     R1,[SP, #+7]
        CMP      R0,R1
        BCS.N    ??time2sec_4
??time2sec_5:
        LDRH     R0,[SP, #+4]
        BL       Is_LeapYear
        CMP      R0,#+1
        BNE.N    ??time2sec_6
        LDRB     R0,[SP, #+6]
        CMP      R0,#+2
        BNE.N    ??time2sec_6
        LDRB     R0,[SP, #+7]
        CMP      R0,#+30
        BLT.N    ??time2sec_4
??time2sec_6:
        MOVS     R1,#+99
        LDR.N    R0,??DataTable1
        BL       assert_failed
//  100 
//  101 
//  102                //ASSERT((time.mon != 2) || ((time.mon == 2) && (time.day  <= 29)));   //���·����������� 29�졣
//  103     //ASSERT((time.mon == 2) && (time.year%4 ��= 0)); //��ݷ�4�ı�����������ͨ���
//  104 
//  105 
//  106     if (0 >= (int8) (time.mon -= 2)) /* 1..12 -> 11,12,1..10 */
??time2sec_4:
        LDRB     R0,[SP, #+6]
        SUBS     R0,R0,#+2
        STRB     R0,[SP, #+6]
        LDRB     R0,[SP, #+6]
        CMP      R0,#+0
        BNE.N    ??time2sec_7
//  107     {
//  108         time.mon += 12; /* Puts Feb last since it has leap day */
        LDRB     R0,[SP, #+6]
        ADDS     R0,R0,#+12
        STRB     R0,[SP, #+6]
//  109         time.year -= 1;
        LDRH     R0,[SP, #+4]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+4]
//  110     }
//  111 
//  112     return (((
//  113             (uint32) (time.year/4 - time.year/100 + time.year/400 + 367*(time.mon)/12 + time.day) + time.year*365 - 719499 /* ���е������� */
//  114             )*24 + time.hour /* ���е���Сʱ�� */
//  115             )*60 + time.min  /* ���е��ܷ����� */
//  116             )*60 + time.sec; /* ���յ�������   */
??time2sec_7:
        LDRH     R0,[SP, #+4]
        MOVS     R1,#+4
        SDIV     R0,R0,R1
        LDRH     R1,[SP, #+4]
        MOVS     R2,#+100
        SDIV     R1,R1,R2
        SUBS     R0,R0,R1
        LDRH     R1,[SP, #+4]
        MOV      R2,#+400
        SDIV     R1,R1,R2
        ADDS     R0,R1,R0
        LDRB     R1,[SP, #+6]
        MOVW     R2,#+367
        MULS     R1,R2,R1
        MOVS     R2,#+12
        SDIV     R1,R1,R2
        ADDS     R0,R1,R0
        LDRB     R1,[SP, #+7]
        UXTAB    R0,R0,R1
        LDRH     R1,[SP, #+4]
        MOVW     R2,#+365
        MLA      R0,R2,R1,R0
        LDR.N    R1,??DataTable1_2  ;; 0xfff50575
        ADDS     R0,R1,R0
        MOVS     R1,#+24
        LDRB     R2,[SP, #+8]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+60
        LDRB     R2,[SP, #+9]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+60
        LDRB     R2,[SP, #+10]
        MLA      R0,R1,R0,R2
        POP      {R1-R3,PC}       ;; return
//  117 }
//  118 
//  119 /*!
//  120  *  @brief      ��1970-01-01 Ϊ��׼�������� תΪ������ʱ�����ʽ
//  121  *  @param      sec     ������
//  122  *  @param      time    ʱ��ṹ��
//  123  *  @since      v5.0
//  124  *  Sample usage:       time_s time;
//  125                         sec2time(1000,&time);   //��1000���Ӧ��ʱ��
//  126                         printf("\nʱ���ǣ�%d-%02d-%02d %02d:%02d:%02d",
//  127                                                 time.year,time.mon,time.day,
//  128                                                 time.hour,time.min,time.sec);
//  129  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  130 void sec2time(uint32 sec, time_s * time)
//  131 {
sec2time:
        PUSH     {R4-R10,LR}
        MOV      R10,R0
        MOVS     R4,R1
//  132 #define DAYSEC  (60*60*24)      //����ÿ���������
//  133     //uint32 i;
//  134     uint32  hms                //һ��ʣ�µ�����
//  135             ,day                //�������е�����
//  136             ,tmp;
//  137 
//  138     uint16 const* dayoff ;
//  139     uint8  const* monoff;
//  140 
//  141     if(sec > 0xf48656ff)    //ʱ�䳬�� 2099-12-31 23:59:59�󣬻�� 1970-1-1 0:0:0 ��ʼ��ʱ
        LDR.N    R0,??DataTable1_3  ;; 0xf4865700
        CMP      R10,R0
        BCC.N    ??sec2time_0
//  142     {
//  143         sec -= 0xf48656ff;
        LDR.N    R0,??DataTable1_4  ;; 0xb79a901
        ADDS     R10,R0,R10
//  144     }
//  145 
//  146     day = sec / DAYSEC;
??sec2time_0:
        LDR.N    R0,??DataTable1_5  ;; 0x15180
        UDIV     R0,R10,R0
        MOVS     R6,R0
//  147     hms = sec % DAYSEC;
        LDR.N    R0,??DataTable1_5  ;; 0x15180
        UDIV     R1,R10,R0
        MLS      R0,R0,R1,R10
        MOVS     R5,R0
//  148 
//  149     //����ʱ����
//  150     time->hour = (uint8) (hms / (60*60));         //ʱ
        MOV      R0,#+3600
        UDIV     R0,R5,R0
        STRB     R0,[R4, #+4]
//  151     hms = hms % (60*60);
        MOV      R0,#+3600
        UDIV     R1,R5,R0
        MLS      R5,R0,R1,R5
//  152     time->min = (uint8) (hms / 60);  //��
        MOVS     R0,#+60
        UDIV     R0,R5,R0
        STRB     R0,[R4, #+5]
//  153     time->sec = (uint8) (hms % 60);   //��
        MOVS     R0,#+60
        UDIV     R1,R5,R0
        MLS      R0,R0,R1,R5
        STRB     R0,[R4, #+6]
//  154 
//  155     /*�����ǰ��ݣ���ʼ�ļ������Ϊ1970��*/
//  156     time->year  =  (uint16)(day/366 );          //������� ���(��û�� 1970)
        MOV      R0,#+366
        UDIV     R0,R6,R0
        STRH     R0,[R4, #+0]
//  157 
//  158     day = day
//  159             -  365*(time->year)    //����
//  160             - ((time->year +1)/4)  //4��һ����
//  161             //+ (time->year/(2101-1970) )      //2100�������꣬������������ 2099��������2100������˴�ע��
//  162             ;
        LDRH     R0,[R4, #+0]
        MOVW     R1,#+365
        MLS      R0,R1,R0,R6
        LDRH     R1,[R4, #+0]
        ADDS     R1,R1,#+1
        MOVS     R2,#+4
        SDIV     R1,R1,R2
        SUBS     R6,R0,R1
//  163 
//  164     time->year += 1970;
        LDRH     R0,[R4, #+0]
        ADDW     R0,R0,#+1970
        STRH     R0,[R4, #+0]
//  165     tmp = 365 + Is_LeapYear(time->year);        //ָ����ݵ� ����
        LDRH     R0,[R4, #+0]
        BL       Is_LeapYear
        ADDW     R0,R0,#+365
        MOVS     R7,R0
//  166     if(day >= tmp)
        CMP      R6,R7
        BCC.N    ??sec2time_1
//  167     {
//  168         time->year++;
        LDRH     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+0]
//  169         day -=  tmp;
        SUBS     R6,R6,R7
//  170     }
//  171 
//  172     time->mon = (uint8)(day/31 +1);                 //�������·ݣ�������Ҫ��1
??sec2time_1:
        MOVS     R0,#+31
        UDIV     R0,R6,R0
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+2]
//  173 
//  174     tmp = Is_LeapYear(time->year);
        LDRH     R0,[R4, #+0]
        BL       Is_LeapYear
        MOVS     R7,R0
//  175     dayoff  = tmp ? momoff2_t : momoff_t;
        CMP      R7,#+0
        BEQ.N    ??sec2time_2
        LDR.W    R8,??DataTable1_6
        B.N      ??sec2time_3
??sec2time_2:
        LDR.W    R8,??DataTable1_7
//  176     monoff  = tmp ? mon2_t : mon_t;
??sec2time_3:
        CMP      R7,#+0
        BEQ.N    ??sec2time_4
        LDR.W    R9,??DataTable1_8
        B.N      ??sec2time_5
??sec2time_4:
        LDR.W    R9,??DataTable1_1
//  177 
//  178     time->day = (uint8)(day +1 - dayoff[time->mon -1]);
??sec2time_5:
        ADDS     R0,R6,#+1
        LDRB     R1,[R4, #+2]
        ADDS     R1,R8,R1, LSL #+1
        LDRH     R1,[R1, #-2]
        SUBS     R0,R0,R1
        STRB     R0,[R4, #+3]
//  179 
//  180     if(time->day > monoff[time->mon-1 ] )
        LDRB     R0,[R4, #+2]
        ADDS     R0,R0,R9
        LDRB     R0,[R0, #-1]
        LDRB     R1,[R4, #+3]
        CMP      R0,R1
        BCS.N    ??sec2time_6
//  181     {
//  182         time->mon++;
        LDRB     R0,[R4, #+2]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+2]
//  183         time->day = (uint8)(day +1 - dayoff[time->mon -1]);
        ADDS     R0,R6,#+1
        LDRB     R1,[R4, #+2]
        ADDS     R1,R8,R1, LSL #+1
        LDRH     R1,[R1, #-2]
        SUBS     R0,R0,R1
        STRB     R0,[R4, #+3]
//  184     }
//  185 }
??sec2time_6:
        POP      {R4-R10,PC}      ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     mon_t

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     0xfff50575

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     0xf4865700

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     0xb79a901

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     0x15180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_6:
        DC32     momoff2_t

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_7:
        DC32     momoff_t

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_8:
        DC32     mon2_t

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 152 bytes in section .rodata
// 672 bytes in section .text
// 
// 672 bytes of CODE  memory
// 152 bytes of CONST memory
//
//Errors: none
//Warnings: none
