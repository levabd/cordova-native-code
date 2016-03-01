package com.wipon.nativeCode;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;


public class NativeCode extends CordovaPlugin
{
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        try {
            if (action.equals("consoleLog")) {
                if (args.length() == 1) {
                    String message = args.getString(0);
                    this.consoleLog(message);

                    return true;
                }
            }
        } catch (JSONException e) {
            Log.d("CordovaLog","Plugin NativeCode: cannot parse args.");
            e.printStackTrace();
        }

        return false;
    }


    private void consoleLog(String message) {
        Log.d("CordovaLog", "first message");
        Log.d("CordovaLog", message);

    }
}