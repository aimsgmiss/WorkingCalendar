//
//  CalendarView.h
//  ICoo
//
//  Created by JuniorKey on 16/8/22.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct _weekdays
{
    __unsafe_unretained  UIButton*  btn;
    __unsafe_unretained  UILabel*   lab;
    int                             tag;
}weekdays;


@protocol CalendarViewDelegate <NSObject>

@optional
-(void)dayBtnClicked:(NSDate*)selectedDate;

@end
@interface CalendarView : UIView
{
    /// 工作天数button和label数组
    weekdays        _weekdays[7];
}

@property (weak, nonatomic) IBOutlet UIButton *sundayBtn;
@property (weak, nonatomic) IBOutlet UIButton *mondayBtn;
@property (weak, nonatomic) IBOutlet UIButton *tuesdayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wednesdayBtn;
@property (weak, nonatomic) IBOutlet UIButton *thursdayBtn;
@property (weak, nonatomic) IBOutlet UIButton *fridayBtn;
@property (weak, nonatomic) IBOutlet UIButton *saturdayBtn;
@property (weak, nonatomic) IBOutlet UILabel *currCalendarLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundayLab;
@property (weak, nonatomic) IBOutlet UILabel *mondayLab;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLab;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLab;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLab;
@property (weak, nonatomic) IBOutlet UILabel *fridayLab;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLab;

/**
 * 先前被选中的按钮
 */
@property (nonatomic) UIButton* previousBtn;
/**
 *  被选中的按钮
 */
@property (nonatomic) UIButton* selectedBtn;
/**
 *  当前选中的日期
 */
@property (nonatomic,strong) NSDate* currentDate;
/**
 *  处理天数时间按钮点击代理
 */
@property (nonatomic) id<CalendarViewDelegate> delegate;
/**
 *  当前日历视图位于哪个视图控制器
 */
@property (nonatomic) UIViewController* viewController;
- (IBAction)btnClick:(id)sender;
- (IBAction)lastWeekBtnClick:(id)sender;
- (IBAction)selectCalendarBtnClick:(id)sender;
- (IBAction)nextWeekBtnClick:(id)sender;

@end
