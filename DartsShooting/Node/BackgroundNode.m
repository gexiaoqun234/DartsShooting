//
//  BackgroundNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/17.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "BackgroundNode.h"

@implementation BackgroundNode

+ (instancetype)initializeBackgroundNode{
    BackgroundNode * bgNode = [[BackgroundNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"lines-sheet0"]];
    bgNode.size = CGSizeMake(TWScreenWidth * 2, TWScreenHeight + 80);
    bgNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
    bgNode.zPosition = BGzposition;
    NSArray * action = @[[SKAction moveToY:TWScreenHeight * 0.5 + 40 duration:2.5],
                          [SKAction moveToY:TWScreenHeight * 0.5 - 40 duration:2.5]];
    [bgNode runAction:[SKAction repeatActionForever:[SKAction sequence:action]]];
    return bgNode;
}

@end
