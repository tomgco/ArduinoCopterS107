//
//  Controller.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDHidLib/DDHidLib.h>

@interface RCController : NSObject {
	//Joystick Shit - Haven't got a clue yet.
	IBOutlet NSArrayController * mJoysticksController;
	DDHidJoystick * mCurrentJoystick;
	unsigned long mJoystickIndex;
	NSArray * mJoysticks;
	NSMutableArray * mJoystickButtons;
	int mXAxis;
	int mYAxis;
	
	//Loading xbox controller to begin, will have an 
	//abstraction layer to be able to choose and 
	//possible a self configuration area when I can be arsed.
	
}

//Joystick Nom

- (NSArray *) joysticks;
- (NSArray *) joystickButtons;
- (unsigned long) joystickIndex;
- (void) setJoystickIndex: (unsigned long) theJoystickIndex;

- (int) xAxis;
- (int) yAxis;

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
                 stick: (unsigned) stick
              xChanged: (int) value;

- (void) ddhidJoystick: (DDHidJoystick *)  joystick
                 stick: (unsigned) stick
              yChanged: (int) value;

- (void) ddhidJoystick: (DDHidJoystick *) joystick
                 stick: (unsigned) stick
             otherAxis: (unsigned) otherAxis
          valueChanged: (int) value;

- (void) ddhidJoystick: (DDHidJoystick *) joystick
            buttonDown: (unsigned) buttonNumber;

- (void) ddhidJoystick: (DDHidJoystick *) joystick
              buttonUp: (unsigned) buttonNumber;

@end
