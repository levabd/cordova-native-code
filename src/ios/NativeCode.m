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

        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        NSLog(@"NativeCode.init() was successful done.");

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
