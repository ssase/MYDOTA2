//
//  Hero+CoreDataProperties.h
//  MYDOTA2
//
//  Created by SASE on 7/25/16.
//  Copyright © 2016 SASE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hero.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *heroID;
@property (nullable, nonatomic, retain) NSString *iconURL;
@property (nullable, nonatomic, retain) NSString *localizedName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *namePinyin;
@property (nullable, nonatomic, retain) NSString *namePinyinHeader;
@property (nullable, nonatomic, retain) HeroAbility *ability;
@property (nullable, nonatomic, retain) HeroDetail *detail;

@end

@interface Hero (CoreDataGeneratedAccessors)

- (void)addAbilityObject:(HeroAbility *)value;
- (void)removeAbilityObject:(HeroAbility *)value;
- (void)addAbility:(NSSet<HeroAbility *> *)values;
- (void)removeAbility:(NSSet<HeroAbility *> *)values;

@end

NS_ASSUME_NONNULL_END
