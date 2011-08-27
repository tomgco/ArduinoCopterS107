//
//  Xbox360Controller.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCController.h"

@protocol XboxControllerDelegate <NSObject>
	@optional
	- (void) RCButtonA;
	- (void) RCButtonB;
	- (void) RCButtonX;
	- (void) RCButtonY;
	- (void) RCButtonY;

	- (void) RCButtonLeftAnalogStick;
	- (void) RCButtonRightAnalogStick;

	- (void) RCButtonDPadUp;
	- (void) RCButtonDPadDown;
	- (void) RCButtonDPadLeft;
	- (void) RCButtonDPadRight;

	- (void) RCButtonRB;
	- (void) RCButtonLB;

	- (void) RCButtonStart;
	- (void) RCButtonBack;
	- (void) RCButtonGuide;

	- (void) RCTriggerRT;
	- (void) RCTriggerLT;

	- (void) RCLeftJoystick;
	- (void) RCLeftJoystick;

@end

@interface Xbox360Controller : RCController {
	id <XboxControllerDelegate> delegate;
}

@property (retain) id <XboxControllerDelegate> delegate;

@end
