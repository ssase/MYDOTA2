//
//  ItemDetail.h
//  MYDOTA2
//
//  Created by SASE on 7/20/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

NS_ASSUME_NONNULL_BEGIN

@interface ItemDetail : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (ItemDetail *)itemDetailWithDota2Info:(NSDictionary *)itemDictionary
            inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadItemsDetailFromDota2Array:(NSArray *)items
             intoManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "ItemDetail+CoreDataProperties.h"
