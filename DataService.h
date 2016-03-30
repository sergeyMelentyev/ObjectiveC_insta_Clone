//
//  DataService.h
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 29.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FireBase.h"

@interface DataService : NSObject
@property (nonatomic, strong) DataService *ds;
+ (id) initWithUrl;
+ (id) initWithUrlPosts;
+ (void) creatNewUserAccountWithUID: (NSString*)uid userName:(NSDictionary*)user;
@end