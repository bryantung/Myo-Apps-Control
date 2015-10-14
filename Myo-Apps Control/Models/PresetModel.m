//
//  PresetModel.m
//  Myo-Apps Control
//
//  Created by Bryan Tung on 8/14/15.
//  Copyright (c) 2015 BT. All rights reserved.
//

#import "PresetModel.h"

@interface PresetModel ()
@property (nonatomic, strong) NSArray *appsList;
@property (nonatomic, strong) NSArray *presets;
@end

@implementation PresetModel

- (id)init
{
    self = [super init];
    if (self) {
        [self readPresetFromFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"presets.json"]];
    }
    return self;
}

- (void)readPresetFromFile:(NSString *)presetFile
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:presetFile]) {
        NSData *presetData = [[NSFileManager defaultManager] contentsAtPath:presetFile];
        NSDictionary *presetObject = [NSJSONSerialization JSONObjectWithData:presetData options:NSJSONReadingMutableContainers error:nil];
        
        _appsList = @[];
        _presets = presetObject[@"presets"];
        [_presets enumerateObjectsUsingBlock:^(NSDictionary *preset, NSUInteger idx, BOOL *stop) {
            _appsList = [_appsList arrayByAddingObject:preset[@"app"]];
        }];
        
        NSLog(@"%@", _appsList);
        NSLog(@"%@", _presets);
    }
}

- (NSArray *)appsList
{
    return _appsList;
}

- (NSArray *)commandsListForApp:(NSString *)app
{
    NSArray *cmds = @[];
    NSUInteger aIdx = [_appsList indexOfObject:app];
    if (aIdx!=NSNotFound) {
        cmds = [[_presets objectAtIndex:aIdx] array];
    }
    return cmds;
}

@end
