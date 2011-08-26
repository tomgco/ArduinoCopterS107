//
//  RemoteControl.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteControl.h"

@implementation RemoteControl

@synthesize channelSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
			serialCommunication = [SerialCommunication sharedSerialConnection];
    }
    
    return self;
}

- (IBAction)tryToConnect:(id)sender {
	[serialCommunication writeByte:126]; // handshake.
	NSLog(@"%ld", [serialCommunication readByte]);
	if ([serialCommunication readByte] > 0) {
		[connect setTitle:@"Disconnect"];
	}
	//[self.view. setIntegerValue:50];
}

@end
