//
//  GameScene.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameScene.h"
#import "TurntableNode.h"
#import "KnifeNode.h"

@interface GameScene()
@property (nonatomic, strong) TurntableNode * turntable;
@property (nonatomic, strong) NSMutableArray <KnifeNode *> * knifeArray;
@property (nonatomic, strong) SKEmitterNode *appleShooting;
@property (nonatomic, assign) NSInteger index;
@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    [self addChild:self.turntable];
    _index = 0;
    _knifeArray = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = 0; i < 5; i++){
        KnifeNode * knifeNode = [KnifeNode spriteNodeWithColor:TWRandomColor size:CGSizeZero];
        knifeNode.size = CGSizeMake(TW_SizeRatio(100), TW_SizeRatio(250));
        knifeNode.position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
        knifeNode.isRotate = NO;
        [_knifeArray addObject:knifeNode];
    }
    
    [self addChild:_knifeArray[0]];
    
    _appleShooting = [SKEmitterNode nodeWithFileNamed:@"AppleShooting.sks"];
    _appleShooting.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
    [self addChild:_appleShooting];
}

-(void)update:(CFTimeInterval)currentTime {
    for (KnifeNode * node in self.knifeArray){
        if(node.isRotate){
            [self rotateByPoint:node point:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7) rad:0.01];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [_appleShooting resetSimulation];
    
    
    [self.knifeArray[_index] runAction:[SKAction moveTo:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7) duration:0.1] completion:^{
        
        self.knifeArray[self.index].isRotate = YES;
        
        // 在添加新的第一个
        if (self.index < (self.knifeArray.count - 1)) {
            self.knifeArray[self.index + 1].position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
            [self addChild:self.knifeArray[self.index + 1]];

            self.index++;
        }
        
        
        
    }];
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

- (TurntableNode *)turntable{
    if (_turntable == nil) {
        _turntable = [[TurntableNode alloc]initWithColor:[UIColor orangeColor] size:CGSizeMake(TW_SizeRatio(100), TW_SizeRatio(100))];
        _turntable.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
    }
    return _turntable;
}

@end
