package com.Likefr.tencentx5;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.FrameLayout;
import com.Likefr.LuaJava.R;
import com.androlua.LuaActivity;
import com.androlua.LuaWebView;

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
public class WebViewX extends LuaWebView {

    private android.webkit.WebView mWebView;
    private  NoAdWebViewClient noAdWebViewClient;
    private LuaActivity luaActivity;
    private String elementClass;
    private ByWebChromeClient mWebChromeClient;

    public WebViewX(LuaActivity luaActivity) {
        super(luaActivity);
        mWebView = this;
        luaActivity = luaActivity;
        // 配置
        handleSetting();
//        // 视频、照片、进度条
        mWebChromeClient = new ByWebChromeClient(luaActivity, this);
        mWebView.setWebChromeClient(mWebChromeClient);
//        // 错误页面、页面结束、处理DeepLink
//        ByWebViewClient mByWebViewClient = new ByWebViewClient(luaActivity, this);

        noAdWebViewClient = new NoAdWebViewClient(luaActivity,this);

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



    public void loadUrlX(String url,String elementClass ) {

        if (!TextUtils.isEmpty(url) && url.endsWith("mp4") && Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            mWebView.loadData(ByWebTools.getVideoHtmlBody(url), "text/html", "UTF-8");
        } else {

            if (elementClass != null){
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

//    public boolean handleKeyEvent(int keyCode, KeyEvent event) {
//        if (keyCode == KeyEvent.KEYCODE_BACK) {
//            return isBack();
//        }
//        return false;
//    }

//    public boolean isBack() {
//        // 全屏播放退出全屏
//        if (mWebChromeClient.inCustomView()) {
//            mWebChromeClient.onHideCustomView();
//            System.out.print("likefr -----isBack" + "isBack: 视频返回");
//            return true;
//
//            // 返回网页上一页
//        } else if (mWebView.canGoBack()) {
//            mWebView.goBack();
//            System.out.print("likefr -----isBack"+ "isBack: 返回");
//            return true;
//        }
//        return false;
//    }

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



    /*
    @Override
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i == 4 && this.canGoBack()) {
            this.goBack();
            System.out.print("likefr -----isBack"+ "isBack: 页面返回2");
            return true;
        } else {
            return super.onKeyDown(i, keyEvent);
        }

    }*/
}
