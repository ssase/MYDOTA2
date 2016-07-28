//
//  Item.h
//  MYDOTA2
//
//  Created by SASE on 7/8/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@class ItemDetail;

@interface Item : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Item *)itemWithDota2Info:(NSDictionary *)itemDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadItemsFromDota2Array:(NSArray *)items
        intoManagedObjectContext:(NSManagedObjectContext *)context;



@end

NS_ASSUME_NONNULL_END

#import "Item+CoreDataProperties.h"
