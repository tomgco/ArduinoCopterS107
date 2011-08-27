//
//  RemoteControl.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteControl.h"
#import <dispatch/dispatch.h>

#define CHANNEL1 0
#define CHANNEL2 1

@implementation RemoteControl

@synthesize channelSelect,
						controller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
			controller = [[Xbox360Controller alloc] init];
			[controller setDelegate:self];
			serialCommunication = [SerialCommunication sharedSerialConnection];
    }
		[self startTimer];
    return self;
}

- (void) startTimer {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue); //run event handler on the default global queue
	dispatch_time_t now = dispatch_walltime(DISPATCH_TIME_NOW, 0);
	dispatch_source_set_timer(timer, now, 125ull * NSEC_PER_MSEC, 5000ull);
	dispatch_source_set_event_handler(timer, ^{
		[self sendPacket:CHANNEL1 yaw:[yaw intValue] pitch:[pitch intValue] throttle:[throttleJoystick intValue] trimAdjust:[trim intValue]];
	});
	
	
	// now that our timer is all set to go, start it
	dispatch_resume(timer);
}

- (IBAction)tryToConnect:(id)sender {
	//[serialCommunication writeByte:126]; // handshake.
	if ([serialCommunication readByte] > 0) {
		[connect setTitle:@"Disconnect"];
	}

}

- (void) sendPacket:(int)channel yaw:(int)y pitch:(int)p throttle:(int)t trimAdjust:(int)trimAdjust {
	int throttleWithChannel = (channel == CHANNEL1) ? t : (t + 128);
	NSString *packet = [[NSString alloc] initWithFormat:@"%c%c%c%c%c%c", 0x4C, 0x4F, y, p, throttleWithChannel, trimAdjust];
	
	[serialCommunication writePacket:packet];
}			

- (void) RCTriggerRT:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	// To use for Throttle;
	[throttleJoystick setIntValue:([value intValue] + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP];
}

- (void) RCRightJoystickX:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	[yaw setIntValue:([value intValue] + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP];
}

- (void) RCRightJoystickY:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	[pitch setIntValue:([value intValue] + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP];
}

- (void) RCButtonLB:(DDHidJoystick *)joystick state:(BOOL)pressed {
	[trim setIntValue: [trim intValue] + 1];
}

- (void) RCButtonRB:(DDHidJoystick *)joystick state:(BOOL)pressed {
	[trim setIntValue: [trim intValue] -1];
}

@end
