#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface NativeCode : CDVPlugin

- (void)open:(CDVInvokedUrlCommand *)command;

@end