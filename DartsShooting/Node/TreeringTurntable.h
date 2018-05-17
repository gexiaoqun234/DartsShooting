//
//  TreeringTurntable.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/14.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TreeringTurntable : SKSpriteNode
- (CGPoint)getnodePoint;
- (void)addNode:(SKSpriteNode *)node point:(CGPoint)point;
- (void)addNode:(SKNode *)node size:(CGSize)size;
@end
