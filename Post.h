//
//  Post.h
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 30.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *postDescription;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *postKey;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSData *imageData;

@end