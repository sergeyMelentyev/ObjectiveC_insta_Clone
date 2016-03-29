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
@end

@implementation MainPageViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Table View Constructor

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
}

@end







