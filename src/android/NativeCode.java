package com.wipon.nativeCode;

import android.Manifest;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;

import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.wipon.nativeCode.PermissionHelper;
import android.util.Log;
import android.content.pm.PackageManager;

public class NativeCode extends CordovaPlugin{

    public static final int START_REQ_CODE = 123;
    public static final int PERMISSION_DENIED_ERROR = 20;
    public CallbackContext callbackContextGlobal;

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
            if (action.equals("requestPermission")) {
                Log.d("CordovaLog", "Permission Request");
                Log.d("CordovaLog", Integer.toString(args.length()));
                callbackContextGlobal = callbackContext;
                if (args.length() >= 1) {

                    ArrayList<String> permissions = new ArrayList<String>();

                    if (args != null) {
                       int len = args.length();
                       for (int i=0;i<len;i++){
                            permissions.add(args.getString(i));  //get(i).toString()
                       }
                    }

                    String[] perms = permissions.toArray(new String[permissions.size()]);
                    //String[] permissions = args.toString().replace("},{", " ,").split(" ");

                    for(int i = 0; i < perms.length; i++){
                        Log.d("CordovaLog", "permission - " + perms[i]);
                    }

                    this.requestPermission(perms);

                    return true;
                }
            }
            if (action.equals("hasPermission")) {
                Log.d("CordovaLog", "Permission Request");
                Log.d("CordovaLog", Integer.toString(args.length()));
                callbackContextGlobal = callbackContext;
                if (args.length() >= 1) {

                    ArrayList<String> permissions = new ArrayList<String>();

                    if (args != null) {
                        int len = args.length();
                        for (int i=0;i<len;i++){
                            permissions.add(args.getString(i));  //get(i).toString()
                        }
                    }

                    String[] perms = permissions.toArray(new String[permissions.size()]);
                    //String[] permissions = args.toString().replace("},{", " ,").split(" ");

                    for(int i = 0; i < perms.length; i++){
                        Log.d("CordovaLog", "permission - " + perms[i]);
                    }

                    if (hasPermission(perms)) {
                        callbackContextGlobal.success();
                    }else{
                        callbackContextGlobal.error("Permission denied");
                    }

                    return true;
                }
            }
        } catch (JSONException e) {
            Log.d("CordovaLog","Plugin NativeCode: cannot parse args.");
            e.printStackTrace();
        }

        return false;
    }


    public boolean hasPermission(String[] permissions) {
        for(String p : permissions)
        {
            if(!PermissionHelper.hasPermission(this, p))
            {
                return false;
            }
        }
        return true;
    }

    private void requestPermission(String[] permissions){
        if (hasPermission(permissions)) {
            Log.d("CordovaLog", "Permission has enabled");;
            callbackContextGlobal.success();
        } else {
            Log.d("CordovaLog", "Try to take permission");;
            PermissionHelper.requestPermissions(this, START_REQ_CODE, permissions);
        }
    }

    public void onRequestPermissionResult(int requestCode, String[] permissions,
                                              int[] grantResults) throws JSONException
        {
            if (requestCode == START_REQ_CODE) {

                for (int r : grantResults) {
                    if (r == PackageManager.PERMISSION_DENIED) {
                        Log.d("CordovaLog", "Permission Denied!");
                        callbackContextGlobal.error("Permission denied");
                        return;
                    }

                }
                callbackContextGlobal.success();
                

            }



        }

    private void consoleLog(String message) {
        Log.d("CordovaLog", "first message");
        Log.d("CordovaLog", message);

    }
}