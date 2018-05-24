//
//  IndicatorNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "IndicatorNode.h"

@interface IndicatorNode()
@property (nonatomic, strong) NSMutableArray <SKSpriteNode *>* knifeArray;
@end

@implementation IndicatorNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        // 第一排左边5根
        for (NSInteger i = 1; i <= 5; i++) {
            SKSpriteNode * indicatorKnifeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
            indicatorKnifeNode.position = CGPointMake(-IndicatorNodeOneW * (5.5 - i), IndicatorNodeOneH * 0.5);
            [self.knifeArray addObject:indicatorKnifeNode];
        }
        // 第一排右边5根
        for (NSInteger i = 1; i <= 5; i++) {
            SKSpriteNode * indicatorKnifeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
            indicatorKnifeNode.position = CGPointMake(IndicatorNodeOneW * (i - 0.5), IndicatorNodeOneH * 0.5);
            [self.knifeArray addObject:indicatorKnifeNode];
        }
        // 第二排左边5根
        for (NSInteger i = 1; i <= 5; i++) {
            SKSpriteNode * indicatorKnifeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
            indicatorKnifeNode.position = CGPointMake(-IndicatorNodeOneW * (5.5 - i), -IndicatorNodeOneH * 0.5);
            [self.knifeArray addObject:indicatorKnifeNode];
        }
        // 第二排右边5根
        for (NSInteger i = 1; i <= 5; i++) {
            SKSpriteNode * indicatorKnifeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
            indicatorKnifeNode.position = CGPointMake(IndicatorNodeOneW * (i - 0.5), -IndicatorNodeOneH * 0.5);
            [self.knifeArray addObject:indicatorKnifeNode];
        }
        for (SKSpriteNode * knife in self.knifeArray) {
            [self addChild:knife];
        }
    }
    return self;
}

// 初始化设置一共多少根
- (void)setIndicatorNode:(NSInteger)number{
    for (NSInteger i = 0; i < self.knifeArray.count; i++) {
        if (i < number) {
            self.knifeArray[i].texture = [SKTexture textureWithImageNamed:@"yellowKnife"];
        } else {
            self.knifeArray[i].texture = [SKTexture textureWithImageNamed:@"whiteKnife"];
        }
    }
}

// 减去一根
- (void)minusARoot{
    
}

// 重设已经使用了多少根
- (void)resetIndicatorNodeAllCount:(NSInteger)allNumber userCount:(NSInteger)userNumber{
    NSMutableArray <SKSpriteNode *>* array = [NSMutableArray arrayWithCapacity:10];
    // 遍历全部的根数
    for (NSInteger i = 0; i < allNumber; i++) {
        // 这些都是黄色的
        [array addObject:self.knifeArray[i]];
    }
    for (NSInteger i = 1; i <= userNumber; i++) {
        array[allNumber - i].texture = [SKTexture textureWithImageNamed:@"whiteKnife"];
    }
}

#pragma mark - --------懒加载--------
- (NSMutableArray <SKSpriteNode *>*)knifeArray{
    if (_knifeArray == nil) {
        _knifeArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _knifeArray;
}

@end
