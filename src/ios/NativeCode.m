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

-(void)iOsHasPermission:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        NSArray *args = command.arguments;
        NSString *permissionName = [args objectAtIndex:0];



        if ([permissionName isEqual:@"Camera"]) {
            if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {

                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

                if(status == AVAuthorizationStatusAuthorized) { // authorized
                    CDVPluginResult *pluginResult;
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }
                else if(status == AVAuthorizationStatusDenied){ // denied
                    CDVPluginResult *pluginResult;
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"denied"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

                }
                else if(status == AVAuthorizationStatusRestricted){ // restricted
                    CDVPluginResult *pluginResult;
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"restricted"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];


                }
                else if(status == AVAuthorizationStatusNotDetermined){ // not determined
                    CDVPluginResult *pluginResult;
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not determined"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

                }


            }else{
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }

            NSLog(@"Try to has perm %@", permissionName);



        } else if ([permissionName isEqual:@"Geolocation"]){

            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways){
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
            else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
            else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {

                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not determined"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

            }
            else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
            {

                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"denied"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                //Location Services is off from settings

            }
            else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)
            {
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"restricted"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }

            NSLog(@"Try to has perm %@", permissionName);

        }else {
            CDVPluginResult *pluginResult;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid application id: null was found"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }


    }];

}

-(void)iOsPermission:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        NSArray *args = command.arguments;
        NSString *permissionName = [args objectAtIndex:0];



        if ([permissionName isEqual:@"Camera"]) {


            NSLog(@"Try to take perm %@", permissionName);

            if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

                    // Will get here on both iOS 7 & 8 even though camera permissions weren't required
                    // until iOS 8. So for iOS 7 permission will always be granted.
                    if (granted) {
                        // Permission has been granted. Use dispatch_async for any UI updating
                        // code because this block may be executed in a thread.
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"GRANTED!!");
                            CDVPluginResult *pluginResult;
                            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                        });


                    } else {
                        CDVPluginResult *pluginResult;
                        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access Denied"];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                        NSLog(@"DENIED!!");
                        // Permission has been denied.
                    }
                }];
            } else {
                // We are on iOS <= 6. Just do what we need to do.
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }

        } else if ([permissionName isEqual:@"Geolocation"]){

            CDVPluginResult *pluginResult;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

            NSLog(@"Try to take perm %@", permissionName);

        }else {
            CDVPluginResult *pluginResult;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid application id: null was found"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }


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
