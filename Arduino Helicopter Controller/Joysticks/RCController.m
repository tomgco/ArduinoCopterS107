//
//  Controller.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RCController.h"
#import <DDHidLib/DDHidJoystick.h>

@interface RCController (Private)

- (void) setJoysticks: (NSArray *) theJoysticks;

@end

@implementation RCController

- (id)init {
	self = [super init];
	if (self) {
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
	return self;
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

@end

@implementation RCController (Private)

- (void) setJoysticks: (NSArray *) theJoysticks
{
	if (mJoysticks != theJoysticks)	{
		mJoysticks = theJoysticks;
	}
}

@end
