//
//  TreeringTurntable.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//  树轮转盘

#import "TreeringTurntable.h"
#import "AppleNode.h"

@interface TreeringTurntable()
@property (nonatomic, strong) NSMutableArray <SKAction *>* actionArray;
@end

@implementation TreeringTurntable

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        self.color = [SKColor clearColor];
        
        // 树轮的背景
        SKSpriteNode * bgNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"shop-sheet0"] size:size];
        bgNode.zPosition = Treebgzposition;
        [self addChild:bgNode];
        
        // 树轮的前景
        SKSpriteNode * boundNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"wood2-sheet0"] size:size];
        boundNode.zPosition = TreeBoundzposition;
        [self addChild:boundNode];
        
        // 物理属性
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:TWScreenWidth * 0.5 * 0.5 * 0.75];
        self.physicsBody.categoryBitMask = TreeringTurntableCategory;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = KnifeCategory;
        self.physicsBody.collisionBitMask = KnifeCategory;
    }
    return self;
}

- (void)addApple:(NSArray *)appleCoordinate{
    CGFloat appleW_small = TW_SizeRatio(25);
    for (NSInteger i = 0; i < appleCoordinate.count; i++) {
        NSDictionary * dic = appleCoordinate[i];
        AppleNode * apple = [[AppleNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"apple-sheet0"] color:[UIColor whiteColor] size:CGSizeMake(appleW_small, appleW_small * 69 / 52.0)];
        apple.position = CGPointMake([dic[CoordinatesX] floatValue], [dic[CoordinatesY] floatValue]);
        apple.zRotation = [dic[CoordinatesZRotation] floatValue];
        [self addChild:apple];
    }
}

- (void)run{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:self.actionArray]]];
}

- (void)stop{
    [self removeAllActions];
}

- (NSMutableArray<SKAction *> *)actionArray{
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 1.13 duration:2.9]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.15 duration:0.3]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 0.8 duration:1.0]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.3 duration:3.0]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 1.3 duration:4.5]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 1.8 duration:5.0]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 0.4 duration:1.5]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 1.3 duration:2.5]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 1.3 duration:5]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.5 duration:3.0]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 0.6 duration:1.0]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.8 duration:4.0]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 3 duration:10.0]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 1.5 duration:5.0]];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 0.3 duration:2.0]];
        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.3 duration:2.0]];
    }
    return _actionArray;
}

@end
