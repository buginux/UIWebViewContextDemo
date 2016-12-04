//
//  XGContactCell.h
//  UIWebViewContextDemo
//
//  Created by wordbeyondyoung on 16/11/17.
//  Copyright © 2016年 swiftyper. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kContactCellIdentifier;

@interface XGContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
