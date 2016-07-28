//
//  HeroAbility.m
//  MYDOTA2
//
//  Created by SASE on 7/20/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "HeroAbility.h"
#import "Hero.h"
#import "MYDOTA2_Availability.h"

@implementation HeroAbility

// Insert code here to add functionality to your managed object subclass

+ (HeroAbility *)heroAbilityWithDota2Info:(NSDictionary *)heroDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    HeroAbility *heroAbility = nil;
    
    NSString *heroID = [NSString stringWithFormat:@"%@",heroDictionary[DOTA2_HERO_ID]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeroAbility"];
    request.predicate = [NSPredicate predicateWithFormat:@"heroID = %@",heroID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)||([matches count] > 1)) {
        //handle errors
    }else if([matches count]) {
        heroAbility = [matches firstObject];
    }else {
        
        heroAbility = [NSEntityDescription insertNewObjectForEntityForName:@"HeroAbility" inManagedObjectContext:context];
        heroAbility.heroID = heroID;

        //heroAbility.abilityName
        //heroAbility.abilityState
        //heroAbility.abilityDiscription
        //heroAbility.abilityIconURL
        
    }
    
    return heroAbility;
}


+ (void)loadHeroesAbilityFromDota2Array:(NSArray *)heroes
        intoManagedObjectContext:(NSManagedObjectContext *)context
{
    
    for (NSDictionary *hero in heroes) {
        [self heroAbilityWithDota2Info:hero inManagedObjectContext:context];
    }
}


@end
