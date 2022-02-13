package com.Likefr.tencentx5;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.KeyEvent;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
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
    String noNetwork = "data:text/html;base64,PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg08aHRtbCB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCI+DTxoZWFkPg08bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCIgLz4NPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAsIHVzZXItc2NhbGFibGU9bm8sIG1pbmltdW0tc2NhbGU9MS4wLCBtYXhpbXVtLXNjYWxlPTEuMCIvPjx0aXRsZT7plJnor6/mj5DnpLo8L3RpdGxlPg08c3R5bGUgdHlwZT0idGV4dC9jc3MiPg0KKnsgcGFkZGluZzogMDsgbWFyZ2luOiAwOyB9DQpib2R5eyBiYWNrZ3JvdW5kOiAjZmZmOyBmb250LWZhbWlseTogJ+W+rui9r+mbhem7kSc7IGNvbG9yOiAjMzMzOyBmb250LXNpemU6IDE2cHg7IH0NCi5zeXN0ZW0tbWVzc2FnZXsgcGFkZGluZzogMjRweCA0OHB4OyB9DQouc3lzdGVtLW1lc3NhZ2UgaDF7IGZvbnQtc2l6ZTogMTAwcHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGxpbmUtaGVpZ2h0OiAxMjBweDsgbWFyZ2luLWJvdHRvbTogMTJweDsgfQ0KLnN5c3RlbS1tZXNzYWdlIC5qdW1weyBwYWRkaW5nLXRvcDogMTBweH0NCi5zeXN0ZW0tbWVzc2FnZSAuc3VjY2Vzcywuc3lzdGVtLW1lc3NhZ2UgLmVycm9yeyBsaW5lLWhlaWdodDogMS44ZW07IGZvbnQtc2l6ZTogMzZweCB9DQo8L3N0eWxlPg08L2hlYWQ+DTxib2R5Pg08ZGl2IGNsYXNzPSJzeXN0ZW0tbWVzc2FnZSI+DTxoMT46KDwvaDE+DTxwIGNsYXNzPSJlcnJvciI+572R57uc6L+e5o6l5byC5bi4PC9wPjxwIGNsYXNzPSJkZXRhaWwiPjwvcD4NPHAgY2xhc3M9Imp1bXAiPg3ml6Dms5Xov57mjqXliLDmnI3liqHlmajvvIzor7fmo4Dmn6XmgqjnmoTnvZHnu5zov57mjqUNPC9kaXY+DTwvYm9keT4NPC9odG1sPg==";

    NoAdWebViewClient(LuaActivity activity, WebViewX webView) {
        mActivity = activity;
        this.webView = webView;
//        this.elementClass = elementClass;
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
        if (!isnetwork(mActivity.getContext())) {
           webView.loadUrl(noNetwork);
        }
        return super.shouldOverrideUrlLoading(view, request);
    }

    @Override
    public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
        super.onReceivedError(view, request, error);
    }

    @Override
    public boolean shouldOverrideKeyEvent(WebView view, KeyEvent event) {
        if (!isnetwork(mActivity.getContext())) {
            webView.loadUrl(noNetwork);
        }
        return super.shouldOverrideKeyEvent(view, event);
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

    public static boolean isnetwork(Context context) {
        ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        if (activeNetworkInfo != null) {
            return activeNetworkInfo.isAvailable();
        }
        return false;
    }

}
