//
//  Item+CoreDataProperties.h
//  MYDOTA2
//
//  Created by SASE on 7/24/16.
//  Copyright © 2016 SASE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *iconURL;
@property (nullable, nonatomic, retain) NSString *itemID;
@property (nullable, nonatomic, retain) NSString *localizedName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) ItemDetail *detail;

@end

NS_ASSUME_NONNULL_END
