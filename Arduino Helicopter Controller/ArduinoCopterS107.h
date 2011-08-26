//
//  ArduinoCopterS107AppDelegate.h
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"

@interface ArduinoCopterS107 : NSObject <NSApplicationDelegate> {
	NSWindow *_window;
	SerialCommunication *serialCommunication;
	NSString *selectedSerialPort;
	IBOutlet NSMenu *serialPortsMenuList;
}

@property (strong) IBOutlet NSWindow *window;
@property (retain) SerialCommunication *serialCommunication;

- (void) updateSerialPortsInMenu: (NSString *) selectedItem;
- (IBAction)openChosenSerialConnection:(id)sender;
- (void) openSerialConnection: (NSString *)location;

@end
