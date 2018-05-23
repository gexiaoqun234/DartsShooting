//
//  TreeringTurntable.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TreeringTurntable : SKSpriteNode

- (void)addApple:(NSArray *)appleCoordinate;    // 根据传来的苹果坐标数组来添加苹果
- (void)run;
- (void)stop;

@end
