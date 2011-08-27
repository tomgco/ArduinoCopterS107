//
//  Xbox360Controller.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

// This will control the Xbox 360 Controller on the mac using the driver found at http://tattiebogle.net/index.php/ProjectRoot/Xbox360Controller/OsxDriver
// This will work on lion.

#import "Xbox360Controller.h"
@implementation Xbox360Controller

@synthesize delegate;

- (id)init {
	self = [super init];
	if (self) {
		delegate = [self delegate];
	}
	return self;
}

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
								 stick: (unsigned) stick
							xChanged: (int) value {
	if ([delegate respondsToSelector:@selector(RCLeftJoystickX:valueChanged:)]) {
		[delegate RCLeftJoystickX:joystick valueChanged:value];
	}
}

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
								 stick: (unsigned) stick
							yChanged: (int) value {
	if ([delegate respondsToSelector:@selector(RCLeftJoystickY:valueChanged:)]) {
		[delegate RCLeftJoystickY:joystick valueChanged:value];
	}
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
								 stick: (unsigned) stick
						 otherAxis: (unsigned) otherAxis
					valueChanged: (int) value {
	
	SEL selectorTobeCalled;
	NSNumber *changedValue = [NSNumber numberWithInt:value];
	
	switch(stick) {
		case 2:	// Triggers
			switch (otherAxis) {
				case 1: //right
					selectorTobeCalled = @selector(RCTriggerRT:valueChanged:);
					break;
				case 0: //left
					break;
			}
			break;
	}
	
	if ([delegate respondsToSelector:selectorTobeCalled]) {
		// ARC doesn't like this, Their will be an override at some point but
		// as I have got this wrapped nothing bad "should|" happen :P
		
		[delegate performSelector:selectorTobeCalled withObject:joystick withObject:changedValue];
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
						buttonDown: (unsigned) buttonNumber {
	
	SEL selectorTobeCalled;
	
	switch(buttonNumber) {
		case 0: // A
			selectorTobeCalled = @selector(RCButtonA:state:);
			break;
		case 1: // B
			selectorTobeCalled = @selector(RCButtonB:state:);
			break;
		case 2: // X
			selectorTobeCalled = @selector(RCButtonX:state:);
			break;
		case 3: // Y
			selectorTobeCalled = @selector(RCButtonY:state:);
			break;
		case 4: // LB
			selectorTobeCalled = @selector(RCButtonLB:state:);
			break;
		case 5: // RB
			selectorTobeCalled = @selector(RCButtonRB:state:);
			break;
		case 6: // Left Stick Click
			selectorTobeCalled = @selector(RCButtonLeftAnalogStick:state:);
			break;
		case 7: // Right Stick Click
			selectorTobeCalled = @selector(RCButtonRightAnalogStick:state:);
			break;
		case 8: // Start
			selectorTobeCalled = @selector(RCButtonStart:state:);
			break;
		case 9: // Back
			selectorTobeCalled = @selector(RCButtonBack:state:);
			break;
		case 10: // Guide
			selectorTobeCalled = @selector(RCButtonGuide:state:);
			break;
		case 11: // DPad Up
			selectorTobeCalled = @selector(RCButtonDPadUp:state:);
			break;
		case 12: // DPad Down
			selectorTobeCalled = @selector(RCButtonDPadDown:state:);
			break;
		case 13: // DPad Left
			selectorTobeCalled = @selector(RCButtonDPadLeft:state:);
			break;
		case 14: // DPad Right
			selectorTobeCalled = @selector(RCButtonDPadRight:state:);
			break;
	}
	
	if ([delegate respondsToSelector:selectorTobeCalled]) {
		// ARC doesn't like this, Their will be an override at some point but
		// as I have got this wrapped nothing bad "should|" happen :P
		
		[delegate performSelector:selectorTobeCalled withObject:joystick withObject:YES];
	}
}

- (void) ddhidJoystick: (DDHidJoystick *) joystick
							buttonUp: (unsigned) buttonNumber;
{
	//	ButtonState * state = [mJoystickButtons objectAtIndex: buttonNumber];
	//	[state setPressed: NO];
}

@end
