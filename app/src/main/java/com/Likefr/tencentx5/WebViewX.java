package com.Likefr.tencentx5;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.net.http.SslError;
import android.os.Build;
import android.os.Message;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.*;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.Toast;
import com.Likefr.LuaJava.R;
import com.androlua.LuaActivity;
import com.androlua.LuaGcable;
import com.androlua.LuaWebView;

import java.io.InputStream;
import java.net.URL;

/**
 * 网页可以处理:
 * 点击相应控件：
 * - 进度条显示
 * - 上传图片(版本兼容)
 * - 全屏播放网络视频
 * - 唤起微信支付宝
 * - 拨打电话、发送短信、发送邮件
 * - 返回网页上一层、显示网页标题
 * JS交互部分：
 * - 前端代码嵌入js(缺乏灵活性)
 * - 网页自带js跳转
 *
 * @author jingbin
 * link to https://github.com/youlookwhat/ByWebView
 */
public class WebViewX extends LuaWebView implements LuaGcable {
    private android.webkit.WebView mWebView;
    private NoAdWebViewClient noAdWebViewClient;
    private LuaActivity luaActivity;
    private String elementClass;
    private ByWebChromeClient mWebChromeClient;


    public WebViewX(LuaActivity var1) {
        super(var1);
        mWebView = this;
        luaActivity = var1;
        this.addJavascriptInterface(new WebViewX.LuaJavaScriptInterface(var1), "androlua");
        // 配置
        handleSetting();
        mWebChromeClient = new ByWebChromeClient(luaActivity, this);
        mWebView.setWebChromeClient(mWebChromeClient);
        noAdWebViewClient = new NoAdWebViewClient(luaActivity, this);

    }


    @SuppressLint("SetJavaScriptEnabled")
    private void handleSetting() {
        WebSettings ws = mWebView.getSettings();
        // 保存表单数据
        ws.setSaveFormData(true);
        // 是否应该支持使用其屏幕缩放控件和手势缩放
        ws.setSupportZoom(true);
        ws.setBuiltInZoomControls(true);
        ws.setDisplayZoomControls(false);
        // 启动应用缓存
        ws.setAppCacheEnabled(true);
        // 设置缓存模式
        ws.setCacheMode(WebSettings.LOAD_DEFAULT);
        // setDefaultZoom  api19被弃用
        // 网页内容的宽度自适应屏幕
        ws.setLoadWithOverviewMode(true);
        ws.setUseWideViewPort(true);
        // 告诉WebView启用JavaScript执行。默认的是false。
        ws.setJavaScriptEnabled(true);
        //  页面加载好以后，再放开图片
//        ws.setBlockNetworkImage(false);
        // 使用localStorage则必须打开
        ws.setDomStorageEnabled(true);
        // 排版适应屏幕
        ws.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.NARROW_COLUMNS);
        // WebView是否新窗口打开(加了后可能打不开网页)
//        ws.setSupportMultipleWindows(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            // WebView从5.0开始默认不允许混合模式,https中不能加载http资源,需要设置开启。
            ws.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }
    }
    public void loadUrl(String url, String elementClass) {
        System.out.println(elementClass);
        if (!TextUtils.isEmpty(url) && url.endsWith("mp4") && Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            mWebView.loadData(ByWebTools.getVideoHtmlBody(url), "text/html", "UTF-8");
        } else {

            if (elementClass != null) {
                this.elementClass = elementClass;
            }

            System.out.println("likefr------获取class元素1111111111111111111" + elementClass);
            mWebView.setWebViewClient(noAdWebViewClient);
            mWebView.loadUrl(url);
        }

    }

    public String getElementClass() {
        return elementClass;
    }

    public void onResume() {
        mWebView.onResume();
        // 支付宝网页版在打开文章详情之后,无法点击按钮下一步
        mWebView.resumeTimers();
    }

    public void onPause() {
        mWebView.onPause();
        mWebView.resumeTimers();
    }


    public void onDestroy() {
        if (mWebChromeClient != null && mWebChromeClient.getVideoFullView() != null) {
            mWebChromeClient.getVideoFullView().removeAllViews();
        }
        if (mWebView != null) {
            ViewGroup parent = (ViewGroup) mWebView.getParent();
            if (parent != null) {
                parent.removeView(mWebView);
            }
            mWebView.removeAllViews();
            mWebView.loadDataWithBaseURL(null, "", "text/html", "utf-8", null);
            mWebView.stopLoading();
            mWebView.setWebChromeClient(null);
            mWebView.setWebViewClient(null);
            mWebView.destroy();
            mWebView = null;
        }
    }

    /**
     * 选择图片之后的回调，在Activity里onActivityResult调用
     */
    public void handleFileChooser(int requestCode, int resultCode, Intent intent) {
        if (mWebChromeClient != null) {
            mWebChromeClient.handleFileChooser(requestCode, resultCode, intent);
        }
    }
    public android.webkit.WebView getWebView() {
        return mWebView;
    }

    /**
     * 修复可能部分h5无故竖屏问题，如果h5里有视频全屏播放请禁用
     */
    public void setFixScreenPortrait(boolean fixScreenPortrait) {
        if (mWebChromeClient != null) {
            mWebChromeClient.setFixScreenPortrait(fixScreenPortrait);
        }
    }

    @Override
    public boolean canGoBack() {
        return super.canGoBack();
    }

    public void setOnKeyListener(OnKeyListener var1) {
        super.setOnKeyListener(var1);
    }
    /**
     * 修复可能部分h5无故横屏问题，如果h5里有视频全屏播放请禁用
     */
    public void setFixScreenLandscape(boolean fixScreenLandscape) {
        if (mWebChromeClient != null) {
            mWebChromeClient.setFixScreenLandscape(fixScreenLandscape);
        }
    }

    @Override
    public void goBack() {
        super.goBack();
    }


    @Override
    public void gc() {

    }
//    @Override
//    public void setWebViewClient(WebViewX.LuaWebViewClient var1) {
//                Toast.makeText(luaActivity.getContext(),"请不要重新 setWebViewClient 该方法",Toast.LENGTH_SHORT).show();
////        super.setWebViewClient(new WebViewX.SimpleLuaWebViewClient(var1));
//    }

    @Override
    public void setWebViewClient(LuaWebViewClient luaWebViewClient) {
//                        Toast.makeText(luaActivity.getContext(),"请不要重新 setWebViewClient 该方法",Toast.LENGTH_SHORT).show();
//        super.setWebViewClient(luaWebViewClient);
    }


    private class SimpleLuaWebViewClient extends WebViewClient {
        private LuaWebView.LuaWebViewClient a;

        public SimpleLuaWebViewClient(LuaWebView.LuaWebViewClient var2) {
            this.a = var2;
        }

        public void doUpdateVisitedHistory(WebView var1, String var2, boolean var3) {
            this.a.doUpdateVisitedHistory(var1, var2, var3);
        }

        public void onFormResubmission(WebView var1, Message var2, Message var3) {
            var2.sendToTarget();
        }

        public void onLoadResource(WebView var1, String var2) {
            this.a.onLoadResource(var1, var2);
        }

        public void onPageFinished(WebView var1, String var2) {
            this.a.onPageFinished(var1, var2);
        }

        public void onPageStarted(WebView var1, String var2, Bitmap var3) {
            this.a.onPageStarted(var1, var2, var3);
        }

        public void onProceededAfterSslError(WebView var1, SslError var2) {
            this.a.onProceededAfterSslError(var1, var2);
        }

        public void onReceivedClientCertRequest(WebView var1, ClientCertRequest var2, String var3) {
            this.a.onReceivedClientCertRequest(var1, var2, var3);
        }

        public void onReceivedError(WebView var1, int var2, String var3, String var4) {
            this.a.onReceivedError(var1, var2, var3, var4);
        }

        public void onReceivedHttpAuthRequest(WebView var1, HttpAuthHandler var2, String var3, String var4) {
            this.a.onReceivedHttpAuthRequest(var1, var2, var3, var4);
        }

        public void onReceivedLoginRequest(WebView var1, String var2, String var3, String var4) {
            this.a.onReceivedLoginRequest(var1, var2, var3, var4);
        }

        public void onReceivedSslError(WebView var1, SslErrorHandler var2, SslError var3) {
            this.a.onReceivedSslError(var1, var2, var3);
        }

        public void onScaleChanged(WebView var1, float var2, float var3) {
            this.a.onScaleChanged(var1, var2, var3);
        }

        @Deprecated
        public void onTooManyRedirects(WebView var1, Message var2, Message var3) {
            var2.sendToTarget();
        }

        public void onUnhandledKeyEvent(WebView var1, KeyEvent var2) {
            this.a.onUnhandledKeyEvent(var1, var2);
        }

        public WebResourceResponse shouldInterceptRequest(WebView var1, WebResourceRequest var2) {
            return super.shouldInterceptRequest(var1, var2);
        }

        public boolean shouldOverrideKeyEvent(WebView var1, KeyEvent var2) {
            return this.a.shouldOverrideKeyEvent(var1, var2);
        }

        public boolean shouldOverrideUrlLoading(WebView var1, String var2) {
            return this.a.shouldOverrideUrlLoading(var1, var2);
        }
    }
    @Override
    public boolean isGc() {
        return false;
    }
    private class LuaJavaScriptInterface {
        private LuaActivity a;

        public LuaJavaScriptInterface(LuaActivity var2) {
            this.a = var2;
        }

        @JavascriptInterface
        public Object callLuaFunction(String var1) {
            return this.a.runFunc(var1, new Object[0]);
        }

        @JavascriptInterface
        public Object callLuaFunction(String var1, String var2) {
            return this.a.runFunc(var1, new Object[]{var2});
        }

        @JavascriptInterface
        public Object doLuaString(String var1) {
            return this.a.doString(var1, new Object[0]);
        }
    }

}
