//
//  TreeringTurntable.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//  树轮转盘

#import "TreeringTurntable.h"

@interface TreeringTurntable()
@property (nonatomic, strong) SKSpriteNode * anchorPointNode;
@end

@implementation TreeringTurntable

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        self.color = TWRandomColor;
        
        SKSpriteNode * bgNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"shop-sheet0"] size:size];
        bgNode.zPosition = Treebgzposition;
//        [self addChild:bgNode];
        
        SKSpriteNode * boundNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"wood2-sheet0"] size:size];
        boundNode.zPosition = TreeBoundzposition;
//        [self addChild:boundNode];
        
        
        _anchorPointNode = [SKSpriteNode spriteNodeWithColor:TWRandomColor size:CGSizeMake(10, 10)];
        _anchorPointNode.position = CGPointMake(0, -size.height * 0.5);
        _anchorPointNode.zPosition = 10001;
        [self addChild:_anchorPointNode];
    }
    return self;
}

- (void)addNode:(SKSpriteNode *)node point:(CGPoint)point{
    
    
    //将本节点坐标系中的一个点转换为节点树中另一个节点的坐标系
    node.position = point;
    
    [self addChild:node];
}

- (void)addNode:(SKSpriteNode *)node size:(CGSize)size{
    
    
    // 将节点树中另一个节点的坐标系的一个点转换为本节点的坐标系。
    node.position = [self convertPoint:CGPointMake(self.size.height, 0) toNode:node];
    
//    [self addChild:node];
}

@end
