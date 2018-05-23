//
//  Header.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#ifndef Header_h
#define Header_h

// MARK:- 屏幕高宽
#define TWScreenWidth [UIScreen mainScreen].bounds.size.width
#define TWScreenHeight [UIScreen mainScreen].bounds.size.height

// 按375来计算比例
#define TWSizeRatio           (TWScreenWidth / 375.0)
#define TW_SizeRatio(a)       ((a) * TWSizeRatio)

#define BrokenTime 1.0

// 指示器
#define IndicatorNodeAllW TWScreenWidth * 0.6
// 每排放5个 每一个的宽度
#define IndicatorNodeOneW IndicatorNodeAllW * 0.2
// 每一个的高度
#define IndicatorNodeOneH 70 * IndicatorNodeOneW / 50.0
// 总高度
#define IndicatorNodeAllH 2 * IndicatorNodeOneH

// 游戏币
#define appleW TW_SizeRatio(30)
#define appleH appleW * 86 / 65.0

#define BuyKnifeTextureWH TWScreenWidth * 0.8 * 0.2 * 0.95

// MARK:- 颜色
#define TWRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]
#define TWColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define TWColorRGB(r,g,b) TWColorRGBA(r,g,b,1.0)
#define GAMEBGCOLOR TWColorRGB(45, 95, 122)

// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
// 弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#endif /* Header_h */
