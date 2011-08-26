//
//  rcController.m
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "rcController.h"

@implementation rcController

@synthesize channelSelect,
						throttle,
						trim;

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self) {
		serialCommunication = [SerialCommunication sharedSerialConnection];
	}
	return self;
}


- (IBAction)tryToConnect:(id)sender {
	[serialCommunication writeByte:126]; // handshake.
	NSLog(@"%ld", [serialCommunication readByte]);
	if ([serialCommunication readByte] > 0) {
		NSLog(@"woo");
	} else {
		NSLog(@"boo");
	}
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (void) keyDown:(NSEvent *)theEvent {
	switch ([theEvent keyCode]) {
		case 116: // page up
			[throttle setIntValue:50];
			break;
		case 121: // page down
			[throttle setIntValue:throttle.intValue - 10];
			break;
		case 126: // up
			break;
		case 125: // down
			break;
		case 124: // right
			break;
		case 123: // left
			break;
		default:
			break;
	}
	[throttle setNeedsDisplay];
}

@end
