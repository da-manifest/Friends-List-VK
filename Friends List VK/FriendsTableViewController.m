//
//  FriendsTableViewController.m
//  Friends List VK
//
//  Created by Admin on 19/07/16.
//  Copyright © 2016 da_manifest. All rights reserved.
//

#import "FriendsTableViewController.h"
#import <VKSdk.h>
#import <VKApiFriends.h>
#import <VKRequest.h>
#import "UserTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface FriendsTableViewController ()

@property (nonatomic, readwrite, strong) NSArray *vkUsers;

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [self.refreshControl setTintColor:[UIColor blackColor]];
    
    [self.refreshControl beginRefreshing];
    
    VKRequest *request = [[VKApiFriends new] get:@{@"order" : @"mobile", @"fields" : @[@"nickname", @"photo_100", @"online"]}];
    
    [request setCompleteBlock:^(VKResponse *response) {
        [self.refreshControl endRefreshing];
        self.vkUsers = [[response parsedModel] items];
        [self.tableView reloadData];
    }];
    
    [request setErrorBlock:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
    
    [request start];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vkUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vkUser" forIndexPath:indexPath];
    
    cell.userImage.layer.cornerRadius = 10.0f;
    
    VKUser *user = self.vkUsers[indexPath.row];
    
    [cell.userName setText:[NSString stringWithFormat:@"%@ %@", user.last_name, user.first_name]];
    
    [cell.userImage setImageWithURL:[NSURL URLWithString:user.photo_100] placeholderImage:nil];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
