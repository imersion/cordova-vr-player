package com.neotrino;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class GoogleVRPlayer extends CordovaPlugin {
  private static final String TAG = "GoogleVRPlayer";

  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);

    Log.d(TAG, "Initializing GoogleVRPlayer");
  }

  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
    if (action.equals("playVideo")) {
      String videoUrl = args.getString(0);
      String fallbackVideoUrl = args.getString(1);
      String displayMode = args.getString(2);
      Log.d(TAG, videoUrl);
      Context context = this.cordova.getActivity().getApplicationContext();
      Intent intent = new Intent(context, VrVideoActivity.class);
      intent.putExtra("videoUrl", videoUrl);
      intent.putExtra("fallbackVideoUrl", fallbackVideoUrl);
      intent.putExtra("displayMode", displayMode);
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

      context.startActivity(intent);
    }
    return true;
  }

}
