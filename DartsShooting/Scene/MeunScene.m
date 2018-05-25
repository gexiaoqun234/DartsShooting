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
@property (nonatomic, strong) SKSpriteNode * buyNode;

// 蒙版背景
@property (nonatomic, strong) SKSpriteNode * maskNode;
@property (nonatomic, strong) SKSpriteNode * buyKnifeNode;
@property (nonatomic, strong) SKSpriteNode * chooesNode;
@property (nonatomic, strong) SKSpriteNode * appleNode;
@property (nonatomic, strong) SKLabelNode * appleCountNode;
@property (nonatomic, strong) SKSpriteNode * currentKnife;
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, strong) SKLabelNode * tipNode;
@end

@implementation MeunScene

- (void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
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


// 重置关卡
- (void)initializeData{
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < CheckpointCount; i++) {
        Checkpoint * point = [[Checkpoint alloc]init];
        point.checkpointCount = 1 + i;
        if (i > (CheckpointCount - 10)) {
            point.knifes = arc4random() % 19 + 2;
            point.apples = arc4random() % 6;
        } else if (i > (CheckpointCount - 20)) {
            point.knifes = arc4random() % 16 + 2;
            point.apples = arc4random() % 6 + 1;
        } else if (i > (CheckpointCount - 30)) {
            point.knifes = arc4random() % 13 + 1;
            point.apples = arc4random() % 4 + 1;
        } else if (i > (CheckpointCount - 40)) {
            point.knifes = arc4random() % 10 + 1;
            point.apples = arc4random() % 2 + 1;
        } else {
            point.knifes = arc4random() % 7 + 1;
            point.apples = arc4random() % 2;
        }
        [dataArray addObject:point];
//        NSLog(@"%@",point.description);
    }
    [[GameTool shareManager] saveCheckpoint:dataArray];
    
    // 每次开启重置当前分数
    [[GameTool shareManager] saveCurrentScore:0];
    // 保存总关卡数
    [[GameTool shareManager] saveCheckpointCount:CheckpointCount];
    // 当前关卡清到1
    [[GameTool shareManager] saveCheckpointNumber:1];
}

#pragma mark - --------点击事件--------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode * node = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    if ([node.name isEqualToString:LockNode]) return;
    if ([node.name isEqualToString:StartName]){
        [self initializeData];
        if ([[GameTool shareManager] getMusicState]) {
            [self runAction:[SKAction playSoundFileNamed:@"clickVoide.mp3" waitForCompletion:YES]];
        }
        GameScene * gameScene = [[GameScene alloc]initWithSize:self.size];
        SKTransition * transition = [SKTransition fadeWithColor:GAMEBGCOLOR duration:BrokenTime];
        [self.view presentScene:gameScene transition:transition];
    } else if ([node.name isEqualToString:Music]){
        BOOL showMusic = [[GameTool shareManager] getMusicState];
        if (!showMusic) {
            [self runAction:[SKAction playSoundFileNamed:@"clickVoide.mp3" waitForCompletion:YES]];
            self.musicNode.texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet0"];
            [[GameTool shareManager] saveMusicState:YES];
        } else {
            // 不显示音乐
            self.musicNode.texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet1"];
            [[GameTool shareManager] saveMusicState:NO];
        }
        showMusic = !showMusic;
    } else if ([node.name isEqualToString:Buy]){
        if ([[GameTool shareManager] getMusicState]) {
            [self runAction:[SKAction playSoundFileNamed:@"clickVoide.mp3" waitForCompletion:YES]];
        }
        [self addChild:self.maskNode];
    } else {
        
#pragma mark - --------点击关闭蒙版--------
        if ([node.name isEqualToString:BackNode]) {
            // 保存下选中的
//            if ([self.chooesNode.parent.name isEqualToString:DefaultKnife]) {
//                [[GameTool shareManager] saveChooesKnife:DefaultKnife];
//            }else if ([self.chooesNode.parent.name isEqualToString:OneKnife]){
//                [[GameTool shareManager] saveChooesKnife:OneKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:TwoKnife]){
//                [[GameTool shareManager] saveChooesKnife:TwoKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:ThreeKnife]){
//                [[GameTool shareManager] saveChooesKnife:ThreeKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:FourKnife]){
//                [[GameTool shareManager] saveChooesKnife:FourKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:FiveKnife]){
//                [[GameTool shareManager] saveChooesKnife:FiveKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:SixKnife]){
//                [[GameTool shareManager] saveChooesKnife:SixKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:SevenKnife]){
//                [[GameTool shareManager] saveChooesKnife:SevenKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:EightKnife]){
//                [[GameTool shareManager] saveChooesKnife:EightKnife];
//            } else if ([self.chooesNode.parent.name isEqualToString:NineKnife]){
//                [[GameTool shareManager] saveChooesKnife:NineKnife];
//            }
            
            if ([[GameTool shareManager] getMusicState]) {
                [self runAction:[SKAction playSoundFileNamed:@"clickVoide.mp3" waitForCompletion:YES]];
            }
            [[GameTool shareManager] saveChooesKnife:self.chooesNode.parent.name];
            [self.titleNode resetTitleNodeTexture];
            // 然后再关闭
            [self.maskNode removeFromParent];
        } else if ([node.name isEqualToString:@"ChooesNode"]){
            if ([[GameTool shareManager] getMusicState]) {
                [self runAction:[SKAction playSoundFileNamed:@"choose.mp3" waitForCompletion:YES]];
            }
            // 重复点击，直接返回
            return;
        
#pragma mark - --------下面是点击购买刀--------
            /* 注意：
             不能直接在else里面写，因为我是分的五行，那么每行底层node都会响应这个点击。
             要么每个使用else if（node==@""）单独写，要么将其他的排除掉，再将选择刀的那些集中写。
             */
        } else if ([node.name isEqualToString:DefaultKnife]) {
            // 这个是默认送的刀
            [self unlockState:node];
        }else if ([node.name isEqualToString:OneKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal1"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:TwoKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal2"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:ThreeKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal3"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:FourKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal4"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:FiveKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal5"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:SixKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal6"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:SevenKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal7"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:EightKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal8"];
            } else {
                [self unlockState:node];
            }
        } else if ([node.name isEqualToString:NineKnife]){
            if (![self inspectionKnife:(LockKnifeNode *)node]) {
                [self buyNewKnife:(LockKnifeNode *)node newKnife:@"knife_nomal9"];
            } else {
                [self unlockState:node];
            }
        }
    }
}

- (void)unlockState:(SKSpriteNode *)node{
    if ([[GameTool shareManager] getMusicState]) {
        [self runAction:[SKAction playSoundFileNamed:@"choose.mp3" waitForCompletion:YES]];
    }
    
    // 添加选择背景
    [self.chooesNode removeFromParent];
    [node addChild:self.chooesNode];
    // 清除提示
    [self.tipNode removeAllActions];
    [self.tipNode removeFromParent];
}

// 使用游戏币购买新的刀
- (void)buyNewKnife:(LockKnifeNode *)node newKnife:(NSString *)name{
    // 清除提示
    [self.tipNode removeAllActions];
    [self.tipNode removeFromParent];
    
    NSInteger money = [[GameTool shareManager] getGameMoney];
    if (money >= 10) {
        
        if ([[GameTool shareManager] getMusicState]) {
            [self runAction:[SKAction playSoundFileNamed:@"choose.mp3" waitForCompletion:YES]];
        }
        
        
        // 1扣钱
        money -= 10;
        // 2解锁
        [self.chooesNode removeFromParent];
        [node unLockKnifeNodeWith:name];
        [node addChild:self.chooesNode];
        // 3保存新的余额
        [[GameTool shareManager] saveGameMoney:money];
        // 4保存进以解锁的刀
        [[GameTool shareManager] saveUnlockKnife:node.name];
        // 5显示新的余额
        self.appleCountNode.text = [NSString stringWithFormat:@"%ld",(long)money];
    } else {
        
        if ([[GameTool shareManager] getMusicState]) {
            [self runAction:[SKAction playSoundFileNamed:@"lost.mp3" waitForCompletion:YES]];
        }
        
        
        // 提示钱不够
        [self.maskNode addChild:self.tipNode];
        __weak typeof(self) weakSelf = self;
        [self.tipNode runAction:[SKAction repeatAction:[SKAction sequence:@[[SKAction scaleTo:1.1 duration:0.5],[SKAction scaleTo:1 duration:0.5]]] count:2] completion:^{
            [weakSelf.tipNode removeFromParent];
        }];
    }
}

#pragma mark - --------懒加载--------
#pragma mark - --------蒙版层内容--------
- (SKSpriteNode *)maskNode{
    if (_maskNode == nil) {
        _maskNode = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:0.7] size:self.size];
        _maskNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
        _maskNode.zPosition = MaskBGzposition;
        [_maskNode addChild:self.buyKnifeNode];
        [_maskNode addChild:self.appleNode];
        [_maskNode addChild:self.appleCountNode];
    }
    return _maskNode;
}

// 总游戏币数目
- (SKSpriteNode *)appleNode{
    if (_appleNode == nil) {
        _appleNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"appleicon-sheet0"] size:CGSizeMake(appleW, appleH)];
        _appleNode.zPosition = Scorezposition;
        _appleNode.position = CGPointMake(-appleW,TWScreenWidth * 0.8 * 0.5 + appleH);
    }
    return _appleNode;
}

- (SKLabelNode *)appleCountNode{
    if (_appleCountNode == nil) {
        CGFloat textW = [SKLabelNode calculateTheLengthOfTextWithText:BestScore fontName:DefaultFontName fontSize:TW_SizeRatio(30)].width;
        _appleCountNode = [SKLabelNode createLabelNodeWithText:[NSString stringWithFormat:@"%ld",(long)[[GameTool shareManager] getGameMoney]] withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:TWColorRGB(222, 55, 44) withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(appleW + textW * 0.5,TWScreenWidth * 0.8 * 0.5 + appleH - TW_SizeRatio(5))];
    }
    return _appleCountNode;
}

- (SKLabelNode *)tipNode{
    if (_tipNode == nil) {
        _tipNode = [SKLabelNode createLabelNodeWithText:@"apple insufficient" withVerticalAlignmentMode:(SKLabelVerticalAlignmentModeCenter) withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentModeCenter) withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition:CGPointMake(0, - TWScreenHeight * 0.35)];
        _tipNode.name = @"TipNode";
    }
    return _tipNode;
}


// 树轮中内容
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
        [twoLayer addChild:firstKnife];
        
        LockKnifeNode * oneKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select1" position:CGPointMake(0, 0) name:OneKnife];
        if ([self inspectionKnife:oneKnife]) {
            [oneKnife unLockKnifeNodeWith:@"knife_nomal1"];
        }
        [twoLayer addChild:oneKnife];
        
        LockKnifeNode * twoKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select2" position:CGPointMake(height, 0) name:TwoKnife];
        if ([self inspectionKnife:twoKnife]) {
            [twoKnife unLockKnifeNodeWith:@"knife_nomal2"];
        }
        [twoLayer addChild:twoKnife];
        [_buyKnifeNode addChild:twoLayer];
        
        
        SKSpriteNode * threeLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        threeLayer.position = CGPointMake(0, 0);
        
        // 添加4~7把剑
        LockKnifeNode * threeKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select3" position:CGPointMake(-height * 1.5, 0) name:ThreeKnife];
        if ([self inspectionKnife:threeKnife]) {
            [threeKnife unLockKnifeNodeWith:@"knife_nomal3"];
        }
        [threeLayer addChild:threeKnife];
        
        LockKnifeNode * fourKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select4" position:CGPointMake(-height * 0.5, 0) name:FourKnife];
        if ([self inspectionKnife:fourKnife]) {
            [fourKnife unLockKnifeNodeWith:@"knife_nomal4"];
        }
        [threeLayer addChild:fourKnife];
        
        LockKnifeNode * fiveKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select5" position:CGPointMake(height * 1.5, 0) name:FiveKnife];
        if ([self inspectionKnife:fiveKnife]) {
            [fiveKnife unLockKnifeNodeWith:@"knife_nomal5"];
        }
        [threeLayer addChild:fiveKnife];
        
        LockKnifeNode * sixKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select6" position:CGPointMake(height * 0.5, 0) name:SixKnife];
        if ([self inspectionKnife:sixKnife]) {
            [sixKnife unLockKnifeNodeWith:@"knife_nomal6"];
        }
        [threeLayer addChild:sixKnife];
        [_buyKnifeNode addChild:threeLayer];
        

        SKSpriteNode * fourLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        fourLayer.position = CGPointMake(0, -height);
        
        // 添加8~10把剑
        LockKnifeNode * sevenKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select7" position:CGPointMake(-height, 0) name:SevenKnife];
        if ([self inspectionKnife:sevenKnife]) {
            [sevenKnife unLockKnifeNodeWith:@"knife_nomal7"];
        }
        [fourLayer addChild:sevenKnife];
        
        LockKnifeNode * eightKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select8" position:CGPointMake(0, 0) name:EightKnife];
        if ([self inspectionKnife:eightKnife]) {
            [eightKnife unLockKnifeNodeWith:@"knife_nomal8"];
        }
        [fourLayer addChild:eightKnife];
        
        LockKnifeNode * nineKnife = [LockKnifeNode createKnifeNodeWith:@"knife_select9" position:CGPointMake(height, 0) name:NineKnife];
        if ([self inspectionKnife:nineKnife]) {
            [nineKnife unLockKnifeNodeWith:@"knife_nomal9"];
        }
        [fourLayer addChild:nineKnife];
        
        [_buyKnifeNode addChild:fourLayer];
        
        // 最下面那部分
        SKSpriteNode * fiveLayer = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.8, height)];
        fiveLayer.position = CGPointMake(0, -height * 2);
        
        SKSpriteNode * backNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"okbtn-sheet0"] size:CGSizeMake(height * 0.7, height * 0.7)];
        backNode.position = CGPointMake(0, TW_SizeRatio(5));
        backNode.name = BackNode;
        [fiveLayer addChild:backNode];
        [_buyKnifeNode addChild:fiveLayer];
        
        [self selectStateSettings];
    }
    return _buyKnifeNode;
}

// 将上次最后一个选中的刀设置为默认选中状态
- (void)selectStateSettings{
    NSString * name = [[GameTool shareManager] getChooesKnife];
    for (SKSpriteNode * node in self.buyKnifeNode.children) {
        for (LockKnifeNode * selectKnife in node.children) {
            if ([selectKnife.name isEqualToString:name]) {
                [self.chooesNode removeFromParent];
                [selectKnife addChild:self.chooesNode];
            }
        }
    }
}

// 检查当前刀是否被解锁过
- (BOOL)inspectionKnife:(LockKnifeNode *)knife{
    // 先查看哪些是已经解锁过的
    NSArray * unlockKnife = [[GameTool shareManager] getUnlockKnife];
    if ([unlockKnife containsObject:knife.name]) {
        return YES;
    } else {
        return NO;
    }
}

// 确认选中按钮
- (SKSpriteNode *)chooesNode{
    if (_chooesNode == nil) {
        _chooesNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"select-sheet0"] size:CGSizeMake(BuyKnifeTextureWH, BuyKnifeTextureWH)];
        _chooesNode.name = @"ChooesNode";
    }
    return _chooesNode;
}

#pragma mark - --------音乐和购买按钮--------
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
        SKTexture * texture;
        if ([[GameTool shareManager] getMusicState]) {
            texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet0"];
        } else {
            texture = [SKTexture textureWithImageNamed:@"soundbtn-sheet1"];
        }
        _musicNode = [[SKSpriteNode alloc]initWithTexture:texture];
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

#pragma mark - --------标题部分--------
- (TitltNode *)titleNode{
    if (_titleNode == nil) {
        CGFloat w = TWScreenWidth / 5 * 4.0;
        CGFloat h = w * 340 / 580.0;
        _titleNode = [[TitltNode alloc]initWithColor:[SKColor clearColor] size:CGSizeMake(w, h)];
        _titleNode.position = CGPointMake(TWScreenWidth* 0.5, TW_SizeRatio(40) + h * 0.5);
    }
    return _titleNode;
}

// 开始按钮
- (SKSpriteNode *)startNode{
    if (_startNode == nil) {
        _startNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"playbtn-sheet0"] size:CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2)];
        _startNode.zPosition = Startzposition;
        _startNode.name = StartName;
        [_startNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleTo:1.1 duration:0.5],[SKAction scaleTo:1 duration:0.5]]]]];
    }
    return _startNode;
}

// 树轮
- (TreeringTurntable *)treeringTurntable{
    if (_treeringTurntable == nil) {
        _treeringTurntable = [[TreeringTurntable alloc]initWithColor:self.backgroundColor size:CGSizeMake(TWScreenWidth * 0.5, TWScreenWidth * 0.5)];
        _treeringTurntable.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
        [_treeringTurntable addChild:self.startNode];
    }
    return _treeringTurntable;
}

#pragma mark - --------分数相关--------
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
        _lastScore = [SKLabelNode createLabelNodeWithText:[NSString stringWithFormat:@"%ld",(long)[[GameTool shareManager] getCurrentScore]] withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth * 0.75, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5 - TW_SizeRatio(30))];
        [_lastScore runAction:self.fadeAction];
    }
    return _lastScore;
}

- (SKLabelNode *)highestScoreLabel{
    if (_highestScoreLabel == nil) {
        _highestScoreLabel = [SKLabelNode createLabelNodeWithText:[NSString stringWithFormat:@"%ld",(long)[[GameTool shareManager] getBestScore]] withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth * 0.25, TWScreenHeight - (TWScreenHeight - (TWScreenHeight * 0.7 + TWScreenWidth * 0.25)) * 0.5 - TW_SizeRatio(30))];
        [_highestScoreLabel runAction:self.fadeAction];
    }
    return _highestScoreLabel;
}

#pragma mark - --------动作--------
- (SKAction *)fadeAction{
    if (_fadeAction == nil) {
        _fadeAction = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction fadeAlphaTo:0.5 duration:5],[SKAction fadeAlphaTo:1.0 duration:0.5]]]];
    }
    return _fadeAction;
}


@end
