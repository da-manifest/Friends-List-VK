//
//  AppDelegate.m
//  Friends List VK
//
//  Created by Admin on 15/07/16.
//  Copyright © 2016 da_manifest. All rights reserved.
//

#import "AppDelegate.h"
#import "VKSdk.h"
#import "FLNotificationConstants.h"

@interface AppDelegate () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    VKSdk *sdk = [VKSdk initializeWithAppId:@"5549191"];
    [sdk registerDelegate:self];
    [sdk setUiDelegate:self];
    
    self.window = [UIWindow new];
    [self.window makeKeyAndVisible];
    
    UIStoryboard *loading = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
    [self.window setRootViewController:[loading instantiateInitialViewController]];

    [self wakeUpSessionVK];
    
    return YES;
}

- (void)wakeUpSessionVK
{
    [VKSdk wakeUpSession:VKSCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [self.window setRootViewController:[main instantiateInitialViewController]];
        } else if (error) {
            UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            [self.window setRootViewController:[login instantiateInitialViewController]];        }
    }];
}

- (void) vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FLNotificationAuthorizationFinished object:result];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.window setRootViewController:[main instantiateInitialViewController]];
}

- (void) vkSdkUserAuthorizationFailed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FLNotificationAuthorizationFailed object:nil];
}

- (void) vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self.window.rootViewController];
}

- (void) vkSdkShouldPresentViewController:(UIViewController *)controller
{
    [self.window.rootViewController presentViewController:controller animated:YES completion:^{
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
