///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:09
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_LCD.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ILI9341_get_h
        EXTERN ILI9341_get_w
        EXTERN LCD_ILI9341_init
        EXTERN LCD_ILI9341_ptlon
        EXTERN ascii_8x16
        EXTERN assert_failed

        PUBLIC LCD_Img_Binary
        PUBLIC LCD_Img_Binary_Z
        PUBLIC LCD_Img_gray
        PUBLIC LCD_Img_gray_Z
        PUBLIC LCD_char
        PUBLIC LCD_clear
        PUBLIC LCD_cross
        PUBLIC LCD_init
        PUBLIC LCD_num
        PUBLIC LCD_num_BC
        PUBLIC LCD_point
        PUBLIC LCD_points
        PUBLIC LCD_rectangle
        PUBLIC LCD_str
        PUBLIC LCD_wave
        PUBLIC LCD_wave_display

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD.c
//    1 /*!
//    2  *     COPYRIGHT NOTICE
//    3  *     Copyright (c) 2013,山外科技
//    4  *     All rights reserved.
//    5  *     技术讨论：山外论坛 http://www.vcan123.com
//    6  *
//    7  *     除注明出处外，以下所有内容版权均属山外科技所有，未经允许，不得用于商业用途，
//    8  *     修改内容时必须保留山外科技的版权声明。
//    9  *
//   10  * @file       VCAN_LCD.c
//   11  * @brief      LCD 函数库
//   12  * @author     山外科技
//   13  * @version    v5.0
//   14  * @date       2013-06-26
//   15  */
//   16 
//   17 
//   18 #include "common.h"
//   19 #include "VCAN_LCD.h"
//   20 
//   21 
//   22 
//   23 /*!
//   24  *  @brief      LCD初始化
//   25  *  @since      v5.0
//   26  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   27 void LCD_init(void)
//   28 {
LCD_init:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//   29     Site_t site = {0, 0};
        LDR.N    R0,??DataTable4
        LDR      R4,[R0, #+0]
//   30     Size_t size ;
//   31 
//   32     LCD_INIT();                             //初始化LCD
        BL       LCD_ILI9341_init
//   33 
//   34     //LCD_SET_DIR(LCD_DIR+1);
//   35 
//   36     //由于初始化的时候进行 屏幕方向 选择，因而初始化完成后，才获取宽高
//   37     size.W = LCD_W;
        BL       ILI9341_get_w
        STRH     R0,[SP, #+0]
//   38     size.H = LCD_H;
        BL       ILI9341_get_h
        STRH     R0,[SP, #+2]
//   39 
//   40     LCD_rectangle(site, size, BCOLOUR);     //初始化背景
        MOV      R2,#+63488
        LDR      R1,[SP, #+0]
        MOVS     R0,R4
        BL       LCD_rectangle
//   41 }
        POP      {R0,R1,R4,PC}    ;; return
//   42 
//   43 /*!
//   44  *  @brief      显示实心矩形
//   45  *  @param      site    左上角坐标
//   46  *  @param      size    矩形大小
//   47  *  @param      rgb565  颜色
//   48  *  @since      v5.0
//   49 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//   50                         Size_t size = {50,60};  // W = 50 ,H = 60
//   51                         LCD_rectangle(site, size, RED);
//   52  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 void LCD_rectangle(Site_t site, Size_t size, uint16 rgb565)
//   54 {
LCD_rectangle:
        PUSH     {R1,R4-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R2
//   55     uint32 n, temp;
//   56 
//   57     LCD_PTLON(site, size);              //开窗
        LDR      R1,[SP, #+0]
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//   58 
//   59     temp = (uint32)size.W * size.H;
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+2]
        MULS     R0,R1,R0
        MOVS     R7,R0
//   60     LCD_RAMWR();                        //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   61     for(n = 0; n < temp; n++)
        MOVS     R0,#+0
        MOVS     R6,R0
??LCD_rectangle_0:
        CMP      R6,R7
        BCS.N    ??LCD_rectangle_1
//   62     {
//   63         LCD_WR_DATA( rgb565 );          //写数据
        MOVS     R0,#+1744830464
        STRH     R5,[R0, #+0]
//   64     }
        ADDS     R6,R6,#+1
        B.N      ??LCD_rectangle_0
//   65 }
??LCD_rectangle_1:
        POP      {R0,R4-R7,PC}    ;; return
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void LCD_clear(uint16 rgb565)     //清屏
//   68 {
LCD_clear:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   69     Site_t site = {0,0};
        LDR.N    R0,??DataTable4_1
        LDR      R5,[R0, #+0]
//   70     Size_t size;
//   71     size.H = LCD_H;
        BL       ILI9341_get_h
        STRH     R0,[SP, #+2]
//   72     size.W = LCD_W;
        BL       ILI9341_get_w
        STRH     R0,[SP, #+0]
//   73 
//   74     LCD_rectangle(site, size, rgb565);
        MOVS     R2,R4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+0]
        MOVS     R0,R5
        BL       LCD_rectangle
//   75 
//   76 }
        POP      {R0,R4,R5,PC}    ;; return
//   77 
//   78 //画十字形

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   79 void LCD_cross(Site_t site,uint16 len,uint16 Color)
//   80 {
LCD_cross:
        PUSH     {R0,R4-R9,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R1
        MOVS     R5,R2
//   81     //画两条直线
//   82     Site_t sitetmp;
//   83     Size_t size;
//   84     int16  stmp,etmp;
//   85     uint16 w = LCD_W,h = LCD_H;
        BL       ILI9341_get_w
        MOV      R8,R0
        BL       ILI9341_get_h
        MOV      R9,R0
//   86 
//   87     ASSERT((site.x<LCD_W) && (site.y<LCD_H));       //十字线的中心不能超出液晶范围
        BL       ILI9341_get_w
        LDRH     R1,[SP, #+8]
        CMP      R1,R0
        BCS.N    ??LCD_cross_0
        BL       ILI9341_get_h
        LDRH     R1,[SP, #+10]
        CMP      R1,R0
        BCC.N    ??LCD_cross_1
??LCD_cross_0:
        MOVS     R1,#+87
        LDR.N    R0,??DataTable4_2
        BL       assert_failed
//   88 
//   89     stmp = site.x - len/2;                          //计算水平线的x轴起点和结束点，限制不超出液晶范围
??LCD_cross_1:
        LDRSH    R0,[SP, #+8]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R1,#+2
        SDIV     R1,R4,R1
        SUBS     R0,R0,R1
        MOVS     R6,R0
//   90     if(stmp < 0)stmp = 0;
        SXTH     R6,R6            ;; SignExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BPL.N    ??LCD_cross_2
        MOVS     R0,#+0
        MOVS     R6,R0
//   91     etmp = site.x + len/2;
??LCD_cross_2:
        LDRSH    R0,[SP, #+8]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R1,#+2
        SDIV     R1,R4,R1
        ADDS     R0,R1,R0
        MOVS     R7,R0
//   92     if(etmp >= w)etmp= w-1;
        SXTH     R7,R7            ;; SignExt  R7,R7,#+16,#+16
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R7,R8
        BLT.N    ??LCD_cross_3
        SUBS     R0,R8,#+1
        MOVS     R7,R0
//   93 
//   94     sitetmp.x = stmp;
??LCD_cross_3:
        STRH     R6,[SP, #+4]
//   95     sitetmp.y = site.y;
        LDRH     R0,[SP, #+10]
        STRH     R0,[SP, #+6]
//   96     size.W = etmp - stmp +1;
        SUBS     R0,R7,R6
        ADDS     R0,R0,#+1
        STRH     R0,[SP, #+0]
//   97     size.H = 1;
        MOVS     R0,#+1
        STRH     R0,[SP, #+2]
//   98     LCD_rectangle(sitetmp,size, Color);
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+4]
        BL       LCD_rectangle
//   99 
//  100     stmp = site.y - len/2;                          //计算水平线的x轴起点和结束点，限制不超出液晶范围
        LDRSH    R0,[SP, #+10]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R1,#+2
        SDIV     R1,R4,R1
        SUBS     R0,R0,R1
        MOVS     R6,R0
//  101     if(stmp < 0)stmp = 0;
        SXTH     R6,R6            ;; SignExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BPL.N    ??LCD_cross_4
        MOVS     R0,#+0
        MOVS     R6,R0
//  102     etmp = site.y + len/2;
??LCD_cross_4:
        LDRSH    R0,[SP, #+10]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R1,#+2
        SDIV     R1,R4,R1
        ADDS     R0,R1,R0
        MOVS     R7,R0
//  103     if(etmp >= h)etmp= h-1;
        SXTH     R7,R7            ;; SignExt  R7,R7,#+16,#+16
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        CMP      R7,R9
        BLT.N    ??LCD_cross_5
        SUBS     R0,R9,#+1
        MOVS     R7,R0
//  104 
//  105     sitetmp.x = site.x;
??LCD_cross_5:
        LDRH     R0,[SP, #+8]
        STRH     R0,[SP, #+4]
//  106     sitetmp.y = stmp;
        STRH     R6,[SP, #+6]
//  107     size.W = 1;
        MOVS     R0,#+1
        STRH     R0,[SP, #+0]
//  108     size.H = etmp - stmp +1;
        SUBS     R0,R7,R6
        ADDS     R0,R0,#+1
        STRH     R0,[SP, #+2]
//  109     LCD_rectangle(sitetmp,size, Color);
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+4]
        BL       LCD_rectangle
//  110 
//  111 
//  112 
//  113 }
        POP      {R0-R2,R4-R9,PC}  ;; return
//  114 
//  115 /*!
//  116  *  @brief      画点
//  117  *  @param      site    左上角坐标
//  118  *  @param      rgb565  颜色
//  119  *  @since      v5.0
//  120 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//  121                         LCD_point(site, RED);
//  122  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  123 void LCD_point(Site_t site, uint16 rgb565)
//  124 {
LCD_point:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  125     Size_t size = {1, 1};
        LDR.N    R0,??DataTable4_3
        LDR      R6,[R0, #+0]
//  126     LCD_PTLON(site, size);
        MOVS     R1,R6
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  127     LCD_RAMWR();                        //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  128     LCD_WR_DATA(rgb565);                //写数据
        MOVS     R0,#+1744830464
        STRH     R5,[R0, #+0]
//  129 }
        POP      {R4-R6,PC}       ;; return
//  130 
//  131 /*!
//  132  *  @brief      画一堆点
//  133  *  @param      site        点坐标数组
//  134  *  @param      point_num   点的数量
//  135  *  @param      rgb565      颜色
//  136  *  @since      v5.0
//  137 *  Sample usage:        Site_t site[3] = {{10,20},{11,21},{12,22}};   //3个点，坐标分别是  {10,20},{11,21},{12,22}
//  138                         LCD_points(site,3, RED);
//  139  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  140 void LCD_points          (Site_t *site,uint32 point_num, uint16 rgb565)                 //画一堆点
//  141 {
LCD_points:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  142     while(point_num--)
??LCD_points_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??LCD_points_1
        LDR      R0,[R4, R5, LSL #+2]
        STR      R0,[SP, #+0]
//  143     {
//  144         LCD_point(site[point_num],rgb565);                 //画点
        MOVS     R1,R6
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR      R0,[SP, #+0]
        BL       LCD_point
        B.N      ??LCD_points_0
//  145     }
//  146 }
??LCD_points_1:
        POP      {R0,R1,R4-R6,PC}  ;; return
//  147 
//  148 /*!
//  149  *  @brief      显示字符
//  150  *  @param      site    左上角坐标
//  151  *  @param      ascii   字符
//  152  *  @param      Color   字体颜色
//  153  *  @param      bkColor 背景颜色
//  154  *  @since      v5.0
//  155 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//  156                         LCD_char(site,'0', BLUE,RED);
//  157  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 void LCD_char(Site_t site, uint8 ascii, uint16 Color, uint16 bkColor)
//  159 {
LCD_char:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//  160 #define MAX_CHAR_POSX (LCD_W-8)
//  161 #define MAX_CHAR_POSY (LCD_H-16)
//  162 
//  163     uint8 temp, t, pos;
//  164     Size_t size = {8, 16};
        LDR.N    R0,??DataTable4_4
        LDR      R10,[R0, #+0]
//  165 
//  166     if(site.x > MAX_CHAR_POSX || site.y > MAX_CHAR_POSY)
        BL       ILI9341_get_w
        SUBS     R0,R0,#+8
        LDRH     R1,[SP, #+4]
        CMP      R0,R1
        BLT.N    ??LCD_char_0
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+6]
        CMP      R0,R1
        BGE.N    ??LCD_char_1
//  167     {
//  168         return;
??LCD_char_0:
        B.N      ??LCD_char_2
//  169     }
//  170 
//  171     LCD_PTLON(site, size);
??LCD_char_1:
        MOV      R1,R10
        LDR      R0,[SP, #+4]
        BL       LCD_ILI9341_ptlon
//  172 
//  173     LCD_RAMWR();                    //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  174 
//  175     for (pos = 0; pos < 16; pos++)
        MOVS     R0,#+0
        MOV      R9,R0
??LCD_char_3:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+16
        BGE.N    ??LCD_char_4
//  176     {
//  177         temp = ascii_8x16[((ascii-0x20)*16)+pos];
        LDR.N    R0,??DataTable4_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+4
        UXTAB    R1,R1,R9
        ADDS     R0,R1,R0
        SUBS     R0,R0,#+512
        LDRB     R0,[R0, #+0]
        MOVS     R7,R0
//  178 
//  179         for(t = 0; t < 8; t++)
        MOVS     R0,#+0
        MOV      R8,R0
??LCD_char_5:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+8
        BGE.N    ??LCD_char_6
//  180         {
//  181 
//  182             if(temp & 0x80)
        LSLS     R0,R7,#+24
        BPL.N    ??LCD_char_7
//  183             {
//  184                 LCD_WR_DATA(Color);
        MOVS     R0,#+1744830464
        STRH     R5,[R0, #+0]
        B.N      ??LCD_char_8
//  185             }
//  186             else
//  187             {
//  188                 LCD_WR_DATA(bkColor);
??LCD_char_7:
        MOVS     R0,#+1744830464
        STRH     R6,[R0, #+0]
//  189             }
//  190             temp <<= 1;
??LCD_char_8:
        LSLS     R7,R7,#+1
//  191         }
        ADDS     R8,R8,#+1
        B.N      ??LCD_char_5
//  192     }
??LCD_char_6:
        ADDS     R9,R9,#+1
        B.N      ??LCD_char_3
//  193     return;
??LCD_char_4:
??LCD_char_2:
        POP      {R0,R1,R4-R10,PC}  ;; return
//  194 #undef MAX_CHAR_POSX
//  195 #undef MAX_CHAR_POSY
//  196 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     ascii_8x16
//  197 
//  198 /*!
//  199  *  @brief      显示字符串
//  200  *  @param      site    左上角坐标
//  201  *  @param      Str     字符串地址
//  202  *  @param      Color   字体颜色
//  203  *  @param      bkColor 背景颜色
//  204  *  @since      v5.0
//  205 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//  206                         LCD_str(site,"www.vcan123.com", BLUE,RED);
//  207  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  208 void LCD_str(Site_t site, uint8 *Str, uint16 Color, uint16 bkColor)
//  209 {
LCD_str:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//  210 #define MAX_CHAR_POSX (LCD_W-8)
//  211 #define MAX_CHAR_POSY (LCD_H-16)
//  212     while(*Str != '\0')
??LCD_str_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??LCD_str_1
//  213     {
//  214         if(site.x > MAX_CHAR_POSX )
        BL       ILI9341_get_w
        SUBS     R0,R0,#+8
        LDRH     R1,[SP, #+4]
        CMP      R0,R1
        BGE.N    ??LCD_str_2
//  215         {
//  216             //换行
//  217             site.x = 0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  218             site.y += 16;
        LDRH     R0,[SP, #+6]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+6]
//  219         }
//  220         if(site.y > MAX_CHAR_POSY )
??LCD_str_2:
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+6]
        CMP      R0,R1
        BGE.N    ??LCD_str_3
//  221         {
//  222             //一屏
//  223             site.y = 0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+6]
//  224             site.x = 0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  225         }
//  226 
//  227         LCD_char(site, *Str, Color, bkColor);
??LCD_str_3:
        MOVS     R3,R6
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRB     R1,[R4, #+0]
        LDR      R0,[SP, #+4]
        BL       LCD_char
//  228         site.x += 8;
        LDRH     R0,[SP, #+4]
        ADDS     R0,R0,#+8
        STRH     R0,[SP, #+4]
//  229         Str ++ ;
        ADDS     R4,R4,#+1
        B.N      ??LCD_str_0
//  230     }
//  231 #undef MAX_CHAR_POSX
//  232 #undef MAX_CHAR_POSY
//  233 }
??LCD_str_1:
        POP      {R0,R1,R4-R6,PC}  ;; return
//  234 
//  235 /*!
//  236  *  @brief      显示数字
//  237  *  @param      site    左上角坐标
//  238  *  @param      num     数字
//  239  *  @param      Color   字体颜色
//  240  *  @param      bkColor 背景颜色
//  241  *  @since      v5.0
//  242 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//  243                         LCD_num(site,123, BLUE,RED);
//  244  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  245 void LCD_num(Site_t site, uint32 num, uint16 Color, uint16 bkColor)
//  246 {
LCD_num:
        PUSH     {R0,R4-R8,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//  247     uint32 res = num;
        MOVS     R7,R4
//  248     uint8 t = 0;
        MOVS     R8,#+0
//  249     Site_t sitetemp;
//  250     sitetemp.y = site.y;
        LDRH     R0,[SP, #+6]
        STRH     R0,[SP, #+2]
//  251 
//  252     if( num == 0 )
        CMP      R4,#+0
        BNE.N    ??LCD_num_0
//  253     {
//  254         LCD_char(site, '0', Color, bkColor);
        MOVS     R3,R6
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,#+48
        LDR      R0,[SP, #+4]
        BL       LCD_char
//  255         return;
        B.N      ??LCD_num_1
//  256     }
//  257     while( res )  /*得到数字长度t*/
??LCD_num_0:
        CMP      R7,#+0
        BEQ.N    ??LCD_num_2
//  258     {
//  259         res /= 10;
        MOVS     R0,#+10
        UDIV     R7,R7,R0
//  260         t++;
        ADDS     R8,R8,#+1
        B.N      ??LCD_num_0
//  261     }
//  262 
//  263     while(num)
??LCD_num_2:
        CMP      R4,#+0
        BEQ.N    ??LCD_num_3
//  264     {
//  265         sitetemp.x = site.x + (8 * (t--) - 8);
        LDRH     R0,[SP, #+4]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        ADDS     R0,R0,R8, LSL #+3
        SUBS     R0,R0,#+8
        STRH     R0,[SP, #+0]
        SUBS     R8,R8,#+1
//  266         LCD_char(sitetemp, (num % 10) + '0', Color, bkColor);
        MOVS     R0,#+10
        MOVS     R3,R6
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        UDIV     R1,R4,R0
        MLS      R0,R0,R1,R4
        ADDS     R1,R0,#+48
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR      R0,[SP, #+0]
        BL       LCD_char
//  267         num /= 10 ;
        MOVS     R0,#+10
        UDIV     R4,R4,R0
        B.N      ??LCD_num_2
//  268     }
//  269 }
??LCD_num_3:
??LCD_num_1:
        POP      {R0,R1,R4-R8,PC}  ;; return
//  270 
//  271 /*!
//  272  *  @brief      显示数字（清空多余的位）
//  273  *  @param      site            左上角坐标
//  274  *  @param      num             数字
//  275  *  @param      max_num_bit     最大的位数
//  276  *  @param      Color           字体颜色
//  277  *  @param      bkColor         背景颜色
//  278  *  @since      v5.0
//  279 *  Sample usage:        Site_t site = {10,20};   //x = 10 ,y = 20
//  280                         LCD_num_BC(site,123,5, BLUE,RED);
//  281  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  282 void LCD_num_BC(Site_t site, uint32 num, uint8 max_num_bit, uint16 Color, uint16 bkColor)
//  283 {
LCD_num_BC:
        PUSH     {R0,R4-R9,LR}
        SUB      SP,SP,#+8
        MOV      R9,R1
        MOVS     R5,R2
        MOVS     R6,R3
        LDR      R4,[SP, #+40]
//  284     uint32 res = num;
        MOV      R7,R9
//  285     uint8 t = 0;
        MOVS     R8,#+0
//  286     Site_t sitetemp;
//  287     Size_t size;
//  288 
//  289     sitetemp.y = site.y;
        LDRH     R0,[SP, #+10]
        STRH     R0,[SP, #+6]
//  290 
//  291     if( num == 0 )
        CMP      R9,#+0
        BNE.N    ??LCD_num_BC_0
//  292     {
//  293         LCD_char(site, '0', Color, bkColor);
        MOVS     R3,R4
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,#+48
        LDR      R0,[SP, #+8]
        BL       LCD_char
//  294 
//  295         site.x += 8;
        LDRH     R0,[SP, #+8]
        ADDS     R0,R0,#+8
        STRH     R0,[SP, #+8]
//  296         size.H  = 16;
        MOVS     R0,#+16
        STRH     R0,[SP, #+2]
//  297         size.W  = 8 * (max_num_bit - 1);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        SUBS     R0,R5,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSLS     R0,R0,#+3
        STRH     R0,[SP, #+0]
//  298         LCD_rectangle(site, size, bkColor);
        MOVS     R2,R4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+8]
        BL       LCD_rectangle
//  299 
//  300         return;
        B.N      ??LCD_num_BC_1
//  301     }
//  302     while( res )            /*得到数字长度t*/
??LCD_num_BC_0:
        CMP      R7,#+0
        BEQ.N    ??LCD_num_BC_2
//  303     {
//  304         res /= 10;
        MOVS     R0,#+10
        UDIV     R7,R7,R0
//  305         t++;
        ADDS     R8,R8,#+1
        B.N      ??LCD_num_BC_0
//  306     }
//  307     if(t >= max_num_bit )    //限制最大长度
??LCD_num_BC_2:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R8,R5
        BCC.N    ??LCD_num_BC_3
//  308     {
//  309         t = max_num_bit;
        MOV      R8,R5
//  310     }
//  311 
//  312     res = t;
??LCD_num_BC_3:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        MOV      R7,R8
//  313 
//  314     while( t != 0 )
??LCD_num_BC_4:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??LCD_num_BC_5
//  315     {
//  316         sitetemp.x = site.x + (8 * (t--) - 8);
        LDRH     R0,[SP, #+8]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        ADDS     R0,R0,R8, LSL #+3
        SUBS     R0,R0,#+8
        STRH     R0,[SP, #+4]
        SUBS     R8,R8,#+1
//  317         LCD_char(sitetemp, (num % 10) + '0', Color, bkColor);
        MOVS     R0,#+10
        MOVS     R3,R4
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        UDIV     R1,R9,R0
        MLS      R0,R0,R1,R9
        ADDS     R1,R0,#+48
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR      R0,[SP, #+4]
        BL       LCD_char
//  318         num /= 10 ;
        MOVS     R0,#+10
        UDIV     R9,R9,R0
        B.N      ??LCD_num_BC_4
//  319     }
//  320 
//  321     if(res != max_num_bit )
??LCD_num_BC_5:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R7,R5
        BEQ.N    ??LCD_num_BC_6
//  322     {
//  323         size.W = 8 * (max_num_bit - res);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        SUBS     R0,R5,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSLS     R0,R0,#+3
        STRH     R0,[SP, #+0]
//  324         site.x += (8 * res);
        LDRH     R0,[SP, #+8]
        LSLS     R1,R7,#+3
        UXTAH    R0,R1,R0
        STRH     R0,[SP, #+8]
//  325         size.H  = 16;
        MOVS     R0,#+16
        STRH     R0,[SP, #+2]
//  326         LCD_rectangle(site, size, bkColor);
        MOVS     R2,R4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+8]
        BL       LCD_rectangle
//  327     }
//  328 }
??LCD_num_BC_6:
??LCD_num_BC_1:
        POP      {R0-R2,R4-R9,PC}  ;; return
//  329 
//  330 /*!
//  331  *  @brief      灰度图像显示
//  332  *  @param      site            左上角坐标
//  333  *  @param      size            显示图像大小
//  334  *  @param      img             图像地址
//  335  *  @since      v5.0
//  336  *  Sample usage:       Site_t site = {10,20};      //x = 10 ,y = 20
//  337                         Size_t size = {320,240};    //W = 320,H = 240
//  338                         LCD_Img_gray(site, size, img);
//  339  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  340 void LCD_Img_gray(Site_t site, Size_t size, uint8 *img)
//  341 {
LCD_Img_gray:
        PUSH     {R0,R1,R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R2
//  342     uint32     total = (size.H * size.W);
        LDRH     R0,[SP, #+6]
        LDRH     R1,[SP, #+4]
        MUL      R8,R1,R0
//  343     uint16     imgtemp;
//  344     uint8     *pimg = (uint8 *)img;
        MOVS     R7,R5
//  345 
//  346     LCD_PTLON(site, size);                      //开窗
        LDR      R1,[SP, #+4]
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  347     LCD_RAMWR();                                //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  348 
//  349     while(total--)
??LCD_Img_gray_0:
        MOV      R0,R8
        SUBS     R8,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??LCD_Img_gray_1
//  350     {
//  351         imgtemp     = (uint16) * (pimg++);
        LDRB     R0,[R7, #+0]
        MOVS     R6,R0
        ADDS     R7,R7,#+1
//  352         imgtemp = GRAY_2_RGB565(imgtemp);
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSRS     R1,R1,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R1,R1,#+5
        ORRS     R0,R1,R0, LSL #+11
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LSRS     R1,R6,#+3
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ORRS     R6,R1,R0
//  353         LCD_WR_DATA( imgtemp );               //写图像数据
        MOVS     R0,#+1744830464
        STRH     R6,[R0, #+0]
        B.N      ??LCD_Img_gray_0
//  354     }
//  355 }
??LCD_Img_gray_1:
        POP      {R0,R1,R4-R8,PC}  ;; return
//  356 
//  357 /*!
//  358  *  @brief      缩放灰度图像显示
//  359  *  @param      site            左上角坐标
//  360  *  @param      size            显示图像大小
//  361  *  @param      img             图像地址
//  362  *  @param      imgsize         图像大小
//  363  *  @since      v5.0
//  364  *  Sample usage:       Site_t site = {10,20};          //x = 10 ,y = 20
//  365                         Size_t size = {80,60};          //W = 80,H = 60
//  366                         Size_t imgsize = {320,240};     //W = 320,H = 240
//  367                         LCD_Img_gray_Z(site, size, img,imgsize);
//  368  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  369 void LCD_Img_gray_Z(Site_t site, Size_t size, uint8 *img, Size_t imgsize)
//  370 {
LCD_Img_gray_Z:
        PUSH     {R1,R3-R11,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R2
//  371 
//  372     uint32 temp, tempY;
//  373     uint16 x, y;
//  374     uint16 X, Y;
//  375     uint8 *pimg = (uint8 *)img;
        MOV      R10,R5
//  376     uint16 rgb;
//  377 
//  378     LCD_PTLON(site, size);                      //开窗
        LDR      R1,[SP, #+12]
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  379 
//  380     LCD_RAMWR();                                //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  381 
//  382     for(y = 0; y < size.H; y++)
        MOVS     R0,#+0
        MOV      R8,R0
??LCD_Img_gray_Z_0:
        LDRH     R0,[SP, #+14]
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,R0
        BCS.N    ??LCD_Img_gray_Z_1
//  383     {
//  384         Y = ( (  y * imgsize.H   ) / size.H) ;
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        LDRH     R0,[SP, #+18]
        MUL      R0,R0,R8
        LDRH     R1,[SP, #+14]
        SDIV     R0,R0,R1
        STRH     R0,[SP, #+0]
//  385         tempY = Y * imgsize.W ;
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+16]
        MULS     R0,R1,R0
        STR      R0,[SP, #+4]
//  386 
//  387         for(x = 0; x < size.W; x++)
        MOVS     R0,#+0
        MOVS     R7,R0
??LCD_Img_gray_Z_2:
        LDRH     R0,[SP, #+12]
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,R0
        BCS.N    ??LCD_Img_gray_Z_3
//  388         {
//  389             X = ( x * imgsize.W  ) / size.W ;
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LDRH     R0,[SP, #+16]
        MUL      R0,R0,R7
        LDRH     R1,[SP, #+12]
        SDIV     R0,R0,R1
        MOV      R9,R0
//  390             temp = tempY + X;
        LDR      R0,[SP, #+4]
        UXTAH    R0,R0,R9
        MOVS     R6,R0
//  391             rgb = GRAY_2_RGB565(pimg[temp]);    //
        LDRB     R0,[R6, R10]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R1,[R6, R10]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSRS     R1,R1,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R1,R1,#+5
        ORRS     R0,R1,R0, LSL #+11
        LDRB     R1,[R6, R10]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSRS     R1,R1,#+3
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ORRS     R0,R1,R0
        MOV      R11,R0
//  392             LCD_WR_DATA(rgb);
        MOVS     R0,#+1744830464
        STRH     R11,[R0, #+0]
//  393         }
        ADDS     R7,R7,#+1
        B.N      ??LCD_Img_gray_Z_2
//  394     }
??LCD_Img_gray_Z_3:
        ADDS     R8,R8,#+1
        B.N      ??LCD_Img_gray_Z_0
//  395 }
??LCD_Img_gray_Z_1:
        ADD      SP,SP,#+20
        POP      {R4-R11,PC}      ;; return
//  396 
//  397 
//  398 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  399 void LCD_Img_Binary(Site_t site, Size_t size, uint8 *img)
//  400 {
LCD_Img_Binary:
        PUSH     {R1,R4-R9,LR}
        MOVS     R4,R0
        MOVS     R5,R2
//  401     uint32     total = (size.H * size.W) / 8;
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        MULS     R0,R1,R0
        MOVS     R1,#+8
        SDIV     R6,R0,R1
//  402     uint8     imgtemp;
//  403     uint8       bitindex;
//  404     uint8     *pimg = (uint8 *)img;
        MOV      R9,R5
//  405 
//  406     LCD_PTLON(site, size);                      //开窗
        LDR      R1,[SP, #+0]
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  407 
//  408     LCD_RAMWR();                                //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  409 
//  410     while(total--)
??LCD_Img_Binary_0:
        MOVS     R0,R6
        SUBS     R6,R0,#+1
        CMP      R0,#+0
        BEQ.N    ??LCD_Img_Binary_1
//  411     {
//  412         imgtemp     = *(pimg++);
        LDRB     R0,[R9, #+0]
        MOVS     R7,R0
        ADDS     R9,R9,#+1
//  413         bitindex    = 8;
        MOVS     R0,#+8
        MOV      R8,R0
//  414         while(bitindex--)
??LCD_Img_Binary_2:
        MOV      R0,R8
        SUBS     R8,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LCD_Img_Binary_0
//  415         {
//  416             if( imgtemp & (0x01 << bitindex) )
        MOVS     R0,#+1
        LSLS     R0,R0,R8
        MOVS     R1,R7
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        TST      R1,R0
        BEQ.N    ??LCD_Img_Binary_3
//  417             {
//  418                 LCD_WR_DATA( BINARY_COLOR );      //写图像数据
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
        B.N      ??LCD_Img_Binary_2
//  419             }
//  420             else
//  421             {
//  422                 LCD_WR_DATA(  BINARY_BGCOLOR  );      //写图像数据
??LCD_Img_Binary_3:
        MOVW     R0,#+65535
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
        B.N      ??LCD_Img_Binary_2
//  423             }
//  424         }
//  425     }
//  426 }
??LCD_Img_Binary_1:
        POP      {R0,R4-R9,PC}    ;; return
//  427 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  428 void LCD_Img_Binary_Z(Site_t site, Size_t size, uint8 *img, Size_t imgsize)
//  429 {
LCD_Img_Binary_Z:
        PUSH     {R0,R1,R3-R11,LR}
        MOVS     R4,R0
        MOV      R10,R2
//  430 
//  431     uint32 temp, tempY;
//  432     uint16 x, y;
//  433     uint16 X, Y;
//  434     uint8 *pimg = (uint8 *)img;
        MOV      R11,R10
//  435 
//  436     LCD_PTLON(site, size);                      //开窗
        LDR      R1,[SP, #+4]
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  437 
//  438     LCD_RAMWR();                                //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  439 
//  440     for(y = 0; y < size.H; y++)
        MOVS     R0,#+0
        MOV      R8,R0
??LCD_Img_Binary_Z_0:
        LDRH     R0,[SP, #+6]
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,R0
        BCS.N    ??LCD_Img_Binary_Z_1
//  441     {
//  442         Y = ( (  y * imgsize.H  ) / size.H) ;
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        LDRH     R0,[SP, #+10]
        MUL      R0,R0,R8
        LDRH     R1,[SP, #+6]
        SDIV     R0,R0,R1
        STRH     R0,[SP, #+0]
//  443         tempY = Y * imgsize.W ;
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+8]
        MULS     R0,R1,R0
        MOVS     R6,R0
//  444 
//  445         for(x = 0; x < size.W; x++)
        MOVS     R0,#+0
        MOVS     R7,R0
??LCD_Img_Binary_Z_2:
        LDRH     R0,[SP, #+4]
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,R0
        BCS.N    ??LCD_Img_Binary_Z_3
//  446         {
//  447             X = (( x * imgsize.W  ) / size.W) ;
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LDRH     R0,[SP, #+8]
        MUL      R0,R0,R7
        LDRH     R1,[SP, #+4]
        SDIV     R0,R0,R1
        MOV      R9,R0
//  448             temp = tempY + X;
        UXTAH    R0,R6,R9
        MOVS     R5,R0
//  449             if( (pimg[temp>>3] & (1 << (7 - (temp & 0x07))) ) == 0  )
        LSRS     R0,R5,#+3
        LDRB     R0,[R0, R11]
        MOVS     R1,#+1
        ANDS     R2,R5,#0x7
        RSBS     R2,R2,#+7
        LSLS     R1,R1,R2
        TST      R0,R1
        BNE.N    ??LCD_Img_Binary_Z_4
//  450             {
//  451                 LCD_WR_DATA( BINARY_BGCOLOR );        //写图像数据
        MOVW     R0,#+65535
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
        B.N      ??LCD_Img_Binary_Z_5
//  452             }
//  453             else
//  454             {
//  455                 LCD_WR_DATA( BINARY_COLOR );      //写图像数据
??LCD_Img_Binary_Z_4:
        MOVS     R0,#+0
        MOVS     R1,#+1744830464
        STRH     R0,[R1, #+0]
//  456             }
//  457         }
??LCD_Img_Binary_Z_5:
        ADDS     R7,R7,#+1
        B.N      ??LCD_Img_Binary_Z_2
//  458     }
??LCD_Img_Binary_Z_3:
        ADDS     R8,R8,#+1
        B.N      ??LCD_Img_Binary_Z_0
//  459 }
??LCD_Img_Binary_Z_1:
        POP      {R0-R2,R4-R11,PC}  ;; return
//  460 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  461 void LCD_wave(Site_t site,Size_t size,uint8 *img,uint8 maxval,uint16 Color ,uint16 bkColor)
//  462 {
LCD_wave:
        PUSH     {R0,R1,R4-R9,LR}
        SUB      SP,SP,#+4
        MOV      R9,R2
        MOVS     R6,R3
        LDR      R4,[SP, #+40]
        LDR      R5,[SP, #+44]
//  463 
//  464     uint8 h;
//  465     uint16 y = site.y + size.H - 1;
        LDRH     R0,[SP, #+6]
        LDRH     R1,[SP, #+10]
        ADDS     R0,R1,R0
        SUBS     R8,R0,#+1
//  466 
//  467     LCD_rectangle(site, size,bkColor);
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[SP, #+8]
        LDR      R0,[SP, #+4]
        BL       LCD_rectangle
//  468     site.x += size.W;
        LDRH     R0,[SP, #+4]
        LDRH     R1,[SP, #+8]
        ADDS     R0,R1,R0
        STRH     R0,[SP, #+4]
//  469     img  += (size.W - 1);
        LDRH     R0,[SP, #+8]
        ADDS     R0,R0,R9
        SUBS     R9,R0,#+1
//  470     while(size.W --)
??LCD_wave_0:
        LDRH     R0,[SP, #+8]
        SUBS     R1,R0,#+1
        STRH     R1,[SP, #+8]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??LCD_wave_1
//  471     {
//  472         if(*img >= maxval )
        LDRB     R0,[R9, #+0]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R0,R6
        BCC.N    ??LCD_wave_2
//  473         {
//  474             h = size.H - 1;
        LDRH     R0,[SP, #+10]
        SUBS     R0,R0,#+1
        MOVS     R7,R0
        B.N      ??LCD_wave_3
//  475         }
//  476         else
//  477         {
//  478             h = ((*img )* size.H )/maxval;
??LCD_wave_2:
        LDRB     R0,[R9, #+0]
        LDRH     R1,[SP, #+10]
        MULS     R0,R1,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SDIV     R0,R0,R6
        MOVS     R7,R0
//  479         }
//  480         site.y = y - h ;
??LCD_wave_3:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        SUBS     R0,R8,R7
        STRH     R0,[SP, #+6]
//  481         site.x--;
        LDRH     R0,[SP, #+4]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+4]
//  482         img --;
        SUBS     R9,R9,#+1
//  483         LCD_point(site, Color);
        MOVS     R1,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR      R0,[SP, #+4]
        BL       LCD_point
        B.N      ??LCD_wave_0
//  484     }
//  485 }
??LCD_wave_1:
        POP      {R0-R2,R4-R9,PC}  ;; return
//  486 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  487 void LCD_wave_display(Site_t site,Size_t size,uint8 *img,uint8 maxval,uint16 Color)
//  488 {
LCD_wave_display:
        PUSH     {R0,R1,R4-R8,LR}
        MOVS     R5,R2
        MOVS     R6,R3
        LDR      R4,[SP, #+32]
//  489 
//  490     uint8 h;
//  491     uint16 y = site.y + size.H - 1;
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+6]
        ADDS     R0,R1,R0
        SUBS     R8,R0,#+1
//  492 
//  493     site.x += size.W;
        LDRH     R0,[SP, #+0]
        LDRH     R1,[SP, #+4]
        ADDS     R0,R1,R0
        STRH     R0,[SP, #+0]
//  494     img  += (size.W - 1);
        LDRH     R0,[SP, #+4]
        ADDS     R0,R0,R5
        SUBS     R5,R0,#+1
//  495     while(size.W --)
??LCD_wave_display_0:
        LDRH     R0,[SP, #+4]
        SUBS     R1,R0,#+1
        STRH     R1,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??LCD_wave_display_1
//  496     {
//  497         if(*img >= maxval )
        LDRB     R0,[R5, #+0]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R0,R6
        BCC.N    ??LCD_wave_display_2
//  498         {
//  499             h = size.H - 1;
        LDRH     R0,[SP, #+6]
        SUBS     R0,R0,#+1
        MOVS     R7,R0
        B.N      ??LCD_wave_display_3
//  500         }
//  501         else
//  502         {
//  503             h = ((*img )* size.H )/maxval;
??LCD_wave_display_2:
        LDRB     R0,[R5, #+0]
        LDRH     R1,[SP, #+6]
        MULS     R0,R1,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SDIV     R0,R0,R6
        MOVS     R7,R0
//  504         }
//  505         site.y = y - h ;
??LCD_wave_display_3:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        SUBS     R0,R8,R7
        STRH     R0,[SP, #+2]
//  506         site.x--;
        LDRH     R0,[SP, #+0]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+0]
//  507         img --;
        SUBS     R5,R5,#+1
//  508         LCD_point(site, Color);
        MOVS     R1,R4
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDR      R0,[SP, #+0]
        BL       LCD_point
        B.N      ??LCD_wave_display_0
//  509     }
//  510 }
??LCD_wave_display_1:
        POP      {R0,R1,R4-R8,PC}  ;; return

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
        DC16 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC16 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 44H, 3AH, 5CH, 53H, 74H, 75H, 64H, 79H
        DC8 5CH, 32H, 30H, 31H, 36H, 0B5H, 0E7H, 0D7H
        DC8 0D3H, 0C9H, 0E8H, 0BCH, 0C6H, 0B4H, 0F3H, 0C8H
        DC8 0FCH, 5CH, 54H, 69H, 5CH, 0B5H, 0E7H, 0C8H
        DC8 0FCH, 0B1H, 0B8H, 0D3H, 0C3H, 0B5H, 0D7H, 0B2H
        DC8 0E3H, 5CH, 42H, 6FH, 61H, 72H, 64H, 5CH
        DC8 73H, 72H, 63H, 5CH, 56H, 43H, 41H, 4EH
        DC8 5FH, 4CH, 43H, 44H, 2EH, 63H, 0
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC16 1, 1

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC16 8, 16

        END
// 
//    80 bytes in section .rodata
// 1 990 bytes in section .text
// 
// 1 990 bytes of CODE  memory
//    80 bytes of CONST memory
//
//Errors: none
//Warnings: none
