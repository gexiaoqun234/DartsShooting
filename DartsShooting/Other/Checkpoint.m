//
//  Checkpoint.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/22.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "Checkpoint.h"

@implementation Checkpoint

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeInteger:self.checkpointCount forKey:@"checkpointCount"];
    [aCoder encodeInteger:self.knifes forKey:@"knifes"];
    [aCoder encodeInteger:self.apples forKey:@"apples"];
    [aCoder encodeObject:self.applesCoordinates forKey:@"applesCoordinates"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.checkpointCount = [aDecoder decodeIntegerForKey:@"checkpointCount"];
        self.knifes = [aDecoder decodeIntegerForKey:@"knifes"];
        self.apples = [aDecoder decodeIntegerForKey:@"apples"];
        self.applesCoordinates = [aDecoder decodeObjectForKey:@"applesCoordinates"];
    }
    return self;
}

// 角度转弧度，逆时针
CGFloat arc(CGFloat angle) {
    return angle * (M_PI / 180);
}

// 一个有12个苹果可以放置
- (NSArray *)applesCoordinates{
    
    CGFloat r = TWScreenWidth * 0.25;
    CGFloat shortSide = r * sin(M_PI / 6.0);
    CGFloat longSide = r * cos(M_PI / 6.0);
    NSString * shortSideStr = [NSString stringWithFormat:@"%.2f",shortSide];
    NSString * longSideStr = [NSString stringWithFormat:@"%.2f",longSide];
    // 负数
    NSString * shortSideStr_n = [NSString stringWithFormat:@"%.2f",-shortSide];
    NSString * longSideStr_n = [NSString stringWithFormat:@"%.2f",-longSide];
    
    // 分4个象限，逆时针放置，从顶点开始，一共12个点
    NSDictionary * dic1 = @{CoordinatesX:@"0",CoordinatesY:[NSString stringWithFormat:@"%.2f",r],CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(0)]};
    NSDictionary * dic2 = @{CoordinatesX:shortSideStr_n,CoordinatesY:longSideStr,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(30)]};
    NSDictionary * dic3 = @{CoordinatesX:longSideStr_n,CoordinatesY:shortSideStr,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(60)]};
    NSDictionary * dic4 = @{CoordinatesX:[NSString stringWithFormat:@"%.2f",-r],CoordinatesY:@"0",CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(90)]};
    NSDictionary * dic5 = @{CoordinatesX:longSideStr_n,CoordinatesY:shortSideStr_n,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(120)]};
    NSDictionary * dic6 = @{CoordinatesX:shortSideStr_n,CoordinatesY:longSideStr_n,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(150)]};
    NSDictionary * dic7 = @{CoordinatesX:@"0",CoordinatesY:[NSString stringWithFormat:@"%.2f",-r],CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(180)]};
    NSDictionary * dic8 = @{CoordinatesX:shortSideStr,CoordinatesY:longSideStr_n,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(210)]};
    NSDictionary * dic9 = @{CoordinatesX:longSideStr,CoordinatesY:shortSideStr_n,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(240)]};
    NSDictionary * dic10 = @{CoordinatesX:[NSString stringWithFormat:@"%.2f",r],CoordinatesY:@"0",CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(270)]};
    NSDictionary * dic11 = @{CoordinatesX:longSideStr,CoordinatesY:shortSideStr,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(300)]};
    NSDictionary * dic12 = @{CoordinatesX:shortSideStr,CoordinatesY:longSideStr,CoordinatesZRotation:[NSString stringWithFormat:@"%.2f",arc(330)]};
    NSArray * coordinatesArray = @[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12];
    return coordinatesArray;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"第%ld关，刀有%ld把，苹果有%ld个",(long)_checkpointCount,(long)_knifes,(long)_apples];
}
@end
