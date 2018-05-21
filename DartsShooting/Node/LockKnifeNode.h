//
//  LockKnifeNode.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LockKnifeNode : SKSpriteNode

+ (instancetype)createKnifeNodeWith:(NSString *)knifeName position:(CGPoint)position name:(NSString *)name;

- (void)unLockKnifeNodeWith:(NSString *)textureName;

@end
