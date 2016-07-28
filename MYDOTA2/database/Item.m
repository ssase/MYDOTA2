//
//  Item.m
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "Item.h"
#import "Dota2Fetcher.h"

@implementation Item

// Insert code here to add functionality to your managed object subclass


+ (Item *)itemWithDota2Info:(NSDictionary *)itemDictionary
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    Item *item = nil;
    
    NSString *itemID = itemDictionary[DOTA2_ITEM_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.predicate = [NSPredicate predicateWithFormat:@"itemID = %@",itemID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)||([matches count] > 1)) {
        //handle errors
    }else if([matches count]) {
        item = [matches firstObject];
    }else {
        item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        item.itemID = itemID;
        item.name = itemDictionary[DOTA2_ITEM_NAME];
        item.localizedName = itemDictionary[DOTA2_ITEM_LOCALIZED_NAME];
        item.iconURL = [Dota2Fetcher getItemIconURLStringWithItemName:item.name];
    }
        
    return item;
}


+ (void)loadItemsFromDota2Array:(NSArray *)items
      intoManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"%lu",(unsigned long)[items count]);
    
    for (NSDictionary *item in items) {
        [self itemWithDota2Info:item inManagedObjectContext:context];
    }
}



@end
