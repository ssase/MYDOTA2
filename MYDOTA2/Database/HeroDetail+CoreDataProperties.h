//
//  HeroDetail+CoreDataProperties.h
//  MYDOTA2
//
//  Created by SASE on 8/10/16.
//  Copyright © 2016 SASE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HeroDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeroDetail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *heroBio;
@property (nullable, nonatomic, retain) NSString *heroID;
@property (nullable, nonatomic, retain) NSString *heroRelated;
@property (nullable, nonatomic, retain) Hero *whoseDetail;

@end

NS_ASSUME_NONNULL_END
