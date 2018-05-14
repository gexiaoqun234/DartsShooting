//
//  TurntableNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "TurntableNode.h"



@implementation TurntableNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        self.color = [SKColor clearColor];
        SKShapeNode * roundNode = [[SKShapeNode alloc]init];
        roundNode.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)].CGPath;
        roundNode.fillColor = color;
        roundNode.strokeColor = [SKColor redColor];
        roundNode.antialiased = YES;
        roundNode.lineWidth = 1;
        roundNode.position = CGPointMake(-size.width * 0.5, -size.height * 0.5);
        roundNode.zPosition = 100;
        [self addChild:roundNode];
        
        SKShapeNode * lineNode = [[SKShapeNode alloc]init];
        lineNode.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 10, 10)].CGPath;
        lineNode.fillColor = [SKColor redColor];
        lineNode.strokeColor = color;
        lineNode.lineWidth = 1;
        lineNode.position = CGPointMake(size.width * 0.5 - 5, -10);
        [roundNode addChild:lineNode];
        
        [self runAction:[SKAction rotateByAngle:M_PI * 4 duration:20]];
    }
    return self;
}

- (void)addAKnife:(NSString *)textName{
    SKSpriteNode * knifeNode = [SKSpriteNode spriteNodeWithColor:TWRandomColor size:CGSizeZero];
    knifeNode.size = CGSizeMake(TW_SizeRatio(100), TW_SizeRatio(250));
    knifeNode.position = CGPointMake(self.size.width * 0.5 - TW_SizeRatio(100) * 0.5, 0);
    [self addChild:knifeNode];
}


@end
