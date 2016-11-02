//
//  CalendarView.m
//  ICoo
//
//  Created by JuniorKey on 16/8/22.
//  Copyright © 2016年 my.JuniorKey. All rights reserved.
//

#import "CalendarView.h"

#define     kWeekdayCount            7
#define     kSecsOfDay               (24 * 60 * 60)

@interface CalendarView()
@property (nonatomic,weak) CalendarView*   weakSelf;
@end
@implementation CalendarView

-(void)awakeFromNib
{
    [super awakeFromNib];

    _weekdays[0] = (weekdays){_sundayBtn,0};
    _weekdays[1] = (weekdays){_mondayBtn,1};
    _weekdays[2] = (weekdays){_tuesdayBtn,2};
    _weekdays[3] = (weekdays){_wednesdayBtn,3};
    _weekdays[4] = (weekdays){_thursdayBtn,4};
    _weekdays[5] = (weekdays){_fridayBtn,5};
    _weekdays[6] = (weekdays){_saturdayBtn,6};
    _currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    _weakSelf = self;
    [self initWithData:_currentDate];
  
}

-(void)initWithData:(NSDate*)currDate
{
    __block NSInteger                  weekday;
    
    [self getDay:currDate weekday:^(NSDateComponents *dateCompo) {
        weekday = [dateCompo weekday];
        //weekday = 1时为星期日（_sundayBtn,数组中索引为0,所以 weekday -1），2 为星期一
        _weakSelf.selectedBtn = _weakSelf->_weekdays[(weekday - 1)].btn;
    }];
    [self setWeekdays:_currentDate];
}

-(void)setWeekdays:(NSDate *)currDate
{

    NSDate*             date;
    __block NSInteger   index;
    
    [self getDay:_currentDate weekday:^(NSDateComponents *dateCompo) {
        for (index = 0; index < kWeekdayCount; index++)if(_weekdays[index].tag == _selectedBtn.tag)[_weakSelf setWeekdays:dateCompo Btn:(CalendarButton*)_weakSelf.selectedBtn];
    }];
    //设置选中按钮前面几个button或者label数据
    for(int index = 0; index < _selectedBtn.tag;index++)
    {
        date = [NSDate dateWithTimeInterval:-(_selectedBtn.tag - index) * kSecsOfDay sinceDate:_currentDate];
        [self getDay:date weekday:^(NSDateComponents *dateCompo) {
             [_weakSelf setWeekdays:dateCompo Btn:(CalendarButton*)_weakSelf->_weekdays[index].btn];
        }];
    }
    //设置选中按钮后面几个button或者label数据
    for (index = _selectedBtn.tag + 1; index < kWeekdayCount; index++)
    {
        date = [NSDate dateWithTimeInterval:(index - _selectedBtn.tag) * kSecsOfDay  sinceDate:_currentDate];
        [self getDay:date weekday:^(NSDateComponents *dateCompo) {
            [_weakSelf setWeekdays:dateCompo Btn:(CalendarButton*)_weakSelf->_weekdays[index].btn];
        }];
    }
    [self setCurrCalendarTitle];
    if([_delegate respondsToSelector:@selector(dayBtnClicked:)])[_delegate dayBtnClicked:_currentDate];
}

-(void)setWeekdays:(NSDateComponents*)dateCompo Btn:(CalendarButton*)btn
{
    NSArray*           nonArrs;
    
    if(!dateCompo || !btn) return;
  
    nonArrs = [self LunarForSolarYear:(int)dateCompo.year Month:(int)dateCompo.month Day:(int)dateCompo.day];
    btn.topTitle = [NSString stringWithFormat:@"%ld",[dateCompo day]];
    [btn setTitle:@"" forState:UIControlStateNormal];
    btn.bottomTitle = nonArrs[1];
    [btn setNeedsDisplay];
}

-(void)getDay:(NSDate*)date weekday:(void (^)(NSDateComponents* dateCompo)) weekday
{
    NSCalendar*         calendar;
    NSCalendarUnit      unit;
    NSDateComponents*   dateCompo;
    
    calendar = [NSCalendar currentCalendar];
    unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday;
    dateCompo = [calendar components:unit fromDate:date];
    if(weekday)weekday(dateCompo);
}

- (IBAction)btnClick:(id)sender
{
    _previousBtn = _selectedBtn;
    self.selectedBtn = (CalendarButton*)sender;
    _currentDate = [NSDate dateWithTimeInterval: (_selectedBtn.tag - _previousBtn.tag) * kSecsOfDay sinceDate:_currentDate];
    
    [self setCurrCalendarTitle];
    if([self.delegate respondsToSelector:@selector(dayBtnClicked:)])[self.delegate dayBtnClicked:_currentDate];

}

- (IBAction)lastWeekBtnClick:(id)sender
{
    NSDate*         lastCurrdate;
    
    lastCurrdate = [NSDate dateWithTimeInterval:-7 * kSecsOfDay sinceDate:_currentDate];
    _currentDate = lastCurrdate;
    [self setWeekdays:_currentDate];
}

- (IBAction)selectCalendarBtnClick:(id)sender
{
   
}

- (IBAction)nextWeekBtnClick:(id)sender
{
    NSDate*         lastCurrdate;
    
    lastCurrdate = [NSDate dateWithTimeInterval:7 * kSecsOfDay sinceDate:_currentDate];
    _currentDate = lastCurrdate;
    [self setWeekdays:_currentDate];
}

-(void)setSelectedBtn:(CalendarButton *)selectedBtn
{
    NSInteger           index;
    
    if(_selectedBtn != selectedBtn)
    {
        _selectedBtn = selectedBtn;
        _selectedBtn.btnSelected = YES;
        
        [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"calendarSelected"] forState:UIControlStateNormal];
        [_selectedBtn setNeedsDisplay];
        for (index = 0; index < kWeekdayCount; index++)
        {
            if(_selectedBtn.tag != _weekdays[index].btn.tag)
            {
                [_weekdays[index].btn setBackgroundImage:nil forState:UIControlStateNormal];
                _weekdays[index].btn.btnSelected = NO;
                [_weekdays[index].btn setNeedsDisplay];
            }
        }
    }
}

-(void)setCurrCalendarTitle
{
    NSDateFormatter*    dateFormatter;
    __block NSArray*     nonArrs;
    NSString*           nonStr;
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"阳历:yyyy年MM月dd日"];
    _currCalendarLabel.font =[UIFont boldSystemFontOfSize:15];
    [self getDay:_currentDate weekday:^(NSDateComponents *dateCompo) {
        nonArrs = [_weakSelf LunarForSolarYear:(int)dateCompo.year Month:(int)dateCompo.month Day:(int)dateCompo.day];
    }];
    nonStr = [NSString stringWithFormat:@" 农历:%@月%@",nonArrs[0],nonArrs[1]];
    _currCalendarLabel.text = [[dateFormatter stringFromDate:_currentDate] stringByAppendingString:nonStr];

}

-(NSArray *)LunarForSolarYear:(int)wCurYear Month:(int)wCurMonth Day:(int)wCurDay
{
    //农历日期名
    NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                          @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                          @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历月
    NSString *szNongliMonth;
    if (wCurMonth < 1){
        szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }else{
        szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    //生成农历日
    NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
    
    //合并
    //NSString *lunarDate = [NSString stringWithFormat:@"%@-%@",szNongliMonth,szNongliDay];
    return @[szNongliMonth,szNongliDay];
}
-(void)setDelegate:(id<CalendarViewDelegate>)delegate
{
    if(_delegate != delegate)
    {
        _delegate = delegate;
        if([_delegate respondsToSelector:@selector(dayBtnClicked:)])[_delegate dayBtnClicked:_currentDate];
    }
    
}
@end
