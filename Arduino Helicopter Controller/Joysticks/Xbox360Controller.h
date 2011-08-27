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
- (void) RCButtonA: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonB: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonX: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonY: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonY: (DDHidJoystick *) joystick state: (BOOL)pressed;

- (void) RCButtonLeftAnalogStick: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonRightAnalogStick: (DDHidJoystick *) joystick state: (BOOL)pressed;

- (void) RCButtonDPadUp: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonDPadDown: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonDPadLeft: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonDPadRight: (DDHidJoystick *) joystick state: (BOOL)pressed;

- (void) RCButtonRB: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonLB: (DDHidJoystick *) joystick state: (BOOL)pressed;

- (void) RCButtonStart: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonBack: (DDHidJoystick *) joystick state: (BOOL)pressed;
- (void) RCButtonGuide: (DDHidJoystick *) joystick state: (BOOL)pressed;

- (void) RCTriggerRT: (DDHidJoystick *) joystick valueChanged: (int)value;
- (void) RCTriggerLT: (DDHidJoystick *) joystick valueChanged: (int)value;

- (void) RCLeftJoystickX: (DDHidJoystick *) joystick valueChanged: (int)value;
- (void) RCLeftJoystickY: (DDHidJoystick *) joystick valueChanged: (int)value;

- (void) RCRightJoystick: (DDHidJoystick *) joystick valueChanged: (int)value;
- (void) RCRightJoystick: (DDHidJoystick *) joystick valueChanged: (int)value;

@end

@interface Xbox360Controller : RCController {
	id <XboxControllerDelegate> delegate;
}

@property (retain) id <XboxControllerDelegate> delegate;

@end
