//
//  ArduinoCopterS107AppDelegate.m
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArduinoCopterS107.h"


@implementation ArduinoCopterS107

@synthesize window = _window,
						serialCommunication,
						remoteControl,
						serialPortErrorMessage;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	remoteControl = [[RemoteControl alloc] initWithNibName:@"RemoteControl" bundle:nil];
	// Insert code here to initialize your application
	[self.window setContentView:remoteControl.view];
	serialCommunication = [SerialCommunication sharedSerialConnection];
	if (true /* auto connect to last device / if not try auto connecting to 'usbserial' */)
		[self updateSerialPortsInMenu:@"usbmodem"];
	else 
		[self updateSerialPortsInMenu:@""];
	
}

- (void) updateSerialPortsInMenu: (NSString *) selectedItem {
	NSArray *serialPortList = [NSArray arrayWithArray:[serialCommunication getSerialPortList]];
	[serialPortsMenuList removeAllItems];
	for (NSString *serialPort in serialPortList) {
		[serialPortsMenuList addItemWithTitle:serialPort action:@selector(openChosenSerialConnection:) keyEquivalent:@""];
		if ([serialPort rangeOfString:selectedItem].location != NSNotFound) {
			selectedSerialPort = serialPort;
			[[serialPortsMenuList itemWithTitle:serialPort] setState:NSOnState];
			[self openSerialConnection:serialPort];
		}
	}
}

- (void) openSerialConnection: (NSString *)location {
	serialPortErrorMessage = [serialCommunication openSerialPort:location baud:300];
	if (serialPortErrorMessage == nil) {
		[[serialPortsMenuList itemWithTitle:location] setState:NSOnState];
		serialPortConnected = YES;
	} else {
		serialPortConnected = NO;
	}
}

- (IBAction) openChosenSerialConnection:(id)sender {
	[self updateSerialPortsInMenu:[sender title]];
	[self openSerialConnection:[sender title]];
}

- (BOOL) isSerialPortConnected {
	return serialPortConnected;
}

- (NSString *) getSerialPortErrorMessage {
	return serialPortErrorMessage;
}




@end
