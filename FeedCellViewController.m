//
//  feedCellViewController.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 29.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "FeedCellViewController.h"

@interface FeedCellViewController()
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UIImageView *feedMainImg;
@property (weak, nonatomic) IBOutlet UILabel *likeCounter;

@end

@implementation FeedCellViewController

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) drawRect:(CGRect)rect {
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    self.feedMainImg.clipsToBounds = YES;
}

@end