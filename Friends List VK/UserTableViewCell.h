//
//  UserTableViewCell.h
//  Friends List VK
//
//  Created by Admin on 19/07/16.
//  Copyright © 2016 da_manifest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
