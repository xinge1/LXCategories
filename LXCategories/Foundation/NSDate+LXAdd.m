//
//  NSDate+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/26.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "NSDate+LXAdd.h"
#import "LXCategoryMacro.h"

#define D_MINUTE        60
#define D_HOUR          3600
#define D_DAY           86400
#define D_WEEK          604800
#define D_YEAR          31556926

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

LXSYNTH_DUMMY_CLASS(NSDate_LXAdd)
@implementation NSDate (LXAdd)

#pragma mark - 当前时间

+ (NSCalendar *)currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}


+ (NSDate *)convertDateToLocalTime:(NSDate *)forDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:forDate];
    NSDate *localeDate = [forDate dateByAddingTimeInterval:interval];
    return localeDate;
}

#pragma mark - 相对日期

+ (NSDate *)dateNow
{
    return [self convertDateToLocalTime:[NSDate date]];
}

+ (NSDate *)dateTomorrow
{
    return [self convertDateToLocalTime:[NSDate dateWithDaysFromNow:1]];
}

+ (NSDate *)dateYesterday
{
    return [self convertDateToLocalTime:[NSDate dateWithDaysBeforeNow:1]];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
    return [self convertDateToLocalTime:[[NSDate date] dateByAddingDays:days]];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

#pragma mark - 日期转字符串
- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    return [formatter stringFromDate:self];
}

- (NSString *)shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - 日期比较

- (BOOL) isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}


- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}


- (BOOL)isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    return (abs((int)[self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}


- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL)isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}


- (BOOL)isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)isThisYear
{
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

- (BOOL)isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}

+ (int)compareWithAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSDate *dateA = [formatter dateFromString:dateTime];
    NSDate *dateB = [formatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return 1;   //已过指定时间日期
    }
    else if (result == NSOrderedAscending) {
        return -1;  //未过指定时间日期
    }
    return 0;   //时间相等
}

+(BOOL)isDateInRangeWithCurrentDate:(NSDate *)currentDate
                          startDate:(NSDate *)startDate
                            endDate:(NSDate *)endDate{
    BOOL isIn = NO;
    
    BOOL isLater = [currentDate isLaterThanDate:startDate];
    BOOL isEarlier = [currentDate isEarlierThanDate:endDate];
    
    if (isLater && isEarlier) {
        isIn = YES;
    }
    
    return isIn;
    
}

#pragma mark - 日期规则

- (BOOL)isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}


#pragma mark - 调整日期

- (NSDate *)dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *)dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

- (NSDate *)dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays
{
    return [self dateByAddingDays:(dDays * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours
{
    return [self dateByAddingHours:(dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - 极端日期
- (NSDate *)dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}


#pragma mark - 检索间隔

- (NSInteger)minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}


#pragma mark - 日期分解

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)weekOfMonth
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger)weekOfYear
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)nthWeekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

#pragma mark ---时间转换，NSDate -->NSString,NSTimeInterval---
/**
 日期时间转换
 NSDate --> NSString
 
 @param date 需要转换的日期时间
 @param format 格式，yyyy-MM-dd HH:mm:ss
 @return 时间字符串
 */
+(NSString *)lx_getDateStrWithDate:(NSDate *)date
                            format:(NSString *)format{
  
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ssπ
    formatter.dateFormat = format;
    formatter.locale = [NSLocale currentLocale];
    formatter.timeZone = [NSTimeZone localTimeZone];
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:date];
    // 输出currentDateStr
    return currentDateStr;
}


/**
 日期时间转换，秒级时间戳
 NSDate --> NSTimeInterval

 @param date 需要转换的日期时间
 @return 时间戳
 */
+(NSTimeInterval)lx_getDateTimeIntervalWithDate:(NSDate *)date{
    return [date timeIntervalSince1970];
}

/**
 日期时间转换，毫秒级时间戳
 NSDate --> NSTimeInterval
 
 @param date 需要转换的日期时间
 @return 时间戳
 */
+(NSTimeInterval)lx_getDateTimeIntervalMSWithDate:(NSDate *)date{
    NSTimeInterval interval = [self lx_getDateTimeIntervalWithDate:date] * 1000;
    return interval;
}

#pragma mark ---时间转换，NSString -->NSDate,NSTimeInterval---
/**
 日期时间转换
 NSString --> NSDate
 
 @param timeStr 时间字符串
 @param dateF timeStr的格式 如：YYYY-MM-dd HH:mm:ss
 @return NSDate
 */
+ (NSDate *)lx_getDateWithString:(NSString *)timeStr
                      dateFormat:(NSString *)dateF{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateF]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    
    return date;
}

/**
 日期时间转换，
 NSString --> NSTimeInterval（秒级）
 
 @param timeStr 时间字符串
 @param dateF timeStr的格式 如：YYYY-MM-dd HH:mm:ss
 @return NSDate
 */
+(NSTimeInterval)lx_getDateTimeIntervalWithString:(NSString *)timeStr
                                       dateFormat:(NSString *)dateF{
    NSDate *date = [self lx_getDateWithString:timeStr dateFormat:dateF];
    NSTimeInterval timeInterval = [self lx_getDateTimeIntervalWithDate:date];
    return timeInterval;
}

/**
 日期时间转换，
 NSString --> NSTimeInterval（毫秒级）
 
 @param timeStr 时间字符串
 @param dateF timeStr的格式 如：YYYY-MM-dd HH:mm:ss
 @return NSDate
 */
+(NSTimeInterval)lx_getDateTimeIntervalMSWithString:(NSString *)timeStr
                                       dateFormat:(NSString *)dateF{
    NSDate *date = [self lx_getDateWithString:timeStr dateFormat:dateF];
    NSTimeInterval timeInterval = [self lx_getDateTimeIntervalMSWithDate:date];
    return timeInterval;
}

#pragma mark ---时间转换，NSTimeInterval -->NSDate,NSString---

/**
 日期时间转换，
 NSTimeInterval -->NSDate

 @param timeInterval 时间戳
 @return 时间
 */
+(NSDate *)lx_getDateWithTimeInterval:(id)timeInterval{
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    
    return date;
}


/**
 日期时间转换，毫秒级时间戳
 NSTimeInterval -->NSDate
 
 @param timeInterval 时间戳
 @return 时间
 */
+(NSDate *)lx_getDateWithTimeIntervalHaoMiao:(id)timeInterval{
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:([timeInterval doubleValue]/1000.0)];
    
    return date;
}

/**
 日期时间转换，
 NSTimeInterval -->NSString

 @param timeInterval 时间戳
 @param format timeStr的格式 如：YYYY-MM-dd HH:mm:ss
 @return NSDate
 */
+(NSString *)lx_getDateStrWithTimeInterval:(nullable id)timeInterval
                                    format:(NSString *)format{
    
    NSDate *date = [self lx_getDateWithTimeInterval:timeInterval];
    NSString *timeStr = [self lx_getDateStrWithDate:date format:format];
    return timeStr;

}

/**
 日期时间转换，毫秒级时间戳
 NSTimeInterval -->NSString
 
 @param timeInterval 毫秒级时间戳
 @param format timeStr的格式 如：YYYY-MM-dd HH:mm:ss
 @return NSDate
 */
+(NSString *)lx_getDateStrWithTimeIntervalHaoMiao:(nullable id)timeInterval
                                           format:(NSString *)format{
    
    NSDate *date = [self lx_getDateWithTimeIntervalHaoMiao:timeInterval];
    NSString *timeStr = [self lx_getDateStrWithDate:date format:format];
    return timeStr;
    
}

/**
 *  计算两个时间字符串差多少秒
 *
 *  @param fromDateStr 开始
 *  @param toDateStr   结束
 *
 *  @return 秒数
 */
+(CGFloat)lx_getTimeGap:(NSString *)fromDateStr
                 toDate:(NSString *)toDateStr{
    
    CGFloat time = 0;
    CGFloat a    = 1.0;
    NSTimeInterval fromTime = [self lx_getDateTimeIntervalWithString:fromDateStr dateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeInterval toTime = [self lx_getDateTimeIntervalWithString:toDateStr dateFormat:@"YYYY-MM-dd HH:mm:ss"];
    time = (toTime-fromTime)/a;
    //    DLog(@"相差===[%f]",time);
    return time;
}

@end
