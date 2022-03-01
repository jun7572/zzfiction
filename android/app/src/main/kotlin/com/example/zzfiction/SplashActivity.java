package com.example.zzfiction;

import android.app.Activity;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.zh.pocket.ads.splash.SplashAD;
import com.zh.pocket.ads.splash.SplashADListener;
import com.zh.pocket.http.bean.ADError;

public class SplashActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SplashADListener splashADListener=new SplashADListener() {
            @Override
            public void onFailed(ADError adError) {

            }

            @Override
            public void onADExposure() {

            }

            @Override
            public void onADClicked() {

            }

            @Override
            public void onADDismissed() {

            }

            @Override
            public void onADTick(long l) {

            }
        };
        SplashAD splashAD = new SplashAD(this,"", splashADListener);
//        splashAD.show(ViewGroup);
    }
}
