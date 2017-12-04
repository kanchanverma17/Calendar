//
//  dataForCalendar.m
//  Calendar
//
//  Created by MAC on 26/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import "dataForCalendar.h"

@implementation dataForCalendar
{
    NSArray *weekArr ;
    NSString *firstDay;
    NSDateFormatter *format;
    int currentMonthDays;
    int monthStartInd;
}
static dataForCalendar *sharedData;

-(NSString *)headforcalendar{
    return @"";
}

+(dataForCalendar*)shareddataForCalendar
{
    @synchronized([dataForCalendar class])
    {
    
        if(!sharedData){
            sharedData = [[dataForCalendar alloc]init];
            
        }
        
    }
    return sharedData;
}

-(void)setInitials
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_currentDate];
    NSUInteger numberOfDaysInMonth = range.length;
    currentMonthDays = (int)numberOfDaysInMonth ;
    format = [[NSDateFormatter alloc]init];
    weekArr = [[NSArray alloc]initWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun", nil];
    NSDate *currentDt = self.currentDate;
    [format setDateFormat:@"dd"];
    
    NSString *tempStr = [format stringFromDate:currentDt];
    //NSLog(@"present date :::: %@",currentDt);
    int dayLapsed = [tempStr intValue] - 1;
    NSDate *startDate = [NSDate dateWithTimeInterval:-dayLapsed*24*60*60 sinceDate:currentDt];
    [format setDateFormat:@"E"];
    // NSLog(@"present date :::: %@",[format stringFromDate:startDate]);
    monthStartInd = (int)[weekArr indexOfObject:[format stringFromDate:startDate]];
    monthStartInd = 6+monthStartInd;
    [format setDateFormat:@"MMMM yyyy"];
    NSString *tempString = [format stringFromDate:currentDt];
    self.monthTitle = tempString;
    
}

-(NSString *)valueForCellAtIndex:(int)indexValue{
   // NSLog(@"index passed is :::: %d",indexValue);
    NSString *resultValue = @"";
    int rowVal = indexValue/7;
    int colVal = indexValue % 7;
    if(rowVal)
    {
        int tempDay = indexValue-monthStartInd;
        if(tempDay>0 && tempDay<= currentMonthDays){
            resultValue = [NSString stringWithFormat:@"%d",tempDay];
        }else{
            resultValue = @"";
        }
    }
    else
    {
            resultValue = [weekArr objectAtIndex:colVal];
    }
  
   //  NSLog(@"resultValue passed is :::: %@",resultValue);
    return resultValue;
}

@end
