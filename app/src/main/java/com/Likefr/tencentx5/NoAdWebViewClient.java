package com.Likefr.tencentx5;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.Likefr.LuaJava.R;
import com.androlua.LuaActivity;

/**
 * Created by BrainWang on 05/01/2016.
 */
public class NoAdWebViewClient extends WebViewClient {
    private WebViewX webView;
    private boolean isClose;
    private LuaActivity mActivity;
    public  String elementClass;

    NoAdWebViewClient( LuaActivity activity,WebViewX webView) {
        mActivity = activity;
        this.webView = webView;
//        this.elementClass = elementClass;
    }

    @Override
    public void onPageStarted(WebView webView, String s, Bitmap bitmap) {
        super.onPageStarted(webView, s, bitmap);
        if (isClose) { //如果为true线程正在运行就不用重新开启一个线程了
            return;
        }
        new Thread(new Runnable() {
            @Override
            public void run() {
                isClose = true;
                while (isClose) {
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    handler.sendEmptyMessage(0);
                }
            }
        }).start();
    }

    @SuppressLint("HandlerLeak")
    Handler handler = new Handler() {
        @SuppressLint("HandlerLeak")
        @Override
        public void handleMessage(Message msg) {
            String clas = getClearAdDivJs(mActivity.getApplicationContext());
//            String js = getClearAdDivId(mActivity.getApplicationContext());
            webView.loadUrl(clas);
//            webView.loadUrl(js);
        }
    };

    // 视频全屏播放按返回页面被放大的问题
    @Override
    public void onScaleChanged(WebView view, float oldScale, float newScale) {
        super.onScaleChanged(view, oldScale, newScale);
        if (newScale - oldScale > 7) {
            view.setInitialScale((int) (oldScale / newScale * 100)); //异常放大，缩回去。
        }
    }
    @Override
    public void onPageFinished(WebView webView, String s) {
        super.onPageFinished(webView, s);
        isClose = false;
    }

    public String getClearAdDivJs(Context context) {
        String js = "javascript:";
//        Resources res = context.getResources();
//        String[] Adclass = res.getStringArray(R.array.Adclass);
        String Adclass = webView.getElementClass();
        for (String k : Adclass.split(",")) {

        js += "var paras = document.getElementsByClassName('" + k + "'); for(i=0;i<paras.length;i++){if (paras[i] != null)paras[i].parentNode.removeChild( paras[i]);} ";
            Log.d("likefr----正在屏蔽class", k);
        }
        return js;
    }
    public static String getClearAdDivId(Context context) {
        String js = "javascript:";
        Resources res = context.getResources();
        String[] Adid = res.getStringArray(R.array.Adid);
        for (int i = 0; i < Adid.length; i++) {
            js += "var adDiv" + i + " = document.getElementById('" + Adid[i] + "');if(adDiv" + i + " != null);adDiv" + i + ".parentNode.removeChild(adDiv" + i + ");";
            Log.d("likefr----正在屏蔽id", Adid[i]);
        }
        return js;
    }
}
