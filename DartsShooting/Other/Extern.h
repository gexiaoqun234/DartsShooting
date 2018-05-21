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
UIKIT_EXTERN uint32_t const FallBallCategory;      
UIKIT_EXTERN uint32_t const FixedBallCategory;     
UIKIT_EXTERN uint32_t const FixedBallOneCategory;  
UIKIT_EXTERN uint32_t const FixedBallTwoCategory;  
UIKIT_EXTERN uint32_t const FixedBallThreeCategory;



// zposition
UIKIT_EXTERN NSInteger const BGzposition;//背景图片
UIKIT_EXTERN NSInteger const Referenceszposition;// 参照点
UIKIT_EXTERN NSInteger const Scorezposition;// 分数相关的
UIKIT_EXTERN NSInteger const Treebgzposition;// 转盘的背景
UIKIT_EXTERN NSInteger const Knifezposition;// 刀
UIKIT_EXTERN NSInteger const TreeBoundzposition;// 树轮
UIKIT_EXTERN NSInteger const Startzposition;
UIKIT_EXTERN NSInteger const MaskBGzposition;//蒙版


// nodeName
UIKIT_EXTERN NSString * const StartName;
UIKIT_EXTERN NSString * const Music;
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


// 标记
UIKIT_EXTERN NSString * const DefaultFontName;
UIKIT_EXTERN NSString * const IsFirst;// 第一次登陆
UIKIT_EXTERN NSString * const GameMoney;// 游戏币
UIKIT_EXTERN NSString * const BestScore;//最高得分
UIKIT_EXTERN NSString * const LastScore;// 上次得分
UIKIT_EXTERN NSString * const CurrentScore;// 当前得分
UIKIT_EXTERN NSString * const WhichKnife;//选中的哪一把到







