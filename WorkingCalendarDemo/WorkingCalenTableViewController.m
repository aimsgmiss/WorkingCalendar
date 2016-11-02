//
//  WorkingCalenTableViewController.m
//  ICoo
//
//  Created by JuniorKey on 16/8/22.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "WorkingCalenTableViewController.h"
#import "CalendarView.h"

@interface WorkingCalenTableViewController ()<CalendarViewDelegate>
{
    
    CGFloat     _calendarViewHeight;
}
/**
 *  日期选择按钮
 */
@property (nonatomic,retain) UIButton* titleView;
@property (nonatomic,retain) CalendarView* headerView;
@end

@implementation WorkingCalenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initData];
}

-(void)initNavigation
{
    self.navigationItem.title = @"工作日历";
}

-(void)initData
{
    if (IS_IPHONE_4 || IS_IPHONE_5 ) {
        _calendarViewHeight = 110;
    } else if(IS_IPHONE_6 || IS_IPHONE_7) {
        _calendarViewHeight = 125;
    }else if(IS_IPHONE_6_PLUS || IS_IPHONE_7_PLUS) {
        _calendarViewHeight = 145;
    }
    _headerView = [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil].lastObject;
    _headerView.viewController = self;
    _headerView.frame = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, kScreenWidth, _calendarViewHeight);
    self.tableView.tableHeaderView = _headerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

#pragma mark CalendarViewDelegate
-(void)dayBtnClicked:(UIButton *)sender
{

}

@end
