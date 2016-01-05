//
//  FLTableViewCell.h
//  FLTask
//
//  Created by Dmytro Benedyk on 1/5/16.
//  Copyright © 2016 Benedyk Dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@end
