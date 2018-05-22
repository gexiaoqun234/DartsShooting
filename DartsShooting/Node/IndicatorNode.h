//
//  IndicatorNode.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IndicatorNode : SKSpriteNode

+ (instancetype)createIndicatorNode;

// 初始化设置一共多少根
- (void)setIndicatorNode:(NSInteger)number;
// 重设_已经使用了多少根
- (void)resetIndicatorNode:(NSInteger)number;


@end
