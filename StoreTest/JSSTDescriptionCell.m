//
//  JSSTDescriptionCell.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTDescriptionCell.h"

@implementation JSSTDescriptionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)loadDescription:(NSString*)description
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 310.0, 0.0)];
    textLabel.numberOfLines = 0;
    [textLabel setText:description];
    [textLabel sizeToFit];
    [self.contentView addSubview:textLabel];
    [self.contentView sizeToFit];
    [self.contentView setNeedsDisplay];
//    NSLog(description);
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
