//
//  RemoteControl.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"
#import <DDHidLib/DDHidLib.h>
#import "Xbox360Controller.h"

@interface RemoteControl : NSViewController {
	SerialCommunication *serialCommunication;
	IBOutlet NSSlider *throttle, *trim, *yaw, *pitch;
	NSSegmentedControl *channelSelect;
	IBOutlet NSButton *connect;
	
	IBOutlet NSLevelIndicator *throttleJoystick;
	
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
	
	Xbox360Controller *controller;
}

@property (retain, nonatomic) Xbox360Controller *controller;
@property (retain, nonatomic) IBOutlet NSSegmentedControl *channelSelect;

- (NSArray *) joysticks;
- (NSArray *) joystickButtons;
- (unsigned long) joystickIndex;
- (void) setJoystickIndex: (unsigned long) theJoystickIndex;

- (IBAction)tryToConnect:(id)sender;
- (void) sendPacket:(int)channel yaw:(int)yaw pitch:(int)pitch throttle:(int)throttle trimAdjust:(int)trimAdjust;
- (void) startTimer;

//Joystick Nom

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
