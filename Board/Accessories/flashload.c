#include  "include.h"
#include  "datamap.h"

#define         PAGE_Config             FLASH_SECTOR_NUM-1

struct datamap Config;

void load_config(void){
	int16_t i;
	int16_t *ptr = &Config.is_good;

	for(i=0 ; i< 8;i++)
        {
          *ptr = flash_read(PAGE_Config, i*8, uint16);
          ptr++;
	}
	if(Config.is_good != (int16_t)0xA55A){ //Data invalid, load default configuartion
		Config.is_good = 0xA55A;
		Config.dGx_offset = 0;
		Config.dGy_offset = 0;
		Config.dGz_offset = 0;
	
		Config.dMx_offset = 0;
		Config.dMy_offset = 0;
		Config.dMz_offset = 0;
	
		Write_config();	 //Write default configuration
	}
}

//Write current configuration
void Write_config(void){
	int16_t i;
	int16_t *ptr = &Config.is_good;
 	flash_erase_sector(PAGE_Config); //Erase pages
        DELAY_MS(50);
	for(i=0;i<8;i++){
                flash_write(PAGE_Config, i*8, (uint32_t)*ptr);
                DELAY_MS(50);
	}
}