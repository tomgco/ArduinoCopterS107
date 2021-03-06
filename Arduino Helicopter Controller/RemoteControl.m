//
//  RemoteControl.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteControl.h"
#import <dispatch/dispatch.h>
#import "ArduinoCopterS107.h"

#define CHANNEL1 0x31
#define CHANNEL2 0x32
#define CENTERED 63

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
	
	timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue); //run event handler on the default global queue
	dispatch_time_t now = dispatch_walltime(DISPATCH_TIME_NOW, 0);
	dispatch_source_set_timer(timer, now, 140ull * NSEC_PER_MSEC, 5000ull);
	dispatch_source_set_event_handler(timer, ^{
		[self sendPacket:CHANNEL1 yaw:[yaw intValue] pitch:[pitch intValue] throttle:[throttleJoystick intValue] trimAdjust:[trim intValue]];
//		NSLog(@"%d %d %d %d", [yaw intValue], [pitch intValue], [throttleJoystick intValue], [trim intValue]);
		if ([[NSApp delegate] isSerialPortConnected] == YES) {
			
			// set Status to green.
		} else {
			[self stopTimer];
			// set status to red.
		}
	});
	
	
	// now that our timer is all set to go, start it
	dispatch_resume(timer);
}

- (void) stopTimer {
	if (timer != nil) {
//		dispatch_release(timer);
	}
}

- (void) sendPacket:(int)channel yaw:(int)y pitch:(int)p throttle:(int)t trimAdjust:(int)trimAdjust {
	y = y > 126 ? 126 : y;
	p = p > 126 ? 126 : p;
	t = t > 126 ? 126 : t;
	trimAdjust = trimAdjust > 126 ? 126 : trimAdjust;
	
	NSString *packet = [[NSString alloc] initWithFormat:@"%c%c%c%c%c%c%c", 0x4C, 0x4F, CHANNEL1, (uint8_t)y + 1, (uint8_t)p + 1, (int)t + 1, (uint8_t)trimAdjust + 1];
	
	[serialCommunication writePacket:packet];
}			

- (void) RCTriggerRT:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	// To use for Throttle;
	[throttleJoystick setIntValue:([value intValue] + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP];
}

- (void) RCRightJoystickX:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	[yaw setIntValue:[self flattenWobbleyValues:((~[value intValue]) + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP sensitivity:10]];
}

- (void) RCRightJoystickY:(DDHidJoystick *)joystick valueChanged:(NSNumber *)value {
	[pitch setIntValue:[self flattenWobbleyValues:(([value intValue]) + MAX_POSITION_ON_AXIS_XBOX) / MAX_POSITION_ON_AXIS_XBOX_STEP sensitivity:12]];
}

- (void) RCButtonLB:(DDHidJoystick *)joystick state:(BOOL)pressed {
	[trim setIntValue: [trim intValue] + 1];
}

- (void) RCButtonRB:(DDHidJoystick *)joystick state:(BOOL)pressed {
	[trim setIntValue: [trim intValue] -1];
}

- (int) flattenWobbleyValues: (int) axisValue sensitivity:(int)sensitivity {
	// 1 is really sensitive, treat her carfully ;)
	// 127 is on off.
	
	if (axisValue > CENTERED) {
		
		if ((axisValue - sensitivity) < CENTERED) {
			return CENTERED;
		}
	} else if (axisValue < CENTERED){
		if ((axisValue + sensitivity) > CENTERED) {
			return CENTERED;
		}
	}
	
	return axisValue;
}

@end
