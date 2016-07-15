//
//  LoginViewController.m
//  Friends List VK
//
//  Created by Admin on 16/07/16.
//  Copyright © 2016 da_manifest. All rights reserved.
//

#import "LoginViewController.h"
#import "VKsdk.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction) loginAction:(id)sender
{
    [VKSdk authorize:@[@"friends"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
