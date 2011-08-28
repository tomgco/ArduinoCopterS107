//
//  ArduinoCopterS107AppDelegate.h
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"
#import "RemoteControl.h"

@interface ArduinoCopterS107 : NSObject <NSApplicationDelegate> {
	NSWindow *_window;
	SerialCommunication *serialCommunication;
	RemoteControl *remoteControl;
	NSString *selectedSerialPort;
	NSString *serialPortErrorMessage;
	BOOL serialPortConnected;
	IBOutlet NSMenu *serialPortsMenuList;
}

@property (strong) IBOutlet NSWindow *window;
@property (retain) SerialCommunication *serialCommunication;
@property (retain, nonatomic) IBOutlet RemoteControl *remoteControl;
@property (retain, nonatomic) NSString *serialPortErrorMessage;

- (void) updateSerialPortsInMenu: (NSString *) selectedItem;
- (IBAction)openChosenSerialConnection:(id)sender;
- (void) openSerialConnection: (NSString *)location;

- (BOOL) isSerialPortConnected;
- (NSString *) getSerialPortErrorMessage;
@end