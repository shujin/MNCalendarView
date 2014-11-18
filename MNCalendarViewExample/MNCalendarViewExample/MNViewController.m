//
//  MNViewController.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNViewController.h"
#import <MNCalendarView/NSDate+MNAdditions.h>

@interface MNViewController () <MNCalendarViewDelegate>

@property(nonatomic,strong) NSCalendar     *calendar;
@property(nonatomic,strong) MNCalendarView *calendarView;
@property(nonatomic,strong) NSDate         *currentDate;

@end

@implementation MNViewController

- (instancetype)initWithCalendar:(NSCalendar *)calendar title:(NSString *)title {
  if (self = [super init]) {
    self.calendar = calendar;
    self.title = title;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components1 = [[NSDateComponents alloc] init];
    [components1 setDay:3];
    NSDateComponents *components2 = [[NSDateComponents alloc] init];
    [components2 setDay:13];
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    [components3 setDay:14];
    NSDateComponents *components4 = [[NSDateComponents alloc] init];
    [components4 setDay:15];
    NSDateComponents *components5 = [[NSDateComponents alloc] init];
    [components5 setDay:19];
    
  self.currentDate = [NSDate date];

  self.calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
  self.calendarView.calendar = self.calendar;
  self.calendarView.selectedDate = [NSDate date];
    self.calendarView.daysInAdvance = 20;
  self.calendarView.delegate = self;
  self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  self.calendarView.backgroundColor = UIColor.whiteColor;
    self.calendarView.datesToHighlight = @[
                                           @{ @"date": [[calendar dateByAddingComponents:components1 toDate:self.currentDate options:0] mn_beginningOfDay:self.calendar], @"progress" : @(0.7) },
                                           @{ @"date": [[calendar dateByAddingComponents:components2 toDate:self.currentDate options:0] mn_beginningOfDay:self.calendar], @"progress" : @(1.0) },
                                           @{ @"date": [[calendar dateByAddingComponents:components3 toDate:self.currentDate options:0] mn_beginningOfDay:self.calendar], @"progress" : @(0.5) },
                                           @{ @"date": [[calendar dateByAddingComponents:components4 toDate:self.currentDate options:0] mn_beginningOfDay:self.calendar], @"progress" : @(0.4) },
                                           @{ @"date": [[calendar dateByAddingComponents:components5 toDate:self.currentDate options:0] mn_beginningOfDay:self.calendar], @"progress" : @(0.2) }
                                           ];

  [self.view addSubview:self.calendarView];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self.calendarView.collectionView.collectionViewLayout invalidateLayout];
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.calendarView reloadData];
}

#pragma mark - MNCalendarViewDelegate

- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date {
  NSLog(@"date selected: %@", date);
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date {
  NSTimeInterval timeInterval = [date timeIntervalSinceDate:self.currentDate];

  if (timeInterval > MN_WEEK && timeInterval < (MN_WEEK * 2)) {
    return NO;
  }

  return YES;
}

@end
