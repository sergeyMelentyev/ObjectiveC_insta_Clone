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

@end