//
//  mainPageViewController.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 28.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController()
@property (weak, nonatomic) IBOutlet UITextField *emailAdress;
@property (weak, nonatomic) IBOutlet UITextField *emailPassword;
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)emailButtonPressed:(id)sender;
@end

@implementation LoginPageViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"uid"] != nil) {
        [self performSegueWithIdentifier:@"loggedIn" sender:nil];
    }
}

#pragma mark - Facebook login

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
                    NSLog(@"Facebook login Error: %@", error);
                } else {
                    NSLog(@"Facebook login success");
                    
                    // ADD NEW FB USER
                    NSDictionary *user = [NSDictionary dictionaryWithObject:authData.provider forKey:@"provider"];
                    [DataService creatNewUserAccountWithUID:authData.uid userName:user];
                    
                    // SAVE UID FOR AUTOLOGIN NEXT TIME
                    [[NSUserDefaults standardUserDefaults] setValue:authData.uid forKey:@"uid"];
                    [self performSegueWithIdentifier:@"loggedIn" sender:nil];
                }
            }];
        }
    }];
}

#pragma mark - Email login

- (IBAction)emailButtonPressed:(id)sender {
    if ([self.emailAdress.text isEqualToString:@""] || [self.emailPassword.text isEqualToString:@""]) {
        [self showErrorAlertWithTitle:@"Sorry" message:@"Email and Password required"];
    } else {
        [[DataService initWithUrl] authUser:self.emailAdress.text password:self.emailPassword.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
            if (error.code == -8) {
                [self createNewUserAlertWithTitle:@"Create new user?" message:[NSString stringWithFormat:@"User %@ does not exist", self.emailAdress.text] address:self.emailAdress.text password:self.emailPassword.text];
            } else if (error.code == -6) {
                [self showErrorAlertWithTitle:@"Could not login" message:@"Password is incorrect"];
                self.emailPassword.text = @"";
            } else {
                // [[NSUserDefaults standardUserDefaults] setValue:authData.uid forKey:@"uid"];
                [self performSegueWithIdentifier:@"loggedIn" sender:nil];
            }
        }];
    }
}

#pragma mark - Alert section

// Error alert function with one action
- (void) showErrorAlertWithTitle: (NSString*)title message:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

// Create new user alert with two actions
- (void) createNewUserAlertWithTitle: (NSString*)title message:(NSString*)msg address:(NSString*)address password:(NSString*)pass {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addNewUserAddress:address password:pass];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.emailAdress.text = @"";
        self.emailPassword.text = @"";
    }];
    [alert addAction:addAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Add new user to the Base

// Add new user to the Firebase
- (void) addNewUserAddress: (NSString*)address password:(NSString*)pass {
    [[DataService initWithUrl] createUser:address password:pass withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error != nil) {
            [self showErrorAlertWithTitle:@"Could not create account" message:@"Preblem creating account"];
        } else {
            // ADD NEW EMAIL USER
            NSDictionary *user = [NSDictionary dictionaryWithObject:@"email" forKey:@"provider"];
            [DataService creatNewUserAccountWithUID:[result objectForKey:@"uid"] userName:user];
            
            // SAVE UID FOR AUTOLOGIN NEXT TIME
            [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"uid"] forKey:@"uid"];
            [self performSegueWithIdentifier:@"loggedIn" sender:nil];
        }
    }];
}

@end