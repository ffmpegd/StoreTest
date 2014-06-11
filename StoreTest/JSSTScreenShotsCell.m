//
//  JSSTScreenShotsCell.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTScreenShotsCell.h"
@interface JSSTScreenShotsCell()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *screenShotsURLArray;

@end

@implementation JSSTScreenShotsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.screenShotsArray = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)loadScreenShots
{
    // Initialization code
    NSLog(@"initing sscell, array count: %lu",(unsigned long)[self.resultScreenShots count]);
    self.screenShotsURLArray = [[NSMutableArray alloc] initWithCapacity:[self.resultScreenShots count]];
    if (self.scrollView)
    {
        [self.scrollView removeFromSuperview];
    }
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 200.0)];
    [self.scrollView setContentMode:UIViewContentModeScaleAspectFit];
    CGFloat width = [self.resultScreenShots count] * (114.0 + 5.0) + 5.0;
    NSLog(@"content width: %f", width);
    self.scrollView.contentSize = CGSizeMake(width, 200.0);
    self.scrollView.scrollEnabled = YES;
    [self.contentView addSubview:self.scrollView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    for (int i =0; i<[self.resultScreenShots count]; i++)
    {
        CGFloat x = 5.0 + i*119.0;
        UIImageView *screenShot = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0.0, 114.0, 200.0)];
        screenShot.backgroundColor = [UIColor whiteColor];
        [self.screenShotsArray insertObject:screenShot atIndex:i];
        [self.scrollView addSubview:screenShot];
        
    }
    [self setNeedsDisplay];
    
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];

    for (int i = 0; i<[self.resultScreenShots count]; i++)
    {
        [self.screenShotsURLArray insertObject:[[UIImage alloc] init] atIndex:i];
        NSString *urlString = [self.resultScreenShots objectAtIndex:i];
        NSURL *ssURL = [NSURL URLWithString:urlString];
        [[session dataTaskWithURL:ssURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *screenshot = [UIImage imageWithData:data];
                UIImageView *screenshotView = [[UIImageView alloc] initWithImage:screenshot];
                [screenshotView setContentMode:UIViewContentModeScaleAspectFit];
                CGFloat x = 5.0 + i*119.0;
                screenshotView.frame = CGRectMake(x, 0.0, 114.0, 200.0);
                [[self.screenShotsArray objectAtIndex:i] removeFromSuperview];
                [self.screenShotsArray replaceObjectAtIndex:i withObject:screenshotView];
                [self.scrollView addSubview:screenshotView];
                [self.scrollView setNeedsDisplay];
            });
        }] resume];
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
