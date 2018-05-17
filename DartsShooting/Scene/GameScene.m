//
//  GameScene.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameScene.h"
#import "TreeringTurntable.h"
#import "KnifeNode.h"
#import "BackgroundNode.h"

@interface GameScene()
@property (nonatomic, strong) TreeringTurntable * treeringTurntable;
@property (nonatomic, strong) NSMutableArray <KnifeNode *> * knifeNodeArray;
@property (nonatomic, assign) BOOL allRotate;// 用来标识所有的刀是否都被发射出去了
@property (nonatomic, strong) SKEmitterNode * appleShootingEmitter;
@property (nonatomic, strong) SKEmitterNode * tuckedInEmitter;  // 扎进去
@end

@implementation GameScene

#pragma mark - --------系统回调函数--------
- (void)didMoveToView:(SKView *)view{
    // 设置背景
    [self addChild:[BackgroundNode initializeBackgroundNode]];
    // 添加树轮
    [self addChild:self.treeringTurntable];
    // 添加第一把刀
    [self addChild:[self.knifeNodeArray firstObject]];
    _allRotate = NO;
    
    [self addChild:self.tuckedInEmitter];
    [self.tuckedInEmitter setHidden:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_allRotate == NO) {
        [self.knifeNodeArray[0] runAction:[SKAction moveTo:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - (TWScreenWidth * 0.5) * 0.5 - TW_SizeRatio(74) * 0.8) duration:0.2] completion:^{
            
            [self.tuckedInEmitter setHidden:NO];
            [self.tuckedInEmitter resetSimulation];
            
            // 从当前场景移除，并且移除自带的动作
            [self.knifeNodeArray[0] removeAllActions];
            [self.knifeNodeArray[0] removeFromParent];
            
#pragma mark - --------计算夹角的弧度--------
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


#pragma mark - --------计算位置--------
            /*
             将本节点坐标系中的一个点转换为节点树中另一个节点的坐标系。
             - (CGPoint)convertPoint:(CGPoint)point toNode:(SKNode *)node
             
             参数
             point:本节点坐标系上的一个点
             node:同一个节点树上的另一个节点
             返回值    转换到其他节点坐标系的同一个点
             
             计算当前场景固定点的绝对坐标转换成转盘节点上的坐标系对应的坐标
             */
            CGPoint point = [self convertPoint:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25 * 0.75) toNode:self.treeringTurntable];
            
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
        
        // 创建刀
        for (NSInteger i = 0; i < 1000; i++) {
            SKTexture * texture = [SKTexture textureWithImageNamed:@"knife05"];
            KnifeNode * knifeNode = [KnifeNode spriteNodeWithTexture:texture size:CGSizeZero];
            knifeNode.size = CGSizeMake(texture.size.width * TWScreenWidth * 0.25 / texture.size.height, TWScreenWidth * 0.25);
            knifeNode.position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
            knifeNode.anchorPoint = CGPointMake(0.5, 1);
            [_knifeNodeArray addObject:knifeNode];
        }
        
        // 添加抖动动作
        for (NSInteger i = 0; i < 1000; i++) {
            [_knifeNodeArray[i] runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveToY:TW_SizeRatio(250) * 0.5 + 5 duration:1],[SKAction moveToY:TW_SizeRatio(250) * 0.5 - 5 duration:1]]]]];
        }
    }
    return _knifeNodeArray;
}

- (SKEmitterNode *)tuckedInEmitter{
    if (_tuckedInEmitter == nil) {
        _tuckedInEmitter = [SKEmitterNode nodeWithFileNamed:@"TuckedIn.sks"];
        _tuckedInEmitter.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
    }
    return _tuckedInEmitter;
}

- (SKEmitterNode *)appleShootingEmitter{
    if (_appleShootingEmitter == nil) {
        _appleShootingEmitter = [SKEmitterNode nodeWithFileNamed:@"AppleShooting.sks"];
//        _appleShootingEmitter.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
    }
    return _appleShootingEmitter;
}


@end
