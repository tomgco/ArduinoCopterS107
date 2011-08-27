//
//  RemoteControl.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"
#import "Xbox360Controller.h"

@interface RemoteControl : NSViewController {
	SerialCommunication *serialCommunication;
	IBOutlet NSSlider *throttle, *trim, *yaw, *pitch;
	NSSegmentedControl *channelSelect;
	IBOutlet NSButton *connect;
	
	IBOutlet NSLevelIndicator *throttleJoystick;
	
	Xbox360Controller *controller;
}

@property (retain, nonatomic) IBOutlet NSSegmentedControl *channelSelect;
@property (retain, nonatomic) Xbox360Controller *controller;

- (IBAction)tryToConnect:(id)sender;
- (void) sendPacket:(int)channel yaw:(int)yaw pitch:(int)pitch throttle:(int)throttle trimAdjust:(int)trimAdjust;
- (void) startTimer;

@end
