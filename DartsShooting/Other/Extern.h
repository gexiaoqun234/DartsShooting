//
//  Extern.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

//Category bit masks
UIKIT_EXTERN uint32_t const WordCategory;
UIKIT_EXTERN uint32_t const TreeringTurntableCategory;      
UIKIT_EXTERN uint32_t const KnifeCategory;     
UIKIT_EXTERN uint32_t const AppleCategory;  



// zposition
UIKIT_EXTERN NSInteger const BGzposition;//背景图片
UIKIT_EXTERN NSInteger const Referenceszposition;// 参照点
UIKIT_EXTERN NSInteger const Scorezposition;// 分数相关的
UIKIT_EXTERN NSInteger const Treebgzposition;// 转盘的背景
UIKIT_EXTERN NSInteger const Knifezposition;// 刀
UIKIT_EXTERN NSInteger const TreeBoundzposition;// 树轮
UIKIT_EXTERN NSInteger const Startzposition;
UIKIT_EXTERN NSInteger const Pausezposition;
UIKIT_EXTERN NSInteger const MaskBGzposition;//蒙版
UIKIT_EXTERN NSInteger const HomeNodezposition;
UIKIT_EXTERN NSInteger const Gameoverzposition;

// nodeName
UIKIT_EXTERN NSString * const StartName;
UIKIT_EXTERN NSString * const Music;
UIKIT_EXTERN NSString * const Pause;
UIKIT_EXTERN NSString * const Continue;
UIKIT_EXTERN NSString * const Home;
UIKIT_EXTERN NSString * const Buy;
UIKIT_EXTERN NSString * const BackNode;
UIKIT_EXTERN NSString * const HomeNode;


UIKIT_EXTERN NSString * const DefaultKnife;
UIKIT_EXTERN NSString * const OneKnife;
UIKIT_EXTERN NSString * const TwoKnife;
UIKIT_EXTERN NSString * const ThreeKnife;
UIKIT_EXTERN NSString * const FourKnife;
UIKIT_EXTERN NSString * const FiveKnife;
UIKIT_EXTERN NSString * const SixKnife;
UIKIT_EXTERN NSString * const SevenKnife;
UIKIT_EXTERN NSString * const EightKnife;
UIKIT_EXTERN NSString * const NineKnife;

UIKIT_EXTERN NSString * const LockNode;

// 标记
UIKIT_EXTERN NSString * const DefaultFontName;
UIKIT_EXTERN NSString * const IsFirst;// 第一次登陆
UIKIT_EXTERN NSString * const GameMoney;// 游戏币
UIKIT_EXTERN NSString * const BestScore;//最高得分
UIKIT_EXTERN NSString * const LastScore;// 上次得分
UIKIT_EXTERN NSString * const CurrentScore;// 当前得分
UIKIT_EXTERN NSString * const WhichKnife;//选中的哪一把到
UIKIT_EXTERN NSString * const UnlockKnifeArray;//已经解锁的刀的数组
UIKIT_EXTERN NSString * const CheckpointString;// 关卡字符串

UIKIT_EXTERN NSString * const CoordinatesX;
UIKIT_EXTERN NSString * const CoordinatesY;
UIKIT_EXTERN NSString * const CoordinatesZRotation;


