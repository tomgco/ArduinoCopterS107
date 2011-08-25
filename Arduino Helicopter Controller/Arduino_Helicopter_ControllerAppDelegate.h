//
//  Arduino_Helicopter_ControllerAppDelegate.h
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Arduino_Helicopter_ControllerAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *_window;
}

@property (strong) IBOutlet NSWindow *window;

@end
