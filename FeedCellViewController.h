//
//  feedCellViewController.h
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 29.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface FeedCellViewController : UITableViewCell
- (void) configureCell:(nonnull Post*)post;
@end