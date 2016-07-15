/**
 *  Cordova Nativa Code plugin
 *  Author: Pogorelov Max
 *  License: Wipon
 */

var exec = require('cordova/exec');

module.exports = {
    consoleLog: function(message){
        exec(null, null, 'NativeCode', 'consoleLog', [ message ]);
    },
    init: function(){
        exec(null, null, 'NativeCode', 'init', [ ]);
    },
    iOsHasPermission: function(permissionName, callbackContext){
        exec(callbackContext.success || null, callbackContext.error || null, 'NativeCode', 'iOsHasPermission', [ permissionName ] )
    },
    iOsPermission: function(permissionName, callbackContext){
        exec(callbackContext.success || null, callbackContext.error || null, 'NativeCode', 'iOsPermission', [ permissionName ] )
    },
    hasPermission: function(permissions, callbackContext){
        exec(callbackContext.success || null, callbackContext.error || null, 'NativeCode', 'hasPermission', permissions )
    },
    requestPermission: function(permissions, callbackContext){
        exec(callbackContext.success || null, callbackContext.error || null, 'NativeCode', 'requestPermission', permissions )
    }
};