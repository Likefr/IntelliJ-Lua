package com.Likefr.LuaJava;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Window;
import com.Likefr.LuaJava.listeners.*;
import android.view.WindowManager;
import androidx.appcompat.app.AppCompatActivity;
import com.Likefr.LuaJava.utils.PaperOnboardingEngine;
import com.Likefr.LuaJava.utils.PaperOnboardingPage;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class MainActivity extends AppCompatActivity {
    Boolean isFirstIn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        //不显示程序的标题栏
        requestWindowFeature( Window.FEATURE_NO_TITLE );
// 在调用TBS初始化、创建WebView之前进行如下配置

        //不显示系统的标题栏
        getWindow().setFlags( WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN );

        //判断是否是首次打开 true说明还未写入
        SharedPreferences pref = MainActivity.this.getSharedPreferences("Paper", 0);
        isFirstIn = pref.getBoolean("Paper", true);
        super.onCreate(savedInstanceState);

        File dirFirstFolder = new File(String.valueOf(R.string.localBackup));
        if(!dirFirstFolder.exists())
        {
            dirFirstFolder.mkdirs();
        }

        if (isFirstIn && "com.Likefr.LuaJava".equals(getAppProcessName(MainActivity.this))) {

            //首次启动
            setContentView(R.layout.onboarding_main_layout);
            PaperOnboardingEngine engine = new PaperOnboardingEngine(findViewById(R.id.onboardingRootView), getDataForOnboarding(), getApplicationContext());
            engine.setOnChangeListener(new PaperOnboardingOnChangeListener() {
                @Override
                public void onPageChanged(int oldElementIndex, int newElementIndex) {
                    //滑动事件

                }
            });
            engine.setOnRightOutListener(new PaperOnboardingOnRightOutListener() {
                @Override
                public void onRightOut() {
                    SharedPreferences pref2 = MainActivity.this.getSharedPreferences("Paper", 0);
                    SharedPreferences.Editor editor = pref2.edit();
                    editor.putBoolean("Paper", false);
                    editor.commit();
                    Intent i = new Intent(MainActivity.this, com.androlua.Welcome.class);
                    startActivity(i);
                    // Probably here will be your exit action
                    //  Toast.makeText(getApplicationContext(), "Swiped out right", Toast.LENGTH_SHORT).show();
                    finish();
                }
            });
        }else{
            Intent i = new Intent(MainActivity.this, com.androlua.Welcome.class);
            startActivity(i);
            // Probably here will be your exit action
            //  Toast.makeText(getApplicationContext(), "Swiped out right", Toast.LENGTH_SHORT).show();
            finish();
            }
    }
    public static String getAppProcessName(Context context) {
        //当前应用pid
        int pid = android.os.Process.myPid();
        //任务管理类
        ActivityManager manager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        //遍历所有应用
        List<ActivityManager.RunningAppProcessInfo> infos = manager.getRunningAppProcesses();
        for (ActivityManager.RunningAppProcessInfo info : infos) {
            if (info.pid == pid)//得到当前应用
                return info.processName;//返回包名
        }
        return "";
    }

    // Just example data for Onboarding
    private ArrayList<PaperOnboardingPage> getDataForOnboarding() {
        // prepare data
        PaperOnboardingPage scr1 = new PaperOnboardingPage("IntelliJ Lua", "是基于LuaJava开发的安卓平台轻量级脚本编程语言工具",
                Color.parseColor("#678FB4"), R.drawable.hotels, R.drawable.key);
        PaperOnboardingPage scr2 = new PaperOnboardingPage("Lua", "既具有简洁优雅的特质",
                Color.parseColor("#65B0B4"), R.drawable.banks, R.drawable.wallet);
        PaperOnboardingPage scr3 = new PaperOnboardingPage("兼容", "又支持绝大部分安卓API,可以使你在手机上快速编写小型应用",
                Color.parseColor("#9B90BC"), R.drawable.stores, R.drawable.shopping_cart);
        PaperOnboardingPage scr4 = new PaperOnboardingPage("即将开始", "下面我们将获取(WRITE_EXTERNAL_STORAGE)存储读写权限,该权限用于获取本地项目工程,拒绝将导致本程序无法正常运作",
                Color.parseColor("#678FB4"), R.drawable.hotels, R.drawable.key);
//，
        ArrayList<PaperOnboardingPage> elements = new ArrayList<>();
        elements.add(scr1);
        elements.add(scr2);
        elements.add(scr3);
        elements.add(scr4);
        return elements;
    }


}
