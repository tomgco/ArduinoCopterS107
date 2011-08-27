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

- (void) ddhidJoystick: (DDHidJoystick *) joystick
								 stick: (unsigned) stick
						 otherAxis: (unsigned) otherAxis
					valueChanged: (int) value {
	// Somehow display values here
	//NSLog(@"Stick: %d, other axis: %d, changed: %d", stick, otherAxis, value);
	switch(stick) {
		case 2:	// Triggers
			switch (otherAxis) {
				case 1: //right
					
					break;
				case 0: //left
					break;
			}
			break;
	}
	
}

@end
