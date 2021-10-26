package com.Likefr.LuaJava.utils;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * @version 1.0 2021/8/7
 * @outhor Likefr
 */
class getWeb {


    public static Elements getWeb(String url) throws IOException {

        String head = "https://www.ganfanhao8.com/";

        //https://www.ab537.com/so/---time----------.html
        //6.Jsoup解析html
        Document document = Jsoup.connect(url).get();
        Elements elements = null;
        elements = document.getElementsByClass("excerpt excerpt-c5");

        return elements;
        // for (Element element : elements) {

             /*   Element first = element.select("a[href]").first();

                Element img = element.select("img[src]").first();

                Element link = element.getElementsByTag("h2").first();*/

               /* System.out.println(link.text());
                stringStringMap.put("标题", link.text());
                System.out.println(head + first.attr("href"));
                stringStringMap.put("链接", head + first.attr("href"));
                System.out.println(head + img.attr("data-src"));
                stringStringMap.put("图片", head + img.attr("data-src"));
                System.out.println("==========");*/

        // }


    }
}

