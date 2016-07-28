//
//  Dota2Fetcher.h
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYDOTA2_Availability.h"

@interface Dota2Fetcher : NSObject

+ (NSArray *)heroes;
+ (NSArray *)items;
+ (NSString *)getItemIconURLStringWithItemName:(NSString *)itemName;
+ (NSString *)getHeroeroIconURLStringWithHeroName:(NSString *)heroName withFormate:(NSString *)formate;

@end
