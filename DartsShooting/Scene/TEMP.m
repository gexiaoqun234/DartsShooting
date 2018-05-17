//
//  TEMP.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/16.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "TEMP.h"
#import "TreeringTurntable.h"
#import "KnifeNode.h"

@interface TEMP()
@property (nonatomic, strong) TreeringTurntable * treeringTurntable;
@property (nonatomic, strong) NSMutableArray <KnifeNode *> * knifeNodeArray;
@property (nonatomic, assign) BOOL allRotate;           // 全部转起来
@end

@implementation TEMP
#pragma mark - --------系统回调函数--------
- (void)didMoveToView:(SKView *)view{
    [self addChild:self.treeringTurntable];
    [self addChild:[self.knifeNodeArray firstObject]];
    _allRotate = NO;
    
    SKSpriteNode * anchorPointNode = [SKSpriteNode spriteNodeWithColor:TWRandomColor size:CGSizeMake(10, 10)];
    anchorPointNode.zPosition = 1000;

    anchorPointNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
    
    [self.treeringTurntable runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction rotateByAngle:M_PI * 3 duration:5.0],[SKAction rotateByAngle:-M_PI * 1.5 duration:5.0],[SKAction rotateByAngle:M_PI * 0.3 duration:2.0],[SKAction rotateByAngle:-M_PI * 0.3 duration:2.0]]]]];
    
    [self addChild:anchorPointNode];
}

-(void)update:(NSTimeInterval)currentTime{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_allRotate == NO) {
        [self.knifeNodeArray[0] runAction:[SKAction moveTo:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - (TWScreenWidth * 0.5) * 0.5 - TW_SizeRatio(74) * 0.8) duration:0.1] completion:^{
            
            [self.knifeNodeArray[0] removeAllActions];
            [self.knifeNodeArray[0] removeFromParent];
            
            [self.treeringTurntable addNode:self.knifeNodeArray[0] size:self.knifeNodeArray[0].size];
            
            // *******计算夹角的弧度*******
            // 计算得出当前转盘上那个标记节点的的绝对坐标(跟随转盘会不停旋转)
            CGPoint point1 = [self convertPoint:CGPointMake(0, -self.treeringTurntable.size.height * 0.5) fromNode:self.treeringTurntable];
            
            // 设置出固定坐标
            CGPoint fixedPoint = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
            
            // 计算夹角对边的长度
            // 1计算三角形竖线的长度
            double tothesideY = fabs(fixedPoint.y - point1.y);
            // 2计算三角形横线的长度
            double tothesideX = fabs(fixedPoint.x - point1.x);
            // 3勾股定理计算斜边长度
            double totheside = sqrt(pow(tothesideX, 2) + pow(tothesideY, 2));
            
            // 正弦值(这里只是计算的夹角的一半)
            double sinX = (totheside * 0.5) / (TWScreenWidth * 0.25);
            
            // 计算一半夹角的弧度
            double radians = asin(sinX);
            
            // 计算完整夹角的度数
            double angle = RADIANS_TO_DEGREES(radians) * 2;
            
            // 计算完整夹角的弧度
            double radians2 = DEGREES_TO_RADIANS(angle);
        
            /*
             将弧度赋值给节点
             这里要注意象限
             在左半边的时候应该是赋值-radians2
             在右半边的时候应该是赋值radians2
             
             
             左右如何判断界定？
             将转盘上的参照点转换成当前场景中的点，根据这个点坐标来进行判断
             这个点上面计算过，就是point1
             */
            if (point1.x >= TWScreenWidth * 0.5) {
                self.knifeNodeArray[0].zRotation = -radians2;
            } else {
                self.knifeNodeArray[0].zRotation = radians2;
            }
    
            /*
             将本节点坐标系中的一个点转换为节点树中另一个节点的坐标系。
             - (CGPoint)convertPoint:(CGPoint)point toNode:(SKNode *)node
             
             参数
             point:本节点坐标系上的一个点
             node:同一个节点树上的另一个节点
             返回值    转换到其他节点坐标系的同一个点
             
             计算当前场景固定点的绝对坐标转换成转盘节点上的坐标系对应的坐标
             */
            CGPoint point = [self convertPoint:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25) toNode:self.treeringTurntable];
            
            self.knifeNodeArray[0].position = point;
            [self.treeringTurntable addChild:self.knifeNodeArray[0]];
            
            
            // 删除掉这个
            [self.knifeNodeArray removeObject:self.knifeNodeArray[0]];
            
            // 在添加新的第一个
            if (self.knifeNodeArray.count > 0) {
                self.knifeNodeArray[0].position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
                [self addChild:self.knifeNodeArray[0]];
            }
            
            if (self.knifeNodeArray.count == 0) {
                self.allRotate = YES;
                NSLog(@"全部发射完毕");
            }
        }];
    }
}

// element为节点，point表示绕某个点旋转，rad表示每帧的弧度
- (void)rotateByPoint:(SKNode *)element point:(CGPoint)point rad:(CGFloat)rad{
    CGPoint tempPos = element.position;
    CGFloat resultX = point.x + (tempPos.x - point.x) * cos(rad) - (tempPos.y - point.y) * sin(rad);
    CGFloat resultY = point.y + (tempPos.x - point.x) * sin(rad) + (tempPos.y - point.y) * cos(rad);
    //修改角度
    element.zRotation += rad;
    //修改位置
    CGPoint newPos = CGPointMake(resultX, resultY);
    element.position = newPos;
}

#pragma mark - --------懒加载--------
- (TreeringTurntable *)treeringTurntable{
    if (_treeringTurntable == nil) {
        _treeringTurntable = [[TreeringTurntable alloc]initWithColor:self.backgroundColor size:CGSizeMake(TWScreenWidth * 0.5, TWScreenWidth * 0.5)];
        _treeringTurntable.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
    }
    return _treeringTurntable;
}

- (NSMutableArray<KnifeNode *> *)knifeNodeArray{
    if (_knifeNodeArray == nil) {
        _knifeNodeArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 1000; i++) {
            KnifeNode * knifeNode = [KnifeNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"knife00"] size:CGSizeZero];
            knifeNode.size = CGSizeMake(TW_SizeRatio(44), TW_SizeRatio(148));
            knifeNode.position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
            knifeNode.anchorPoint = CGPointMake(0.5, 1);
            [_knifeNodeArray addObject:knifeNode];
        }
    }
    return _knifeNodeArray;
}


@end
