package com.Likefr.tencentx5;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.FrameLayout;
import androidx.annotation.LayoutRes;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.Likefr.LuaJava.R;
import com.androlua.LuaActivity;
import com.androlua.LuaWebView;

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
public class WebViewX extends com.androlua.LuaWebView {

    private android.webkit.WebView mWebView;
    private View mErrorView;
    private int mErrorLayoutId;
    private String mErrorTitle;
    private Context context;
    private ByWebChromeClient mWebChromeClient;

    public WebViewX(LuaActivity luaActivity) {
        super(luaActivity);
        mWebView = this;
        context = luaActivity.getContext();
        FrameLayout parentLayout = new FrameLayout(luaActivity);
//        parentLayout.addView(mWebView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        // 配置
        handleSetting();
//        // 视频、照片、进度条
        mWebChromeClient = new ByWebChromeClient(luaActivity, this);
//
        mWebView.setWebChromeClient(mWebChromeClient);
//
//        // 错误页面、页面结束、处理DeepLink
//        ByWebViewClient mByWebViewClient = new ByWebViewClient(luaActivity, this);
//
        mWebView.setWebViewClient(new NoAdWebViewClient(luaActivity,mWebView));
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
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            ws.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.NARROW_COLUMNS);
        } else {
            ws.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.NORMAL);
        }
        // WebView是否新窗口打开(加了后可能打不开网页)
//        ws.setSupportMultipleWindows(true);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            // WebView从5.0开始默认不允许混合模式,https中不能加载http资源,需要设置开启。
            ws.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }


        mWebView.setOnKeyListener(new OnKeyListener() {
            @Override
            public boolean onKey(View view, int i, KeyEvent keyEvent) {
                if (keyEvent.getAction() == KeyEvent.ACTION_DOWN) {
                    if (keyEvent.getAction() == KeyEvent.KEYCODE_BACK && mWebView.canGoBack()) {
                        mWebView.goBack();
                        return true;
                    }
                }
                return false;
            }
        });


    }

/*    public void loadUrl(String url) {
        if (!TextUtils.isEmpty(url) && url.endsWith("mp4") && Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            mWebView.loadData(ByWebTools.getVideoHtmlBody(url), "text/html", "UTF-8");
        } else {
            mWebView.loadUrl(url);
        }
        hideErrorView();
    }*/

    public void reload() {
        hideErrorView();
        mWebView.reload();
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

/*    public void onDestroy() {
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
    }*/

    /**
     * 选择图片之后的回调，在Activity里onActivityResult调用
     */
    public void handleFileChooser(int requestCode, int resultCode, Intent intent) {
        if (mWebChromeClient != null) {
            mWebChromeClient.handleFileChooser(requestCode, resultCode, intent);
        }
    }

    public boolean handleKeyEvent(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return isBack();
        }
        return false;
    }

    @SuppressLint("SourceLockedOrientationActivity")
    public boolean isBack() {
        // 全屏播放退出全屏
        if (mWebChromeClient.inCustomView()) {
            mWebChromeClient.onHideCustomView();
            return true;

            // 返回网页上一页
        } else if (mWebView.canGoBack()) {
            hideErrorView();
            mWebView.goBack();
            return true;
        }
        return false;
    }

    public android.webkit.WebView getWebView() {
        return mWebView;
    }


    /**
     * 显示错误布局
     */
    public void showErrorView() {
        try {
            if (mErrorView == null) {
                FrameLayout parent = (FrameLayout) mWebView.getParent();
                mErrorView = LayoutInflater.from(parent.getContext()).inflate((mErrorLayoutId == 0) ? R.layout.by_load_url_error : mErrorLayoutId, null);
                mErrorView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        reload();
                    }
                });
                parent.addView(mErrorView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
            } else {
                mErrorView.setVisibility(View.VISIBLE);
            }
            mWebView.setVisibility(View.INVISIBLE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 隐藏错误布局
     */
    public void hideErrorView() {
        if (mErrorView != null) {
            mErrorView.setVisibility(View.GONE);
        }
    }

    public View getErrorView() {
        return mErrorView;
    }

    String getErrorTitle() {
        return mErrorTitle;
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
    public boolean onKeyDown(int var1, KeyEvent var2) {
        if (var1 == 4 && this.canGoBack()) {
            this.goBack();
            return true;
        } else {
            return super.onKeyDown(var1, var2);
        }
    }



}