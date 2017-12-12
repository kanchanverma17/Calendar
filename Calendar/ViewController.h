//
//  ViewController.h
//  Calendar
//
//  Created by MAC on 26/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dataForCalendar.h"
#import "calendarCell.h"

@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *Calendar;

@end

