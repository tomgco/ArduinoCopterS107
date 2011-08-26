//
//  RemoteControl.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SerialCommunication.h"

@interface RemoteControl : NSViewController {
	SerialCommunication *serialCommunication;
	IBOutlet NSSlider *throttle, *trim;
	NSSegmentedControl *channelSelect;
	IBOutlet NSButton *connect;
}


@property (retain, nonatomic) IBOutlet NSSegmentedControl *channelSelect;

- (IBAction)tryToConnect:(id)sender;

@end
