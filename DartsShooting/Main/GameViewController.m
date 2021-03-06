//
//  GameViewController.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameViewController.h"
#import "MeunScene.h"

@implementation GameViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MeunScene * menuScene = [[MeunScene alloc]initWithSize:CGSizeMake(TWScreenWidth, TWScreenHeight)];
    SKView * spriteView = (SKView *)self.view;
    [spriteView presentScene:menuScene];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView * spriteView = (SKView *)self.view;
    spriteView.showsFPS = YES;              // 显示帧数
    spriteView.showsDrawCount = YES;        // 显示当前绘画次数
    spriteView.showsNodeCount = YES;        // 显示当前节点的数量
//    spriteView.showsPhysics = YES;
    
    // 初始化几个数据
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:IsFirst];
    if (isFirst) {
//        NSLog(@"不是第一次开启");
    } else {
//        NSLog(@"第一次开启设置初始值");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsFirst];
        [[GameTool shareManager] saveBestScore:0];
        [[GameTool shareManager] saveGameMoney:100];
        [[GameTool shareManager] saveChooesKnife:DefaultKnife];
        [[GameTool shareManager] saveCurrentScore:0];
        [[GameTool shareManager] saveUnlockKnife:@""];
        [[GameTool shareManager] saveCheckpointNumber:1];
        [[GameTool shareManager] saveMusicState:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
