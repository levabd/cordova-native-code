#include "NativeCode.h"

@implementation NativeCode

- (void)pluginInitialize
{
}

- (void)consoleLog:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        NSArray *args = command.arguments;
        NSString *message = [args objectAtIndex:0];

        CDVPluginResult *pluginResult;
        if (message) {

            NSLog(@"Value of string is %@", message);

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid application id: null was found"];
        }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)init:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{

        CDVPluginResult *pluginResult;
        NSLog(@"NativeCode initialization started.");

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

        @try {
           [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"NativeCode.init()You have errors in native code"];
        }
        NSLog(@"NativeCode.init() was successful done.");

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
