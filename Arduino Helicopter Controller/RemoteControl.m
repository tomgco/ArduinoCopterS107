//
//  RemoteControl.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteControl.h"
#import <dispatch/dispatch.h>
#import <DDHidLib/DDHidJoystick.h>

#define CHANNEL1 0
#define CHANNEL2 1

@implementation RemoteControl

@interface RemoteControl (Private)

- (void) setJoysticks: (NSArray *) theJoysticks;

@end

@synthesize channelSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
			serialCommunication = [SerialCommunication sharedSerialConnection];
    }
		[self startTimer];
    return self;
}

- (void) awakeFromNib {
	NSArray * joysticks = [DDHidJoystick allJoysticks];
	
	mJoystickButtons = [[NSMutableArray alloc] init];
	[joysticks makeObjectsPerformSelector: @selector(setDelegate:)
														 withObject: self];
	[self setJoysticks: joysticks];
	if ([mJoysticks count] > 0)
		[self setJoystickIndex: 0];
	else
		[self setJoystickIndex: NSNotFound];
}

- (void) startTimer {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue); //run event handler on the default global queue
	dispatch_time_t now = dispatch_walltime(DISPATCH_TIME_NOW, 0);
	dispatch_source_set_timer(timer, now, 125ull * NSEC_PER_MSEC, 5000ull);
	dispatch_source_set_event_handler(timer, ^{
		[self sendPacket:CHANNEL1 yaw:[yaw intValue] pitch:[pitch intValue] throttle:([throttleJoystick intValue] + 65536) / 1032 trimAdjust:[trim intValue]];
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
	NSString *packet = [[NSString alloc] initWithFormat:@"%c%c%c%c%c%c", 0x4C, 0x4F, y, p, throttleWithChannel + 1, trimAdjust];
	
	[serialCommunication writePacket:packet];
}

//=========================================================== 
//  joysticks 
//=========================================================== 
- (NSArray *) joysticks
{
	return mJoysticks; 
}

- (NSArray *) joystickButtons;
{
	return mJoystickButtons;
}

//=========================================================== 
//  joystickIndex 
//=========================================================== 
- (unsigned long) joystickIndex
{
	return mJoystickIndex;
}

- (void) setJoystickIndex: (unsigned long) theJoystickIndex
{
	if (mCurrentJoystick != nil)
	{
		[mCurrentJoystick stopListening];
		mCurrentJoystick = nil;
	}
	mJoystickIndex = theJoystickIndex;
	[mJoysticksController setSelectionIndex: mJoystickIndex];
	if (mJoystickIndex != NSNotFound)
	{
		mCurrentJoystick = [mJoysticks objectAtIndex: mJoystickIndex];
		[mCurrentJoystick startListening];
		
		[self willChangeValueForKey: @"joystickButtons"];
		[mJoystickButtons removeAllObjects];
		NSArray * buttons = [mCurrentJoystick buttonElements];
		NSEnumerator * e = [buttons objectEnumerator];
		DDHidElement * element;
		while (element = [e nextObject])
		{
			[[element usage] usageName];
		}
		[self didChangeValueForKey: @"joystickButtons"];
	}
}

- (int) xAxis;
{
	return mXAxis;
}

- (int) yAxis;
{
	return mYAxis;
}

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
stick: (unsigned) stick
xChanged: (int) value;
{
	[self willChangeValueForKey: @"xAxis"];
	mXAxis = value;
	[self didChangeValueForKey: @"xAxis"];
}

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
stick: (unsigned) stick
yChanged: (int) value;
{
	[self willChangeValueForKey: @"yAxis"];
	mYAxis = value;
	[self didChangeValueForKey: @"yAxis"];
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
stick: (unsigned) stick
otherAxis: (unsigned) otherAxis
valueChanged: (int) value;
{
	// Somehow display values here
//	NSLog(@"Stick: %d, other axis: %d, changed: %d", stick, otherAxis, value);
	switch(stick) {
		case 2:	// Triggers
			switch (otherAxis) {
				case 1: //right
					[throttleJoystick setIntValue:value];
					break;
				case 0: //left
					break;
			}
			break;
	}
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
stick: (unsigned) stick
povNumber: (unsigned) povNumber
valueChanged: (int) value;
{
	// Somehow display values here
//	NSLog(@"Stick: %d, POV number: %d, changed: %d", stick, povNumber, value);
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
buttonDown: (unsigned) buttonNumber;
{
//	ButtonState * state = [mJoystickButtons objectAtIndex: buttonNumber];
//	[state setPressed: YES];
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
buttonUp: (unsigned) buttonNumber;
{
//	ButtonState * state = [mJoystickButtons objectAtIndex: buttonNumber];
//	[state setPressed: NO];
}
																		

@end

@implementation RemoteControl (Private)

- (void) setJoysticks: (NSArray *) theJoysticks
{
	if (mJoysticks != theJoysticks)	{
		mJoysticks = theJoysticks;
	}
}

@end
