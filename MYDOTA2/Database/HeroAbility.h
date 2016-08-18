//
//  HeroAbility.h
//  MYDOTA2
//
//  Created by SASE on 7/20/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

NS_ASSUME_NONNULL_BEGIN

@interface HeroAbility : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (NSArray *)fetchHeroAbilitiesWithHeroID:(NSString *)heroID
            inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)heroAbilitiesWithDota2Info:(NSDictionary *)heroDictionary
            inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadHeroesAbilitiesFromDota2Array:(NSArray *)heroes
            intoManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "HeroAbility+CoreDataProperties.h"
