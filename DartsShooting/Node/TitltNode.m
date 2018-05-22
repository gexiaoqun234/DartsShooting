//
//  TitltNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "TitltNode.h"
#import "KnifeNode.h"

@interface TitltNode()
@property (nonatomic, strong) KnifeNode * knifeNode;
@end

@implementation TitltNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        SKSpriteNode * titleNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"title-sheet0"] size:size];
        [self addChild:titleNode];
        
        SKTexture * texture = [SKTexture textureWithImageNamed:[[GameTool shareManager] getChooesKnife]];
        _knifeNode = [KnifeNode spriteNodeWithTexture:texture size:CGSizeMake(texture.size.width * TWScreenWidth * 0.25 / texture.size.height, TWScreenWidth * 0.25)];
        _knifeNode.position = CGPointMake(TW_SizeRatio(5),0);
        _knifeNode.anchorPoint = CGPointMake(0.5, 0);
        [_knifeNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:TW_SizeRatio(10) duration:0.5],[SKAction moveByX:0 y:-TW_SizeRatio(10) duration:0.5]]]]];
        [titleNode addChild:_knifeNode];
    }
    return self;
}

- (void)resetTitleNodeTexture{
    SKTexture * texture = [SKTexture textureWithImageNamed:[[GameTool shareManager] getChooesKnife]];
    _knifeNode.texture = texture;
}

@end
