//
//  MQTT.h
//  MQTTExample
//
//  Created by DaChui on 7/23/15.
//  Copyright (c) 2015 jmesnil.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTKit.h"

@interface MQTT : NSObject

+(void)Track;
+ (void)PostMsg:(NSString *)msg;

@end
