//
//  GameScene.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameScene.h"
#import "TreeringTurntable.h"
#import "KnifeNode.h"
#import "BackgroundNode.h"
#import "MeunScene.h"
#import "IndicatorNode.h"
#import "BrokenNode.h"
#import "AppleNode.h"

@interface GameScene()<SKPhysicsContactDelegate>
@property (nonatomic, strong) TreeringTurntable * treeringTurntable;
@property (nonatomic, strong) NSMutableArray <KnifeNode *> * knifeNodeArray;
@property (nonatomic, assign) BOOL allRotate;// 用来标识所有的刀是否都被发射出去了
@property (nonatomic, strong) SKEmitterNode * appleShootingEmitter;
@property (nonatomic, strong) SKEmitterNode * tuckedInEmitter;  // 扎进去
@property (nonatomic, strong) SKEmitterNode * knifeBrokenEmitter;
@property (nonatomic, strong) SKSpriteNode * appleNode;
@property (nonatomic, strong) SKLabelNode * appleCountNode;
@property (nonatomic, strong) SKLabelNode * scoreLabel;
@property (nonatomic, strong) SKLabelNode * historyHighestScoreLabel;// 历史最高分label
@property (nonatomic, strong) SKLabelNode * highestScoreLabel;// 历史最高分分数
@property (nonatomic, strong) SKAction * fadeAction;

@property (nonatomic, strong) IndicatorNode * indicatorNode;// 指示器

@property (nonatomic, assign) NSInteger currentScore;
@property (nonatomic, assign) NSInteger appleCount;
@property (nonatomic, strong) SKSpriteNode * pauseNode;

@property (nonatomic, strong) SKSpriteNode * maskNode;
@property (nonatomic, strong) SKSpriteNode * continueNode;
@property (nonatomic, strong) SKSpriteNode * homeNode;

@property (nonatomic, assign) NSUInteger currentCheckpointNum;//当前关卡数
@property (nonatomic, strong) Checkpoint * currentCheckpoint;//当前关卡对象
@property (nonatomic, assign) BOOL currentCheckpointComplete;//当前关卡已经完成

@property (nonatomic, assign) NSInteger shootKnife;

@property (nonatomic, strong) BrokenNode * brokenNode;

@property (nonatomic, strong) SKSpriteNode * gameoverNode;
@end

@implementation GameScene

#pragma mark - --------系统回调函数--------
- (void)didMoveToView:(SKView *)view{
    self.backgroundColor = GAMEBGCOLOR;
    _shootKnife = 0;
    _currentScore = 0;
    _appleCount = [[GameTool shareManager] getGameMoney];
    // 获取关卡
    _currentCheckpointNum = 0;
    _currentCheckpointComplete = NO;
    _currentCheckpoint = [[GameTool shareManager] getCheckpoint:_currentCheckpointNum];
    // 初始设置基础内容
    [self resetCheckpointContent];
    
    // 设置背景
    [self addChild:[BackgroundNode initializeBackgroundNode]];
    // 添加树轮
    [self addChild:self.treeringTurntable];
    [self.treeringTurntable run];
    // 添加第一把刀
    [self addChild:[self.knifeNodeArray firstObject]];
    // 计数器
    [self addChild:self.indicatorNode];
    // 添加游戏币
    [self addChild:self.appleNode];
    [self addChild:self.appleCountNode];
    // 添加得分
    [self addChild:self.scoreLabel];
    [self addChild:self.historyHighestScoreLabel];
    [self addChild:self.highestScoreLabel];
    // 添加暂停按钮
    [self addChild:self.pauseNode];
    
    _allRotate = NO;
    
    // 添加特效
    [self addChild:self.tuckedInEmitter];
    [self.tuckedInEmitter setHidden:YES];
    [self addChild:self.appleShootingEmitter];
    [self.appleShootingEmitter setHidden:YES];
    [self addChild:self.knifeBrokenEmitter];
    [self.knifeBrokenEmitter setHidden:YES];
    
    // 物理特性
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = WordCategory;
}

- (void)update:(NSTimeInterval)currentTime{
    if (_currentCheckpointComplete) {
        // 关卡数加1
        _currentCheckpointNum++;
        // 重设基础内容
        [self resetCheckpointContent];
    }
}

// 重设基础内容
- (void)resetCheckpointContent{
    // 刀的数量重置
    [self.indicatorNode setIndicatorNode:_currentCheckpoint.knifes];
    // 苹果的摆放位置
    [self.treeringTurntable addApple:_currentCheckpoint.applesCoordinates];
}

// 增加刀飞舞的效果
- (void)addKnifeFly{
    // 这是树轮所在的区间
    CGFloat maxX = TWScreenWidth * 0.75;
    CGFloat minX = TWScreenWidth * 0.25;
    CGFloat maxY = TWScreenHeight * 0.7 + minX;
    CGFloat minY = TWScreenHeight * 0.7 - minX;
    
    for (NSInteger i = 0; i < _currentCheckpoint.knifes; i++) {
        NSInteger randomX = [self getRandomNumber:minX to:maxX];
        NSInteger randomY = [self getRandomNumber:minY to:maxY];
        NSInteger randomIR = [self getRandomAngle];
        NSInteger randomR = [self getRandomAngle];
        SKTexture * texture = [SKTexture textureWithImageNamed:[[GameTool shareManager] getChooesKnife]];
        SKSpriteNode * knifeNode = [[SKSpriteNode alloc]initWithTexture:texture color:[UIColor whiteColor] size:CGSizeMake(texture.size.width * TWScreenWidth * 0.25 / texture.size.height, TWScreenWidth * 0.25)];
        knifeNode.position = CGPointMake(randomX,randomY);
//        [knifeNode runAction:[SKAction rotateByAngle:randomR duration:0]];
        knifeNode.zRotation = randomR;
        [self addChild:knifeNode];
        [knifeNode runAction:[SKAction group:@[[SKAction rotateByAngle:randomIR duration:BrokenTime],[SKAction fadeOutWithDuration:BrokenTime]]] completion:^{
            [knifeNode removeFromParent];
            [knifeNode removeAllActions];
        }];
    }
}

// 获取自from到to的随机整数值
- (NSInteger)getRandomNumber:(int)from to:(int)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

// 随机一个刀的角度
- (CGFloat)getRandomAngle{
    NSInteger randomN = arc4random() % 10 + 1;
    CGFloat randomNu = randomN / 10.0;
    CGFloat mun = M_PI * 2 * randomNu;
    return mun;
}

#pragma mark - --------SKPhysicsContactDelegate--------
- (void)didBeginContact:(SKPhysicsContact *)contact{
    if (contact.bodyA.categoryBitMask == KnifeCategory && contact.bodyB.categoryBitMask == KnifeCategory) {
        // 移调那两把刀
        [(KnifeNode *)contact.bodyA.node removeFromParent];
        [(KnifeNode *)contact.bodyB.node removeFromParent];
        [(KnifeNode *)contact.bodyA.node removeAllActions];
        [(KnifeNode *)contact.bodyB.node removeAllActions];
        
        
        // 刀碰撞的效果
        [self.tuckedInEmitter setHidden:YES];
        [self.knifeBrokenEmitter setHidden:NO];
        [self.knifeBrokenEmitter resetSimulation];
        
        // 保存数据游戏结束
        [self.treeringTurntable stop];
        [self.knifeNodeArray[0] stop];
        // 保存当前得分
        [[GameTool shareManager] saveCurrentScore:_currentScore];
        [[GameTool shareManager] saveBestScore:_currentScore];
        
        
//        [self addChild:self.gameoverNode];
        // 跳转到首页
//        MeunScene * meunScene = [[MeunScene alloc]initWithSize:self.size];
//        [self.gameoverNode runAction:[SKAction fadeOutWithDuration:2.0] completion:^{
//            [self.view presentScene:meunScene];
//        }];
    }
    
    if (contact.bodyA.categoryBitMask == AppleCategory || contact.bodyB.categoryBitMask == AppleCategory) {
    
        AppleNode * apple;
        if (contact.bodyA.categoryBitMask == AppleCategory) {
            apple = (AppleNode *)contact.bodyA.node;
        } else {
            apple = (AppleNode *)contact.bodyB.node;
        }
        [apple removeFromParent];
        
        [self.tuckedInEmitter setHidden:YES];
        [self.knifeBrokenEmitter setHidden:YES];
        [self.appleShootingEmitter setHidden:NO];
        [self.appleShootingEmitter resetSimulation];
        
        // 增加游戏币
        _appleCount++;
        self.appleCountNode.text = [NSString stringWithFormat:@"%ld",_appleCount];
        // 保存游戏币
        [[GameTool shareManager] saveGameMoney:_appleCount];
    }
    
//    if (contact.bodyA.categoryBitMask == TreeringTurntableCategory || contact.bodyB.categoryBitMask == TreeringTurntableCategory) {

//        NSLog(@"**");
//
//        _currentScore++;
//        _scoreLabel.text = [NSString stringWithFormat:@"%ld",_currentScore];
//
//        // 保存当前得分
//        [[GameTool shareManager] saveCurrentScore:_currentScore];
//        [[GameTool shareManager] saveBestScore:_currentScore];
//    }
}

#pragma mark - --------点击事件--------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode * node = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    if ([node.name isEqualToString:Pause]) {
        [self.treeringTurntable stop];
        if (_allRotate == NO) {
            [self.knifeNodeArray[0] stop];
        }
        [self addChild:self.maskNode];
    } else if ([node.name isEqualToString:Continue]) {
        [self.treeringTurntable run];
        if (_allRotate == NO) {
            [self.knifeNodeArray[0] run];
        }
        [self.maskNode removeFromParent];
    } else if ([node.name isEqualToString:Home]) {
        [[GameTool shareManager] saveCurrentScore:_currentScore];
        [[GameTool shareManager] saveBestScore:_currentScore];
        MeunScene * meunScene = [[MeunScene alloc]initWithSize:self.size];
        [self.view presentScene:meunScene];
    } else {
        // 点击发射刀
        if (_allRotate == NO) {
            [self.knifeNodeArray[0] runAction:[SKAction moveTo:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - (TWScreenWidth * 0.5) * 0.5 - TW_SizeRatio(74) * 0.8) duration:0.2] completion:^{
                
                [self.tuckedInEmitter setHidden:NO];
                [self.tuckedInEmitter resetSimulation];
                
                // 从当前场景移除，并且移除自带的动作
                [self.knifeNodeArray[0] removeAllActions];
                [self.knifeNodeArray[0] removeFromParent];
                
                
                // 不需要管越界，因为发射完旧不会进到这里
                self.shootKnife++;
                //计数器减1
                [self.indicatorNode resetIndicatorNodeAllCount:self.currentCheckpoint.knifes userCount:self.shootKnife];
                
                
#pragma mark - --------计算夹角的弧度--------
                // *******计算夹角的弧度*******
                // 计算得出当前转盘上那个标记节点的的绝对坐标(跟随转盘会不停旋转)
                CGPoint point1 = [self convertPoint:CGPointMake(0, -self.treeringTurntable.size.height * 0.5) fromNode:self.treeringTurntable];
                
                // 设置出固定坐标
                CGPoint fixedPoint = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
                
                // 计算夹角对边的长度
                // 1计算三角形竖线的长度
                double tothesideY = fabs(fixedPoint.y - point1.y);
                // 2计算三角形横线的长度
                double tothesideX = fabs(fixedPoint.x - point1.x);
                // 3勾股定理计算斜边长度
                double totheside = sqrt(pow(tothesideX, 2) + pow(tothesideY, 2));
                
                // 正弦值(这里只是计算的夹角的一半)
                double sinX = (totheside * 0.5) / (TWScreenWidth * 0.25);
                
                // 计算一半夹角的弧度
                double radians = asin(sinX);
                
                // 计算完整夹角的度数
                double angle = RADIANS_TO_DEGREES(radians) * 2;
                
                // 计算完整夹角的弧度
                double radians2 = DEGREES_TO_RADIANS(angle);
                
                /*
                 将弧度赋值给节点
                 这里要注意象限
                 在左半边的时候应该是赋值-radians2
                 在右半边的时候应该是赋值radians2
                 
                 
                 左右如何判断界定？
                 将转盘上的参照点转换成当前场景中的点，根据这个点坐标来进行判断
                 这个点上面计算过，就是point1
                 */
                if (point1.x >= TWScreenWidth * 0.5) {
                    self.knifeNodeArray[0].zRotation = -radians2;
                } else {
                    self.knifeNodeArray[0].zRotation = radians2;
                }
                
                
#pragma mark - --------计算位置--------
                /*
                 将本节点坐标系中的一个点转换为节点树中另一个节点的坐标系。
                 - (CGPoint)convertPoint:(CGPoint)point toNode:(SKNode *)node
                 
                 参数
                 point:本节点坐标系上的一个点
                 node:同一个节点树上的另一个节点
                 返回值    转换到其他节点坐标系的同一个点
                 
                 计算当前场景固定点的绝对坐标转换成转盘节点上的坐标系对应的坐标
                 */
                CGPoint point = [self convertPoint:CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25) toNode:self.treeringTurntable];
                
                self.knifeNodeArray[0].position = point;
                self.knifeNodeArray[0].anchorPoint = CGPointMake(0.5, 0.8);
                [self.treeringTurntable addChild:self.knifeNodeArray[0]];
                
                
                // 删除掉这个
                [self.knifeNodeArray removeObject:self.knifeNodeArray[0]];
                
                // 在添加新的第一个
                if (self.knifeNodeArray.count > 0) {
                    self.knifeNodeArray[0].position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(127));
                    [self addChild:self.knifeNodeArray[0]];
                }
                
                self.currentScore++;
                self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.currentScore];

                // 保存当前得分
                [[GameTool shareManager] saveCurrentScore:self.currentScore];
                [[GameTool shareManager] saveBestScore:self.currentScore];
                
                if (self.knifeNodeArray.count == 0) {
                    self.allRotate = YES;
//                    NSLog(@"全部发射完毕");

                    // 去掉树轮
                    [self.treeringTurntable removeAllChildren];
                    [self.treeringTurntable removeAllActions];
                    [self.treeringTurntable removeFromParent];
                    // 增加树轮破烂效果
                    [self addChild:self.brokenNode];
                    // 增加乱箭飞舞的效果
                    [self addKnifeFly];
                    
                    
                }
            }];
        }
    }
}

// element为节点，point表示绕某个点旋转，rad表示每帧的弧度
- (void)rotateByPoint:(SKNode *)element point:(CGPoint)point rad:(CGFloat)rad{
    CGPoint tempPos = element.position;
    CGFloat resultX = point.x + (tempPos.x - point.x) * cos(rad) - (tempPos.y - point.y) * sin(rad);
    CGFloat resultY = point.y + (tempPos.x - point.x) * sin(rad) + (tempPos.y - point.y) * cos(rad);
    //修改角度
    element.zRotation += rad;
    //修改位置
    CGPoint newPos = CGPointMake(resultX, resultY);
    element.position = newPos;
}

#pragma mark - --------懒加载--------
#pragma mark - --------刀和树根--------
- (TreeringTurntable *)treeringTurntable{
    if (_treeringTurntable == nil) {
        _treeringTurntable = [[TreeringTurntable alloc]initWithColor:self.backgroundColor size:CGSizeMake(TWScreenWidth * 0.5, TWScreenWidth * 0.5)];
        _treeringTurntable.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
    }
    return _treeringTurntable;
}

- (NSMutableArray<KnifeNode *> *)knifeNodeArray{
    if (_knifeNodeArray == nil) {
        _knifeNodeArray = [NSMutableArray array];
 
        // 创建刀
        for (NSInteger i = 0; i < _currentCheckpoint.knifes; i++) {
            SKTexture * texture = [SKTexture textureWithImageNamed:[[GameTool shareManager] getChooesKnife]];
            KnifeNode * knifeNode = [[KnifeNode alloc]initWithTexture:texture color:[UIColor clearColor] size:CGSizeMake(texture.size.width * TWScreenWidth * 0.25 / texture.size.height, TWScreenWidth * 0.25)];
            knifeNode.position = CGPointMake(TWScreenWidth * 0.5, TW_SizeRatio(127));
            knifeNode.anchorPoint = CGPointMake(0.5, 0);
            [_knifeNodeArray addObject:knifeNode];
        }
    }
    return _knifeNodeArray;
}

#pragma mark - --------蒙版层内容--------
- (SKSpriteNode *)maskNode{
    if (_maskNode == nil) {
        _maskNode = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:0.7] size:self.size];
        _maskNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
        _maskNode.zPosition = MaskBGzposition;
        [_maskNode addChild:self.continueNode];
        [_maskNode addChild:self.homeNode];
    }
    return _maskNode;
}

- (SKSpriteNode *)continueNode{
    if (_continueNode == nil) {
        _continueNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"resumebtn-sheet0"]];
        _continueNode.name = Continue;
        _continueNode.zPosition = HomeNodezposition;
        _continueNode.size = CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2);
        _continueNode.position = CGPointMake(TWScreenWidth * 0.2, 0);
    }
    return _continueNode;
}

- (SKSpriteNode *)homeNode{
    if (_homeNode == nil) {
        _homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"homebtn-sheet0"]];
        _homeNode.name = Home;
        _homeNode.zPosition = HomeNodezposition;
        _homeNode.size = CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2);
        _homeNode.position = CGPointMake(-TWScreenWidth * 0.2, 0);
    }
    return _homeNode;
}

- (SKSpriteNode *)gameoverNode{
    if (_gameoverNode == nil) {
        _gameoverNode = [[SKSpriteNode alloc]initWithColor:GAMEBGCOLOR size:self.size];
        _gameoverNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5);
        _gameoverNode.zPosition = Gameoverzposition;
    }
    return _gameoverNode;
}

#pragma mark - --------树轮击碎--------
- (BrokenNode *)brokenNode{
    if (_brokenNode == nil) {
        _brokenNode = [[BrokenNode alloc]initWithColor:[UIColor clearColor] size:CGSizeMake(TWScreenWidth * 0.5, TWScreenWidth * 0.5)];
        _brokenNode.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7);
    }
    return _brokenNode;
}


#pragma mark - --------指示器--------
- (IndicatorNode *)indicatorNode{
    if (_indicatorNode == nil) {
        _indicatorNode = [[IndicatorNode alloc]initWithColor:[UIColor clearColor] size:CGSizeMake(IndicatorNodeAllW, IndicatorNodeAllH)];
        _indicatorNode.position = CGPointMake(TWScreenWidth * 0.6, IndicatorNodeOneH);
    }
    return _indicatorNode;
}

- (SKSpriteNode *)creactNode:(CGPoint)position{
    CGFloat allW = TWScreenWidth * 0.6;
    CGFloat oneW = allW * 0.1;
    CGFloat oneH = 70 * oneW / 50.0;
    SKSpriteNode * one = [[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"whiteKnife"]];
    one.size = CGSizeMake(oneW, oneH);
    one.position = position;
    return one;
}

- (SKSpriteNode *)pauseNode{
    if (_pauseNode == nil) {
        _pauseNode = [[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"extrasbtn-sheet1"]];
        _pauseNode.size = CGSizeMake(TWScreenWidth * 0.2, TWScreenWidth * 0.2);
        _pauseNode.name = Pause;
        _pauseNode.zPosition = Pausezposition;
        _pauseNode.position = CGPointMake(TWScreenWidth * 0.2 * 0.5, TWScreenWidth * 0.2);
    }
    return _pauseNode;
}

#pragma mark - --------得分--------
- (SKLabelNode *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [SKLabelNode createLabelNodeWithText:@"0" withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(40) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth * 0.5, TWScreenHeight - TW_SizeRatio(60))];
    }
    return _scoreLabel;
}

- (SKLabelNode *)historyHighestScoreLabel{
    if (_historyHighestScoreLabel == nil) {
        CGFloat textW = [SKLabelNode calculateTheLengthOfTextWithText:BestScore fontName:DefaultFontName fontSize:TW_SizeRatio(20)].width;
        _historyHighestScoreLabel = [SKLabelNode createLabelNodeWithText:BestScore withVerticalAlignmentMode:(SKLabelVerticalAlignmentModeCenter) withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentModeCenter) withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(20) withFontName:DefaultFontName withPosition:CGPointMake(textW * 0.5 + TW_SizeRatio(10), TWScreenHeight - TW_SizeRatio(45))];
        [_historyHighestScoreLabel runAction:self.fadeAction];
    }
    return _historyHighestScoreLabel;
}

- (SKLabelNode *)highestScoreLabel{
    if (_highestScoreLabel == nil) {
        CGFloat textW = [SKLabelNode calculateTheLengthOfTextWithText:BestScore fontName:DefaultFontName fontSize:TW_SizeRatio(20)].width;
        _highestScoreLabel = [SKLabelNode createLabelNodeWithText:[NSString stringWithFormat:@"%ld",[[GameTool shareManager] getBestScore]] withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter withFontColor:[SKColor whiteColor] withFontSize:TW_SizeRatio(20) withFontName:DefaultFontName withPosition: CGPointMake(textW * 0.5 + TW_SizeRatio(10), TWScreenHeight - TW_SizeRatio(45) - TW_SizeRatio(20))];
        [_highestScoreLabel runAction:self.fadeAction];
    }
    return _highestScoreLabel;
}

#pragma mark - --------游戏币--------
- (SKSpriteNode *)appleNode{
    if (_appleNode == nil) {
        _appleNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"appleicon-sheet0"] size:CGSizeMake(appleW, appleH)];
        _appleNode.zPosition = Scorezposition;
        _appleNode.position = CGPointMake(TWScreenWidth - appleW, TWScreenHeight - appleH - TW_SizeRatio(20));
    }
    return _appleNode;
}

- (SKLabelNode *)appleCountNode{
    if (_appleCountNode == nil) {
        _appleCountNode = [SKLabelNode createLabelNodeWithText:[NSString stringWithFormat:@"%ld",[[GameTool shareManager] getGameMoney]] withVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter withHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft withFontColor:TWColorRGB(222, 55, 44) withFontSize:TW_SizeRatio(30) withFontName:DefaultFontName withPosition: CGPointMake(TWScreenWidth - 3 * appleW - TW_SizeRatio(10), TWScreenHeight - appleH - TW_SizeRatio(25))];
    }
    return _appleCountNode;
}

#pragma mark - --------特效懒加载--------
- (SKEmitterNode *)tuckedInEmitter{
    if (_tuckedInEmitter == nil) {
        _tuckedInEmitter = [SKEmitterNode nodeWithFileNamed:@"TuckedIn.sks"];
        _tuckedInEmitter.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
    }
    return _tuckedInEmitter;
}

- (SKEmitterNode *)appleShootingEmitter{
    if (_appleShootingEmitter == nil) {
        _appleShootingEmitter = [SKEmitterNode nodeWithFileNamed:@"AppleShooting.sks"];
        _appleShootingEmitter.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
    }
    return _appleShootingEmitter;
}

- (SKEmitterNode *)knifeBrokenEmitter{
    if (_knifeBrokenEmitter == nil) {
        _knifeBrokenEmitter = [SKEmitterNode nodeWithFileNamed:@"KnifeBroken.sks"];
        _knifeBrokenEmitter.particleTexture = [SKTexture textureWithImageNamed:[[GameTool shareManager] getChooesKnife]];
        _knifeBrokenEmitter.position = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.7 - TWScreenWidth * 0.25);
    }
    return _knifeBrokenEmitter;
}

#pragma mark - --------action懒加载--------
- (SKAction *)fadeAction{
    if (_fadeAction == nil) {
        _fadeAction = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction fadeAlphaTo:0.2 duration:5],[SKAction fadeAlphaTo:1.0 duration:0.5]]]];
    }
    return _fadeAction;
}

@end
