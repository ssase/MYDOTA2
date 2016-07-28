//
//  Hero.h
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@class HeroDetail;
@class HeroAbility;

@interface Hero : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Hero *)heroWithDota2Info:(NSDictionary *)heroDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadHeroesFromDota2Array:(NSArray *)heroes
       intoManagedObjectContext:(NSManagedObjectContext *)context;


@end

NS_ASSUME_NONNULL_END

#import "Hero+CoreDataProperties.h"
