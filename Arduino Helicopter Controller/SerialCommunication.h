//
//  SerialCommunication.h
//  Arduino Helicopter Controller
//
//  Created by Tom Gallacher on 25/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
	
// import IOKit headers
#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>

@interface SerialCommunication : NSObject {
	@private
	NSMutableArray *serialPorts;
	// Serial Port stuff
	int serialFileDescriptor; // file handle to the serial port
	struct termios gOriginalTTYAttrs; // Hold the original termios attributes so we can reset them on quit ( best practice )
}
+ (SerialCommunication *) sharedSerialConnection;
- (NSMutableArray *) getSerialPortList;
- (NSString *) openSerialPort: (NSString *)serialPortFile baud: (speed_t)baudRate;
- (void) writePacket: (NSString*)packet;
- (long) readByte;
- (int) isConnected;
@end
