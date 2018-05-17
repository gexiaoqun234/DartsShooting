//
//  TreeringTurntable.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//  树轮转盘

#import "TreeringTurntable.h"

@interface TreeringTurntable()
//@property (nonatomic, strong) SKSpriteNode * anchorPointNode;
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
        
        // 参照点
//        _anchorPointNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(10, 10)];
//        _anchorPointNode.position = CGPointMake(0, -size.height * 0.5);
//        _anchorPointNode.zPosition = Referenceszposition;
//        [self addChild:_anchorPointNode];
        
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:self.actionArray]]];
    }
    return self;
}

- (NSMutableArray<SKAction *> *)actionArray{
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 3 duration:5.0]];
        //        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 1.5 duration:5.0]];
        //        [_actionArray addObject:[SKAction rotateByAngle:M_PI * 0.3 duration:2.0]];
        //        [_actionArray addObject:[SKAction rotateByAngle:-M_PI * 0.3 duration:2.0]];
    }
    return _actionArray;
}

@end
