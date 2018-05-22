//
//  LockKnifeNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "LockKnifeNode.h"

@implementation LockKnifeNode

+ (instancetype)createKnifeNodeWith:(NSString *)knifeName position:(CGPoint)position name:(NSString *)name{
    LockKnifeNode * node = [LockKnifeNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:knifeName] size:CGSizeMake(BuyKnifeTextureWH, BuyKnifeTextureWH)];
    node.position = position;
    node.name = name;
    //加锁 44 × 58
    CGFloat w = TWScreenWidth * 0.8 * 0.2 * 0.25;
    CGFloat h = w * 58 / 44.0;
    SKSpriteNode * lockNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"padlock-sheet0"] size:CGSizeMake(w,h)];
    lockNode.position = CGPointMake(BuyKnifeTextureWH * 0.5 - w * 0.5, -(BuyKnifeTextureWH * 0.5 - w * 0.5));
    lockNode.name = LockNode;
    [node addChild:lockNode];
    return node;
}

- (void)unLockKnifeNodeWith:(NSString *)textureName{
    [self removeAllChildren];
    self.texture = [SKTexture textureWithImageNamed:textureName];
}

@end
