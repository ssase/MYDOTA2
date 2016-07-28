//
//  ItemDetail+CoreDataProperties.h
//  MYDOTA2
//
//  Created by SASE on 7/24/16.
//  Copyright © 2016 SASE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ItemDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemDetail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cost;
@property (nullable, nonatomic, retain) NSString *itemDiscription;
@property (nullable, nonatomic, retain) NSString *itemID;
@property (nullable, nonatomic, retain) NSString *recipe;
@property (nullable, nonatomic, retain) NSNumber *secretShop;
@property (nullable, nonatomic, retain) NSNumber *sideShop;
@property (nullable, nonatomic, retain) Item *whoseDetail;

@end

NS_ASSUME_NONNULL_END
