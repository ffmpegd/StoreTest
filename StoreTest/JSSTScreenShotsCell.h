//
//  JSSTScreenShotsCell.h
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSTScreenShotsCell : UICollectionViewCell
@property (strong, nonatomic) NSArray *resultScreenShots;
@property (strong, nonatomic) UICollectionView *myCV;
@property (strong, nonatomic) NSMutableArray *screenShotsArray;

-(void) loadScreenShots;

@end
