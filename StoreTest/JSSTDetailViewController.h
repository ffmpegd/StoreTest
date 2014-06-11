//
//  JSSTDetailViewController.h
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSTScreenShotsCell.h"
#import "JSSTDescriptionCell.h"
#import "JSSTScreenShotViewController.h"
#import "JSSTAnimator.h"

@interface JSSTDetailViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>
@property (strong, nonatomic) NSArray *resultScreenShots;
@property (strong, nonatomic) NSString *resultDescription;

@end
