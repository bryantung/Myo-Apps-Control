//
//  PresetModel.h
//  Myo-Apps Control
//
//  Created by Bryan Tung on 8/14/15.
//  Copyright (c) 2015 BT. All rights reserved.
//

#import "BaseModel.h"

@interface PresetModel : BaseModel

- (NSArray *)appsList;
- (NSArray *)commandsListForApp:(NSString *)app;

@end
