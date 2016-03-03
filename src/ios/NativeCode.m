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

- (void)secondMethod:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        NSArray *args = command.arguments;
        NSString *message = [args objectAtIndex:0];

        CDVPluginResult *pluginResult;
        if (message) {

            NSLog(@"Second Method and string is - %@", message);

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid application id: null was found"];
        }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
