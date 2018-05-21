//
//  SKLabelNode+CreateLabel.h
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKLabelNode (CreateLabel)

// 快速创建一个label
+ (instancetype)createLabelNodeWithText:(NSString *)text withVerticalAlignmentMode:(SKLabelVerticalAlignmentMode)verticalMode withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentMode)horizontalMode withFontColor:(UIColor *)fontColor withFontSize:(CGFloat)fontSize withFontName:(NSString *)fontName withPosition:(CGPoint)position;

// 计算文本的尺寸
+ (CGSize)calculateTheLengthOfTextWithText:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;

@end
