//
//  MainPageViewController.m
//  ObjectiveC_insta_Clone
//
//  Created by Админ on 29.03.16.
//  Copyright © 2016 Melentyev. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayOfPostsFromServer;
- (IBAction)addNewPost:(UIBarButtonItem *)sender;
@end

@implementation MainPageViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSMutableArray *internalArrayOfPosts = [[NSMutableArray alloc] init];
    [[DataService initWithUrlPosts] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [internalArrayOfPosts removeAllObjects];
        for (FDataSnapshot* snap in snapshot.children) {
            Post *post = [[Post alloc] init];
            NSDictionary *description = [snap.value objectForKey:@"description"];
            if (description) {
                post.postDescription = [NSString stringWithFormat:@"%@", description];
            } else {
                post.postDescription = @"";
            }
            NSDictionary *imageUrl = [snap.value objectForKey:@"imageUrl"];
            if (imageUrl) {
                post.imageUrl = [NSString stringWithFormat:@"%@", imageUrl];
            } else {
                post.imageUrl = @"";
            }
            NSDictionary *likes = [snap.value objectForKey:@"likes"];
            if (likes) {
                post.likes = (NSNumber*)[NSString stringWithFormat:@"%@", likes];
            } else {
                post.likes = 0;
            }
            [internalArrayOfPosts addObject:post];
        }
        self.arrayOfPostsFromServer = internalArrayOfPosts;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table View Constructor

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPostsFromServer.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = [self.arrayOfPostsFromServer objectAtIndex:indexPath.row];
    FeedCellViewController *cell = (FeedCellViewController*)[tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    [cell configureCell:post];
    return cell;
}

- (IBAction)addNewPost:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New post" message:@"What would you like to post?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *addImg = [UIAlertAction actionWithTitle:@"Add photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"CHOOSE A PHOTO");
    }];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"NEW POST");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Write a caption...";
        textField.layer.cornerRadius = 5.0;
    }];
    [alert addAction:addImg];
    [alert addAction:addAction];
    [alert addAction:cancelAction];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end







