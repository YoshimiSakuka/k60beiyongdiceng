///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:19
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\Vcan_touch.c
//    Command line =  
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\Vcan_touch.c -D
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
//        D:\Study\2016������ƴ���\Ti\�������õײ�\Prj\IAR\DZ10_Debug\List\Vcan_touch.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ILI9341_get_h
        EXTERN ILI9341_get_w
        EXTERN LCD_clear
        EXTERN LCD_cross
        EXTERN __aeabi_cfcmple
        EXTERN __aeabi_cfrcmple
        EXTERN __aeabi_d2f
        EXTERN __aeabi_dadd
        EXTERN __aeabi_f2d
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_fadd
        EXTERN __aeabi_fdiv
        EXTERN __aeabi_fmul
        EXTERN __aeabi_fsub
        EXTERN __aeabi_i2f
        EXTERN __aeabi_memclr4
        EXTERN abs
        EXTERN core_clk_khz
        EXTERN port_init
        EXTERN spi_init
        EXTERN spi_mosi_cmd
        EXTERN systick_delay
        EXTERN systick_delay_ms

        PUBLIC touch_calibrate
        PUBLIC touch_get_point
        PUBLIC touch_init
        PUBLIC touch_load
        PUBLIC touch_save
        PUBLIC xpt2046_get_xy
        PUBLIC xpt2046_read
        PUBLIC xpt2046_read_ch

// D:\Study\2016������ƴ���\Ti\�������õײ�\Board\src\Vcan_touch.c
//    1 #include "common.h"
//    2 #include "MK60_port.h"
//    3 #include "MK60_gpio.h"
//    4 #include "MK60_spi.h"
//    5 
//    6 #include "VCAN_LCD.h"
//    7 #include "Vcan_touch.h"
//    8 
//    9 
//   10 #define XPT2046_INT_IN    PTX_T(TOUCH_INT_PTXn,IN)
//   11 
//   12 #define USE_TSLIB       1
//   13 
//   14 #if (USE_TSLIB )
//   15 #define  TOUCH_COUNT    5
//   16 
//   17 typedef struct {
//   18     //x[5]/y[5] �Ǵ���ֵ��xfb[5]/yfb[5] ��LCD���ꡣa[7]��У������
//   19     int x[TOUCH_COUNT], xfb[TOUCH_COUNT];
//   20     int y[TOUCH_COUNT], yfb[TOUCH_COUNT];
//   21     int a[7];
//   22 } calibration;
//   23 
//   24 #else
//   25 #define  TOUCH_COUNT    4
//   26 
//   27 typedef struct {
//   28     //x[5]/y[5] �Ǵ���ֵ��xfb[5]/yfb[5] ��LCD���ꡣa[7]��У������
//   29     int x[TOUCH_COUNT], xfb[TOUCH_COUNT];
//   30     int y[TOUCH_COUNT], yfb[TOUCH_COUNT];
//   31     float a[7];
//   32 } calibration;
//   33 
//   34 #endif
//   35 
//   36 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   37 static uint32 touch_baud;
touch_baud:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   38 static uint32 touch_delay;
touch_delay:
        DS8 4
//   39 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   40 static calibration cal;
cal:
        DS8 108
//   41 
//   42 
//   43 static int perform_calibration(calibration *cal);
//   44 
//   45 
//   46 /*
//   47  * ����ģ��SPI IO �� �ж� IO ��ʼ��
//   48  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void touch_init(void)
//   50 {
touch_init:
        PUSH     {R7,LR}
//   51     touch_baud = spi_init(TOUCH_SPI, TOUCH_CS, MASTER,150*1000);               //��ʼ��SPI,����ģʽ
        LDR.W    R3,??DataTable6  ;; 0x249f0
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       spi_init
        LDR.W    R1,??DataTable6_1
        STR      R0,[R1, #+0]
//   52 
//   53     port_init(TOUCH_INT_PTXn,ALT1  | PULLUP | IRQ_FALLING);         //�������½��ش����ж�
        LDR.W    R1,??DataTable6_2  ;; 0xa0103
        MOVS     R0,#+41
        BL       port_init
//   54 
//   55     touch_delay = 8*1000*1000 / touch_baud;
        LDR.W    R0,??DataTable6_3  ;; 0x7a1200
        LDR.W    R1,??DataTable6_1
        LDR      R1,[R1, #+0]
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable6_4
        STR      R0,[R1, #+0]
//   56 
//   57     //gpio_init(TOUCH_CS_PTXn,GPO,0);
//   58 }
        POP      {R0,PC}          ;; return
//   59 
//   60 /******************************************************
//   61 * ��������Touchl_Calibrate
//   62 * ����  ��������У������
//   63 * ����  : ��
//   64 * ���  ��1 --- У���ɹ�
//   65                     0   --- У��ʧ��
//   66 * ����  ����
//   67 * ע��  ����
//   68 *********************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 int touch_calibrate(void)
//   70 {
touch_calibrate:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
//   71     uint16 lcd_h = LCD_H;
        BL       ILI9341_get_h
        MOVS     R4,R0
//   72     uint16 lcd_w = LCD_W;
        BL       ILI9341_get_w
        MOVS     R5,R0
//   73     uint8 i;
//   74     Site_t site;
//   75 
//   76     //���ô�����У����λ��
//   77     cal.xfb[0] = 40;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+20]
//   78     cal.yfb[0] = 40;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+60]
//   79 
//   80     cal.xfb[1] = 40;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+24]
//   81     cal.yfb[1] = lcd_h - 40;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        SUBS     R0,R4,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+64]
//   82 
//   83     cal.xfb[2] = lcd_w - 40;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R0,R5,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+28]
//   84     cal.yfb[2] = lcd_h - 40;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        SUBS     R0,R4,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+68]
//   85 
//   86     cal.xfb[3] = lcd_w -40;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        SUBS     R0,R5,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+32]
//   87     cal.yfb[3] = 40;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+72]
//   88 
//   89 #if (USE_TSLIB )
//   90     cal.xfb[4] = lcd_w/2;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+2
        SDIV     R0,R5,R0
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+36]
//   91     cal.yfb[4] = lcd_h/2;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,#+2
        SDIV     R0,R4,R0
        LDR.W    R1,??DataTable6_5
        STR      R0,[R1, #+76]
//   92 #endif
//   93 
//   94     //ѭ����ʾ5������У��㣬����ȡ����ֵ
//   95     for(i = 0; i< TOUCH_COUNT;i++)
        MOVS     R0,#+0
        MOVS     R6,R0
??touch_calibrate_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+5
        BGE.N    ??touch_calibrate_1
//   96     {
//   97         LCD_clear(BCOLOUR);                     //����
        MOV      R0,#+63488
        BL       LCD_clear
//   98 
//   99         DELAY_MS(500);                          //��ʱ�����򰴵�̫�죬���´���ʧ��
        MOV      R0,#+500
        BL       systick_delay_ms
//  100 
//  101         site.x = cal.xfb[i];            //LCD��ʾ������ʮ��ͼ��
        LDR.W    R0,??DataTable6_5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R0,R0,R6, LSL #+2
        LDR      R0,[R0, #+20]
        STRH     R0,[SP, #+0]
//  102         site.y = cal.yfb[i];
        LDR.W    R0,??DataTable6_5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R0,R0,R6, LSL #+2
        LDR      R0,[R0, #+60]
        STRH     R0,[SP, #+2]
//  103         LCD_cross(site,10,FCOLOUR);
        MOVS     R2,#+31
        MOVS     R1,#+10
        LDR      R0,[SP, #+0]
        BL       LCD_cross
//  104 
//  105         while(!xpt2046_read(&site));            //�ȴ���ȡ������λ��
??touch_calibrate_2:
        ADD      R0,SP,#+0
        BL       xpt2046_read
        CMP      R0,#+0
        BEQ.N    ??touch_calibrate_2
//  106         cal.x[i] = site.x;
        LDRH     R0,[SP, #+0]
        LDR.W    R1,??DataTable6_5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        STR      R0,[R1, R6, LSL #+2]
//  107         cal.y[i] = site.y;
        LDRH     R0,[SP, #+2]
        LDR.W    R1,??DataTable6_5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R1,R1,R6, LSL #+2
        STR      R0,[R1, #+40]
//  108     }
        ADDS     R6,R6,#+1
        B.N      ??touch_calibrate_0
//  109 
//  110     LCD_clear(BCOLOUR);                     //����
??touch_calibrate_1:
        MOV      R0,#+63488
        BL       LCD_clear
//  111 
//  112 
//  113     //���д���У��
//  114     if( perform_calibration(&cal) )
        LDR.W    R0,??DataTable6_5
        BL       perform_calibration
        CMP      R0,#+0
        BEQ.N    ??touch_calibrate_3
//  115     {
//  116         return 1;
        MOVS     R0,#+1
        B.N      ??touch_calibrate_4
//  117     }
//  118     else
//  119     {
//  120         return 0;
??touch_calibrate_3:
        MOVS     R0,#+0
??touch_calibrate_4:
        POP      {R1,R2,R4-R6,PC}  ;; return
//  121     }
//  122 }
//  123 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  124 int touch_get_point(Site_t *site)
//  125 {
touch_get_point:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  126     Site_t sitetmp;
//  127 
//  128     if(xpt2046_read(&sitetmp))
        ADD      R0,SP,#+0
        BL       xpt2046_read
        CMP      R0,#+0
        BEQ.N    ??touch_get_point_0
//  129     {
//  130 #if (USE_TSLIB )
//  131         site->x =( cal.a[0]
//  132                  + cal.a[1] * sitetmp.x
//  133                  + cal.a[2] * sitetmp.y)/cal.a[6];
        LDR.W    R0,??DataTable6_5
        LDR      R0,[R0, #+80]
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+84]
        LDRH     R2,[SP, #+0]
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+88]
        LDRH     R2,[SP, #+2]
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+104]
        SDIV     R0,R0,R1
        STRH     R0,[R4, #+0]
//  134         site->y =( cal.a[3]
//  135                  + cal.a[4] * sitetmp.x
//  136                  + cal.a[5] * sitetmp.y)/cal.a[6];
        LDR.W    R0,??DataTable6_5
        LDR      R0,[R0, #+92]
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+96]
        LDRH     R2,[SP, #+0]
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+100]
        LDRH     R2,[SP, #+2]
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable6_5
        LDR      R1,[R1, #+104]
        SDIV     R0,R0,R1
        STRH     R0,[R4, #+2]
//  137 #else
//  138         site->x =( cal.a[0] * sitetmp.x
//  139                  + cal.a[1] * sitetmp.y
//  140                  + cal.a[2]             )/cal.a[6];
//  141         site->y =( cal.a[3] * sitetmp.x
//  142                  + cal.a[4] * sitetmp.y
//  143                  + cal.a[5]             )/cal.a[6];
//  144 
//  145 #endif
//  146         if((int16)site->x < 0)site->x = 0;
        LDRSH    R0,[R4, #+0]
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??touch_get_point_1
        MOVS     R0,#+0
        STRH     R0,[R4, #+0]
        B.N      ??touch_get_point_2
//  147         else if(site->x >= LCD_W ) site->x = LCD_W-1;
??touch_get_point_1:
        BL       ILI9341_get_w
        LDRH     R1,[R4, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R1,R0
        BCC.N    ??touch_get_point_2
        BL       ILI9341_get_w
        SUBS     R0,R0,#+1
        STRH     R0,[R4, #+0]
//  148         if((int16)site->y < 0)site->y = 0;
??touch_get_point_2:
        LDRSH    R0,[R4, #+2]
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??touch_get_point_3
        MOVS     R0,#+0
        STRH     R0,[R4, #+2]
        B.N      ??touch_get_point_4
//  149         else if(site->y >= LCD_H ) site->y = LCD_H-1;
??touch_get_point_3:
        BL       ILI9341_get_h
        LDRH     R1,[R4, #+2]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R1,R0
        BCC.N    ??touch_get_point_4
        BL       ILI9341_get_h
        SUBS     R0,R0,#+1
        STRH     R0,[R4, #+2]
//  150         return 1;
??touch_get_point_4:
        MOVS     R0,#+1
        B.N      ??touch_get_point_5
//  151     }
//  152     else
//  153     {
//  154         return 0;
??touch_get_point_0:
        MOVS     R0,#+0
??touch_get_point_5:
        POP      {R1,R2,R4,PC}    ;; return
//  155     }
//  156 
//  157 }
//  158 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  159 int touch_load(touch_call_back_func func)
//  160 {
touch_load:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  161     return func((uint8 *)&(cal.a[0]),sizeof(int)*7);
        MOVS     R1,#+28
        LDR.W    R0,??DataTable6_6
        BLX      R4
        POP      {R4,PC}          ;; return
//  162 }
//  163 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  164 int touch_save(touch_call_back_func func)
//  165 {
touch_save:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  166     return func((uint8 *)&(cal.a[0]),sizeof(int)*7);
        MOVS     R1,#+28
        LDR.W    R0,??DataTable6_6
        BLX      R4
        POP      {R4,PC}          ;; return
//  167 }
//  168 
//  169 
//  170 //tslib (touchscreen library)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  171 int perform_calibration(calibration *cal) {
perform_calibration:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R0
//  172 #if (USE_TSLIB )
//  173 
//  174     int j;
//  175     float n, x, y, x2, y2, xy, z, zx, zy;
//  176     float det, a, b, c, e, f, i;
//  177     float scaling = 65536.0;
        MOVS     R0,#+1199570944
        STR      R0,[SP, #+16]
//  178 
//  179 // Get sums for matrix
//  180     n = x = y = x2 = y2 = xy = 0;
        MOVS     R0,#+0
        MOV      R9,R0
        STR      R0,[SP, #+20]
        STR      R0,[SP, #+24]
        MOV      R10,R0
        STR      R0,[SP, #+8]
        MOV      R11,R0
//  181     for(j=0;j<5;j++) {
        MOVS     R0,#+0
        MOVS     R5,R0
??perform_calibration_0:
        CMP      R5,#+5
        BGE.N    ??perform_calibration_1
//  182         n += 1.0;
        MOV      R0,R11
        BL       __aeabi_f2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable6_7  ;; 0x3ff00000
        BL       __aeabi_dadd
        BL       __aeabi_d2f
        MOV      R11,R0
//  183         x += (float)cal->x[j];
        LDR      R0,[R4, R5, LSL #+2]
        BL       __aeabi_i2f
        LDR      R1,[SP, #+8]
        BL       __aeabi_fadd
        STR      R0,[SP, #+8]
//  184         y += (float)cal->y[j];
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+40]
        BL       __aeabi_i2f
        MOV      R1,R10
        BL       __aeabi_fadd
        MOV      R10,R0
//  185         x2 += (float)(cal->x[j]*cal->x[j]);
        LDR      R0,[R4, R5, LSL #+2]
        LDR      R1,[R4, R5, LSL #+2]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        LDR      R1,[SP, #+24]
        BL       __aeabi_fadd
        STR      R0,[SP, #+24]
//  186         y2 += (float)(cal->y[j]*cal->y[j]);
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+40]
        ADDS     R1,R4,R5, LSL #+2
        LDR      R1,[R1, #+40]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        LDR      R1,[SP, #+20]
        BL       __aeabi_fadd
        STR      R0,[SP, #+20]
//  187         xy += (float)(cal->x[j]*cal->y[j]);
        LDR      R0,[R4, R5, LSL #+2]
        ADDS     R1,R4,R5, LSL #+2
        LDR      R1,[R1, #+40]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        MOV      R1,R9
        BL       __aeabi_fadd
        MOV      R9,R0
//  188     }
        ADDS     R5,R5,#+1
        B.N      ??perform_calibration_0
//  189 
//  190 // Get determinant of matrix -- check if determinant is too small
//  191     det = n*(x2*y2 - xy*xy) + x*(xy*y - x*y2) + y*(x*xy - y*x2);
??perform_calibration_1:
        LDR      R1,[SP, #+24]
        LDR      R0,[SP, #+20]
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R9
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        MOV      R1,R11
        BL       __aeabi_fmul
        STR      R0,[SP, #+4]
        MOV      R0,R9
        MOV      R1,R10
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R1,[SP, #+8]
        LDR      R0,[SP, #+20]
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+8]
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fadd
        STR      R0,[SP, #+4]
        LDR      R0,[SP, #+8]
        MOV      R1,R9
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+24]
        MOV      R1,R10
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        MOV      R1,R10
        BL       __aeabi_fmul
        LDR      R1,[SP, #+4]
        BL       __aeabi_fadd
        STR      R0,[SP, #+12]
//  192     if(det < 0.1 && det > -0.1) {
        LDR      R0,[SP, #+12]
        LDR.N    R1,??DataTable6_8  ;; 0x3dcccccd
        BL       __aeabi_cfcmple
        BCS.N    ??perform_calibration_2
        LDR      R0,[SP, #+12]
        LDR.N    R1,??DataTable6_9  ;; 0xbdcccccc
        BL       __aeabi_cfrcmple
        BHI.N    ??perform_calibration_2
//  193         //printf("ts_calibrate: determinant is too small -- %f\n",det);
//  194         return 0;
        MOVS     R0,#+0
        B.N      ??perform_calibration_3
//  195     }
//  196 
//  197 // Get elements of inverse matrix
//  198     a = (x2*y2 - xy*xy)/det;
??perform_calibration_2:
        LDR      R1,[SP, #+24]
        LDR      R0,[SP, #+20]
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R9
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+48]
//  199     b = (xy*y - x*y2)/det;
        MOV      R0,R9
        MOV      R1,R10
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R1,[SP, #+8]
        LDR      R0,[SP, #+20]
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+36]
//  200     c = (x*xy - y*x2)/det;
        LDR      R0,[SP, #+8]
        MOV      R1,R9
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+24]
        MOV      R1,R10
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+32]
//  201     e = (n*y2 - y*y)/det;
        LDR      R0,[SP, #+20]
        MOV      R1,R11
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R10
        MOV      R1,R10
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+44]
//  202     f = (x*y - n*xy)/det;
        LDR      R0,[SP, #+8]
        MOV      R1,R10
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        MOV      R0,R11
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+28]
//  203     i = (n*x2 - x*x)/det;
        LDR      R0,[SP, #+24]
        MOV      R1,R11
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R1,[SP, #+8]
        LDR      R0,[SP, #+8]
        BL       __aeabi_fmul
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       __aeabi_fsub
        LDR      R1,[SP, #+12]
        BL       __aeabi_fdiv
        STR      R0,[SP, #+40]
//  204 
//  205 // Get sums for x calibration
//  206     z = zx = zy = 0;
        MOVS     R0,#+0
        MOVS     R7,R0
        MOVS     R6,R0
        MOV      R8,R0
//  207     for(j=0;j<5;j++) {
        MOVS     R0,#+0
        MOVS     R5,R0
??perform_calibration_4:
        CMP      R5,#+5
        BGE.N    ??perform_calibration_5
//  208         z += (float)cal->xfb[j];
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+20]
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        MOV      R8,R0
//  209         zx += (float)(cal->xfb[j]*cal->x[j]);
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+20]
        LDR      R1,[R4, R5, LSL #+2]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        MOVS     R1,R6
        BL       __aeabi_fadd
        MOVS     R6,R0
//  210         zy += (float)(cal->xfb[j]*cal->y[j]);
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+20]
        ADDS     R1,R4,R5, LSL #+2
        LDR      R1,[R1, #+40]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        MOVS     R1,R7
        BL       __aeabi_fadd
        MOVS     R7,R0
//  211     }
        ADDS     R5,R5,#+1
        B.N      ??perform_calibration_4
//  212 
//  213 // Now multiply out to get the calibration for framebuffer x coord
//  214     cal->a[0] = (int)((a*z + b*zx + c*zy)*(scaling));
??perform_calibration_5:
        LDR      R0,[SP, #+48]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+36]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+32]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+80]
//  215     cal->a[1] = (int)((b*z + e*zx + f*zy)*(scaling));
        LDR      R0,[SP, #+36]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+44]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+28]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+84]
//  216     cal->a[2] = (int)((c*z + f*zx + i*zy)*(scaling));
        LDR      R0,[SP, #+32]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+28]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+40]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+88]
//  217 
//  218 //    printf("%f %f %f\n",(a*z + b*zx + c*zy),
//  219 //                (b*z + e*zx + f*zy),
//  220 //                (c*z + f*zx + i*zy));
//  221 
//  222 // Get sums for y calibration
//  223     z = zx = zy = 0;
        MOVS     R0,#+0
        MOVS     R7,R0
        MOVS     R6,R0
        MOV      R8,R0
//  224     for(j=0;j<5;j++) {
        MOVS     R0,#+0
        MOVS     R5,R0
??perform_calibration_6:
        CMP      R5,#+5
        BGE.N    ??perform_calibration_7
//  225         z += (float)cal->yfb[j];
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+60]
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        MOV      R8,R0
//  226         zx += (float)(cal->yfb[j]*cal->x[j]);
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+60]
        LDR      R1,[R4, R5, LSL #+2]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        MOVS     R1,R6
        BL       __aeabi_fadd
        MOVS     R6,R0
//  227         zy += (float)(cal->yfb[j]*cal->y[j]);
        ADDS     R0,R4,R5, LSL #+2
        LDR      R0,[R0, #+60]
        ADDS     R1,R4,R5, LSL #+2
        LDR      R1,[R1, #+40]
        MULS     R0,R1,R0
        BL       __aeabi_i2f
        MOVS     R1,R7
        BL       __aeabi_fadd
        MOVS     R7,R0
//  228     }
        ADDS     R5,R5,#+1
        B.N      ??perform_calibration_6
//  229 
//  230 // Now multiply out to get the calibration for framebuffer y coord
//  231     cal->a[3] = (int)((a*z + b*zx + c*zy)*(scaling));
??perform_calibration_7:
        LDR      R0,[SP, #+48]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+36]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+32]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+92]
//  232     cal->a[4] = (int)((b*z + e*zx + f*zy)*(scaling));
        LDR      R0,[SP, #+36]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+44]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+28]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+96]
//  233     cal->a[5] = (int)((c*z + f*zx + i*zy)*(scaling));
        LDR      R0,[SP, #+32]
        MOV      R1,R8
        BL       __aeabi_fmul
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+28]
        MOVS     R1,R6
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        STR      R0,[SP, #+0]
        LDR      R0,[SP, #+40]
        MOVS     R1,R7
        BL       __aeabi_fmul
        LDR      R1,[SP, #+0]
        BL       __aeabi_fadd
        LDR      R1,[SP, #+16]
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STR      R0,[R4, #+100]
//  234 
//  235 //    printf("%f %f %f\n",(a*z + b*zx + c*zy),
//  236 //                (b*z + e*zx + f*zy),
//  237 //                (c*z + f*zx + i*zy));
//  238 
//  239 // If we got here, we're OK, so assign scaling to a[6] and return
//  240     cal->a[6] = (int)scaling;
        LDR      R0,[SP, #+16]
        BL       __aeabi_f2iz
        STR      R0,[R4, #+104]
//  241     return 1;
        MOVS     R0,#+1
??perform_calibration_3:
        ADD      SP,SP,#+52
        POP      {R4-R11,PC}      ;; return
//  242 /*
//  243 // This code was here originally to just insert default values
//  244     for(j=0;j<7;j++) {
//  245         c->a[j]=0;
//  246     }
//  247     c->a[1] = c->a[5] = c->a[6] = 1;
//  248     return 1;
//  249 */
//  250 
//  251 #else
//  252 //#define  TOUXCH_DIV    (65536.0)
//  253 
//  254     uint16 test_x=0, test_y=0;
//  255     uint16 gap_x=0, gap_y=0;
//  256 
//  257 
//  258     /* K��(X0��X2) (Y1��Y2)��(X1��X2) (Y0��Y2) */
//  259     cal->a[6] = ((cal->x[0] - cal->x[2]) * (cal->y[1] - cal->y[2])) -
//  260                     ((cal->x[1] - cal->x[2]) * (cal->y[0] - cal->y[2])) ;
//  261 
//  262     if( cal->a[6]  == 0 )
//  263     {
//  264         return 0;
//  265     }
//  266     else
//  267     {
//  268         /* A��((XD0��XD2) (Y1��Y2)��(XD1��XD2) (Y0��Y2))��K */
//  269         cal->a[0] = (((cal->xfb[0] - cal->xfb[2]) * (cal->y[1] - cal->y[2])) -
//  270                    ((cal->xfb[1] - cal->xfb[2]) * (cal->y[0] - cal->y[2])));
//  271 
//  272         /* B��((X0��X2) (XD1��XD2)��(XD0��XD2) (X1��X2))��K */
//  273         cal->a[1] = (((cal->x[0] - cal->x[2]) * (cal->xfb[1] - cal->xfb[2])) -
//  274                    ((cal->xfb[0] - cal->xfb[2]) * (cal->x[1] - cal->x[2])));
//  275 
//  276         /* C��(Y0(X2XD1��X1XD2)+Y1(X0XD2��X2XD0)+Y2(X1XD0��X0XD1))��K */
//  277         cal->a[2] = ((cal->x[2] * cal->xfb[1] - cal->x[1] * cal->xfb[2]) * cal->y[0] +
//  278                    (cal->x[0] * cal->xfb[2] - cal->x[2] * cal->xfb[0]) * cal->y[1] +
//  279                    (cal->x[1] * cal->xfb[0] - cal->x[0] * cal->xfb[1]) * cal->y[2]);
//  280 
//  281         /* D��((YD0��YD2) (Y1��Y2)��(YD1��YD2) (Y0��Y2))��K */
//  282         cal->a[3] = (((cal->yfb[0] - cal->yfb[2]) * (cal->y[1] - cal->y[2])) -
//  283                    ((cal->yfb[1] - cal->yfb[2]) * (cal->y[0] - cal->y[2]))) ;
//  284 
//  285         /* E��((X0��X2) (YD1��YD2)��(YD0��YD2) (X1��X2))��K */
//  286         cal->a[4] = (((cal->x[0] - cal->x[2]) * (cal->yfb[1] - cal->yfb[2])) -
//  287                    ((cal->yfb[0] - cal->yfb[2]) * (cal->x[1] - cal->x[2]))) ;
//  288 
//  289 
//  290         /* F��(Y0(X2YD1��X1YD2)+Y1(X0YD2��X2YD0)+Y2(X1YD0��X0YD1))��K */
//  291         cal->a[5] = ((cal->x[2] * cal->yfb[1] - cal->x[1] * cal->yfb[2]) * cal->y[0] +
//  292                    (cal->x[0] * cal->yfb[2] - cal->x[2] * cal->yfb[0]) * cal->y[1] +
//  293                    (cal->x[1] * cal->yfb[0] - cal->x[0] * cal->yfb[1]) * cal->y[2]);
//  294 
//  295         //У���4����
//  296             /*ȡһ�������Xֵ*/
//  297         test_x = (( (cal->a[0] * cal->x[3]) +
//  298                    (cal->a[1] * cal->y[3]) +
//  299                     cal->a[2]
//  300                  )) / cal->a[6] ;
//  301 
//  302             /*ȡһ�������Yֵ*/
//  303         test_y = (( (cal->a[3] * cal->x[3]) +
//  304                    (cal->a[4] * cal->y[3]) +
//  305                    cal->a[5]
//  306                  )) / cal->a[6] ;
//  307 
//  308         /* ʵ���������������Ĳ� */
//  309         gap_x = abs(test_x - cal->xfb[3]);
//  310         if(gap_x > 10)return 0;
//  311         gap_y = abs(test_y - cal->yfb[3]);
//  312         if(gap_y > 10)return 0;
//  313 
//  314     }
//  315     return 1 ;
//  316 
//  317 #endif
//  318 
//  319 }
//  320 
//  321 
//  322 /*
//  323 *********************************************************************************************************
//  324 *   �� �� ��: TSC2046_ReadAdc
//  325 *   ����˵��: ѡ��һ��ģ��ͨ��������ADC��������ADC�������
//  326 *   ��    �Σ�_ucCh = 0x90 ��ʾYͨ���� 0xd0 ��ʾXͨ��
//  327 *   �� �� ֵ: 12λADCֵ
//  328 *********************************************************************************************************
//  329 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  330 uint16 xpt2046_read_ch(uint8_t _ucCh)
//  331 {
xpt2046_read_ch:
        PUSH     {R0,R4,LR}
        SUB      SP,SP,#+20
//  332     uint16 tmp;
//  333     uint8 buff[2]={0,0};
        MOVS     R0,#+0
        STRH     R0,[SP, #+16]
//  334     spi_mosi_cmd(TOUCH_SPI,TOUCH_CS, &_ucCh ,NULL ,buff, buff, 1 , 2); //SPI���ͽ��պ���
        MOVS     R0,#+2
        STR      R0,[SP, #+12]
        MOVS     R0,#+1
        STR      R0,[SP, #+8]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+4]
        ADD      R0,SP,#+16
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        ADD      R2,SP,#+20
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       spi_mosi_cmd
//  335                                                                                 //�������� _ucCh ����2������
//  336 
//  337 #if 1
//  338     //if(_ucCh == 0x90)
//  339     {
//  340         //tmp =  (buff[0]<<5);
//  341         //tmp |= (buff[1]>>3);
//  342         //tmp >>= 4;
//  343         tmp = buff[0] <<8;
        LDRB     R0,[SP, #+16]
        LSLS     R0,R0,#+8
        MOVS     R4,R0
//  344         tmp |= buff[1];
        LDRB     R0,[SP, #+17]
        ORRS     R4,R0,R4
//  345         tmp >>= 3;
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LSRS     R4,R4,#+3
//  346 
//  347         return tmp ;
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ADD      SP,SP,#+24
        POP      {R4,PC}          ;; return
//  348     }
//  349 //    else
//  350 //    {
//  351 //        return (buff[0]<<4) | (buff[1]>>4);
//  352 //    }
//  353 #else
//  354 
//  355 #endif
//  356 
//  357 
//  358 }
//  359 
//  360 
//  361 /*
//  362  * ��ȡTP x y ��ADֵ(12bit�������4096)
//  363  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  364 void xpt2046_get_xy(Site_t * site)
//  365 {
xpt2046_get_xy:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  366     DELAY_US(touch_delay);
        LDR.N    R0,??DataTable6_4
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_10
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOV      R1,#+1000
        UDIV     R0,R0,R1
        BL       systick_delay
//  367 
//  368     site->x= xpt2046_read_ch(TOUCH_XCh_12bit);
        MOVS     R0,#+208
        BL       xpt2046_read_ch
        STRH     R0,[R4, #+0]
//  369 
//  370     DELAY_US(touch_delay);
        LDR.N    R0,??DataTable6_4
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable6_10
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOV      R1,#+1000
        UDIV     R0,R0,R1
        BL       systick_delay
//  371 
//  372     site->y = xpt2046_read_ch(TOUCH_YCh_12bit);
        MOVS     R0,#+144
        BL       xpt2046_read_ch
        STRH     R0,[R4, #+2]
//  373 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x249f0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     touch_baud

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0xa0103

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x7a1200

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     touch_delay

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     cal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     cal+0x50

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0x3ff00000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     0x3dcccccd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     0xbdcccccc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     core_clk_khz
//  374 
//  375 
//  376 /******************************************************
//  377 * ��������Read_2046
//  378 * ����  ���õ����˲�֮���X Y
//  379 * ����  ��Coordinate�ṹ���ַ
//  380 * ���  ��1�ɹ���0ʧ��
//  381 * ����  ����
//  382 * ע��  ��������Ӧ��ʵ��"ר��,���Ǻܾ�׼�������ٶȱȽϿ�
//  383 *********************************************************/
//  384 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  385 uint8 xpt2046_read(Site_t * site )
//  386 {
xpt2046_read:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+32
        MOVS     R4,R0
//  387 #define READ_COUNT      3
//  388 #define XPT2046_ERROR   40
//  389     //static Site_t screen;
//  390     uint8 count=0,i;
        MOVS     R6,#+0
//  391     Site_t  sitexy;
//  392 
//  393     uint32 sumx,sumy;
//  394 
//  395     int buffer[2][READ_COUNT]={{0},{0}};  /*����X��Y���ж�β���*/
        ADD      R0,SP,#+4
        MOVS     R1,#+24
        BL       __aeabi_memclr4
//  396 
//  397     /* ѭ������ READ_COUNT �� */
//  398     do{
//  399         xpt2046_get_xy(&sitexy);
??xpt2046_read_0:
        ADD      R0,SP,#+0
        BL       xpt2046_get_xy
//  400         if((sitexy.x == 0) || (sitexy.y == 0xFFF))return 0;//����
        LDRH     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??xpt2046_read_1
        LDRH     R0,[SP, #+2]
        MOVW     R1,#+4095
        CMP      R0,R1
        BNE.N    ??xpt2046_read_2
??xpt2046_read_1:
        MOVS     R0,#+0
        B.N      ??xpt2046_read_3
//  401         buffer[0][count]=sitexy.x;
??xpt2046_read_2:
        LDRH     R0,[SP, #+0]
        ADD      R1,SP,#+4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        STR      R0,[R1, R6, LSL #+2]
//  402         buffer[1][count]=sitexy.y;
        LDRH     R0,[SP, #+2]
        ADD      R1,SP,#+4
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        ADDS     R1,R1,R6, LSL #+2
        STR      R0,[R1, #+12]
//  403         count++;
        ADDS     R6,R6,#+1
//  404     }while(count<READ_COUNT); //�û����������ʱ��TP_INT_IN�ź�Ϊ�� ���� count<10
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BLT.N    ??xpt2046_read_0
//  405 
//  406     if(count == READ_COUNT)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??xpt2046_read_4
//  407     {
//  408         //ȥ����Сֵ �� ���ֵ ,����ƽ��ֵ
//  409         sumx = buffer[0][0];
        LDR      R0,[SP, #+4]
        MOVS     R7,R0
//  410         sumy = buffer[1][0];
        LDR      R0,[SP, #+16]
        MOV      R8,R0
//  411         for(i=1;i<READ_COUNT;i++)
        MOVS     R0,#+1
        MOVS     R5,R0
??xpt2046_read_5:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BGE.N    ??xpt2046_read_6
//  412         {
//  413             sumx += buffer[0][i];
        ADD      R0,SP,#+4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        ADDS     R7,R0,R7
//  414             sumy += buffer[1][i];
        ADD      R0,SP,#+4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+2
        LDR      R0,[R0, #+12]
        ADDS     R8,R0,R8
//  415         }
        ADDS     R5,R5,#+1
        B.N      ??xpt2046_read_5
//  416         site->x = sumx /READ_COUNT;
??xpt2046_read_6:
        MOVS     R0,#+3
        UDIV     R0,R7,R0
        STRH     R0,[R4, #+0]
//  417         site->y = sumy /READ_COUNT;
        MOVS     R0,#+3
        UDIV     R0,R8,R0
        STRH     R0,[R4, #+2]
//  418 
//  419 
//  420         //У�顣�ж���û�������㳬�� ���ֵ
//  421         for(i=1;i<READ_COUNT;i++)
        MOVS     R0,#+1
        MOVS     R5,R0
??xpt2046_read_7:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BGE.N    ??xpt2046_read_8
//  422         {
//  423             if(abs(buffer[0][i] -site->x ) > XPT2046_ERROR)
        ADD      R0,SP,#+4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R0, R5, LSL #+2]
        LDRH     R1,[R4, #+0]
        SUBS     R0,R0,R1
        BL       abs
        CMP      R0,#+41
        BLT.N    ??xpt2046_read_9
//  424             {
//  425                 return 0;
        MOVS     R0,#+0
        B.N      ??xpt2046_read_3
//  426             }
//  427             if(abs(buffer[1][i] -site->y ) > XPT2046_ERROR)
??xpt2046_read_9:
        ADD      R0,SP,#+4
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        ADDS     R0,R0,R5, LSL #+2
        LDR      R0,[R0, #+12]
        LDRH     R1,[R4, #+2]
        SUBS     R0,R0,R1
        BL       abs
        CMP      R0,#+41
        BLT.N    ??xpt2046_read_10
//  428             {
//  429                 return 0;
        MOVS     R0,#+0
        B.N      ??xpt2046_read_3
//  430             }
//  431 
//  432         }
??xpt2046_read_10:
        ADDS     R5,R5,#+1
        B.N      ??xpt2046_read_7
//  433 
//  434         return 1;
??xpt2046_read_8:
        MOVS     R0,#+1
        B.N      ??xpt2046_read_3
//  435 
//  436         //
//  437     }
//  438     return 0;
??xpt2046_read_4:
        MOVS     R0,#+0
??xpt2046_read_3:
        ADD      SP,SP,#+32
        POP      {R4-R8,PC}       ;; return
//  439 
//  440 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC32 0, 0, 0, 0, 0, 0

        END
//  441 
//  442 
//  443 
//  444 
//  445 
//  446 
//  447 
//  448 
//  449 
// 
//   116 bytes in section .bss
//    26 bytes in section .rodata
// 1 948 bytes in section .text
// 
// 1 948 bytes of CODE  memory
//    26 bytes of CONST memory
//   116 bytes of DATA  memory
//
//Errors: none
//Warnings: none
