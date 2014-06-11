//
//  JSSTScreenShotViewController.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTScreenShotViewController.h"

@interface JSSTScreenShotViewController ()
@property (strong, nonatomic) UITapGestureRecognizer *tapGR;

@end

@implementation JSSTScreenShotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bigImageView = [[UIImageView alloc] initWithImage:self.screenshotImage];
    [bigImageView setContentMode:UIViewContentModeScaleAspectFit];
    bigImageView.frame = [[UIScreen mainScreen] bounds];
    
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [self.tapGR setNumberOfTapsRequired:1];
    [self.tapGR setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:self.tapGR];
    
    [self.view addSubview:bigImageView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenTapped:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"screen tapped");
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
