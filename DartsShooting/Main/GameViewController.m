//
//  GameViewController.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "GameViewController.h"
#import "PlayScene.h"
#import "TEMP.h"

@implementation GameViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TEMP * playScene = [[TEMP alloc]initWithSize:CGSizeMake(TWScreenWidth, TWScreenHeight)];
    SKView * spriteView = (SKView *)self.view;
    [spriteView presentScene:playScene];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView * spriteView = (SKView *)self.view;
    spriteView.showsFPS = YES;              // 显示帧数
    spriteView.showsDrawCount = YES;        // 显示当前绘画次数
    spriteView.showsNodeCount = YES;        // 显示当前节点的数量
    spriteView.showsPhysics = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



@end
