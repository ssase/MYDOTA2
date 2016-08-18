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

+ (NSArray *)fetchHeroAbilitiesWithHeroID:(NSString *)heroID
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSArray *heroAbilities = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeroAbility"];
    request.predicate = [NSPredicate predicateWithFormat:@"heroID = %@",heroID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)) {
        //handle errors
    }else if([matches count]) {
        heroAbilities = matches;
    }else {
        //deal with the situation when it doesn't exist
    }
    return heroAbilities;
}

+ (NSArray *)heroAbilitiesWithDota2Info:(NSDictionary *)heroDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSMutableArray *heroAbilities = nil;
    
    NSString *heroID = [NSString stringWithFormat:@"%@",heroDictionary[DOTA2_HERO_ID]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeroAbility"];
    request.predicate = [NSPredicate predicateWithFormat:@"heroID = %@",heroID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)) {
        //handle errors
    }else if([matches count]) {
        heroAbilities = [NSMutableArray arrayWithArray:matches];
    }else {
        
        NSURL *jsonURL = [[NSBundle mainBundle] URLForResource:@"HeroInfo" withExtension:@"json"];
        NSError *error;
        NSArray *heroInfoArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:jsonURL] options:0 error:&error];
        
        if (error) {
            //deal with the error
        }else {
            
            NSArray *abilities = nil;
            NSString *heroName = [[NSString stringWithFormat:@"%@",heroDictionary[DOTA2_HERO_NAME]] stringByReplacingOccurrencesOfString:DOTA2_HERO_HEADER withString:@""];
            NSString *heroAbilitiesKeyPath = [heroName stringByAppendingString:@".hero_abilities"];
            abilities = [heroInfoArray valueForKeyPath:heroAbilitiesKeyPath];
            
            for (NSArray *abilityArray in abilities) {

                if (![abilityArray isKindOfClass:[NSNull class]]) {
                    
                    for (NSDictionary *abilityDic in abilityArray) {
                        
                        HeroAbility *ability= [NSEntityDescription insertNewObjectForEntityForName:@"HeroAbility" inManagedObjectContext:context];
                        
                        ability.heroID = heroID;
                        ability.whoseAbility = [Hero heroWithDota2Info:heroDictionary inManagedObjectContext:context];
                                        
                        ability.abilityName = [abilityDic valueForKey:DOTA2_HERO_ABILITY_NAME];
                        ability.abilityLocalizedName = [abilityDic valueForKey:DOTA2_HERO_ABILITY_LOCALIZED_NAME];
                        ability.abilityNote = [abilityDic valueForKey:DOTA2_HERO_ABILITY_NOTE];
                        ability.abilityDiscription = [abilityDic valueForKey:DOTA2_HERO_ABILITY_DESCRIPTION];
                        ability.abilityLore = [abilityDic valueForKey:DOTA2_HERO_ABILITY_LORE];
                        
                        int state = [[abilityDic valueForKey:DOTA2_HERO_ABILITY_STATE] intValue];
                        ability.abilityState = [[NSNumber alloc]initWithInt:state];;

                        [heroAbilities addObject:ability];
                    }
                }
            }
        }
    }
    
    return heroAbilities;
}


+ (void)loadHeroesAbilitiesFromDota2Array:(NSArray *)heroes
        intoManagedObjectContext:(NSManagedObjectContext *)context
{
    
    for (NSDictionary *hero in heroes) {
        [self heroAbilitiesWithDota2Info:hero inManagedObjectContext:context];
    }
}


@end
