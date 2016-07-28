//
//  Hero.m
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "Hero.h"
#import "Dota2Fetcher.h"

@implementation Hero

// Insert code here to add functionality to your managed object subclass


+ (Hero *)heroWithDota2Info:(NSDictionary *)heroDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    Hero *hero = nil;
    
    NSString *heroID = [NSString stringWithFormat:@"%@",heroDictionary[DOTA2_HERO_ID]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hero"];
    request.predicate = [NSPredicate predicateWithFormat:@"heroID = %@",heroID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)||([matches count] > 1)) {
        //handle errors
    }else if([matches count]) {
        
        hero = [matches firstObject];
    }else {

        hero = [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:context];
        hero.heroID = heroID;
        hero.name = [heroDictionary[DOTA2_HERO_NAME]stringByReplacingOccurrencesOfString:DOTA2_HERO_HEADER withString:@""];
        hero.name = [hero.name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        hero.localizedName = heroDictionary[DOTA2_HERO_LOCALIZED_NAME] ;
        
        //获取英雄名字拼音
        NSMutableString *heroName_pinyin = [NSMutableString stringWithString:hero.localizedName];
        CFStringTransform((CFMutableStringRef)heroName_pinyin, NULL, kCFStringTransformToLatin, false);
        CFStringTransform((CFMutableStringRef)heroName_pinyin, NULL, kCFStringTransformStripDiacritics, false);
        hero.namePinyin = heroName_pinyin;
        hero.namePinyinHeader = [[heroName_pinyin substringToIndex:1] uppercaseString];
        NSLog(@"%@",hero.namePinyinHeader);
        
        hero.iconURL = [Dota2Fetcher getHeroeroIconURLStringWithHeroName:hero.name withFormate:DOTA2_HERO_ICON_FORMATE_VERT];
        
        
    }
    
    return hero;
}


+ (void)loadHeroesFromDota2Array:(NSArray *)heroes
        intoManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"%lu",(unsigned long)[heroes count]);

    for (NSDictionary *hero in heroes) {
        [self heroWithDota2Info:hero inManagedObjectContext:context];
    }
}


@end
