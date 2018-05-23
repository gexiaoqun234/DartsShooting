
//
//  AppleNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/23.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "AppleNode.h"

@implementation AppleNode

- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithTexture:texture color:color size:size]) {
        self.zPosition = TreeBoundzposition;
        
        // 物理属性
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(size.width, size.height)];
        self.physicsBody.categoryBitMask = AppleCategory;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.contactTestBitMask = KnifeCategory;
        self.physicsBody.collisionBitMask = KnifeCategory;
    }
    return self;
}

@end
