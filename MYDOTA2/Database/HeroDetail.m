//
//  HeroDetail.m
//  MYDOTA2
//
//  Created by SASE on 7/20/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "HeroDetail.h"
#import "Hero.h"
#import "MYDOTA2_Availability.h"

@implementation HeroDetail

// Insert code here to add functionality to your managed object subclass

+ (HeroDetail *)heroDetailWithDota2Info:(NSDictionary *)heroDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    HeroDetail *hero = nil;
    
    NSString *heroID = [NSString stringWithFormat:@"%@",heroDictionary[DOTA2_HERO_ID]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeroDetail"];
    request.predicate = [NSPredicate predicateWithFormat:@"heroID = %@",heroID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)||([matches count] > 1)) {
        //handle errors
    }else if([matches count]) {
        hero = [matches firstObject];
    }else {
        
        hero = [NSEntityDescription insertNewObjectForEntityForName:@"HeroDetail" inManagedObjectContext:context];
        hero.heroID = heroID;
        
        //hero.heroRelated = @"";
        //hero.heroDiscription = @"";
        
    }
    
    return hero;
}


+ (void)loadHeroesDetailFromDota2Array:(NSArray *)heroes
        intoManagedObjectContext:(NSManagedObjectContext *)context
{
    
    for (NSDictionary *hero in heroes) {
        [self heroDetailWithDota2Info:hero inManagedObjectContext:context];
    }
}


@end
