//
//  RemoteControlView.h
//  ArduinoCopterS107
//
//  Created by Tom Gallacher on 26/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RemoteControlView : NSView {
	IBOutlet NSSlider *throttle, *trim;
}
@end
