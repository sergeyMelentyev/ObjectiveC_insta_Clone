//
//  MaterialView.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 28.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MaterialView.h"

@implementation MaterialView

- (void) awakeFromNib {
    self.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
}

@end