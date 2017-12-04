//
//  dataForCalendar.h
//  Calendar
//
//  Created by MAC on 26/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface dataForCalendar : NSObject

+(dataForCalendar*)shareddataForCalendar;
-(void)setInitials;
-(NSString*)valueForCellAtIndex:(int)indexValue;
@property(strong,nonatomic)NSString *monthTitle;
@property(strong,nonatomic)NSDate *currentDate;
@end
