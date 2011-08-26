//
//  rcController.h
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"

@interface rcController : NSView {
	NSSegmentedControl *channelSelect;
	IBOutlet NSSlider *throttle, *trim;
	SerialCommunication *serialCommunication;
	IBOutlet NSButton *connect;
}

@property (retain, nonatomic) IBOutlet NSSegmentedControl *channelSelect;
@property (retain, nonatomic) IBOutlet NSSlider *throttle, *trim;

- (IBAction)tryToConnect:(id)sender;
@end
