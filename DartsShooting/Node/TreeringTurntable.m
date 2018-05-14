//
//  TreeringTurntable.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//  树轮转盘

#import "TreeringTurntable.h"

@implementation TreeringTurntable

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        SKSpriteNode * bgNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"shop-sheet0"] size:size];
        bgNode.zPosition = Treebgzposition;
        [self addChild:bgNode];
        
        SKSpriteNode * boundNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"wood2-sheet0"] size:size];
        boundNode.zPosition = TreeBoundzposition;
        [self addChild:boundNode];
    }
    return self;
}



@end
