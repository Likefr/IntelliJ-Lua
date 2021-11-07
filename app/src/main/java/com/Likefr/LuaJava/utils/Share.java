package com.Likefr.LuaJava.utils;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.widget.Toast;
import androidx.core.content.FileProvider;
import com.Likefr.LuaJava.BuildConfig;

import java.io.File;

/**
 * @ClassName : Share
 * @Author : likefr
 * @Date : 2018/11/26
 * @Description : say something
 */
public class Share {
    public static void shareFile(Context context, String  fileName) {
        File file = new File(fileName);
        if (null != file && file.exists()) {
            Intent share = new Intent(Intent.ACTION_SEND);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                Uri contentUri = FileProvider.getUriForFile(context,  "com.Likefr.LuaJava.fileprovider",file);
                share.putExtra(Intent.EXTRA_STREAM, contentUri);
                share.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            } else {
                share.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(file));
            }
            share.setType("application/vnd.ms-excel");//此处可发送多种文件
            share.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            share.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            context.startActivity(Intent.createChooser(share, "分享文件"));
        } else {
            Toast.makeText(context, "分享文件不存在", Toast.LENGTH_SHORT).show();
        }
    }

    public static void install(Context content,String path){
        File apk = new File(path);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            Uri uri = FileProvider.getUriForFile(content, BuildConfig.APPLICATION_ID + ".fileprovider", apk);
            intent.setDataAndType(uri, "application/vnd.android.package-archive");
        }else{
            intent.setDataAndType(Uri.fromFile(apk),"application/vnd.android.package-archive");
        }
        try {
            content.startActivity(intent);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
