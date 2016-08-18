//
//  HeroCDTVC.m
//  MYDOTA2
//
//  Created by SASE on 7/9/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "HeroCDTVC.h"
#import "Hero.h"
#import "MYDOTA2_Availability.h"
#import "HeroTableViewCell.h"
#import "HeroDetailViewController.h"

@interface HeroCDTVC () <UITableViewDelegate>

@property (nonatomic) id managedObjectContextObserver;

@end

@implementation HeroCDTVC

- (void)awakeFromNib
{
    _managedObjectContextObserver = [[NSNotificationCenter defaultCenter]addObserverForName:managedObjectContextNotification
        object:nil queue:nil
        usingBlock:^(NSNotification * _Nonnull note) {
            self.managedObjectContect = [note.userInfo valueForKey:content_managedObjectContext];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"英雄";
    NSLog(@"++++viewDidLoad");
    //self.navigationController.navigationBarHidden = YES;
    //self.navigationController = [[UINavigationController alloc]initWithRootViewController:self];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"______view did appear");
}

- (void)setManagedObjectContect:(NSManagedObjectContext *)managedObjectContect
{
    _managedObjectContect = managedObjectContect;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hero"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"namePinyinHeader" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"namePinyin" ascending:YES]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                            initWithFetchRequest:request
                            managedObjectContext:_managedObjectContect
                            sectionNameKeyPath:@"namePinyinHeader"
                            cacheName:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HeroDetailViewController"];
    
    //pass info to the coming view
    detailViewController.context = self.managedObjectContect;
    Hero *hero = [self.fetchedResultsController objectAtIndexPath:indexPath];
    detailViewController.heroID = hero.heroID;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"hero cell";
    
    /** NOTE: This method can return nil so you need to account for that in code */
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // NOTE: Add some code like this to create a new cell if there are none to reuse
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HeroCell" owner:self options:nil]lastObject];
        NSLog(@"%f",cell.frame.size.width);
    }
    
    Hero *hero = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.heroLocalizedNameLabel.text = hero.localizedName;
    cell.heroNameLabel.text = hero.name;
    cell.heroIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[hero.name stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
    //NSLog(@"%@",hero.name);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.width/6;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_managedObjectContextObserver];
}


@end
