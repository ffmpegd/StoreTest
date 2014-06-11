//
//  JSSTDetailViewController.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTDetailViewController.h"

@interface JSSTDetailViewController ()
@property (strong, nonatomic) JSSTDescriptionCell *dCell;
@property (strong, nonatomic) JSSTScreenShotsCell *ssCell;
@property (strong, nonatomic) NSMutableArray *ssArray;

@end

@implementation JSSTDetailViewController

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
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[JSSTScreenShotsCell class] forCellWithReuseIdentifier:@"ssCell"];
    [self.collectionView registerClass:[JSSTDescriptionCell class] forCellWithReuseIdentifier:@"dCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = YES;
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0)
    {
        UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ssCell" forIndexPath:indexPath];
        self.ssCell= (JSSTScreenShotsCell*)cell;
        self.ssCell.resultScreenShots = self.resultScreenShots;
        self.ssCell.myCV = self.collectionView;
        [self.ssCell loadScreenShots];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClicked:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [self.ssCell addGestureRecognizer:tapRecognizer];
        self.ssArray = self.ssCell.screenShotsArray;
        return self.ssCell;
    }
    else
    {
        UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"dCell" forIndexPath:indexPath];
        self.dCell = (JSSTDescriptionCell*)cell;
        [self.dCell loadDescription:self.resultDescription];

        return self.dCell;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0)
    {
        return CGSizeMake(320.0, 200.0);
    }
    else
    {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 310.0, 0.0)];
        textLabel.numberOfLines = 0;
        [textLabel setText:self.resultDescription];
        [textLabel sizeToFit];
        return CGSizeMake(320.0, textLabel.frame.size.height + 5.0);
    }

}

- (id<UIViewControllerAnimatedTransitioning>)
navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
fromViewController:(UIViewController*)fromVC
toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush && [fromVC isKindOfClass:[self class]])
    {
//        return self.animator;
        return [[JSSTAnimator alloc] init];
    }
    else if (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[self class]])
    {
        return [[JSSTAnimator alloc] init];
    }
    else
    {
        self.navigationController.delegate = nil;
        return nil;
    }
//    return nil;
}

-(void)cellClicked:(UITapGestureRecognizer*)sender
{
    CGPoint tapLocation = [sender locationInView:[[self.ssCell.contentView subviews] objectAtIndex:0]];
    int ssClicked = ((int)tapLocation.x - 5) / 114;
    NSLog(@"ssclicked: %d", ssClicked);
    
    if (ssClicked < [self.resultScreenShots count])
    {
        JSSTScreenShotViewController *ssVC = [[JSSTScreenShotViewController alloc] init];
//        NSArray *cellViewArray = self.ssCell.subviews;
//        UIScrollView *cellScrollView = [cellViewArray firstObject];
//        NSArray *scrollSubviews = [cellScrollView subviews];
//        UIScrollView *secondScrollView = [scrollSubviews firstObject];
//        NSArray *secondScrollViewSubviews = [secondScrollView subviews];
//        int distanceFromEnd = (int)[self.resultScreenShots count] - (ssClicked);
//        int convertedIndex = (int)[secondScrollViewSubviews count] - distanceFromEnd;
//        UIImageView *imageView = [secondScrollViewSubviews objectAtIndex:convertedIndex];
//        ssVC.screenshotImage = imageView.image;
        UIImageView *tempIV = [self.ssCell.screenShotsArray objectAtIndex:ssClicked];
        ssVC.screenshotImage = [tempIV image];
        
        [self.navigationController pushViewController:ssVC animated:YES];
        
    }
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
