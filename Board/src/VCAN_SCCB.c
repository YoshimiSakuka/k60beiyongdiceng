/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,ɽ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�ɽ����̳ http://www.vcan123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����ɽ��Ƽ����У�δ����������������ҵ��;��
 *     �޸�����ʱ���뱣��ɽ��Ƽ��İ�Ȩ������
 *
 * @file       VCAN_SCCB.c
 * @brief      OV����ͷ��������SCCB������
 * @author     ɽ��Ƽ�
 * @version    v5.0
 * @date       2013-09-01
 */


#include "common.h"
#include "MK60_gpio.h"
#include "VCAN_SCCB.h"

static void SCCB_delay(uint16 i);

/*!
 *  @brief      SCCB�ӳٺ���
 *  @param      time    ��ʱʱ��
 *  @since      v5.0
 */
static void SCCB_delay(volatile uint16 time)
{
    while(time)
    {
        time--;
    }
}

/*!
 *  @brief      SCCB�ܽ�����
 *  @since      v5.0
 */
void SCCB_GPIO_init(void)
{
    gpio_init  (SCCB_SCL, GPO, 1); //��ʼ��SCL
    gpio_init  (SCCB_SDA, GPO, 1); //��ʼ��SDA

    port_init_NoALT(SCCB_SCL,ODO | PULLUP);
    port_init_NoALT(SCCB_SDA,ODO | PULLUP);
}

/*!
 *  @brief      SCCB��ʼ�ź�
 *  @since      v5.0
 */
static uint8 SCCB_Start(void)
{
    SCCB_SDA_H();
    SCCB_SCL_H();
    SCCB_DELAY();

    SCCB_SDA_DDR_IN();
    if(!SCCB_SDA_IN())
    {
        SCCB_SDA_DDR_OUT();
        return 0;   /* SDA��Ϊ�͵�ƽ������æ,�˳� */
    }
    SCCB_SDA_DDR_OUT();
    SCCB_SDA_L();

    SCCB_DELAY();
    SCCB_SCL_L();

    if(SCCB_SDA_IN())
    {
        SCCB_SDA_DDR_OUT();
        return 0;   /* SDA��Ϊ�ߵ�ƽ�����߳���,�˳� */
    }
    //SCCB_SDA_DDR_OUT();
    //SCCB_SDA_L();
    //SCCB_delay();
    return 1;
}

/*!
 *  @brief      SCCBֹͣ�ź�
 *  @since      v5.0
 */
static void SCCB_Stop(void)
{
    SCCB_SCL_L();
    //SCCB_DELAY();
    
    SCCB_SDA_L();
    SCCB_DELAY();
    
    SCCB_SCL_H();
    SCCB_DELAY();
    
    SCCB_SDA_H();
    SCCB_DELAY();
}

/*!
 *  @brief      SCCBӦ���ź�
 *  @since      v5.0
 */
static void SCCB_Ack(void)
{
    SCCB_SCL_L();
    SCCB_DELAY();
    
    SCCB_SDA_L();
    SCCB_DELAY();
    
    SCCB_SCL_H();
    SCCB_DELAY();
    
    SCCB_SCL_L();
    SCCB_DELAY();
}

/*!
 *  @brief      SCCB��Ӧ���ź�
 *  @since      v5.0
 */
static void SCCB_NoAck(void)
{
    SCCB_SCL_L();
    SCCB_DELAY();
    
    SCCB_SDA_H();
    SCCB_DELAY();
    
    SCCB_SCL_H();
    SCCB_DELAY();
    
    SCCB_SCL_L();
    SCCB_DELAY();
}

/*!
 *  @brief      SCCB �ȴ�Ӧ��
 *  @return     Ӧ������0��ʾ��Ӧ��1��ʾ��Ӧ��
 *  @since      v5.0
 */
static int SCCB_WaitAck(void)
{
    SCCB_SCL_L();
    //SCCB_SDA_H();
    SCCB_SDA_DDR_IN();

    SCCB_DELAY();
    SCCB_SCL_H();

    SCCB_DELAY();

    if(SCCB_SDA_IN())           //Ӧ��Ϊ�ߵ�ƽ���쳣��ͨ��ʧ��
    {
        SCCB_SDA_DDR_OUT();
        SCCB_SCL_L();
        return 0;
    }
    SCCB_SDA_DDR_OUT();
    SCCB_SCL_L();
    return 1;
}

/*!
 *  @brief      SCCB ���͵�����
 *  @param      SendByte    ��Ҫ���͵�����
 *  @since      v5.0
 */
static void SCCB_SendByte(uint8 SendByte)
{
    uint8 i = 8;
    while(i--)
    {

        if(SendByte & 0x80)     //SDA �������
        {
            SCCB_SDA_H();
        }
        else
        {
            SCCB_SDA_L();
        }
        SendByte <<= 1;
        SCCB_DELAY();
        
        SCCB_SCL_H();                //SCL ���ߣ��ɼ��ź�
        SCCB_DELAY();
        
        SCCB_SCL_L();                //SCL ʱ��������
        //SCCB_DELAY();
    }
    //SCCB_SCL_L();
}

/*!
 *  @brief      ����SCCB���ߵ�����
 *  @return     ���յ�������
 *  @since      v5.0
 */
static int SCCB_ReceiveByte(void)
{
    uint8 i = 8;
    uint8 ReceiveByte = 0;

    //SCCB_SDA_H();
    //SCCB_DELAY();
    SCCB_SDA_DDR_IN();

    while(i--)
    {
        ReceiveByte <<= 1;
        SCCB_SCL_L();
        SCCB_DELAY();
        
        SCCB_SCL_H();
        SCCB_DELAY();

        if(SCCB_SDA_IN())
        {
            ReceiveByte |= 0x01;
        }


    }
    SCCB_SDA_DDR_OUT();
    SCCB_SCL_L();
    return ReceiveByte;
}

/*****************************************************************************************
* ��������SCCB_WriteByte
* ����  ��дһ�ֽ�����
* ����  ��- WriteAddress: ��д���ַ    - SendByte: ��д������  - DeviceAddress: ��������
* ���  ������Ϊ:=1�ɹ�д��,=0ʧ��
* ע��  ����
*****************************************************************************************/
static int SCCB_WriteByte_one( uint16 WriteAddress , uint8 SendByte );


int SCCB_WriteByte( uint16 WriteAddress , uint8 SendByte )            //���ǵ���sccb�Ĺܽ�ģ�⣬�Ƚ�����ʧ�ܣ���˶��Լ���
{
    uint8 i = 0;
    while( 0 == SCCB_WriteByte_one ( WriteAddress, SendByte ) )
    {
        i++;
        if(i == 20)
        {
            return 0 ;
        }
    }
    return 1;
}

int SCCB_WriteByte_one( uint16 WriteAddress , uint8 SendByte )
{
    if(!SCCB_Start())
    {
        return 0;
    }
    SCCB_SendByte( DEV_ADR );                    /* ������ַ */
    if( !SCCB_WaitAck() )
    {
        SCCB_Stop();
        return 0;
    }
    SCCB_SendByte((uint8)(WriteAddress & 0x00FF));   /* ���õ���ʼ��ַ */
    SCCB_WaitAck();
    SCCB_SendByte(SendByte);
    SCCB_WaitAck();
    SCCB_Stop();
    return 1;
}




/******************************************************************************************************************
 * ��������SCCB_ReadByte
 * ����  ����ȡһ������
 * ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
 * ���  ������Ϊ:=1�ɹ�����,=0ʧ��
 * ע��  ����
 **********************************************************************************************************************/
static int SCCB_ReadByte_one(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress);

int SCCB_ReadByte(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress)
{
    uint8 i = 0;
    while( 0 == SCCB_ReadByte_one(pBuffer, length, ReadAddress) )
    {
        i++;
        if(i == 30)
        {
            return 0 ;
        }
    }
    return 1;
}

int SCCB_ReadByte_one(uint8 *pBuffer,   uint16 length,   uint8 ReadAddress)
{
    if(!SCCB_Start())
    {
        return 0;
    }
    SCCB_SendByte( DEV_ADR );         /* ������ַ */
    if( !SCCB_WaitAck() )
    {
        SCCB_Stop();
        return 0;
    }
    SCCB_SendByte( ReadAddress );           /* ���õ���ʼ��ַ */
    SCCB_WaitAck();
    SCCB_Stop();

    if(!SCCB_Start())
    {
        return 0;
    }
    SCCB_SendByte( DEV_ADR + 1 );               /* ������ַ */

    if(!SCCB_WaitAck())
    {
        SCCB_Stop();
        return 0;
    }
    while(length)
    {
        *pBuffer = SCCB_ReceiveByte();
        if(length == 1)
        {
            SCCB_NoAck();
        }
        else
        {
            SCCB_Ack();
        }
        pBuffer++;
        length--;
    }
    SCCB_Stop();
    return 1;
}




