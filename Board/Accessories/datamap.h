#ifndef __DATAMAP_H
#define __DATAMAP_H

extern struct datamap Config;

struct datamap
{
	int16_t is_good;   //数据是否有效
	int16_t dGx_offset;
	int16_t dGy_offset;
	int16_t dGz_offset;
	
	int16_t dMx_offset;
	int16_t dMy_offset;
	int16_t dMz_offset; // 7*2 Bytes
};

void Write_config(void);
void load_config(void);
#endif