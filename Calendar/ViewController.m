//
//  ViewController.m
//  Calendar
//
//  Created by MAC on 26/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import "ViewController.h"
#import "calendarCell.h"
@interface ViewController ()
{
    CGFloat calHt;
    CGFloat calWt;
    dataForCalendar *calendarData;
    NSString *lastDate;
    NSDateComponents *dateCompo;
  CGFloat commonDiff;
    NSArray *frameArr;
    CGFloat thresholdValue;
    CGRect frame1;
    CGRect frame2;
    CGRect frame3;
}

@property (weak, nonatomic) IBOutlet UILabel *headerForMonth;


@end

@implementation ViewController

enum MonthType{
    previousMonth = 0,
    presentMonth = 1,
    nextMonth = 2
};

- (IBAction)nextMonthAct:(id)sender
{
    [self updateCalendar:1];
   
}

-(void)updateCalendar:(NSInteger)monthsDays
{
  
    calendarData.currentDate = [[NSCalendar currentCalendar]dateByAddingUnit:NSCalendarUnitMonth value:monthsDays toDate:calendarData.currentDate options:0];
    [calendarData setInitials];
    self.headerForMonth.text = calendarData.monthTitle;
    [self.Calendar reloadData];
    [self.rightCalendar reloadData];
    [self.leftCal reloadData];
}


- (IBAction)prevMonth:(id)sender
{
  
    [self updateCalendar:-1];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    calHt = self.Calendar.frame.size.height;
    calWt = self.Calendar.frame.size.width;

    commonDiff = self.view.frame.size.width;
    calendarData = [dataForCalendar shareddataForCalendar];
    calendarData.currentDate = [NSDate date];
    [calendarData setInitials];
    self.Calendar.pagingEnabled = NO;
    frame1 = self.leftCal.frame;
    frame2 = self.Calendar.frame;
    frame3 = self.rightCalendar.frame;
    frameArr = [[NSArray alloc]initWithObjects:[NSNumber numberWithFloat:frame1.origin.x],[NSNumber numberWithFloat:frame2.origin.x],[NSNumber numberWithFloat:frame3.origin.x], nil];
    [self.Calendar registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    [self.leftCal registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    [self.rightCalendar registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    // Do any additional setup after loading the view, typically from a nib.
    
    thresholdValue = self.view.frame.size.width/5;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _headerForMonth.text = calendarData.monthTitle;
}



-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    UIView *cal = scrollView;
    NSLog(@"scrollView.contentOffset.x value ---- %f",scrollView.contentOffset.x);
        if(scrollView.contentOffset.x != 0)
        {
              CGRect tempFrame = cal.frame;

                    CGFloat offsetValue  = scrollView.contentOffset.x;

            if(scrollView.contentOffset.x>0)
            {
                 tempFrame = CGRectMake(cal.frame.size.width - offsetValue, tempFrame.origin.y, tempFrame.size.width, tempFrame.size.height);
            }
            else
            {
                  tempFrame = CGRectMake(-(cal.frame.size.width+offsetValue), tempFrame.origin.y, tempFrame.size.width, tempFrame.size.height);
            }
            
     
                    [UIView animateWithDuration:0.2 animations:^{
                        cal.hidden = YES;
                        [cal setFrame:tempFrame];
                    } completion:^(BOOL finished) {
                          cal.hidden = NO;
                        [UIView animateWithDuration:1.0 animations:^{
                          
                            cal.frame = CGRectMake(0, tempFrame.origin.y, tempFrame.size.width, tempFrame.size.height);
                            if(tempFrame.origin.x>0)
                            {
                            [self updateCalendar:1];
                            }
                            else
                            {
                                [self updateCalendar:-1];
                            }
                        }];
                        
                    }];
   
          
        }

    
}


                                                                                                                                                                                                                                                                                                                                                        
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellwidth = calWt/7;
    
    return CGSizeMake(cellwidth, cellwidth);
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@" collectionView numberOfItemsInSection %ld:: ",(long)collectionView.tag);
    return 49;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    calendarCell *cell = (calendarCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"calendarCell" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = (calendarCell *)[UICollectionViewCell init];
    }
   
    cell.Lbldate.text =[calendarData valueForCellAtIndex:(int)indexPath.row];
    
    if(![cell.Lbldate.text isEqualToString:@""])
    {
        lastDate = cell.Lbldate.text;
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
