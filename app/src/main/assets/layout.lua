layout = {
 home = {
  LinearLayout;
  layout_width = "fill";
  layout_height = "fill";
  orientation = "vertical";
  {
   CardView;
   layout_width = "match";
   CardElevation = "10dp";
   radius = "0dp";
   layout_height = "60dp",
   id = "mToolbar";
   CardBackgroundColor = background;
   {
    BlurringView,
    layout_width = "-1",
    layout_height = "fill",
    background = "#ffffffff"; --必须设置背景色否则会透明化
    id = "BlurView",
   },
   {
    LinearLayout;
    layout_width = "fill";
    layout_height = "fill";
    {
     TextView;
     textSize = "20dp";
     text = "IntelliJ Lua";
     layout_marginLeft = "25dp";
     layout_gravity = "left|center";
     layout_weight = 1;
     gravity = "left";
     TextColor = wbColor;
     Typeface = 字体("product-Bold");
    };
    {
     ImageView;
     layout_height = "26.5dp";
     layout_width = "26.5dp";
     layout_marginRight = "22dp";
     layout_gravity = "right|center";
     id = "ooo";
     colorFilter = filter;
     src = "res/ic_choicePath.png";
     onClick = function()
      an.setVisibility(View.VISIBLE)
      an.openMenu();
     end
    };

   };
  };
  {
   FrameLayout;
   layout_width = "fill";
   layout_height = "fill";
   backgroundColor = background;
   {
    LinearLayout;
    layout_width = "fill";
    layout_height = "fill";
    orientation = "vertical";
    backgroundColor = background;

    {
     MyEditText({
      Hint = "搜索";
      HintColor = 0x99ffffff;
      backgroundColor = background;
      id = "ed";
     });
     layout_width = "fill";
     id = "eds";
     Visibility = "gone";
    },
    {
     ImageView;
     layout_height = "-1";
     layout_width = "-1";
     id = "home";
     src = "res/nilProject.png";
    };
    {
     NoScrollListView;
     id = "置顶";
     layout_width = "fill";
     cacheColorHint = "#ff000000"; --去除拖动时默认的黑色背景
     layout_height = "wrap";
    };
    {
     PullRefreshLayout,
     layout_width = "fill";
     layout_height = "fill";
     id = "pulltwo",
     {
      GridView;
      id = "project_list";
      layout_width = "fill";
      cacheColorHint = "#00000000"; --去除拖动时默认的黑色背景
      layout_height = "fill";
     };
    };
   };

   {
    CircleMenu;
    layout_height = "fill";
    layout_width = "fill";
    id = "an";
    layout_gravity = "center";
    Visibility = "gone";
   };
   {
    CardView;
    layout_gravity = "bottom|center";
    layout_height = "56dp";
    CardElevation = "18dp";
    radius = "28dp";
    id = "ChoosePath",
    layout_margin = "16dp";
    layout_marginBottom = "25dp";
    layout_width = "56dp";
    CardBackgroundColor = 0xFFF9F9F9;
    Visibility = "invisible";
    onClick = function()
     choicePath();
    end,
    {
     ImageView;
     layout_gravity = "center";
     layout_height = "25dp";
     layout_width = "25dp";
     src = "res/ic_choicePath.png";
    };
   };

   {
    CardView;
    layout_gravity = "bottom|center";
    layout_height = "0dp";
    CardElevation = "18dp";
    radius = "28dp";
    id = "importProject",
    layout_margin = "16dp";
    layout_marginBottom = "25dp";
    layout_width = "0dp";
    CardBackgroundColor = 0xFFF9F9F9;
    onClick = function()
     导入()
     水珠动画(importProject, 850)

    end,
    {
     ImageView;
     layout_gravity = "center";
     layout_height = "25dp";
     id = "test";
     layout_width = "25dp";
     src = "res/twotone_add_black_24dp.png";
    };
   };
  };

 };

 EditCode = {
  FrameLayout;
  {
   LinearLayout;
   orientation = "vertical";
   layout_height = "fill";
   layout_width = "fill";

   {
    LinearLayout;
    layout_width = "fill";
    layout_height = "60dp";
    orientation = "horizontal";
    id = "top1";
    elevation = "6dp";
    elevation = "6dp";
    BackgroundColor = Bar;
     {
      AwesomeTextView;
      id = "sideslip";
      layout_height = "55dp";
      layout_width = "55dp";
      textSize = "25dp";
      textColor = ColorFilter;
     MaterialIcon = MaterialIcons.MD_MENU;
      layout_gravity = "center";
      gravity = "center";
     };
    {
     LinearLayout;
     layout_height = "fill";
     layout_width = "40%w";
     orientation = "vertical";
     elevation = "6dp";
     layout_weight = 2;
     layout_marginTop = '10dp'; --卡片边距
     {
      TextView;
      gravity = "center_vertical";
      id = "title";
      text = activity.getString(R.string.app_name);
      layout_width = "fill";
      textSize = "18dp";
      textColor = wbColor;
      singleLine = true;
      ellipsize = "start";
      maxLines = 1;
     };
     {
      TextView;
      gravity = "center_vertical";
      id = "sub_title";
      textSize = "13dp";
      textColor = wbColor;
      singleLine = true;
      ellipsize = "start";
     };
    };
    {
     LinearLayout;
     layout_width = "70%w";
     layout_height = "fill";
     elevation = "6dp";
     gravity = "right";
     layout_gravity = "right";
     layout_weight = 1;
     {--webView
      AwesomeTextView;
      layout_margin = '1.8%w';
      Visibility = "gone";
      layout_gravity = "center";
      layout_marginRight = '4%w'; --卡片边距
      id = "look",
      textSize = "25dp";
      textColor = ColorFilter;
      fontAwesomeIcon=FontAwesome.FA_PENCIL_SQUARE;
     };
     {
      ImageView;
      layout_gravity = "center";
      colorFilter = ColorFilter;
      layout_width = "22dp";
      layout_marginRight = '4%w'; --卡片边距
      id = "icon",
      src = "res/layout.png";
      layout_height = "22dp";
      layout_margin = '1.8%w';
      Visibility = "gone";
     };
     {
      AwesomeTextView;
      id = "undo";
      layout_gravity = "center";
      layout_margin = '1.8%w';
      textSize = "28dp";
      textColor = ColorFilter;
      MaterialIcon = MaterialIcons.MD_REPLY;
      onClick = function()
       editor.undo()
      end
     };
     {
      AwesomeTextView;
      id = "redo";
      layout_marginLeft = '4%w'; --卡片边距
      layout_gravity = "center";
      layout_margin = '1.8%w';
      textSize = "28dp";
      textColor = ColorFilter;
      MaterialIcon = MaterialIcons.MD_REPLY;
      Rotation="-180";
      onClick = function()
       editor.redo()
      end
     };
     {
      ImageView;
      id = "Run";
      colorFilter = ColorFilter;
      layout_height = "22dp";
      src = "res/run.png";
      layout_gravity = "center";
      layout_width = "22dp";
      layout_margin = '1.8%w';
     };
      {
       AwesomeTextView;
       layout_width = "27dp";
       layout_height = "27dp";
       layout_gravity = "center";
       layout_margin = '1.8%w';
       id = "menu";
       textSize = "25dp";
       textColor = ColorFilter;
       MaterialIcon = MaterialIcons.MD_MORE_VERT;
     };
    };
   };
   --搜索

   {
    LinearLayout;
    layout_width = "fill";
    layout_height = "60dp";
    orientation = "horizontal";
    elevation = "6dp";
    id = "opii";
    Visibility = 8, --隐藏控件
    BackgroundColor = Bar;
    {
     LinearLayout;
     layout_height = "60dp";
     gravity = "center";
     layout_gravity = "center";
     layout_width = "55dp";
     {
      AwesomeTextView;
      textSize = "25dp";
      textColor = ColorFilter;
      MaterialIcon = MaterialIcons.MD_MENU;
      onClick = function()
       opi.Visibility = 8
       opii.Visibility = 8
       top1.Visibility = 0
      end
     };
    };
    {
     LinearLayout;
     layout_height = "fill";
     layout_width = "80%w";
     id="edit_Anim";
     {
      MyEditText({
       Hint = "请输入关键字";
       HintColor = 0x99ffffff;
       backgroundColor = background;
       id = "wbwb";
      });
      layout_width = "fill",
      layout_weight = 1;
     };
     {
      AwesomeTextView;
      layout_marginLeft = '10dp';
      layout_width = "50dp";
      layout_gravity = "center";
      textColor = ColorFilter;
      id = "seach";
      textSize = "25dp";
      MaterialIcon = MaterialIcons.MD_SEARCH;
      onClick = function()
       editor.findNext(wbwb.getText())
      end
     };
    };
   };
   {
    LinearLayout;
    layout_width = "fill";
    layout_height = "60dp";
    orientation = "horizontal";
    elevation = "8dp";
    BackgroundColor = background;
    Visibility = 8, --隐藏控件
    gravity = "left|center";
    id = "opi";
    {
     LinearLayout;
     layout_width = "fill";
     layout_height = "fill";
     gravity = "left|center";
     layout_marginTop = "2dp";
     {
      ImageView;
      id = "close";
      layout_width = "26dp";
      layout_height = "26dp";
      layout_marginLeft = "16dp",
      colorFilter = ColorFilter;
      src = "res/left.png";
     };
     {
      TextView;
      layout_marginLeft = '10dp'; --20
      layout_width = "wrap";
      layout_gravity = "center";
      layout_marginTop = "1dp";
      text = "选择";
      textColor = wbColor;
      id = "xzmz";
      textSize = "17.5dp";
     };
     {
      LinearLayout;
      layout_width = "63%w";
      layout_height = "fill";
      gravity = "right|center";
      layout_gravity = "right";
      layout_weight = 1;
      {
       ImageView;
       id = "selectAll";
       src = "res/selectAll.png";
       layout_width = "24dp";
       layout_height = "24dp";
       layout_marginLeft = '2.8%w'; --布局左距
       layout_margin = '1.8%w';
       colorFilter = ColorFilter;
      };
      {
       ImageView;
       id = "Cat";
       layout_marginLeft = '19dp'; --布局左距
       layout_width = "30dp";
       layout_height = "30dp";
       src = "res/Cat.png";
       layout_margin = '1.8%w';
       colorFilter = ColorFilter;
      };
      {
       ImageView;
       id = "Copy";
       layout_width = "25dp";
       layout_height = "25dp";
       src = "res/Copy.png";
       layout_marginLeft = '18.5dp'; --布局左距
       layout_margin = '1.8%w';
       colorFilter = ColorFilter;
      };
      {
       ImageView;
       id = "Paste";
       layout_width = "22dp";
       layout_height = "22dp";
       layout_marginLeft = '18dp'; --布局左距
       src = "res/Paste.png";
       layout_margin = '1.8%w';
       colorFilter = ColorFilter;
      };
     };
    };
   };
   {
    DrawerLayout;
    layout_height = "fill";
    id = "Drawer";
    layout_width = "fill";
    backgroundColor = background;
    {
     LinearLayout;
     orientation = "vertical";
     layout_height = "fill";
     layout_width = "fill";
     {
      LinearLayout;
      orientation = "vertical";
      layout_height = "wrap";
      id = "pl",
      Visibility = "gone"; --隐藏
      layout_width = "fill";
      {
       TextView;
       id = "erro";
       layout_height = "wrap";
       background = "#99fd364e";
       layout_width = "fill";
      };
      {
       TextView; --翻译 TODO
       id = "fy";
       layout_height = "0dp";
       layout_width = "0dp";
       Visibility = "invisible";
      };
     };
     {
      XPageView;
      layout_height = "fill";
      layout_width = "fill";
      id = "pageview";
      pages = {
       {
        LinearLayout;
        orientation = "vertical";
        layout_height = "fill";
        layout_width = "fill";
        {
         FrameLayout;
         layout_width = "fill";
         layout_height = "fill";
         {
          TextView;
          id = "nilCode";
          layout_width = "fill";
          Visibility = "gone";
          layout_height = "fill";
          text = "请打开一个文件";
         };
         {
          CodeEditor;
          layout_height = "fill";
          id = "editor";
          layout_width = "fill";
         };
         {
          LinearLayout;
          layout_width = "fill";
          id = "symbolBar";
          layout_marginBottom = "20dp";
          layout_gravity = "bottom";
          {
           HorizontalScrollView;
           horizontalScrollBarEnabled = false;
           {
            LinearLayout;
            layout_width = "fill";
            layout_height = "35dp";
            gravity = "center";
            id = "ps_bar";
           };
          };
         };
        };
       };
       "Controller/layout/createFile";
       "Controller/layout/Image_x";
       "Controller/layout/AllScanner";
      };
     };
    };
    {
     LinearLayout;
     backgroundColor = background;
     layout_height = "fill";
     layout_gravity = "start";
     layout_width = "80%w";
     {
      TextView;
      id = "projectOpenPath";
      layout_height = "0dp";
      layout_width = "0dp";
      Visibility = "invisible";
     };
     {
      PullRefreshLayout,
      layout_width = "fill";
      layout_height = "fill";
      id = "pulltwo",
      {
       NoScrollListView;
       id = "file_list";
       layout_height = "-1";
       layout_width = "-1";
       DividerHeight = 0;
      };
     };
    };
   };
  };
  {
   TextView;
   id = "gotoLine";
   layout_height = "0dp";
   layout_width = "0dp";
   Visibility = "invisible";
  };
 };

 --items
 item = {--兼容性差
  LinearLayout;
  layout_height = "19%h";
  layout_width = "fill";
  gravity = "center";
  orientation = "vertical";
  {
   CardView;
   layout_height = "14%h";
   layout_width = "45%w";
   radius = "10dp";
   layout_gravity = "center";
   elevation = "5dp";
   CardBackgroundColor = background;
   {
    FrameLayout;
    layout_height = "fill";
    layout_width = "fill";
           {
    TextView;
    id="bw";
    layout_height="-1";
    layout_width="-1";
   };
    {
     CardView;
     layout_height = "58dp";
     layout_width = "58dp";
     radius = "60dp";
     CardBackgroundColor = 0x00000000;
     layout_gravity = "right",
     layout_marginRight = "10dp";
     padding = "10dp";
     elevation = "0dp";
     {
      ImageView;
      id = "project_icon";
      scaleType = "fitXY";
      layout_height = "fill";
      layout_width = "fill";
     };
    };
    {
     LinearLayout;
     layout_height = "63dp";
     layout_width = "fill";
     layout_marginTop = "12dp";
     layout_marginLeft = "10dp";
     {
      TextView;
      textColor = wbColor;
      id = "project_name";
      textSize = "17dp";
      Typeface = 字体("product-Bold");
     };
    };
    {
     ImageView;
     background = "#55000000";
     layout_height = "75dp";
     layout_width = "250dp";
     layout_marginBottom = "-3%w";
     layout_marginLeft = "-10dp";
     rotation = "7";
     layout_gravity = "bottom";
    };
    {
     TextView;
     textColor = wbColor;
     id = "project_packageNames";
     layout_marginLeft = "2dp";
     layout_marginTop = "4.7%w";
     layout_gravity = "left|center",
     textSize = "14dp";
     Typeface = 字体("product");
     singleLine = "true";
     maxLines = "5";
    };
    {
     TextView;
     layout_height = "-1";
     layout_marginLeft = "2dp";
     layout_marginBottom = "6.5dp";
     id = "project_version";
     gravity = "left|bottom",
     textSize = "14dp";
     Typeface = 字体("product");
     singleLine = "true";
     maxLines = "5";
     textColor = wbColor;
    };
   };
  };
  {
   TextView;
   id = "project_title";
   layout_height = "0dp";
   layout_width = "0dp";
   Visibility = "invisible";
  };
 };

 item2 = { --标题版本 包名
  LinearLayout;
  layout_height = "100dp";
  layout_width = "match";
  gravity = "center";
  orientation = "vertical";
  {
   CardView; --卡片控件
   layout_margin = '10dp'; --卡片边距
   layout_width = "90%w";
   radius = "10dp";
   layout_gravity = "center";
   elevation = elevation;
   layout_height = 'fill'; --卡片高度
   radius = '6dp'; --卡片圆角
   CardBackgroundColor = background; --卡片背景颜色
   {
    FrameLayout;
    layout_height = "fill";
    layout_width = "fill";
    BackgroundColor = background;
           {
    TextView;
    id="bw";
    layout_height="-1";
    layout_width="-1";
   };
    {
     CardView;
     layout_height = "58dp";
     layout_width = "58dp";
     radius = "24%w";
     CardBackgroundColor = 0x00000000;
     layout_gravity = "right|center",
     layout_marginRight = "10dp";
     padding = "10dp";
     elevation = "0dp";
     {
      ImageView;
      id = "project_icon";
      scaleType = "fitXY";
      layout_height = "58dp";
      layout_width = "58dp";
     };
    };
    {
     LinearLayout;
     layout_height = dp2px(63);
     layout_width = "fill";
     layout_marginTop = "12dp";
     layout_marginLeft = "10dp";
     {
      TextView;
      textColor = wbColor;
      id = "project_title";
      textSize = "17dp";
      Typeface = 字体("product-Bold");
     };
     {
      TextView;
      textColor = 0x90ff0000;
      textSize = "12dp";
      layout_marginLeft = "30dp";
      layout_marginTop = "-1dp";
      id = "isTop";
      Typeface = 字体("product-Bold");
     };
    };
    {
     TextView;
     textColor = wbColor;
     id = "project_packageNames";
     layout_marginLeft = "10dp";
     layout_marginTop = "1.5%w";
     layout_gravity = "left|center",
     textSize = "14dp";
     Typeface = 字体("product");
     singleLine = "true";
     maxLines = "5";
    };
    {
     TextView;
     layout_height = "-1";
     layout_marginLeft = "10dp";
     layout_marginBottom = "7dp";
     id = "project_version";
     gravity = "left|bottom",
     textColor = wbColor;
     textSize = "14dp";
     Typeface = 字体("product");
     singleLine = "true";
     maxLines = "5";
    };
   };
  };
  {
   TextView;
   id = "project_name";
   Visibility = "invisible";
  };
 };


 item3 = {--标题 版本
  LinearLayout; --线性布局
  Orientation = 'horizontal'; --布局方向
  layout_width = 'fill'; --布局宽度
  layout_height = '95dp'; --布局高度
  {
   CardView; --卡片控件
   layout_margin = '10dp'; --卡片边距
   layout_gravity = 'center'; --子控件在父布局中的对齐方式
   CardElevation = '0dp'; --卡片阴影
   layout_width = 'fill'; --卡片宽度
   layout_height = 'fill'; --卡片高度
   radius = '3dp'; --卡片圆角
   CardBackgroundColor = listColor; --卡片背景颜色
   {
    FrameLayout;
    layout_height = "fill";
    layout_width = "fill";
    id = "lay";
       {
    TextView;
    id="bw";
    layout_height="-1";
    layout_width="-1";
   };
    {
     CardView; --卡片控件
     id = "card"; --设置id
     layout_margin = '5dp'; --卡片边距
     layout_gravity = 'right'; --子控件在父布局中的对齐方式
     CardElevation = '6dp'; --卡片阴影
     layout_width = '0dp'; --卡片宽度
     layout_height = '11dp'; --卡片高度
     radius = '15dp'; --卡片圆角
     CardBackgroundColor = '#ff8080'; --卡片背景颜色
     alpha = 0.5;
    };
    {
     LinearLayout; --线性布局
     Orientation = 'horizontal'; --布局方向
     layout_height = "fill";
     layout_width = "fill";
     layout_gravity = "center";
     {
      FrameLayout;
      layout_width = "55dp";
      layout_height = "55dp";
      backgroundColor = 0x00000000;
      layout_marginLeft = "10dp";
      layout_gravity = "center";

      {
       ImageView;
       layout_width = '55dp'; --卡片宽度
       layout_height = '55dp'; --卡片高度
       id = "project_icon";
      };
     };
     {
      LinearLayout; --线性布局
      Orientation = 'horizontal'; --布局方向
      layout_height = "fill";
      layout_width = "fill";
      layout_marginLeft = "20dp";
      layout_gravity = "center";
      {
       TextView;
       textColor = wbColor;
       id = "project_packageNames";
       layout_height = "0dp";
       layout_width = '0dp'; --卡片宽度
       layout_gravity = "left|center",
       textSize = "0dp";
       Typeface = 字体("product");
      };
      {
       TextView;
       textColor = wbColor;
       id = "project_title";
       textSize = "17dp";
       layout_gravity = "center";
       Typeface = 字体("product-Bold");
       layout_width = "wrap";
       singleLine = "true";
       ellipsize = "marquee",
       Selected = "true";
      };
      {
       TextView;
       id = "project_name";
       layout_height = "0dp";
       textSize = "0dp";
       layout_width = "20dp";
      };
      {
       TextView;
       id = "project_version";
       textColor = wbColor;
       textSize = "17dp";
       layout_gravity = "center";
       Typeface = 字体("product");
       layout_width = "wrap";
       singleLine = "true";
       ellipsize = "marquee",
       Selected = "true";
      };
      {
       TextView;
       textColor = 0x90ff0000;
       textSize = "12dp";
       layout_gravity = "center";
       layout_marginLeft = "30dp";
       layout_marginTop = "-1dp";
       id = "isTop";
       Typeface = 字体("product-Bold");
      };
     };
    };
   };
  };
 };


 file_item = {
  {
   LinearLayout;
   layout_height = "fill";
   layout_width = "fill";
   {
    ImageView;
    layout_height = "40dp";
    id = "icon";
    layout_gravity = "center";
    layout_margin = "5dp";
    layout_marginLeft = "10dp";
    layout_width = "40dp";
    src = "/Controller/res/FileTypeIcons/ic_file.png";
   };
   {
    LinearLayout;
    layout_height = "wrap";
    orientation = "vertical";
    layout_width = "-1";
    layout_gravity = "center";
    layout_margin = "5dp";
    {
     TextView;
     ellipsize = "end";
     id = "title";
     textSize = "18dp";
     maxLines = 1;
     text = "标题";
     TextColor = wbColor;
     singleLine = true;
     Typeface = 字体("product-Bold");
    };
    {
     LinearLayout;
     layout_height = "wrap";
     layout_width = "-1";
     {
      TextView;
      textSize = "14dp";
      id = "typesOf";
      Typeface = 字体("product");
      maxLines = 1;
      textColor = wbColor;
      text = "文件夹";
      layout_height = "wrap";
      layout_width = "wrap";
      gravity = "center";
      singleLine = "true";
      ellipsize = "marquee",
      Selected = "true";
     };
     {
      TextView;
      textSize = "10dp";
      id = "count";
      Typeface = 字体("product");
      maxLines = 1;
      textColor = wbColor;
      layout_height = "wrap";
      layout_marginLeft="10dp";
      layout_width = "wrap";
      gravity = "center";
      singleLine = "true";
      ellipsize = "marquee",
      Selected = "true";
    };
    }
   };
  };
 };
};

