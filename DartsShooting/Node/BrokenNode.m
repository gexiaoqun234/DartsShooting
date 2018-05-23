//
//  BrokenNode.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/23.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "BrokenNode.h"

@implementation BrokenNode

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    if (self = [super initWithColor:color size:size]) {
        
        // 上
        SKSpriteNode * topNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"p3-sheet0"] size:CGSizeMake(TW_SizeRatio(59), TW_SizeRatio(66))];
        topNode.position = CGPointMake(0,TW_SizeRatio(66) * 0.5);
        // 左
        SKSpriteNode * leftNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"p2-sheet0"] size:CGSizeMake(TW_SizeRatio(61), TW_SizeRatio(60))];
        leftNode.position = CGPointMake(-TW_SizeRatio(61) * 0.5,0);
        // 下
        SKSpriteNode * bottomNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"p1-sheet0"] size:CGSizeMake(TW_SizeRatio(76), TW_SizeRatio(74))];
        bottomNode.position = CGPointMake(0,-TW_SizeRatio(74) * 0.5);
        // 右
        SKSpriteNode * rightNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"p4-sheet0"] size:CGSizeMake(TW_SizeRatio(66), TW_SizeRatio(60))];
        rightNode.position = CGPointMake(TW_SizeRatio(66) * 0.5,0);
        
        
        // 上运动
        UIBezierPath * pathTop = [UIBezierPath bezierPath];
        [pathTop moveToPoint:CGPointMake(0, TW_SizeRatio(66) * 0.5)];
        [pathTop addQuadCurveToPoint:CGPointMake(size.width, 0) controlPoint:CGPointMake(0, size.height)];
        // Offset(是否是相对路径) orientToPath(节点Z轴在旋转的时候属性是否发生改变)
        [topNode runAction:[SKAction group:@[[SKAction followPath:pathTop.CGPath asOffset:YES orientToPath:YES duration:BrokenTime],[SKAction speedBy:5 duration:BrokenTime],[SKAction fadeOutWithDuration:BrokenTime]]] completion:^{
            [topNode removeFromParent];
            [topNode removeAllActions];
        }];
        
        // 左运动
        UIBezierPath * pathLeft = [UIBezierPath bezierPath];
        [pathLeft moveToPoint:CGPointMake(-TW_SizeRatio(61) * 0.5,0)];
        [pathLeft addQuadCurveToPoint:CGPointMake(-size.width * 0.8, 0) controlPoint:CGPointMake(0, size.height * 0.8)];
        [leftNode runAction:[SKAction group:@[[SKAction followPath:pathLeft.CGPath asOffset:YES orientToPath:YES duration:BrokenTime],[SKAction speedBy:5 duration:BrokenTime],[SKAction fadeOutWithDuration:BrokenTime]]] completion:^{
            [leftNode removeFromParent];
            [leftNode removeAllActions];
        }];
        
        // 下运动
        UIBezierPath * pathBottom = [UIBezierPath bezierPath];
        [pathBottom moveToPoint:CGPointMake(0,-TW_SizeRatio(74) * 0.5)];
        [pathBottom addQuadCurveToPoint:CGPointMake(-size.width * 0.5, -size.height) controlPoint:CGPointMake(-size.width * 0.5, size.height * 0.4)];
        [bottomNode runAction:[SKAction group:@[[SKAction followPath:pathBottom.CGPath asOffset:YES orientToPath:YES duration:BrokenTime],[SKAction speedBy:5 duration:BrokenTime],[SKAction fadeOutWithDuration:BrokenTime]]] completion:^{
            [bottomNode removeAllActions];
            [bottomNode removeFromParent];
        }];
        
        // 右运动
        UIBezierPath * pathRight = [UIBezierPath bezierPath];
        [pathRight moveToPoint:CGPointMake(TW_SizeRatio(66) * 0.5,0)];
        [pathRight addQuadCurveToPoint:CGPointMake(size.width * 0.5, -size.height * 0.7) controlPoint:CGPointMake(size.width * 0.6, size.height * 0.4)];
        [rightNode runAction:[SKAction group:@[[SKAction followPath:pathRight.CGPath asOffset:YES orientToPath:YES duration:BrokenTime],[SKAction speedBy:5 duration:BrokenTime],[SKAction fadeOutWithDuration:BrokenTime]]] completion:^{
            [rightNode removeAllActions];
            [rightNode removeFromParent];
        }];
        
        
        [self addChild:topNode];
        [self addChild:leftNode];
        [self addChild:bottomNode];
        [self addChild:rightNode];
        
        
        // 展示路径
//        SKShapeNode * shapeNode = [[SKShapeNode alloc]init];
//        shapeNode.path = pathTop.CGPath;
//        shapeNode.strokeColor = TWRandomColor;
//        shapeNode.lineWidth = 2;
//        [self addChild:shapeNode];
    }
    return self;
}



@end
