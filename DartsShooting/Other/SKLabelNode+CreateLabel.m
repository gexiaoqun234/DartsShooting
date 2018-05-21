//
//  SKLabelNode+CreateLabel.m
//  DartsShooting
//
//  Created by 田伟 on 2018/5/21.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "SKLabelNode+CreateLabel.h"

@implementation SKLabelNode (CreateLabel)

+ (instancetype)createLabelNodeWithText:(NSString *)text withVerticalAlignmentMode:(SKLabelVerticalAlignmentMode)verticalMode withHorizontalAlignmentMode:(SKLabelHorizontalAlignmentMode)horizontalMode withFontColor:(UIColor *)fontColor withFontSize:(CGFloat)fontSize withFontName:(NSString *)fontName withPosition:(CGPoint)position{
    SKLabelNode * labelNode = [SKLabelNode labelNodeWithText:text];
    labelNode.verticalAlignmentMode = verticalMode;
    labelNode.horizontalAlignmentMode = horizontalMode;
    labelNode.fontColor = fontColor;
    labelNode.fontSize = fontSize;
    labelNode.fontName = fontName;
    labelNode.position = position;
    labelNode.zPosition = Scorezposition;
    return labelNode;
}

+ (CGSize)calculateTheLengthOfTextWithText:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize{
    return [text boundingRectWithSize:CGSizeMake(TWScreenWidth, TW_SizeRatio(45)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:fontName size:fontSize]} context:nil].size;
}

@end
