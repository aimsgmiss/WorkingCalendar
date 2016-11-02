//
//  CalendarButton.m
//  ICoo
//
//  Created by JuniorKey on 9/28/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import "CalendarButton.h"

@implementation CalendarButton
-(void)drawRect:(CGRect)rect
{
    CGSize          textSize;
    CGFloat         x;
    CGFloat         y;
   
    if (self.btnSelected) {
        if(IS_IPHONE_4 || IS_IPHONE_5) self.fontAttr = kBoldFontSize13BlackColor;
        else self.fontAttr = kBoldFontSize15BlackColor;
    }else{
        self.fontAttr = kSystemFontSize11BlackColor;
    }
   
    textSize = [_topTitle sizeWithAttributes:self.fontAttr];
    x = rect.size.width/2 - textSize.width/2;
    y = rect.size.height/2 - textSize.height;
    [_topTitle drawAtPoint:CGPointMake(x, y) withAttributes:self.fontAttr];
    textSize = [_bottomTitle sizeWithAttributes:self.fontAttr];
    x = rect.size.width/2 - textSize.width/2;
    y = rect.size.height/2;
    [_bottomTitle drawAtPoint:CGPointMake(x, y) withAttributes:self.fontAttr];
 

}
@end
