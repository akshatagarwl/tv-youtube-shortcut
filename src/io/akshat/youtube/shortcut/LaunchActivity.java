package io.akshat.youtube.shortcut;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

/** Personal home-screen shortcut. Not a YouTube client or voice/search bridge. */
public final class LaunchActivity extends Activity {
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        Intent target = getPackageManager().getLeanbackLaunchIntentForPackage("io.gh.akshat.tizentube.cobalt");
        if (target == null) target = getPackageManager().getLeanbackLaunchIntentForPackage("io.gh.reisxd.tizentube.cobalt");
        try {
            if (target == null) throw new ActivityNotFoundException();
            startActivity(target.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK));
        } catch (ActivityNotFoundException e) {
            Toast.makeText(this, "Install TizenTube Cobalt first", Toast.LENGTH_LONG).show();
        } finally {
            finish();
        }
    }
}
