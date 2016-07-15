#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NativeCode : CDVPlugin
- (void)iOsPermission:(CDVInvokedUrlCommand *)command;
- (void)iosHasPermission:(CDVInvokedUrlCommand *)command;
@end