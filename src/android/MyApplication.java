package com.wipon.nativeCode;

import android.app.Application;
import org.acra.*;
import org.acra.annotation.*;
import android.util.Log;
import android.content.pm.PackageManager;

@ReportsCrashes(formUri = "https://wipon.net:8183/v3/crash-report",
        httpMethod = org.acra.sender.HttpSender.Method.POST,
        mode = ReportingInteractionMode.TOAST,
        reportType = org.acra.sender.HttpSender.Type.JSON)


public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        // The following line triggers the initialization of ACRA
        try{
            ACRA.init(this);
            Log.d("ACRA.init", "was run successfully");
        }catch(Throwable e){
            Log.d("ACRA.init", "cannot run ACRA");
        }

    }

}