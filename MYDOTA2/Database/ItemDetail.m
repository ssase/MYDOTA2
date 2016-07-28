//
//  ItemDetail.m
//  MYDOTA2
//
//  Created by SASE on 7/20/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "ItemDetail.h"
#import "Item.h"
#import "MYDOTA2_Availability.h"

@implementation ItemDetail

// Insert code here to add functionality to your managed object subclass

+ (ItemDetail *)itemDetailWithDota2Info:(NSDictionary *)itemDictionary
     inManagedObjectContext:(NSManagedObjectContext *)context
{
    ItemDetail *item = nil;
    
    NSString *itemID = itemDictionary[DOTA2_ITEM_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ItemDetail"];
    request.predicate = [NSPredicate predicateWithFormat:@"itemID = %@",itemID];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ((!matches)||(error)||([matches count] > 1)) {
        //handle errors
    }else if([matches count]) {
        item = [matches firstObject];
    }else {
        item = [NSEntityDescription insertNewObjectForEntityForName:@"ItemDetail" inManagedObjectContext:context];
        item.itemID = itemID;
        item.cost = itemDictionary[DOTA2_ITEM_COST];
        item.secretShop = itemDictionary[DOTA2_ITEM_SECRET_SHOP];
        item.sideShop = itemDictionary[DOTA2_ITEM_SIDE_SHOP];
        
        //Need JSON file to fill in these.
        //item.recipe = itemDictionary[DOTA2_ITEM_RECIPE];
        //item.itemDiscription =
    }
    
    return item;
}


+ (void)loadItemsDetailFromDota2Array:(NSArray *)items
       intoManagedObjectContext:(NSManagedObjectContext *)context
{
    
    for (NSDictionary *item in items) {
        [self itemDetailWithDota2Info:item inManagedObjectContext:context];
    }
}


@end
