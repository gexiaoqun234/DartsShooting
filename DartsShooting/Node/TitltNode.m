//
//  TitltNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "TitltNode.h"
#import "KnifeNode.h"

@implementation TitltNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        SKSpriteNode * titleNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"title-sheet0"] size:size];
        [self addChild:titleNode];
        
        SKTexture * texture = [SKTexture textureWithImageNamed:@"knife05"];
        KnifeNode * knifeNode = [KnifeNode spriteNodeWithTexture:texture size:CGSizeMake(texture.size.width * TWScreenWidth * 0.25 / texture.size.height, TWScreenWidth * 0.25)];
        knifeNode.position = CGPointMake(TW_SizeRatio(5),0);
        knifeNode.anchorPoint = CGPointMake(0.5, 0);
        [knifeNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:TW_SizeRatio(10) duration:0.5],[SKAction moveByX:0 y:-TW_SizeRatio(10) duration:0.5]]]]];
        [titleNode addChild:knifeNode];
    }
    return self;
}

@end
