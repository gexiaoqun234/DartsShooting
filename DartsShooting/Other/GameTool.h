//
//  GameTool.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Checkpoint;

@interface GameTool : NSObject

+ (instancetype)shareManager;

// 获取第几个关卡的数据
- (Checkpoint *)getCheckpoint:(NSInteger)number;
// 保存关卡
- (void)saveCheckpoint:(NSArray <Checkpoint *>*)checkArray;

// 获取游戏币
- (NSInteger)getGameMoney;
- (void)saveGameMoney:(NSInteger)money;
// 获取当前选中的刀
- (NSString *)getChooesKnife;
- (void)saveChooesKnife:(NSString *)knife;
// 获取当前得分
- (NSInteger)getCurrentScore;
- (void)saveCurrentScore:(NSInteger)score;
// 获取最高分
- (NSInteger)getBestScore;
- (void)saveBestScore:(NSInteger)score;
// 获取解锁过的刀的数组
- (NSArray *)getUnlockKnife;
- (void)saveUnlockKnife:(NSString *)knifeName;

@end
