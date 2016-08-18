//
//  HeroDetailView.h
//  MYDOTA2
//
//  Created by SASE on 8/3/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *heroIcon;
@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *localizedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroBioLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *abilityViews;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *abilityIcons;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *abilityNameLabels;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *abilityDescriptionLabels;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *abilityNoteLabels;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *abilityLoreLabels;

@end
