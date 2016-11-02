//
//  CalendarButton.h
//  ICoo
//
//  Created by JuniorKey on 9/28/16.
//  Copyright © 2016 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalendarButton : UIButton
/**  阳历*/
@property (nonatomic,copy) NSString* topTitle;
/**  阴历*/
@property (nonatomic,copy) NSString* bottomTitle;
/**  字体属性*/
@property (nonatomic,strong) NSDictionary* fontAttr;
/**  选中*/
@property (nonatomic,assign) BOOL btnSelected;
@end
