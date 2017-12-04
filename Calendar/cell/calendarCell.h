//
//  calendarCell.h
//  Calendar
//
//  Created by MAC on 26/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface calendarCell : UICollectionViewCell

@property (strong,nonatomic) NSString *dateValue;

@property (weak, nonatomic) IBOutlet UILabel *Lbldate;

@end
