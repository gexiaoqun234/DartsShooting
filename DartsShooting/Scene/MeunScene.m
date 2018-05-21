//
//  MeunScene.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "MeunScene.h"
#import "TreeringTurntable.h"
#import "KnifeNode.h"
#import "TitltNode.h"
#import "BackgroundNode.h"
#import "GameScene.h"
#import "LockKnifeNode.h"

@interface MeunScene()
@property (nonatomic, strong) TitltNode * titleNode;
@property (nonatomic, strong) TreeringTurntable * treeringTurntable;
@property (nonatomic, strong) SKSpriteNode * startNode;
@property (nonatomic, strong) SKLabelNode * historyHighestScoreLabel;// 历史最高分label
@property (nonatomic, strong) SKLabelNode * highestScoreLabel;// 历史最高分分数
@property (nonatomic, strong) SKLabelNode * lastScoreLabel;// 上次得分label
@property (nonatomic, strong) SKLabelNode * lastScore;// 上次得分分数
@property (nonatomic, strong) SKAction * fadeAction;
@property (nonatomic, strong) SKSpriteNode * toolNode;
@property (nonatomic, strong) SKSpriteNode * musicNode;
@property (nonatomic, assign) BOOL showMusic;
@property (nonatomic, strong) SKSpriteNode * buyNode;

// 蒙版背景
@property (nonatomic, strong) SKSpriteNode * maskNode;
@property (nonatomic, strong) SKSpriteNode * buyKnifeNode;
@property (nonatomic, strong) SKSpriteNode * chooesNode;

@end

@implementation MeunScene

- (void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    _showMusic = YES;
    self.backgroundColor = GAMEBGCOLOR;
    [self addChild:[BackgroundNode initializeBackgroundNode]];
    [self addChild:self.treeringTurntable];
    [self addChild:self.titleNode];
    [self addChild:self.historyHighestScoreLabel];
    [self addChild:self.lastScoreLabel];
    [self addChild:self.highestScoreLabel];
    [self addChild:self.lastScore];
    [self addChild:self.toolNode];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode * node = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    if ([node.name isEqualToString:StartName]){
        GameScene * gameScene = [[GameScene alloc]initWithSize:self.size];
        gameScene.showMusic = _showMusic;
        SKTransition * transition = [SKTransition revealWithDirection:(SKTransitionDirectionLeft) duration:1];
        [self.view presentScene:gameScene transition:transition];
    } else if ([node.name isEqualToString:Music]){
        if (!_showMusic) {
            self.musicNode.texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet0"];
            _showMusic = NO;
        } else {
            self.musicNode.texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet1"];
            _showMusic = YES;
        }
        _showMusic = !_showMusic;
    } else if ([node.name isEqualToString:Buy]){
        [self addChild:self.maskNode];
    } else if ([node.name isEqualToString:BackNode]){
        // 保存下选中的
        
        // 关闭
        [self.maskNode removeFromParent];
    } else if ([node.name isEqualToString:DefaultKnife]){
        
    } else if ([node.name isEqualToString:OneKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal1"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:TwoKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal2"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:ThreeKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal3"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:FourKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal4"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:FiveKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal5"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:SixKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal6"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:SevenKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal7"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:EightKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal8"];
        [tempNode addChild:self.chooesNode];
    } else if ([node.name isEqualToString:NineKnife]){
        [self.chooesNode removeFromParent];
        LockKnifeNode * tempNode = (LockKnifeNode *)node;
        [tempNode unLockKnifeNodeWith:@"knife_nomal9"];
        [tempNode addChild:self.chooesNode];
    }
}

#pragma mark - --------懒加载--------
- (SKSpriteNode *)maskNode{
    if (_maskNode == nil) {
        _maskNode = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:0.7] size:self.size];
        _maskNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
        _maskNode.zPosition = MaskBGzposition;
        [_maskNode addChild:self.buyKnifeNode];
    }
    return _maskNode;
}

- (SKSpriteNode *)buyKnifeNode{
    if (_buyKnifeNode == nil) {
        _buyKnifeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"shop-sheet0"] size:CGSizeMake(TWScreenWidth * 0.8, TWScreenWidth * 0.8)];
        
        // 分成5分,每把剑的外部圆圈都是这个尺寸
        CGFloat height = TWScreenWidth * 0.8 * 0.2;
        
        // 第一层
        SKSpriteNode * oneLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        oneLayer.position = CGPointMake(0, height * 2);
        // 第一层的单价
        CGFloat h = height * 0.6;
        CGFloat w = h * 181 / 72.0;
        SKSpriteNode * priceNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"shopicon-sheet0"] size:CGSizeMake(w,h)];
        priceNode.position = CGPointMake(0, -TW_SizeRatio(5));
        [oneLayer addChild:priceNode];
        [_buyKnifeNode addChild:oneLayer];
        
        // 第二层
        SKSpriteNode * twoLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        twoLayer.position = CGPointMake(0, height);
        
        // 添加1~3把剑(其中第一把是默认剑)
        SKSpriteNode * firstKnife = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"knife_nomal"] size:CGSizeMake(BuyKnifeTextureWH, BuyKnifeTextureWH)];
        firstKnife.position = CGPointMake(-height, 0);
        firstKnife.name = DefaultKnife;
        [firstKnife addChild:self.chooesNode];
        [twoLayer addChild:firstKnife];
        
        [twoLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select1" position:CGPointMake(0, 0) name:OneKnife]];
        [twoLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select2" position:CGPointMake(height, 0) name:TwoKnife]];
        [_buyKnifeNode addChild:twoLayer];
        
        
        SKSpriteNode * threeLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        threeLayer.position = CGPointMake(0, 0);
        
        // 添加4~7把剑
        [threeLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select3" position:CGPointMake(-height * 1.5, 0) name:ThreeKnife]];
        [threeLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select4" position:CGPointMake(-height * 0.5, 0) name:FourKnife]];
        [threeLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select5" position:CGPointMake(height * 1.5, 0) name:FiveKnife]];
        [threeLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select6" position:CGPointMake(height * 0.5, 0) name:SixKnife]];
        [_buyKnifeNode addChild:threeLayer];
        

        SKSpriteNode * fourLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        fourLayer.position = CGPointMake(0, -height);
        
        // 添加8~10把剑
        [fourLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select7" position:CGPointMake(-height, 0) name:SevenKnife]];
        [fourLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select8" position:CGPointMake(0, 0) name:EightKnife]];
        [fourLayer addChild:[LockKnifeNode createKnifeNodeWith:@"knife_select9" position:CGPointMake(height, 0) name:NineKnife]];
        
        [_buyKnifeNode addChild:fourLayer];
        
        SKSpriteNode * fiveLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        fiveLayer.position = CGPointMake(0, -height * 2);
        
        SKSpriteNode * backNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"okbtn-sheet0"] size:CGSizeMake(height * 0.7, height * 0.7)];
        backNode.position = CGPointMake(0, TW_SizeRatio(5));
        backNode.name = BackNode;
        [fiveLayer addChild:backNode];
        [_buyKnifeNode addChild:fiveLayer];
    }
    return _buyKnifeNode;
}

- (SKSpriteNode *)chooesNode{
    if (_chooesNode == nil) {
        _chooesNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"select-sheet0"] size:CGSizeMake(BuyKnifeTextureWH, BuyKnifeTextureWH)];
    }
    return _chooesNode;
}

- (SKSpriteNode *)toolNode{
    if (_toolNode == nil) {
        CGFloat h = TWScreenHeight - (TWScreenHeight * 0.3 + TWScreenWidth * 0.25) - (TW_SizeRatio(40) + TWScreenWidth / 5 * 4.0 * 340 / 580.0);
        _toolNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(TWScreenWidth, h)];
        _toolNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight - (TWScreenHeight * 0.3 + TWScreenWidth * 0.5));
        [_toolNode addChild:self.musicNode];
        [_toolNode addChild:self.buyNode];
    }
    return _toolNode;
}


- (SKSpriteNode *)musicNode{
    if (_musicNode == nil) {
        _musicNode = [[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"soundbtn-sheet0"]];
        _musicNode.size = CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2);
        _musicNode.name = Music;
        _musicNode.zPosition = Startzposition;
        _musicNode.position = CGPointMake(-TWScreenWidth * 0.25, 0);
    }
    return _musicNode;
}

- (SKSpriteNode *)buyNode{
    if (_buyNode == nil) {
        _buyNode = [[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"extrasbtn-sheet0"]];
        _buyNode.size = CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2);
        _buyNode.name = Buy;
        _buyNode.zPosition = Startzposition;
        _buyNode.position = CGPointMake(TWScreenWidth * 0.25, 0);
    }
    return _buyNode;
}

- (TitltNode *)titleNode{
    if (_titleNode == nil) {
        CGFloat w = TWScreenWidth / 5 * 4.0;
        CGFloat h = w * 340 / 580.0;
        _titleNode = [[TitltNode alloc]initWithColor:[SKColor clearColor] size:CGSizeMake(w, h)];
        _titleNode.position = CGPointMake(TWScreenWidth* 0.5, TW_SizeRatio(40) + h * 0.5);
    }
    return _titleNode;
}

- (SKSpriteNode *)startNode{
    if (_startNode == nil) {
        _startNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"playbtn-sheet0"] size:CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2)];
        _startNode.zPosition = Startzposition;
        _startNode.name = StartName;
        [_startNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleTo:1.1 duration:0.5],[SKAction scaleTo:1 duration:0.5]]]]];
    }
    return _startNode;
}

- (TreeringTurntable *)treeringTurntable{
    if (_treeringTurntable == nil) {
        _treeringTurntable = [[TreeringTurntable alloc]initWithColor:self.backgroundColor size:CGSizeMake(TWScreenWidth * 0.5, TWScreenWidth * 0.5)];
        _treeringTurntable.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
        [_treeringTurntable addChild:self.startNode];
    }
    return _treeringTurntable;
}

- (SKLabelNode *)lastScoreLabel{
    if (_lastScoreLabel == nil) {
        _lastScoreLabel = [SKLabelNode createLabelNodeWithText:LastScore withVerticalAlignmentMode:(SKLabelVerticalAlignmentModeCenter) withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentModeCenter) withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition:CGPointMake(TWScreenWidth * 0.75, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5)];
        [_lastScoreLabel runAction:self.fadeAction];
    }
    return _lastScoreLabel;
}

- (SKLabelNode *)historyHighestScoreLabel{
    if (_historyHighestScoreLabel == nil) {
        _historyHighestScoreLabel = [SKLabelNode createLabelNodeWithText:BestScore withVerticalAlignmentMode:(SKLabelVerticalAlignmentModeCenter) withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentModeCenter) withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition:CGPointMake(TWScreenWidth * 0.25, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5)];
        [_historyHighestScoreLabel runAction:self.fadeAction];
    }
    return _historyHighestScoreLabel;
}

- (SKLabelNode *)lastScore{
    if (_lastScore == nil) {
        _lastScore = [SKLabelNode createLabelNodeWithText:@"0" withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth * 0.75, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5 - TW_SizeRatio(30))];
        [_lastScore runAction:self.fadeAction];
    }
    return _lastScore;
}

- (SKLabelNode *)highestScoreLabel{
    if (_highestScoreLabel == nil) {
        _highestScoreLabel = [SKLabelNode createLabelNodeWithText:@"0" withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth * 0.25, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5 - TW_SizeRatio(30))];
        [_highestScoreLabel runAction:self.fadeAction];
    }
    return _highestScoreLabel;
}

- (SKAction *)fadeAction{
    if (_fadeAction == nil) {
        _fadeAction = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction fadeAlphaTo:0.5 duration:5],[SKAction fadeAlphaTo:1.0 duration:0.5]]]];
    }
    return _fadeAction;
}
@end
