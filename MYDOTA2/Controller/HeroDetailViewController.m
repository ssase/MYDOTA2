//
//  HeroDetailViewController.m
//  MYDOTA2
//
//  Created by SASE on 7/27/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "Hero.h"
#import "HeroDetailView.h"
#import "Dota2Fetcher.h"
#import "HeroDetail.h"
#import "HeroAbility.h"

@interface HeroDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *heroDetailScrollView;
@property (nonatomic) HeroDetailView *detailView;
@property (nonatomic) UIImage *heroImage;
@property (nonatomic,assign) int numberOfPrsentedViews;

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"-------HERO DETAIL");
    _detailView = [[[NSBundle mainBundle] loadNibNamed:@"HeroDetailViewUI" owner:self options:nil]lastObject];
    _heroDetailScrollView.bounds = [UIScreen mainScreen].bounds;
   
    //hero info
    Hero *hero = [Hero fetchHeroWithHeroID:self.heroID inManagedObjectContext:self.context];
    
    _detailView.heroNameLabel.text = hero.name;
    _detailView.localizedNameLabel.text = hero.localizedName;
    _detailView.heroBioLabel.text = [HeroDetail fetchHeroDetailWithHeroID:hero.heroID inManagedObjectContext:self.context].heroBio;
    
    hero.name = [hero.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    [[NSOperationQueue new]addOperationWithBlock:^{
    
        NSURL *url = [NSURL URLWithString:[Dota2Fetcher getHeroeroIconURLStringWithHeroName:hero.name withFormate:DOTA2_HERO_ICON_FORMATE_VERT]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.heroImage = image;
        }];
        //add the solution when no network
    }];
    
    //abilities info
    NSString *abilityNameHeader = [hero.name stringByAppendingString:@"_"];
    NSArray *abilities = [HeroAbility fetchHeroAbilitiesWithHeroID:self.heroID inManagedObjectContext:self.context];
    _numberOfPrsentedViews = [abilities count];
    
    for (int i = 0; i < _numberOfPrsentedViews; i++) {
        
        HeroAbility *ability = abilities[i];
        NSString * abilityName = [abilityNameHeader stringByAppendingString:ability.abilityName];
        int abilityState = [ability.abilityState integerValue] - 1;
        //icon
        UIImageView *iamgeView = _detailView.abilityIcons[abilityState];
        iamgeView.image = [UIImage imageNamed:abilityName];
        //name
        UILabel *nameLabel = _detailView.abilityNameLabels[abilityState];
        nameLabel.text = ability.abilityLocalizedName;
        //description
        UILabel *descriptionLabel = _detailView.abilityDescriptionLabels[abilityState];
        descriptionLabel.text = ability.abilityDiscription;
        //lore
        UILabel *loreLable = _detailView.abilityLoreLabels[abilityState];
        loreLable.text = ability.abilityLore;
        //note
        UILabel *noteLabel = _detailView.abilityNoteLabels[abilityState];
        noteLabel.text = ability.abilityNote;
        
    }
    
    //delete superfluous views
    for (int i = _numberOfPrsentedViews; i < [_detailView.abilityViews count]; i++) {
        UIView *abilityView = _detailView.abilityViews[i];
        [abilityView removeFromSuperview];
    }
    
    [self.heroDetailScrollView addSubview:_detailView];

}

- (void)setHeroImage:(UIImage *)heroImage
{
    _detailView.heroIcon.image = heroImage;
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self adaptDetailViewFrame];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

- (void)adaptDetailViewFrame
{
    UIView *view = _numberOfPrsentedViews ? [_detailView.abilityViews objectAtIndex:_numberOfPrsentedViews-1] : (UIView *)_detailView.heroBioLabel;
    float height = view.frame.origin.y + view.frame.size.height + 20;
    _detailView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    _heroDetailScrollView.contentSize = _detailView.frame.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
