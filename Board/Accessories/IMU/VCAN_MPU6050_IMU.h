#ifndef __IMU_H
#define __IMU_H

#include "common.h"  //包含所有的驱动 头文件

#include <math.h>
#define M_PI  (float)3.1415926535

//IMU AHRS 解算的API
void IMU_init(void); //初始化
void IMU_getYawPitchRoll(float * ypr); //更新姿态

#endif

//------------------End of File----------------------------
