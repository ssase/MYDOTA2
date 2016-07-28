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

@interface HeroCDTVC ()

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
    //self.navigationController.navigationBarHidden = YES;

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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"hero cell";
    
    /** NOTE: This method can return nil so you need to account for that in code */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // NOTE: Add some code like this to create a new cell if there are none to reuse
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    Hero *hero = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = hero.localizedName;
    cell.detailTextLabel.text = hero.name;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[hero.name stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
    //NSLog(@"%@",hero.name);
    
    return cell;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_managedObjectContextObserver];
}


@end
