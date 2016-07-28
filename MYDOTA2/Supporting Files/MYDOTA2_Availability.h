//
//  MYDOTA2_Availability.h
//  MYDOTA2
//
//  Created by SASE on 7/19/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#ifndef MYDOTA2_Availability_h
#define MYDOTA2_Availability_h

#define managedObjectContextNotification @"managedObjectContextNotification"
#define content_managedObjectContext @"content_managedObjectContext"

#define USERINFOLISTPATH           [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"User_Info_List.plist"]

#define DOTA2_HERO_HEADER            @"npc_dota_hero_"

#define DOTA2_ITEM_ID                @"id"
#define DOTA2_ITEM_NAME              @"name"
#define DOTA2_ITEM_COST              @"cost"
#define DOTA2_ITEM_SECRET_SHOP       @"secret_shop"
#define DOTA2_ITEM_SIDE_SHOP         @"side_shop"
#define DOTA2_ITEM_RECIPE            @"recipe"
#define DOTA2_ITEM_LOCALIZED_NAME    @"localized_name"

#define DOTA2_HERO_ID                @"id"
#define DOTA2_HERO_NAME              @"name"
#define DOTA2_HERO_LOCALIZED_NAME    @"localized_name"

#define DOTA2_HERO_ICON_FORMATE_SB   @"sb.png"
#define DOTA2_HERO_ICON_FORMATE_LG   @"lg.png"
#define DOTA2_HERO_ICON_FORMATE_FULL @"full.png"
#define DOTA2_HERO_ICON_FORMATE_VERT @"vert.jpg"


#endif /* MYDOTA2_Availability_h */
