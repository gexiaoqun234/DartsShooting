//
//  Checkpoint.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checkpoint : NSObject<NSCoding>
// 第几关卡
@property (nonatomic, assign) NSInteger checkpointCount;
// 给几把刀
@property (nonatomic, assign) NSInteger knifes;
// 给几个苹果
@property (nonatomic, assign) NSInteger apples;
// 苹果的坐标
@property (nonatomic, copy) NSArray * applesCoordinates;

@end
