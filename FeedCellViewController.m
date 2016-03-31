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
@property (weak, nonatomic) IBOutlet UILabel *feedText;

@end

@implementation FeedCellViewController

// UPGRADE CONTENT OF EACH CELL
- (void) configureCell:(nonnull Post*)post {
    self.feedText.text = post.postDescription;
    self.likeCounter.text = [NSString stringWithFormat:@"%@", post.likes];
    if (post.imageData != nil) {
        self.feedMainImg.image = [UIImage imageWithData:post.imageData];
    } else {
        [self getImageFromUrl:(post) imageView:(self.feedMainImg)];
    }
}

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) drawRect:(CGRect)rect {
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    self.feedMainImg.clipsToBounds = YES;
}

// CONVERT THE IMAGE FROM URL TO UIIMAGE
- (void) getImageFromUrl:(Post*)post imageView:(UIImageView*)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: post.imageUrl]];
        if (data != nil) {
            post.imageData = data;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [UIImage imageWithData:post.imageData];
        });
    });
}

@end






