//
//  PlayScene.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "PlayScene.h"
#import "TreeringTurntable.h"
#import "KnifeNode.h"

@interface PlayScene()
@property (nonatomic, strong) TreeringTurntable * treeringTurntable;
@property (nonatomic, strong) NSMutableArray <KnifeNode *> * knifeNodeArray;
@property (nonatomic, assign) NSInteger whichKnife;
@property (nonatomic, strong) NSMutableArray * actionsArray;
@end

@implementation PlayScene

#pragma mark - --------系统回调函数--------
- (void)didMoveToView:(SKView *)view{
    [self addChild:self.treeringTurntable];
    [self addChild:[self.knifeNodeArray firstObject]];
    _whichKnife = 0;
    [self.treeringTurntable runAction:[SKAction repeatActionForever:[SKAction sequence:self.actionsArray]]];
}

-(void)update:(NSTimeInterval)currentTime{
    for (KnifeNode * knife in self.knifeNodeArray) {
        if(knife.isRotate){
            [self rotateByPoint:knife point:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7) rad:0.01];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.knifeNodeArray[_whichKnife] runAction:[SKAction moveTo:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - (TWScreenWidth * 0.5) * 0.5 - TW_SizeRatio(74) * 0.8) duration:0.1] completion:^{
        
        // 先让他转起来
        self.knifeNodeArray[self.whichKnife].isRotate = YES;
        
        // 在添加新的第一个
        if (self.whichKnife < (self.knifeNodeArray.count - 1)) {
            self.knifeNodeArray[self.whichKnife + 1].position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
            [self addChild:self.knifeNodeArray[self.whichKnife + 1]];
            self.whichKnife++;
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
        
        for (NSInteger i = 0; i < 5; i++) {
            KnifeNode * knifeNode = [KnifeNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"knife00"] size:CGSizeZero];
            knifeNode.size = CGSizeMake(TW_SizeRatio(44), TW_SizeRatio(148));
            knifeNode.position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(250) * 0.5);
            knifeNode.isRotate = NO;
            [_knifeNodeArray addObject:knifeNode];
        }
    }
    return _knifeNodeArray;
}


- (NSMutableArray *)actionsArray{
    if (_actionsArray == nil) {
        _actionsArray = [NSMutableArray array];
        
        [_actionsArray addObject:[SKAction rotateByAngle:M_PI duration:5.0]];
        [_actionsArray addObject:[SKAction rotateByAngle:-M_PI duration:5.0]];
        [_actionsArray addObject:[SKAction rotateByAngle:M_PI * 0.3 duration:2.0]];
        [_actionsArray addObject:[SKAction rotateByAngle:-M_PI * 0.3 duration:2.0]];
    }
    return _actionsArray;
}

@end
