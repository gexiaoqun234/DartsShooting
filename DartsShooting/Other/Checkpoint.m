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


- (NSString *)description{
    return [NSString stringWithFormat:@"当前是第%ld关，可以发射的刀有%ld把，可以获取%ld个苹果，苹果的坐标数组为%@",_checkpointCount,_knifes,_apples,_applesCoordinates];
}
@end
