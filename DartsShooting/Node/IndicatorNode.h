//
//  IndicatorNode.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IndicatorNode : SKSpriteNode

// 初始化设置一共多少根
- (void)setIndicatorNode:(NSInteger)number;

// 减去一根
- (void)minusARoot;

// 重设_共几根，已经使用了多少根
- (void)resetIndicatorNodeAllCount:(NSInteger)allNumber userCount:(NSInteger)userNumber;


@end
