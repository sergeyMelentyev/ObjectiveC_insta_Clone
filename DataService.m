//
//  DataService.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 29.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "DataService.h"

@implementation DataService

+ (id) initWithUrl {
    Firebase *refBase = [[Firebase alloc] initWithUrl:@"https://objectivec-insta-app.firebaseio.com"];
    return refBase;
}

+ (id) initWithUrlPosts {
    Firebase *refBasePosts = [[Firebase alloc] initWithUrl:@"https://objectivec-insta-app.firebaseio.com/posts"];
    return refBasePosts;
}

+ (id) initWithUrlUsers {
    Firebase *refBaseUsers = [[Firebase alloc] initWithUrl:@"https://objectivec-insta-app.firebaseio.com/users"];
    return refBaseUsers;
}

+ (void) creatNewUserAccountWithUID: (NSString*)uid userName:(NSDictionary*)user {
    Firebase *newUser = [[[Firebase alloc] initWithUrl:@"https://objectivec-insta-app.firebaseio.com/users"] childByAppendingPath:uid];
    [newUser setValue:user];
}

@end