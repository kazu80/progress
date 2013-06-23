//
//  ViewController.m
//  progress
//
//  Created by kazuyoshi kawakami on 13/06/23.
//  Copyright (c) 2013年 kazuyoshi kawakami. All rights reserved.
//

#import "ViewController.h"

#define PROGRESS_SETP_TIME 0.01

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *speedSegment;
@property (weak, nonatomic) IBOutlet UISwitch *repeatSwitch;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIProgressView *timeProgress;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (nonatomic)       float    progressTimer;
@property (nonatomic)       float    performanceTime;
@property (nonatomic)       BOOL     inProgress;

- (IBAction)speedChanged:(id)sender;
- (IBAction)touchStartButton:(id)sender;


@end

@implementation ViewController

static float performanceTimes[] = {0.5, 5.0};

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProgress
{
    _inProgress = NO;
    _speedSegment.selectedSegmentIndex = 0;
    _performanceTime = performanceTimes[_speedSegment.selectedSegmentIndex];
    _repeatSwitch.on = NO;
    _timeProgress.progress = 0.0;
    _second.text = @"0.00";
}

- (void)startProgress
{
    _progressTimer = 0.0;
    _timeProgress.progress = _progressTimer;
    _inProgress = YES;
    _second.text = @"0.00";
    [_startButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self performSelector:@selector(updateProgress) withObject:nil afterDelay:PROGRESS_SETP_TIME];
}

- (void)stopProgress
{
    _inProgress = NO;
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)updateProgress
{
    _progressTimer += PROGRESS_SETP_TIME;
    _second.text = [NSString stringWithFormat:@"%.2f", _progressTimer];
    _timeProgress.progress = _progressTimer / _performanceTime;
    if ( _progressTimer < _performanceTime ) {
        [self performSelector:@selector(updateProgress) withObject:nil afterDelay:PROGRESS_SETP_TIME];
    } else {
        [self stopProgress];
        if ( _repeatSwitch.on ) {
            [self startProgress];
        }
    }
}

- (IBAction)speedChanged:(id)sender {
    _performanceTime = performanceTimes[_speedSegment.selectedSegmentIndex];
}

- (IBAction)touchStartButton:(id)sender {
    if ( _inProgress ) {
        [self stopProgress];
    } else {
        [self startProgress];
    }
}



@end
