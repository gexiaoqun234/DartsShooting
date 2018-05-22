//
//  Extern.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "Extern.h"

uint32_t const WordCategory = 0x1 << 0;
uint32_t const TreeringTurntableCategory = 0x1 << 1;
uint32_t const KnifeCategory = 0x1 << 2;
uint32_t const AppleCategory = 0x1 << 3;


NSInteger const BGzposition = 1;
NSInteger const Referenceszposition = 2;// 参照点
NSInteger const Scorezposition = 5;
NSInteger const Treebgzposition = 10;//转盘背景
NSInteger const Knifezposition = 20;// 刀
NSInteger const TreeBoundzposition = 30;// 转盘
NSInteger const Startzposition = 40;//开始按钮
NSInteger const Pausezposition = 45;// 暂停按钮
NSInteger const MaskBGzposition = 50;//蒙版
NSInteger const HomeNodezposition = 60;


NSString * const StartName = @"StartName";
NSString * const Music = @"Music";
NSString * const Pause = @"Pause";
NSString * const Continue = @"Continue";
NSString * const Home = @"Home";
NSString * const Buy = @"Buy";
NSString * const DefaultFontName = @"309";
NSString * const BackNode = @"BackNode";
NSString * const HomeNode = @"HomeNode";

NSString * const DefaultKnife = @"knife01";
NSString * const OneKnife = @"knife02";
NSString * const TwoKnife = @"knife03";
NSString * const ThreeKnife = @"knife04";
NSString * const FourKnife = @"knife05";
NSString * const FiveKnife = @"knife06";
NSString * const SixKnife = @"knife07";
NSString * const SevenKnife = @"knife08";
NSString * const EightKnife = @"knife09";
NSString * const NineKnife = @"knife10";

NSString * const LockNode = @"LockNode";

// 标记
NSString * const IsFirst = @"IsFirst";
NSString * const BestScore = @"BEST";//最高得分的文本
NSString * const LastScore = @"LAST";//最高得分的文本
NSString * const GameMoney = @"GameMoney";//游戏币
NSString * const CurrentScore = @"CurrentScore";// 当前得分
NSString * const WhichKnife = @"WhichKnife";//选中的哪一把到
NSString * const UnlockKnifeArray = @"UnlockKnifeArray";//已经解锁的刀的数组
NSString * const CheckpointString = @"CheckpointString";







