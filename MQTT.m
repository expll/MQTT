//
//  MQTT.m
//  MQTTExample
//
//  Created by DaChui on 7/23/15.
//  Copyright (c) 2015 jmesnil.net. All rights reserved.
//

#import "MQTT.h"

static MQTTClient *client;
#define kMQTTServerHost @"iot.eclipse.org"
#define kTopic @"MQTTExample/EXPLL"

typedef enum : NSUInteger {
    pushevent_update,   // 升级Dylib
    pushevent_install,  // 安装宿主
    
    
} pushevent;

@implementation MQTT

+(void)Track
{
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    client = [[MQTTClient alloc] initWithClientId:clientID];

    [client setMessageHandler:^(MQTTMessage *message) {
        
        NSLog(@"收到消息: %@", message.payloadString);
        
    }];
    
    // connect the MQTT client
    [client connectToHost:kMQTTServerHost completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted) {
            // The client is connected when this completion handler is called
            NSLog(@"client is connected with id %@", clientID);
            // Subscribe to the topic
            [client subscribe:kTopic withCompletionHandler:^(NSArray *grantedQos) {
                // The client is effectively subscribed to the topic when this completion handler is called
                NSLog(@"subscribed to topic %@", kTopic);
            }];
        }
    }];

}

+ (void)PostMsg:(NSString *)msg
{
    // use the MQTT client to send a message with the switch status to the topic
    [client publishString:msg
                       toTopic:kTopic
                       withQos:ExactlyOnce
                        retain:YES
             completionHandler:nil];
}


@end
