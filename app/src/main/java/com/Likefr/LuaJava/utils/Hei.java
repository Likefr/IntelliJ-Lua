package com.Likefr.LuaJava.utils;

import android.os.Environment;

import java.io.*;

public class Hei {
    private static String hexString = "0123456789abcdef";

    public Hei() {
    }

    public static String Jm(String var0) {
        byte[] var1 = var0.getBytes();
        StringBuilder var2 = new StringBuilder(var1.length * 2);

        for(int var3 = 0; var3 < var1.length; ++var3) {
            var2.append(hexString.charAt((var1[var3] & 240) >> 4));
            var2.append(hexString.charAt((var1[var3] & 15) >> 0));
        }

        String var7 = "";
        String[] var4 = new String[]{"a", "b", "c", "d", "e", "f", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
        String[] var5 = new String[]{".", ":", "+", "}", "?", "$", "……", "%", "_", "～", "&", "#", "•", ">", "、", "￥"};

        for(int var6 = 0; var6 < 16; ++var6) {
            if (var6 == 0) {
                var7 = var2.toString().replace(var4[var6], var5[var6]);
            }

            var7 = var7.replace(var4[var6], var5[var6]);
        }

        return var7;
    }

    public static String jM(String var0) {
        String var1 = "";
        String[] var2 = new String[]{"a", "b", "c", "d", "e", "f", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
        String[] var3 = new String[]{".", ":", "+", "}", "?", "$", "……", "%", "_", "～", "&", "#", "•", ">", "、", "￥"};

        for(int var4 = 0; var4 < 16; ++var4) {
            if (var4 == 0) {
                var1 = var0.replace(var3[var4], var2[var4]);
            }

            var1 = var1.replace(var3[var4], var2[var4]);
        }

        ByteArrayOutputStream var6 = new ByteArrayOutputStream(var1.length() / 2);

        for(int var5 = 0; var5 < var1.length(); var5 += 2) {
            var6.write(hexString.indexOf(var1.charAt(var5)) << 4 | hexString.indexOf(var1.charAt(var5 + 1)));
        }

        return new String(var6.toByteArray());
    }

    public static String getCount(String path) throws IOException {
        String st = "";
        int words = 0;//单词数
        int chars = 0;//字符数
        int lines = 0;//行数

        if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
            File file = new File(path);
            // 打开文件输入流
            FileInputStream fir = new FileInputStream(file);
            BufferedReader reads = new BufferedReader(new InputStreamReader(fir));
            while ((st = reads.readLine()) != null) {
                words += st.split("[ \\.,?]").length;//用于把一个字符串分割成字符串数组,字符串数组的长度，就是单词个数
                chars += st.length();//字符串的长度，即字符数
                lines++;//行数（由于每次读取一行，行数自加即可）
            }
            fir.close();
        }
        return "关键字:" + words + ",字符数：" + chars + ",行数：" + lines;
    }
    }
