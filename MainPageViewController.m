//
//  mainPageViewController.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 28.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MainPageViewController.h"
#import "DataService.h"
#import "FireBase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainPageViewController()
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)emailButtonPressed:(id)sender;
@end

@implementation MainPageViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)facebookButtonPressed:(id)sender {
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    [facebookLogin logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Facebook login failed. Error: %@", error);
        } else if (result.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            [[DataService initWithUrl] authWithOAuthProvider:@"facebook" token: accessToken withCompletionBlock:^(NSError *error, FAuthData *authData) {
                if (error != nil) {
                    NSLog(@"Login Error: %@", error);
                } else {
                    NSLog(@"Login success");
                    [[NSUserDefaults standardUserDefaults] setValue:authData.uid forKey:@"uid"];
                }
            }];
        }
    }];
}

- (IBAction)emailButtonPressed:(id)sender {

}

@end







