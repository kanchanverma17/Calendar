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
    int inFocus;
    int directionMultiplier;
    CGFloat commonDiff;
    NSArray *frameArr;
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
   // calendarData = [NSDate dateWithTimeInterval: sinceDate:[NSDate date]];
}

-(void)updateCalendar:(NSInteger)monthsDays
{
    //dateCompo = [[NSDateComponents alloc]init];
   // dateCompo.day = monthsDays;
 //   calendarData.currentDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateCompo toDate:calendarData.currentDate options:0];
    calendarData.currentDate = [[NSCalendar currentCalendar]dateByAddingUnit:NSCalendarUnitMonth value:monthsDays toDate:calendarData.currentDate options:0];
    [calendarData setInitials];
    self.headerForMonth.text = calendarData.monthTitle;
    [self.Calendar reloadData];
   [self.prevMonthCal reloadData];
    [self.nextMonth reloadData];
}


- (IBAction)prevMonth:(id)sender
{
  
    [self updateCalendar:-1];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    calHt = self.Calendar.frame.size.height;
    calWt = self.Calendar.frame.size.width;
    // directionMultiplier = -1;
    inFocus = presentMonth;
    commonDiff = self.view.frame.size.width;
    calendarData = [dataForCalendar shareddataForCalendar];
    calendarData.currentDate = [NSDate date];
    [calendarData setInitials];
    self.Calendar.pagingEnabled = NO;
    frameArr = [[NSArray alloc]initWithObjects:self.prevMonthCal,self.Calendar,self.nextMonth, nil];
    [self.Calendar registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    [self.prevMonthCal registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    [self.nextMonth registerNib:[UINib nibWithNibName:@"calendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"calendarCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    _headerForMonth.text = calendarData.monthTitle;
}



-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
     NSLog(@"cell decelarating at scrollViewWillBeginDecelerating ---> %f %ld ",scrollView.contentOffset.x,scrollView.tag);
    // if negative prev month
    int prevFocus = inFocus;
    int prevDirect = directionMultiplier;
    NSLog(@"scrollViewWillBeginDecelerating prev stats :: %d %d",prevFocus,prevDirect);
   
    if(scrollView.contentOffset.x < 0)
    {
        directionMultiplier = -1;
//        if(inFocus>0)
//        {
//        --inFocus;
//        }
        
         [self updateCalendar:-1];
    }
    else
    {
        directionMultiplier = 1;
        //++inFocus;
        [self updateCalendar:1];
    }
    
        [UIView animateWithDuration:0.5 animations:^{
    // self.presentMonthLeading.constant = -self.Calendar.contentOffset.x;
    // self.presentMOnthTrail.constant = -self.Calendar.contentOffset.x;
            NSLog(@"infocus value :: %i",inFocus);
              NSLog(@"directionMultiplier value :: %i",directionMultiplier);
           switch (inFocus) {
                case presentMonth:
                   self.prevMonthCal.hidden = inFocus;
                    self.presentMonthLeading.constant = -self.view.frame.size.width*directionMultiplier;
                    self.prevMonthLeading.constant = 0;
                //   self.nextMonth.hidden = 1-inFocus;
                //   self.nextMonthLeading.constant = self.view.frame.size.width*directionMultiplier;
                    inFocus = previousMonth;
                   break;
                
                case previousMonth:
                    self.prevMonthLeading.constant = -self.view.frame.size.width*directionMultiplier;
                   self.Calendar.hidden = inFocus;
                    self.presentMonthLeading.constant = self.view.frame.size.width*directionMultiplier;
                    self.nextMonthLeading.constant = 0;
                   self.nextMonth.hidden = inFocus+1;
                    inFocus = nextMonth;
                    break;
                   
                case nextMonth:
                   self.Calendar.hidden = inFocus-1;
                   self.prevMonthCal.hidden = inFocus;
                    self.prevMonthLeading.constant = self.view.frame.size.width*directionMultiplier;
                    self.presentMonthLeading.constant = 0;
                    self.nextMonthLeading.constant = -self.view.frame.size.width*directionMultiplier;
                    inFocus = presentMonth;
                   
                    break;
                default:
                    break;
            }
            
            [self.view layoutIfNeeded];
        }];
   
    
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
    if(collectionView == self.Calendar)
    {
       // cell.backgroundColor = [UIColor greenColor];
    }
    if(collectionView == self.Calendar)
    {
         //  cell.backgroundColor = [UIColor grayColor];
    }
    if(collectionView == self.Calendar)
    {
         //  cell.backgroundColor = [UIColor cyanColor];
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
