#include "LDC1314.h"


void LDC1314_Init(void)
{
    i2c_init(I2C0,400*1000);
    i2c_write_reg(I2C0, LDC_ADDR, ERROR_CONFIG,2);
    i2c_write_reg(I2C0, LDC_ADDR, CONFIG,000(0��1,Rp���ؿ�����ر�)0(0�������У��)1011000000;
    i2c_write_reg(I2C0, LDC_ADDR, MUX_CONFIG, 0xC20F);//���3λ��001��1��  100��3.3��  101��10��  111��33
    i2c_write_reg(I2C0, LDC_ADDR, RESET_DEV,10000(00��11)000000000);
    i2c_write_reg(I2C0, LDC_ADDR, MANUFACTURER_ID,0x5449);
    i2c_write_reg(I2C0, LDC_ADDR, DEVICE_ID,0x3054);
    
    i2c_write_reg(I2C0, LDC_ADDR, DRIVE_CURRENT_CH0,2);
    i2c_write_reg(I2C0, LDC_ADDR, DRIVE_CURRENT_CH1,2);
    i2c_write_reg(I2C0, LDC_ADDR, DRIVE_CURRENT_CH1,2);
    i2c_write_reg(I2C0, LDC_ADDR, DRIVE_CURRENT_CH1,2);
    
}