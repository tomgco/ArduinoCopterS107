//
//  RemoteControlView.m
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteControlView.h"

@implementation RemoteControlView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
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
			[throttle setIntegerValue:throttle.integerValue + 5];
			break;
		case 121: // page down
			[throttle setIntegerValue:throttle.integerValue - 5];
			break;
		case 126: // up
			[pitch setIntegerValue:pitch.integerValue - 15];
			break;
		case 125: // down
			[pitch setIntegerValue:pitch.integerValue + 15];
			break;
		case 124: // right
			[yaw setIntegerValue:yaw.integerValue - 5];
			break;
		case 123: // left
			[yaw setIntegerValue:yaw.integerValue + 5];
			break;
		default:
			break;
	}
}

@end
