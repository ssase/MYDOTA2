//
//  HeroTableViewCell.h
//  MYDOTA2
//
//  Created by SASE on 8/12/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *heroIcon;
@property (weak, nonatomic) IBOutlet UILabel *heroLocalizedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;

@end
