require"import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LayBox"
import "IntelliJ"
import "java.io.File"
import "android.graphics.Color"
import "android.graphics.drawable.*"
import "android.graphics.Typeface"
import "android.graphics.drawable.GradientDrawable"

mode=2-- 设置列表样式 建议1或者2。

lay={
  LinearLayout;
  layout_height="fill";
  layout_width="fill";
  backgroundColor=background;--全局背景
  orientation="vertical";
  {
    CardView;
    layout_height="65dp";
    layout_width="fill";
    radius="0dp";
    CardBackgroundColor=background;--背景颜色
        elevation=elevation;
    {
      ImageView;
      layout_height="30dp";
      id="back";
      layout_marginLeft="20dp";
      layout_width="30dp";
      layout_gravity="left|center";
      src="res/Settings/twotone_arrow_back_black_24dp.png";
      ColorFilter=ColorFilter;
    };
    {
      TextView;
      text="设置";
      layout_marginLeft="70dp";
      textSize="18dp";
      textColor=wbColor;
      layout_gravity="left|center";
    };
  };
  --[[  {
    ImageView;
    layout_height="200dp";
    id="image";
    layout_width="300dp";
    layout_gravity="center";
    src="res/Settings/undraw_settings.png";
    ColorFilter=filter;
  };]]
  {
    GridView;
    layout_height="fill";
    numColumns=mode;--列数
    layout_width="fill";
    horizontalSpacing="0dp";--横向布局
    verticalSpacing="5dp";--竖向布局
    id="grid";
    gravity="center";
  };
};

activity.setContentView(loadlayout(lay))
--状态选择器
stateListDrawable = StateListDrawable()
--按下时的效果
pressedDrawable = GradientDrawable();
--也可以自定义
pressedDrawable.setColor(Color.parseColor("#00000000"));
--pressedDrawable.setColor(Color.DKGRAY);
pressedDrawable.setShape(GradientDrawable.RECTANGLE);
--给状态选择器添加状态
stateListDrawable.addState({android.R.attr.state_pressed},pressedDrawable)
grid.setSelector(stateListDrawable)
--LuaAdapter(Lua适配器)
--创建自定义项目视图

item=
{
  LinearLayout;
  layout_height="155dp";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  {
    CardView;
    layout_height="135dp";
    layout_width="150dp";
    radius="12dp";
    CardBackgroundColor=background;
    layout_gravity="center";
    elevation=elevation;
    {--设置项(图片标题,简介,开关)
      LinearLayout;
      gravity="center";
      layout_width="fill";
      layout_height="56dp";
      {
        ImageView;
        layout_height="36dp";
        id="图片";
        layout_marginLeft="5dp";
        layout_width="36dp";
        -- ColorFilter=listcolor;
      };
      {
        Switch;
        clickable=false;
        Focusable=false;
        layout_height="wrap";
        layout_width="wrap";
        layout_marginLeft="45dp";
        id="witch";
      };
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_height="fill";
      layout_width="fill";
      layout_marginBottom="20dp";
      gravity="bottom";
      {
        TextView;
        textSize="16dp";
        layout_marginLeft="16dp";
        textColor=wbColor;
        layout_height="wrap";
        layout_width="fill";
        id="标题";
        Typeface=字体("product-Bold");
      };
      {
        TextView;
        id="message";
        layout_marginLeft="16dp";
        textColor=wbColor;
        layout_marginTop="5dp";
      };
    };
  };
};



data = {}
adapter=LuaAdapter(activity,data,item)
adapter.add{图片="res/Settings/twotone_web_black_24dp.png",标题="主页布局",message="主页详细列表模式",witch={Checked=Boolean.valueOf(this.getSharedData("主页布局"))}}
--adapter.add{图片="res/Settings/crown1.png",标题="CodePane",message="高性能编辑器",witch={Checked=Boolean.valueOf(this.getSharedData("CodePane"))}}
adapter.add{图片="res/Settings/twotone_brightness_2_black_24dp.png",标题=activity.getString(R.string.night),message="启动黑夜模式",witch={Checked=Boolean.valueOf(this.getSharedData(activity.getString(R.string.night)))}}
adapter.add{图片="res/Settings/ic_fullscreen_black_24dp.png",标题=activity.getString(R.string.FullSc),message="更好的体验",witch={Checked=Boolean.valueOf(this.getSharedData(activity.getString(R.string.FullSc)))}}
adapter.add{图片="res/Settings/ic_details_black_24dp.png",标题="显示状态栏",message="沉浸状态栏",witch={Checked=Boolean.valueOf(this.getSharedData("显示状态栏"))}}
adapter.add{图片="res/Settings/anim.png",标题="Activity动画",message="淡入淡出效果",witch={Checked=Boolean.valueOf(this.getSharedData("Activity动画"))}}
adapter.add{图片="res/Settings/twotone_local_florist_black_24dp.png",标题="代码检查",message="编译器实时查错",witch={Checked=Boolean.valueOf(this.getSharedData("代码检查"))}}
adapter.add{图片="res/Settings/twotone_beach_access_black_24dp.png",标题="原生Toast",message="安卓提供的默认Toast",witch={Checked=Boolean.valueOf(this.getSharedData("原生Toast"))}}
adapter.add{图片="res/Settings/twotone_wb_sunny_black_24dp.png",标题="屏幕常亮",message="屏幕常亮",witch={Checked=Boolean.valueOf(this.getSharedData("屏幕常亮"))}}


--[[
添加设置选项。

 第1个参数为图片。
 第2个为标题。
 第3个为设置简介。
 第4个为参数和标题一样写。]]
--adapter.add{图片="",标题="",message="",witch={Checked=Boolean.valueOf(this.getSharedData(""))}}

grid.setAdapter(adapter)




--列表点击事件
--这边可以不用改
grid.setOnItemClickListener(AdapterView.OnItemClickListener{

  onItemClick=function(id,v,zero,one)

    if v.Tag.witch.Checked then
      this.setSharedData(v.Tag.标题.Text,"false")
      data[one].witch["Checked"]=false
      -- this.recreate()--重构activity
      print("部分功能需要重启后生效")

     else
      this.setSharedData(v.Tag.标题.Text,"true")
      data[one].witch["Checked"]=true
      -- this.recreate()--重构activity
      print("部分功能需要重启后生效")
    end
    adapter.notifyDataSetChanged()--更新列表
end})


back.onClick=function()
  this.finish()
end