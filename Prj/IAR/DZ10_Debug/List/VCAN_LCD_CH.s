///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.40.3.8902/W32 for ARM       26/Jul/2016  23:31:09
// Copyright 1999-2015 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_CH.c
//    Command line =  
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_CH.c -D
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
//        D:\Study\2016电子设计大赛\Ti\电赛备用底层\Prj\IAR\DZ10_Debug\List\VCAN_LCD_CH.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ILI9341_get_h
        EXTERN ILI9341_get_w
        EXTERN LCD_ILI9341_ptlon
        EXTERN LCD_char
        EXTERN f_close
        EXTERN f_lseek
        EXTERN f_mount
        EXTERN f_open
        EXTERN f_read

        PUBLIC GetGBKCode_from_sd
        PUBLIC LCD_Char_CH
        PUBLIC LCD_FChar_CH
        PUBLIC LCD_FStr_CH
        PUBLIC LCD_Str_CH
        PUBLIC LCD_Str_ENCH
        PUBLIC mybr
        PUBLIC myfs
        PUBLIC myfsrc
        PUBLIC myres

// D:\Study\2016电子设计大赛\Ti\电赛备用底层\Board\src\VCAN_LCD_CH.c
//    1 #include "common.h"
//    2 
//    3 
//    4 #include "VCAN_lcd.h"
//    5 #include "ff.h"
//    6 
//    7 
//    8 
//    9 
//   10 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   11 FATFS myfs;                    // Work area (file system object) for logical drive
myfs:
        DS8 560

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12 FIL myfsrc;            // file objects
myfsrc:
        DS8 548

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   13 FRESULT myres;                 // FatFs function common result code
myres:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 uint32 mybr;               // File R/W count
mybr:
        DS8 4
//   15 
//   16 /*******************************************************************************
//   17 * Function Name  : GetGBKCode_from_sd
//   18 * Description    : 从SD卡字库中读取自摸数据到指定的缓冲区
//   19 * Input          : pBuffer---数据保存地址
//   20 *				   					c--汉字字符低字节码
//   21 * Output         : None
//   22 * Return         : 0(success)  -1(fail)
//   23 * Attention		 	 : None
//   24 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   25 int GetGBKCode_from_sd(unsigned char* pBuffer,const unsigned char * c)
//   26 {
GetGBKCode_from_sd:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   27     unsigned char High8bit,Low8bit;
//   28     unsigned int pos;
//   29     High8bit=*c;     /* 取高8位数据 */
        LDRB     R0,[R5, #+0]
        MOVS     R6,R0
//   30     Low8bit=*(c+1);  /* 取低8位数据 */
        LDRB     R0,[R5, #+1]
        MOVS     R7,R0
//   31 
//   32     pos = ((High8bit-0xb0)*94+Low8bit-0xa1)*LCD_CH_SIZE ;	
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        MOVS     R0,#+94
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MLA      R0,R0,R6,R7
        LDR.N    R1,??DataTable2  ;; 0xffffbebf
        ADDS     R0,R1,R0
        LSLS     R0,R0,#+5
        MOV      R8,R0
//   33     f_mount(0, &myfs);
        LDR.N    R1,??DataTable2_1
        MOVS     R0,#+0
        BL       f_mount
//   34     myres = f_open(&myfsrc , "0:/HZLIB.bin", FA_OPEN_EXISTING | FA_READ);
        MOVS     R2,#+1
        LDR.N    R1,??DataTable2_2
        LDR.N    R0,??DataTable2_3
        BL       f_open
        LDR.N    R1,??DataTable2_4
        STRB     R0,[R1, #+0]
//   35 
//   36     if ( myres == FR_OK )
        LDR.N    R0,??DataTable2_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??GetGBKCode_from_sd_0
//   37     {
//   38         f_lseek (&myfsrc, pos);														 //指针偏移
        MOV      R1,R8
        LDR.N    R0,??DataTable2_3
        BL       f_lseek
//   39         myres = f_read( &myfsrc, pBuffer, LCD_CH_SIZE, &mybr );		 //16*16大小的汉字 其字模 占用16*2个字节
        LDR.N    R3,??DataTable2_5
        MOVS     R2,#+32
        MOVS     R1,R4
        LDR.N    R0,??DataTable2_3
        BL       f_read
        LDR.N    R1,??DataTable2_4
        STRB     R0,[R1, #+0]
//   40 
//   41         f_close(&myfsrc);
        LDR.N    R0,??DataTable2_3
        BL       f_close
//   42 
//   43         return 0;
        MOVS     R0,#+0
        B.N      ??GetGBKCode_from_sd_1
//   44     }
//   45     else
//   46     {
//   47         return -1;
??GetGBKCode_from_sd_0:
        MOVS     R0,#-1
??GetGBKCode_from_sd_1:
        POP      {R4-R8,PC}       ;; return
//   48     }
//   49 }
//   50 
//   51 /********************************************************************
//   52  * 函数名：LCD_Char_CH
//   53  * 描述  ：显示单个汉字字符
//   54  * 输入  : 	x: 0~(319-16)
//   55  *         	y: 0~(239-16)
//   56  *			str: 中文字符串首址
//   57  *			Color: 字符颜色
//   58  *			bkColor: 背景颜色
//   59  * 输出  ：无
//   60  * 举例  ：	LCD_Char_CH(200,100,"好",0,0);
//   61  * 注意	 ：如果输入大于1的汉字字符串，显示将会截断，只显示最前面一个汉字
//   62 ************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   63 void LCD_Char_CH(Site_t site,const uint8 *str,uint16 Color,uint16 bkColor)
//   64 {
LCD_Char_CH:
        PUSH     {R0,R4-R11,LR}
        SUB      SP,SP,#+32
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//   65     uint8 i,j;
//   66     uint8 buffer[32];
//   67     uint8 *pbuf = buffer;
        ADD      R9,SP,#+0
//   68     uint8 tmp_char=0;
        MOVS     R10,#+0
//   69 
//   70     const Size_t size   = {LCD_CH_W,LCD_CH_H};
        LDR.N    R0,??DataTable2_6
        LDR      R11,[R0, #+0]
//   71 
//   72     GetGBKCode_from_sd(buffer,str);  /* 取字模数据 */
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       GetGBKCode_from_sd
//   73 
//   74     LCD_PTLON(site, size);              //开窗
        MOV      R1,R11
        LDR      R0,[SP, #+32]
        BL       LCD_ILI9341_ptlon
//   75     LCD_RAMWR();                        //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//   76 
//   77     for (i=0;i < LCD_CH_SIZE;i++)
        MOVS     R0,#+0
        MOVS     R7,R0
??LCD_Char_CH_0:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+32
        BGE.N    ??LCD_Char_CH_1
//   78     {
//   79         tmp_char = *pbuf++;
        LDRB     R0,[R9, #+0]
        MOV      R10,R0
        ADDS     R9,R9,#+1
//   80 
//   81         for(j=0;j<8;j++)
        MOVS     R0,#+0
        MOV      R8,R0
??LCD_Char_CH_2:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+8
        BGE.N    ??LCD_Char_CH_3
//   82         {
//   83             if(tmp_char & (0x80))
        LSLS     R0,R10,#+24
        BPL.N    ??LCD_Char_CH_4
//   84             {
//   85                 LCD_WR_DATA( Color );
        MOVS     R0,#+1744830464
        STRH     R5,[R0, #+0]
        B.N      ??LCD_Char_CH_5
//   86             }
//   87             else
//   88             {
//   89                 LCD_WR_DATA( bkColor );
??LCD_Char_CH_4:
        MOVS     R0,#+1744830464
        STRH     R6,[R0, #+0]
//   90             }
//   91             tmp_char <<= 1;
??LCD_Char_CH_5:
        LSLS     R10,R10,#+1
//   92         }
        ADDS     R8,R8,#+1
        B.N      ??LCD_Char_CH_2
//   93     }
??LCD_Char_CH_3:
        ADDS     R7,R7,#+1
        B.N      ??LCD_Char_CH_0
//   94 }
??LCD_Char_CH_1:
        ADD      SP,SP,#+36
        POP      {R4-R11,PC}      ;; return
//   95 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   96 void LCD_Str_CH(Site_t site,const uint8 *str  , uint16 Color ,uint16 bkColor) 		//显示16*16汉字字符串
//   97 {
LCD_Str_CH:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//   98     while(*str != '\0')
??LCD_Str_CH_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??LCD_Str_CH_1
//   99     {
//  100         if(site.x>(LCD_W-16))
        BL       ILI9341_get_w
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+4]
        CMP      R0,R1
        BGE.N    ??LCD_Str_CH_2
//  101             {	
//  102              /*换行*/
//  103             site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  104             site.y +=LCD_CH_H;
        LDRH     R0,[SP, #+6]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+6]
//  105         }
//  106         if(site.y >(LCD_H-LCD_CH_W))
??LCD_Str_CH_2:
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+6]
        CMP      R0,R1
        BGE.N    ??LCD_Str_CH_3
//  107         {
//  108              /*重新归零*/
//  109              site.y =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+6]
//  110              site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  111         }
//  112         LCD_Char_CH(site,str,Color,bkColor);
??LCD_Str_CH_3:
        MOVS     R3,R6
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R5
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R4
        LDR      R0,[SP, #+4]
        BL       LCD_Char_CH
//  113         str += 2 ;
        ADDS     R4,R4,#+2
//  114         site.x += LCD_CH_W ;	
        LDRH     R0,[SP, #+4]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+4]
        B.N      ??LCD_Str_CH_0
//  115     }
//  116 }
??LCD_Str_CH_1:
        POP      {R0,R1,R4-R6,PC}  ;; return
//  117 
//  118 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 void LCD_Str_ENCH(Site_t site,const uint8 *str  , uint16 Color ,uint16 bkColor) 		//显示16*16汉字字符串
//  120 {
LCD_Str_ENCH:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+4
        MOVS     R6,R1
        MOVS     R4,R2
        MOVS     R5,R3
//  121     while(*str != '\0')
??LCD_Str_ENCH_0:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BEQ.N    ??LCD_Str_ENCH_1
//  122     {
//  123         if( *str < 0x80)       //英文
        LDRB     R0,[R6, #+0]
        CMP      R0,#+128
        BGE.N    ??LCD_Str_ENCH_2
//  124         {
//  125             if(site.x>(LCD_W-LCD_EN_W))
        BL       ILI9341_get_w
        SUBS     R0,R0,#+8
        LDRH     R1,[SP, #+4]
        CMP      R0,R1
        BGE.N    ??LCD_Str_ENCH_3
//  126             {	
//  127                  /*换行*/
//  128                 site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  129                 site.y +=LCD_EN_H;
        LDRH     R0,[SP, #+6]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+6]
//  130             }
//  131             if(site.y >(LCD_H-LCD_EN_H))
??LCD_Str_ENCH_3:
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+6]
        CMP      R0,R1
        BGE.N    ??LCD_Str_ENCH_4
//  132             {
//  133                  /*重新归零*/
//  134                  site.y =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+6]
//  135                  site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  136             }
//  137             LCD_char(site,*str,Color,bkColor);
??LCD_Str_ENCH_4:
        MOVS     R3,R5
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRB     R1,[R6, #+0]
        LDR      R0,[SP, #+4]
        BL       LCD_char
//  138             str += 1 ;
        ADDS     R6,R6,#+1
//  139             site.x += LCD_EN_W ;	
        LDRH     R0,[SP, #+4]
        ADDS     R0,R0,#+8
        STRH     R0,[SP, #+4]
        B.N      ??LCD_Str_ENCH_0
//  140         }
//  141         else
//  142         {
//  143             if(site.x>(LCD_W-LCD_CH_W))
??LCD_Str_ENCH_2:
        BL       ILI9341_get_w
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+4]
        CMP      R0,R1
        BGE.N    ??LCD_Str_ENCH_5
//  144             {	
//  145                  /*换行*/
//  146                 site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  147                 site.y +=LCD_CH_H;
        LDRH     R0,[SP, #+6]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+6]
//  148             }
//  149             if(site.y >(LCD_H-LCD_CH_H))
??LCD_Str_ENCH_5:
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+6]
        CMP      R0,R1
        BGE.N    ??LCD_Str_ENCH_6
//  150             {
//  151                  /*重新归零*/
//  152                  site.y =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+6]
//  153                  site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+4]
//  154             }
//  155             LCD_Char_CH(site,str,Color,bkColor);
??LCD_Str_ENCH_6:
        MOVS     R3,R5
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R6
        LDR      R0,[SP, #+4]
        BL       LCD_Char_CH
//  156             str += 2 ;
        ADDS     R6,R6,#+2
//  157             site.x += LCD_CH_W ;	
        LDRH     R0,[SP, #+4]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+4]
        B.N      ??LCD_Str_ENCH_0
//  158         }
//  159     }
//  160 }
??LCD_Str_ENCH_1:
        POP      {R0,R1,R4-R6,PC}  ;; return
//  161 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void LCD_FChar_CH (Site_t site,const uint8 *str,uint16 Color,uint16 bkColor)
//  163 {
LCD_FChar_CH:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  164     uint8 i,j;
//  165     //uint8 *pbuf = str;
//  166     uint8 tmp_char=0;
        MOVS     R10,#+0
//  167 
//  168     const Size_t size   = {LCD_CH_W,LCD_CH_H};
        LDR.N    R0,??DataTable2_7
        LDR      R11,[R0, #+0]
//  169 
//  170     LCD_PTLON(site, size);              //开窗
        MOV      R1,R11
        MOVS     R0,R4
        BL       LCD_ILI9341_ptlon
//  171     LCD_RAMWR();                        //写内存
        MOVS     R0,#+44
        MOVS     R1,#+1610612736
        STRH     R0,[R1, #+0]
//  172 
//  173     for (i=0;i < LCD_CH_SIZE;i++)
        MOVS     R0,#+0
        MOV      R8,R0
??LCD_FChar_CH_0:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+32
        BGE.N    ??LCD_FChar_CH_1
//  174     {
//  175         tmp_char = *str++;
        LDRB     R0,[R5, #+0]
        MOV      R10,R0
        ADDS     R5,R5,#+1
//  176 
//  177         for(j=0;j<8;j++)
        MOVS     R0,#+0
        MOV      R9,R0
??LCD_FChar_CH_2:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+8
        BGE.N    ??LCD_FChar_CH_3
//  178         {
//  179             if(tmp_char & (0x80))
        LSLS     R0,R10,#+24
        BPL.N    ??LCD_FChar_CH_4
//  180             {
//  181                 LCD_WR_DATA( Color );
        MOVS     R0,#+1744830464
        STRH     R6,[R0, #+0]
        B.N      ??LCD_FChar_CH_5
//  182             }
//  183             else
//  184             {
//  185                 LCD_WR_DATA( bkColor );
??LCD_FChar_CH_4:
        MOVS     R0,#+1744830464
        STRH     R7,[R0, #+0]
//  186             }
//  187             tmp_char <<= 1;
??LCD_FChar_CH_5:
        LSLS     R10,R10,#+1
//  188         }
        ADDS     R9,R9,#+1
        B.N      ??LCD_FChar_CH_2
//  189     }
??LCD_FChar_CH_3:
        ADDS     R8,R8,#+1
        B.N      ??LCD_FChar_CH_0
//  190 }
??LCD_FChar_CH_1:
        POP      {R0,R4-R11,PC}   ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0xffffbebf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     myfs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     myfsrc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     myres

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     mybr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ?_2
//  191 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  192 void LCD_FStr_CH (Site_t site,const uint8 *str,uint16 num,uint16 Color,uint16 bkColor)
//  193 {
LCD_FStr_CH:
        PUSH     {R0,R4-R7,LR}
        MOVS     R5,R1
        MOVS     R7,R2
        MOVS     R6,R3
        LDR      R4,[SP, #+24]
//  194     while(num--)
??LCD_FStr_CH_0:
        MOVS     R0,R7
        SUBS     R7,R0,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??LCD_FStr_CH_1
//  195     {
//  196         if(site.x>(LCD_W-16))
        BL       ILI9341_get_w
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BGE.N    ??LCD_FStr_CH_2
//  197         {
//  198              /*换行*/
//  199             site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  200             site.y +=LCD_CH_H;
        LDRH     R0,[SP, #+2]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+2]
//  201         }
//  202         if(site.y >(LCD_H-LCD_CH_W))
??LCD_FStr_CH_2:
        BL       ILI9341_get_h
        SUBS     R0,R0,#+16
        LDRH     R1,[SP, #+2]
        CMP      R0,R1
        BGE.N    ??LCD_FStr_CH_3
//  203         {
//  204              /*重新归零*/
//  205              site.y =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+2]
//  206              site.x =0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  207         }
//  208         LCD_FChar_CH(site,str,Color,bkColor);
??LCD_FStr_CH_3:
        MOVS     R3,R4
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        MOVS     R1,R5
        LDR      R0,[SP, #+0]
        BL       LCD_FChar_CH
//  209         str += LCD_CH_SIZE ;
        ADDS     R5,R5,#+32
//  210         site.x += LCD_CH_W ;
        LDRH     R0,[SP, #+0]
        ADDS     R0,R0,#+16
        STRH     R0,[SP, #+0]
        B.N      ??LCD_FStr_CH_0
//  211     }
//  212 }
??LCD_FStr_CH_1:
        POP      {R0,R4-R7,PC}    ;; return

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
        DC8 "0:/HZLIB.bin"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC16 16, 16

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC16 16, 16

        END
//  213 
// 
// 1 113 bytes in section .bss
//    24 bytes in section .rodata
//   782 bytes in section .text
// 
//   782 bytes of CODE  memory
//    24 bytes of CONST memory
// 1 113 bytes of DATA  memory
//
//Errors: none
//Warnings: none
