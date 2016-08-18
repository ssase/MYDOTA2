//
//  HeroDetailViewController.h
//  MYDOTA2
//
//  Created by SASE on 7/27/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailViewController : UIViewController

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSString *heroID;

@end
