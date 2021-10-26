require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.animation.ObjectAnimator"
import "android.graphics.Typeface"


if this.getSharedData(activity.getString(R.string.night)) == "true" then
    Bar=0xFF2C303B;
    background=0xFF2C303B;--夜间背景。
    backgroundB=0xff1890ff;--按压颜色
    elevation="8dp"--阴影
    wbColor=0x90ffffff--夜间字体颜色

else
    Bar=0xFFF9F9F9
    background=0xFFF9F9F9;
    backgroundB=0xffff8080;
    ColorFilter=0xFF2C303B
    elevation="3dp"
    wbColor=0xff495057
end



if this.getSharedData("Activity动画") == "true" then
    activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
end
if this.getSharedData("屏幕常亮") == "true" then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
end

--设置ActionBar背景颜色
import "android.graphics.drawable.ColorDrawable"
activity.ActionBar.setBackgroundDrawable(ColorDrawable(background))

activity.setTitle('帮助')--设置窗口标题

theview=loadlayout(
{
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    backgroundColor=background;
    {
        CardView;
        layout_height="200dp";
        id="_card";
        layout_margin="16dp";
        radius="16dp";
        elevation=0;
        layout_width="fill";
        {
            LinearLayout;
            alpha="0";
            layout_height="fill";
            id="_cardin";
            orientation="vertical";
            layout_width="fill";
            {
                LinearLayout;
                layout_height="56dp";
                layout_width="fill";
                {
                    TextView;
                    paddingLeft="16dp";
                    layout_height="fill";
                    TextSize="10dp";
                    id="_title";
                    paddingTop="16dp";
                    textColor=wbColor;
                    text="关于打包";
                };
                {
                    CardView;
                    layout_height="fill";
                    layout_width="2dp";
                    BackgroundColor=4278190080;
                    layout_marginLeft="12dp";
                    layout_marginTop="16dp";
                    id="_cutline1";
                    layout_marginBottom="8dp";
                    elevation=0;
                    radius="1dp";
                };
            };
            {
                CardView;
                layout_height="2dp";
                layout_width="fill";
                BackgroundColor=4278190080;
                layout_marginLeft="12dp";
                layout_marginRight="16dp";
                id="_cutline2";
                layout_marginTop="2dp";
                elevation=0;
                radius="1dp";
            };
            {
                LinearLayout;
                {
                    TextView;
                    layout_height="fill";
                    TextSize="7dp";
                    id="_text";
                    layout_width="fill";
                    padding="16dp";
                    textColor=wbColor;
                    text=[==[  编译器会自动编译并加密 打包后的路径在 
 /storage/emulated/0/IntelliJ Lua/apk/]==];
                };
            };
        };
    };


    {
        CardView;
        layout_height="240dp";
        id="_card2";
        layout_margin="16dp";
        radius="16dp";
        elevation=0;
        layout_width="fill";
        {
            LinearLayout;
            alpha="0";
            layout_height="fill";
            id="_cardin2";
            orientation="vertical";
            layout_width="fill";
            {
                LinearLayout;
                layout_height="56dp";
                layout_width="fill";
                {
                    TextView;
                    paddingLeft="16dp";
                    layout_height="fill";
                    TextSize="10dp";
                    id="_title2";
                    paddingTop="16dp";
                    textColor=wbColor;
                    text="备份的路径在哪？";
                };
                {
                    CardView;
                    layout_height="fill";
                    layout_width="2dp";
                    BackgroundColor=4278190080;
                    layout_marginLeft="12dp";
                    layout_marginTop="16dp";
                    id="_cutline12";
                    layout_marginBottom="8dp";
                    elevation=0;
                    radius="1dp";
                };
            };
            {
                CardView;
                layout_height="2dp";
                layout_width="fill";
                BackgroundColor=4278190080;
                layout_marginLeft="12dp";
                layout_marginRight="16dp";
                id="_cutline22";
                layout_marginTop="2dp";
                elevation=0;
                radius="1dp";
            };
            {
                LinearLayout;
                {
                    TextView;
                    layout_height="fill";
                    TextSize="7dp";
                    id="_text2";
                    layout_width="fill";
                    padding="16dp";
                    textColor=wbColor;
                    text="  备份后的路径将会以alp的格式 他将放入到 /storage/emulated/0/IntelliJ Lua/backup/ 这个文件夹 适用于任何编译器导入";
                };
            };
        };
    };
  
  
  
    {
        CardView;
        layout_height="220dp";
        id="_card3";
        layout_margin="16dp";
        radius="16dp";
        elevation=0;
        layout_width="fill";
        {
            LinearLayout;
            alpha="0";
            layout_height="fill";
            id="_cardin3";
            orientation="vertical";
            layout_width="fill";
            {
                LinearLayout;
                layout_height="56dp";
                layout_width="fill";
                {
                    TextView;
                    paddingLeft="16dp";
                    layout_height="fill";
                    TextSize="10dp";
                    id="_title3";
                    paddingTop="16dp";
                    textColor=wbColor;
                    text="关于";
                };
                {
                    CardView;
                    layout_height="fill";
                    layout_width="2dp";
                    BackgroundColor=4278190080;
                    layout_marginLeft="12dp";
                    layout_marginTop="16dp";
                    id="_cutline3";
                    layout_marginBottom="8dp";
                    elevation=0;
                    radius="1dp";
                };
            };
            {
                CardView;
                layout_height="2dp";
                layout_width="fill";
                BackgroundColor=4278190080;
                layout_marginLeft="12dp";
                layout_marginRight="16dp";
                id="_cutline33";
                layout_marginTop="2dp";
                elevation=0;
                radius="1dp";
            };
            {
                LinearLayout;
                {
                    TextView;
                    layout_height="fill";
                    TextSize="7dp";
                    id="_text3";
                    layout_width="fill";
                    padding="16dp";
                    textColor=wbColor;
                    text="我知道这个编译器还有很多不足,你可以随时找到我 并像我提一些宝贵意见  酷安@Likefr";
                };
            };
        };
    };
  
}
)
activity.setContentView(theview)
function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end
import "android.graphics.drawable.GradientDrawable"
drawable =  GradientDrawable()  
drawable.setShape(GradientDrawable.RECTANGLE) 
drawable.setCornerRadius(dp2px(16))
drawable.setStroke(dp2px(4), wbColor)
drawable.setColor(0)
theview.getChildAt(0).setBackgroundDrawable(drawable)
theview.getChildAt(2).setBackgroundDrawable(drawable)
theview.getChildAt(1).setBackgroundDrawable(drawable)
function showAnim()
  animt=500
  _cardin.alpha=0
    _cardin2.alpha=0
        _cardin3.alpha=0
  dh2(_title,_cutline1,_cutline2,_text)
   dh2(_title2,_cutline12,_cutline22,_text2)
      dh2(_title3,_cutline3,_cutline33,_text3)
  task(animt/2,function()
    _cardin.alpha=1
      _cardin2.alpha=1
          _cardin3.alpha=1
end)
    end
  task(100,function()--在没有绘制之前获取不到xy，我懒得判断了
showAnim()
end)


function dh2(a,b,c,d)

  ObjectAnimator.ofFloat(a, "alpha", {0, 1}).setDuration(animt*0.8).start()
  ObjectAnimator.ofFloat(a, "ScaleX", {0, 1.1,.95,1}).setDuration(animt).start()
  ObjectAnimator.ofFloat(a, "ScaleY", {0, 1.1,0.95,1}).setDuration(animt).start()
  ObjectAnimator.ofFloat(b, "X", {activity.getWidth(), b.getX()-dp2px(36),b.getX()+dp2px(16),b.getX()}).setDuration(animt).start() ObjectAnimator.ofFloat(c, "Alpha", {0,1}).setDuration(animt).start() ObjectAnimator.ofFloat(d, "alpha", {0, 1}).setDuration(animt/0.8).start()
  ObjectAnimator.ofFloat(d, "ScaleX", {0, 1.1,0.95,1}).setDuration(animt).start()
  ObjectAnimator.ofFloat(d, "ScaleY", {0, 1.1,0.95,1}).setDuration(animt).start()
  
  end