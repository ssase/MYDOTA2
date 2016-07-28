//
//  Dota2Fetcher.m
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "Dota2Fetcher.h"
#import "Dota2APIKey.h"


@implementation Dota2Fetcher

#pragma mark - get info

+ (NSDictionary *)executeDota2Fetch:(NSString *)quary
{
    quary = [NSString stringWithFormat:@"%@?key=%@&language=zh",quary,DOTA2_API_KEY];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:quary] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    return results;
}

+ (NSArray *)heroes
{
    NSString *quary = [NSString stringWithFormat:@"http://api.steampowered.com/IEconDOTA2_570/GetHeroes/v1/"];
    
    return [[self executeDota2Fetch:quary] valueForKeyPath:@"result.heroes"];
}

+ (NSArray *)items
{
    NSString *quary = [NSString stringWithFormat:@"http://api.steampowered.com/IEconDOTA2_570/GetGameItems/v1/"];
    
    return [[self executeDota2Fetch:quary] valueForKeyPath:@"result.items"];
}

#pragma mark - get icon

+ (NSString *)getItemIconURLStringWithItemName:(NSString *)itemName
{
    return [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",itemName];
}

+ (NSString *)getHeroeroIconURLStringWithHeroName:(NSString *)heroName withFormate:(NSString *)formate
{
    return [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_%@",heroName,formate];
}

@end
