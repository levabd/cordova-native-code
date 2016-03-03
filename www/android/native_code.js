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
    secondMethod: function(message){
        exec(null, null, 'NativeCode', 'secondMethod', [ message ]);
    }
};