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
@property (nonatomic, assign) BOOL allRotate;           // 全部转起来
@end

@implementation PlayScene

#pragma mark - --------系统回调函数--------
- (void)didMoveToView:(SKView *)view{
}

-(void)update:(NSTimeInterval)currentTime{
   
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
