//
//  GameTool.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameTool.h"

@implementation GameTool

static GameTool * tool;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc]init];
    });
    return tool;
}

- (Checkpoint *)getCheckpoint:(NSInteger)number{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:CheckpointString];
    for (NSData * data in dataArray) {
        Checkpoint * check = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:check];
    }
    return array[number];
}

// 保存总关卡数
- (void)saveCheckpointCount:(NSInteger)count{
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:AllCheckpointNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取总关卡数
- (NSInteger)getCheckpointCount{
    return [[NSUserDefaults standardUserDefaults] integerForKey:AllCheckpointNumber];
}

- (void)saveCheckpointNumber:(NSInteger)number{
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey:CheckpointNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)getCheckpointNumber{
    return [[NSUserDefaults standardUserDefaults] integerForKey:CheckpointNumber];
}

- (void)saveCheckpoint:(NSArray <Checkpoint *>*)checkArray{
    NSMutableArray * array = [NSMutableArray array];
    for (Checkpoint * point in checkArray) {
        // 将对象转成NSData
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:point];
        [array addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:array] forKey:CheckpointString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 获取游戏币
- (NSInteger)getGameMoney{
    return [[NSUserDefaults standardUserDefaults] integerForKey:GameMoney];
}
- (void)saveGameMoney:(NSInteger)money{
    [[NSUserDefaults standardUserDefaults] setInteger:money forKey:GameMoney];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取当前选中的刀
- (NSString *)getChooesKnife{
    return [[NSUserDefaults standardUserDefaults] objectForKey:WhichKnife];
}
- (void)saveChooesKnife:(NSString *)knife{
    [[NSUserDefaults standardUserDefaults] setObject:knife forKey:WhichKnife];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取当前得分
- (NSInteger)getCurrentScore{
    return [[NSUserDefaults standardUserDefaults] integerForKey:CurrentScore];
}
- (void)saveCurrentScore:(NSInteger)score{
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:CurrentScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取最高分
- (NSInteger)getBestScore{
    return [[NSUserDefaults standardUserDefaults] integerForKey:BestScore];
}
- (void)saveBestScore:(NSInteger)score{
    // 保存最大值，先取出之前的最大值跟传来的最大值进行比对
    if ([self getBestScore] >= score) {
        [[NSUserDefaults standardUserDefaults] setInteger:[self getBestScore] forKey:BestScore];
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:BestScore];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取解锁过的刀的数组
- (NSArray *)getUnlockKnife{
    return [[NSUserDefaults standardUserDefaults] objectForKey:UnlockKnifeArray];
}
- (void)saveUnlockKnife:(NSString *)knifeName{
    NSMutableArray * knifesArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:UnlockKnifeArray]];
    [knifesArr addObject:knifeName];
    [[NSUserDefaults standardUserDefaults] setObject:knifesArr forKey:UnlockKnifeArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
