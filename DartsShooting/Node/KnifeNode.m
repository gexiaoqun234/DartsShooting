//
//  KnifeNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "KnifeNode.h"

@implementation KnifeNode

- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithTexture:texture color:color size:size]) {
        [self run];
        // 物理属性
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(size.width * 0.8, size.height * 0.5)];
        self.physicsBody.categoryBitMask = KnifeCategory;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = TreeringTurntableCategory | KnifeCategory | AppleCategory;
        self.physicsBody.collisionBitMask = TreeringTurntableCategory;
    }
    return self;
}

- (void)run{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:TW_SizeRatio(5) duration:0.5],[SKAction moveByX:0 y:-TW_SizeRatio(5) duration:0.5]]]]];
}
- (void)stop{
    [self removeAllActions];
}

@end
