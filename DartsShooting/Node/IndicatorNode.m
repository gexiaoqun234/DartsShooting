//
//  IndicatorNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "IndicatorNode.h"

@interface IndicatorNode()
@property (nonatomic, strong) SKSpriteNode * knife1;
@property (nonatomic, strong) SKSpriteNode * knife2;
@property (nonatomic, strong) SKSpriteNode * knife3;
@property (nonatomic, strong) SKSpriteNode * knife4;
@property (nonatomic, strong) SKSpriteNode * knife5;
@property (nonatomic, strong) SKSpriteNode * knife6;
@property (nonatomic, strong) SKSpriteNode * knife7;
@property (nonatomic, strong) SKSpriteNode * knife8;
@property (nonatomic, strong) SKSpriteNode * knife9;
@property (nonatomic, strong) SKSpriteNode * knife10;
@property (nonatomic, strong) NSMutableArray <SKSpriteNode *>* knifeArray;
@end

@implementation IndicatorNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        [self.knifeArray addObject:self.knife1];
        [self.knifeArray addObject:self.knife2];
        [self.knifeArray addObject:self.knife3];
        [self.knifeArray addObject:self.knife4];
        [self.knifeArray addObject:self.knife5];
        [self.knifeArray addObject:self.knife6];
        [self.knifeArray addObject:self.knife7];
        [self.knifeArray addObject:self.knife8];
        [self.knifeArray addObject:self.knife9];
        [self.knifeArray addObject:self.knife10];
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

- (SKSpriteNode *)knife1{
    if (_knife1 == nil) {
        _knife1 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife1.position = CGPointMake(-IndicatorNodeOneW * 2, IndicatorNodeOneH * 0.5);
    }
    return _knife1;
}

- (SKSpriteNode *)knife2{
    if (_knife2 == nil) {
        _knife2 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife2.position = CGPointMake(-IndicatorNodeOneW, IndicatorNodeOneH * 0.5);
    }
    return _knife2;
}

- (SKSpriteNode *)knife3{
    if (_knife3 == nil) {
        _knife3 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife3.position = CGPointMake(0, IndicatorNodeOneH * 0.5);
    }
    return _knife3;
}

- (SKSpriteNode *)knife4{
    if (_knife4 == nil) {
        _knife4 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife4.position = CGPointMake(IndicatorNodeOneW, IndicatorNodeOneH * 0.5);
    }
    return _knife4;
}

- (SKSpriteNode *)knife5{
    if (_knife5 == nil) {
        _knife5 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife5.position = CGPointMake(IndicatorNodeOneW * 2, IndicatorNodeOneH * 0.5);
    }
    return _knife5;
}

- (SKSpriteNode *)knife6{
    if (_knife6 == nil) {
        _knife6 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife6.position = CGPointMake(-IndicatorNodeOneW * 2, -IndicatorNodeOneH * 0.5);
    }
    return _knife6;
}

- (SKSpriteNode *)knife7{
    if (_knife7 == nil) {
        _knife7 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife7.position = CGPointMake(-IndicatorNodeOneW, -IndicatorNodeOneH * 0.5);
    }
    return _knife7;
}

- (SKSpriteNode *)knife8{
    if (_knife8 == nil) {
        _knife8 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife8.position = CGPointMake(0, -IndicatorNodeOneH * 0.5);
    }
    return _knife8;
}

- (SKSpriteNode *)knife9{
    if (_knife9 == nil) {
        _knife9 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife9.position = CGPointMake(IndicatorNodeOneW, -IndicatorNodeOneH * 0.5);
    }
    return _knife9;
}

- (SKSpriteNode *)knife10{
    if (_knife10 == nil) {
        _knife10 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"] size:CGSizeMake(IndicatorNodeOneW, IndicatorNodeOneH)];
        _knife10.position = CGPointMake(IndicatorNodeOneW * 2, -IndicatorNodeOneH * 0.5);
    }
    return _knife10;
}

@end
