//
//  IndicatorNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "IndicatorNode.h"

@implementation IndicatorNode

+ (instancetype)createIndicatorNode{
    // 最多可以有10根刀
    
    // 先使用占位的占满
    CGFloat allW = TWScreenWidth * 0.6;
    // 每排放5个
    CGFloat oneW = allW * 0.2;
    // 计算高度
    CGFloat oneH = 70 * oneW / 50.0;
    // 一共2排
    CGFloat allH = 2 * oneH;
    IndicatorNode * indicatorNode = [[IndicatorNode alloc]initWithColor:[UIColor clearColor] size:CGSizeMake(allW, allH)];
    indicatorNode.position = CGPointMake(TWScreenWidth * 0.6, oneH);
    
//    [indicatorNode addChild:[self creactNode:CGPointMake(-oneW * 2, oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(-oneW, oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(0, oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(oneW, oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(oneW * 2, oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(-oneW * 2, -oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(-oneW, -oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(0, -oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(oneW, -oneH * 0.5)]];
//    [indicatorNode addChild:[self creactNode:CGPointMake(oneW * 2, -oneH * 0.5)]];
//    
    
    
    return indicatorNode;
}


- (SKSpriteNode *)creactNode:(CGPoint)position{
    CGFloat allW = TWScreenWidth * 0.6;
    CGFloat oneW = allW * 0.1;
    CGFloat oneH = 70 * oneW / 50.0;
    SKSpriteNode * one = [[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"]];
    one.size = CGSizeMake(oneW, oneH);
    one.position = position;
    return one;
}

// 初始化设置一共多少根
- (void)setIndicatorNode:(NSInteger)number{
    
}


// 重设已经使用了多少根
- (void)resetIndicatorNode:(NSInteger)number{
    
}





@end
