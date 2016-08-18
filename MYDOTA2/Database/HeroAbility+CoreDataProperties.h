//
//  HeroAbility+CoreDataProperties.h
//  MYDOTA2
//
//  Created by SASE on 8/11/16.
//  Copyright © 2016 SASE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HeroAbility.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeroAbility (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *abilityDiscription;
@property (nullable, nonatomic, retain) NSString *abilityLore;
@property (nullable, nonatomic, retain) NSString *abilityName;
@property (nullable, nonatomic, retain) NSString *abilityNote;
@property (nullable, nonatomic, retain) NSNumber *abilityState;
@property (nullable, nonatomic, retain) NSString *heroID;
@property (nullable, nonatomic, retain) NSString *abilityLocalizedName;
@property (nullable, nonatomic, retain) Hero *whoseAbility;

@end

NS_ASSUME_NONNULL_END
