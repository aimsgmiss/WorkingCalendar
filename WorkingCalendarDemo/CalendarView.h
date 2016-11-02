//
//  CalendarView.h
//  ICoo
//
//  Created by JuniorKey on 16/8/22.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarButton.h"
typedef struct _weekdays
{
    __unsafe_unretained  CalendarButton*    btn;
    int                                     tag;
}weekdays;


@protocol CalendarViewDelegate <NSObject>

@optional
-(void)dayBtnClicked:(NSDate*)selectedDate;

@end
@interface CalendarView : UIView
{
    @public
    /// 工作天数button和label数组
    weekdays        _weekdays[7];
}
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet CalendarButton *sundayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *mondayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *tuesdayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *wednesdayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *thursdayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *fridayBtn;
@property (weak, nonatomic) IBOutlet CalendarButton *saturdayBtn;
@property (weak, nonatomic) IBOutlet UILabel *currCalendarLabel;

/**
 * 先前被选中的按钮
 */
@property (nonatomic) CalendarButton* previousBtn;
/**
 *  被选中的按钮
 */
@property (nonatomic) CalendarButton* selectedBtn;
/**
 *  当前选中的日期
 */
@property (nonatomic,strong) NSDate* currentDate;
/**
 *  处理天数时间按钮点击代理
 */
@property (nonatomic,weak) id<CalendarViewDelegate> delegate;
/**
 *  当前日历视图位于哪个视图控制器
 */
@property (nonatomic,weak) UIViewController* viewController;
- (IBAction)btnClick:(id)sender;
- (IBAction)lastWeekBtnClick:(id)sender;
- (IBAction)selectCalendarBtnClick:(id)sender;
- (IBAction)nextWeekBtnClick:(id)sender;

@end
