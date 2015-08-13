//
//  ViewController.m
//  Myo-Apps Control
//
//  Created by Bryan Tung on 7/26/15.
//  Copyright (c) 2015 BT. All rights reserved.
//

#import "ViewController.h"
#import "MyoHelper.h"

@interface ViewController () <MyoDelegate, NSMenuDelegate>
{
    NSArray *mPlayerActions;
}
@property (nonatomic, strong) Myo *myMyo;

@property (nonatomic, weak) IBOutlet NSPopUpButton *popupAppFist;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupActionFist;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupAppFingersSpread;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupActionFingersSpread;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupAppWaveIn;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupActionWaveIn;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupAppWaveOut;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popupActionWaveOut;

@property (nonatomic, weak) IBOutlet NSMatrix *radioFist;
@property (nonatomic, weak) IBOutlet NSMatrix *radioFingersSpread;
@property (nonatomic, weak) IBOutlet NSMatrix *radioWaveIn;
@property (nonatomic, weak) IBOutlet NSMatrix *radioWaveOut;

@property (nonatomic, weak) IBOutlet NSTextField *textCmdFist;
@property (nonatomic, weak) IBOutlet NSTextField *textCmdFingersSpread;
@property (nonatomic, weak) IBOutlet NSTextField *textCmdWaveIn;
@property (nonatomic, weak) IBOutlet NSTextField *textCmdWaveOut;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mPlayerActions = @[@"playpause",@"next",@"previous",@"activate"];

    self.myMyo = [[Myo alloc] initWithApplicationIdentifier:@"com.btmyo.mac-apps-control"];
    self.myMyo.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^(void) {
        
        // Create Loop To Keep Trying To Find & Connect To Myo
        BOOL found = false;
        while (!found) {
            found = [self.myMyo connectMyoWaiting:10000];
        }
        
        // Create Block To Run Commands on Main Thread
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            self.myMyo.updateTime = 1000; // Set the Update Time
            [self.myMyo startUpdate]; // Start Getting Updates From Myo (This Command Runs on Background Thread In Implementation)
        });
    });
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -
#pragma mark Myo delegates

- (void)myo:(Myo *)myo onPose:(MyoPose *)pose timestamp:(uint64_t)timestamp
{
    char cmd[128];
    switch (pose.poseType) {
        case MyoPoseTypeFingersSpread: {
            if (_radioFingersSpread.selectedRow==0) {
                sprintf(cmd, "osascript -e '%s'",[self.textCmdFingersSpread.stringValue UTF8String]);
            } else {
                NSString *appName = self.popupAppFingersSpread.selectedTag==0?@"Spotify":@"iTunes";
                sprintf(cmd, "osascript -e 'tell application \"%s\" to %s'",[appName UTF8String],[[self actionWithSelectedIndex:self.popupActionFingersSpread.indexOfSelectedItem] UTF8String]);
            }
            system(cmd);
        }
        break;
        
        case MyoPoseTypeFist: {
            if (_radioFist.selectedRow==0) {
                sprintf(cmd, "osascript -e '%s'",[self.textCmdFist.stringValue UTF8String]);
            } else {
                NSString *appName = self.popupActionFist.selectedTag==0?@"Spotify":@"iTunes";
                sprintf(cmd, "osascript -e 'tell application \"%s\" to %s'",[appName UTF8String],[[self actionWithSelectedIndex:self.popupActionFist.indexOfSelectedItem] UTF8String]);
            }
            system(cmd);
        }
        break;
        
        case MyoPoseTypeWaveIn: {
            if (_radioWaveIn.selectedRow==0) {
                sprintf(cmd, "osascript -e '%s'",[self.textCmdWaveIn.stringValue UTF8String]);
            } else {
                NSString *appName = self.popupActionWaveIn.selectedTag==0?@"Spotify":@"iTunes";
                sprintf(cmd, "osascript -e 'tell application \"%s\" to %s'",[appName UTF8String],[[self actionWithSelectedIndex:self.popupActionWaveIn.indexOfSelectedItem] UTF8String]);
            }
            system(cmd);
        }
        break;
        
        case MyoPoseTypeWaveOut: {
            if (_radioWaveOut.selectedRow==0) {
                sprintf(cmd, "osascript -e '%s'",[self.textCmdWaveOut.stringValue UTF8String]);
            } else {
                NSString *appName = self.popupActionWaveOut.selectedTag==0?@"Spotify":@"iTunes";
                sprintf(cmd, "osascript -e 'tell application \"%s\" to %s'",[appName UTF8String],[[self actionWithSelectedIndex:self.popupActionWaveOut.indexOfSelectedItem] UTF8String]);
            }
            system(cmd);
        }
        break;
        
        default:
        break;
    }
}

- (NSString *)actionWithSelectedIndex:(NSInteger)selectedIndex
{
    switch (selectedIndex) {
        case 0:
            return @"playpause";
        break;
        
        case 1:
            return @"next track";
        break;
        
        case 2:
            return @"previous track";
        break;
        
        case 3:
            return @"activate";
        break;
        
        default:
            return @"";
        break;
    }
}

#pragma mark -
#pragma mark IB menu delegates
- (void)menu:(NSMenu *)menu willHighlightItem:(NSMenuItem *)item
{
    if ([menu isEqualTo:self.popupAppFingersSpread.menu]) {
        
    } else if ([menu isEqualTo:self.popupAppFist.menu]) {
        
    } else if ([menu isEqualTo:self.popupAppWaveIn.menu]) {
        
    } else if ([menu isEqualTo:self.popupAppWaveOut.menu]) {
        
    } else if ([menu isEqualTo:self.popupActionFingersSpread.menu]) {
        
    } else if ([menu isEqualTo:self.popupActionFist.menu]) {
        
    } else if ([menu isEqualTo:self.popupActionWaveIn.menu]) {
        
    } else if ([menu isEqualTo:self.popupActionWaveOut.menu]) {
        
    }
}

@end
