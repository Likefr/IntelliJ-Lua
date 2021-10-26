import "android.graphics.drawable.ColorDrawable"
import "android.graphics.*"
import "android.view.Gravity"
import "android.content.Context"
import "android.view.animation.AlphaAnimation"
import "android.animation.ObjectAnimator"
import "android.animation.AnimatorSet"
import "android.view.animation.Animation"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.OvershootInterpolator"
import "android.view.animation.AnimationSet"
import "android.view.animation.AlphaAnimation"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.DecelerateInterpolator"
import "android.view.animation.AccelerateDecelerateInterpolator"
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"
import "android.content.res.ColorStateList"
import "android.widget.Toast"
--[[  /**
 * Author:    Likefr
 * Version    V2.0
 * Date:      21/01/22 10:00
 * Description:
 * Modification  History:
 * Date     	Author   	Version        	Description
 * -------------------------------------------------------
 * 21/1/26      Likefr        1.0               1.0
 Bug: nil
 *  * ]]

local Alert = {}
local n = {}

Warning = 2; --⚠
Err = 3;
Ok = 1;
cs = 200

function onClickNull()
  --TODO
   Toast.makeText(activity, "无论如何都请重写onClick事件", Toast.LENGTH_SHORT).show()
end

function n.onClick()

end

function getpath(Themew)
  return Themew;
end



function Dialike(value, mode)

  if mode ~= nil then
    Mode = mode
   else
    Mode = nil
  end

  if mode == Warning then
    --选择1为警告对话框
    n.setImage ="res/warning.png"
    -- n.setImage = "https://icon.qiantucdn.com/20200423/11c437b7d9eeca8ded63ec79d264550a2"
   else
    if mode == Err then
      n.setImage ="res/err.png"
      -- n.setImage = "https://icon.qiantucdn.com/20200423/b2f4de72b45d05ee03ba69ecd93f32e82"
     else
      if mode == Ok then
        n.setImage = "res/ok.png"
        --    n.setImage = "https://icon.qiantucdn.com/20200423/513b005e4824912da808aca364b1ebd52"
      end
    end
  end
  if value then
    Themew = value
   else
    Themew = "Dialog"
  end
  return Alert
end

function Alert.setWidth(W, H)
  n.W = W
  n.H = H
  return Alert
end
function Alert.setGravity(value)
  n.GRAVITY = value
  return Alert
end
--
function Alert.setMessage(value)
  n.text = value
  return Alert
end

--
function Alert.setMessageColor(value)
  n.textColor = value
  return Alert
end

function Alert.setMessageSize(value)
  n.textSize = value
  return Alert
end

function Alert.setTitle(value)
  n.title = value
  return Alert
end

function Alert.setTitleColor(value)
  n.titleColor = value
  return Alert
end

function Alert.setRadius(value)
  if value then
    n.radius = value
   else
    n.radius = "18dp"
  end
  return Alert
end

function Alert.setElevation(value)
  n.elevation = value
  return Alert
end

function Alert.setBackground(value)
  --设置背景
  n.background = value
  return Alert
end

function Alert.setImage(value)
  --设置图片
  n.VisibilityImage = "visible"

  if value == nil then
    n.setImage = "https://icon.qiantucdn.com/20200422/6cf849aebb65f2b20db3e9c4307954412"--默认升级img
   else
    n.setImage = value
  end
  return Alert
end

function Alert.setCardBackground(values)
  --设置对话框背景
  n.color = values
  return Alert
end



--TODO 中立事件

function Alert.setNegativeButton(txt, x)
  -- print(n.Negative)
  --取消
  n.Negative = txt
  if x then
    n.onClick = x
   else
    n.onClick = onClickNull--提示重写事件
  end
  return Alert
end

function Alert.setPositiveButton(txt, x)  --确定事件

  n.Positive = txt
  if x then
    n.onClick3 = x
   else
    n.onClick3 = onClickNull
  end
  return Alert
end

function Alert.setButtonSize(index, size)
  --可重载
  if index == 1 then
    n.textSize1 = size
   else
    if index == 2 then
      n.textSize2 = size
     else
      if index == 3 then
        n.textSize3 = size
      end
    end
  end
  return Alert
end

function Alert.setOutsideTouchable(boolean)
  --设置对话框点击外部是否可消失
  n.OutsideTouchable = boolean
  return Alert
end

function Alert.setFocusable(value)
  --设置返回键对对话框的操作
  n.Focusable = value
  return Alert
end

function Alert.show()
  init()
  if Themew == "Dialog" then
    --默认对话框
    showX()
   else
    if Mode == Warning or Mode == Ok or Mode == Err then
      --动画对话框
      showY()
     else
      print("没有输入 自动配置默认对话框")
    end
  end
  --调用玩对话框后清空cace
  DEFULT()

end

function showX()  --defalult

  Dialog = {
    LinearLayout,
    layout_width = "fill",
    layout_height = "fill",
    Gravity = n.GRAVITY,
    orientation = "vertical";
    backgroundColor = n.background,
    id = "Dialog",
    {
      ImageView;
      src = n.setImage;
      layout_height = "136dp"; --原图尺寸/1.5
      Visibility = n.VisibilityImage;
      layout_width = "fill";
      layout_marginBottom = "-5dp";
    };
    {
      CardView,
      layout_width = n.W, --默认值为90%w
      layout_height = n.H, --默认值为自适应。
      elevation = n.elevation;
      layout_marginBottom = n.BottonS;
      radius = n.radius,
      id = "Card",
      {
        LinearLayout,
        layout_width = n.W, --默认值为90%w
        layout_height = n.H, --默认值为自适应。
        orientation = "vertical";
        backgroundColor = "#ffffffff",
        {
          LinearLayout,
          layout_width = n.W, --默认值为90%w
          layout_height = n.H, --默认值为自适应。
          orientation = "vertical";
          backgroundColor = n.color;
          {
            TextView,
            layout_width = "wrap",
            layout_height = "50dp",
            layout_gravity = "center",
            textColor = n.titleColor,
            textSize = "20sp",
            id = "title";
            Gravity = "center",
            text = n.title,
          },
          {
            LinearLayout,
            layout_width = "fill",
            layout_height = "wrap",
            orientation = "vertical";
            layout_margin = "10dp";
            {
              TextView,
              layout_width = "wrap",
              layout_height = "wrap",
              textColor = n.textColor,
              text = n.text;
              textSize = n.textSize,
            },
          },
        },
        {
          LinearLayout,
          layout_width = "fill",
          layout_height = -1,
          backgroundColor = n.color;
          padding = '10dp',
          {
            Button;
            textColor = "#ffa8a8a8",
            text = n.Negative;
            layout_width = '0dp',
            textSize = n.textSize1;
            layout_height = -2,
            layout_weight = "1.0",
            background = "#0000000",
            Visibility = n.Visibility1;
            onClick = function()
              n.onClick()
              OutAnim1()
            end,
          },
          {
            Button;
            textColor = "#ffa8a8a8",
            text = n.Positive; --TODO
            textSize = n.textSize2;
            layout_width = '0dp',
            layout_height = -2,
            background = "#00000000",
            layout_weight = "1.0",
            Visibility = "invisible"; --gone.不可见不占用位置
            onClick = function()
              n.onClick2()
              OutAnim1()
            end,
          },
          {
            Button;
            textColor = "#ffa8a8a8",
            text = n.Positive;
            layout_width = '0dp',
            background = "#00000000",
            textSize = n.textSize3;
            layout_height = -2,
            Visibility = n.Visibility3;
            layout_weight = "1.0",
            --layout_cenderIn.arend="true",
            onClick = function()
              n.onClick3()
              OutAnim1()
            end,
          },
        },
      },
    },
  };

  task(1,function()
    pop = PopupWindow(loadlayout(Dialog))
    pop.setWidth(-1)
    pop.setHeight(-1)
    pop.setFocusable(true)
    pop.setBackgroundDrawable(ColorDrawable(0x00000000))--去除默认背景黑色

    --TODO 未来将实现 SnackBar
    pop.setFocusable(n.Focusable)--true 为返回键可取消对话框。false 返回键直接finish
    --TODO
    import "android.graphics.drawable.BitmapDrawable"

    pop.setOutsideTouchable(n.OutsideTouchable) --穿透
    pop.showAtLocation(webView, Gravity.CENTER, 0, 0)
    intoAnim()--入场动画

  end)
end

function showY()
  toast = {
    LinearLayout,
    layout_width = "fill",
    layout_height = "fill",
    Gravity = n.GRAVITY,
    backgroundColor = n.background,
    orientation = "vertical";
    id = "Dialog",
    {
      CardView,
      layout_width = n.W, --默认值为90%w
      layout_height = n.H, --默认值为自适应。
      elevation = n.elevation;
      CardBackgroundColor = n.color;
      radius = n.radius,
      id = "Card",
      layout_marginTop = "12dp";
      layout_marginBottom = "10dp";
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "fill",
        orientation = "horizontal";
        gravity = "center|left";
        {
          LinearLayout,
          layout_width = "40dp",
          layout_height = "40dp",
          id = "imgo";
          {
            ImageView;
            src = n.setImage;
            id = "img";
            layout_margin = "2%w",
            layout_width = "30dp";
            layout_height = "30dp",
          };
        };
        {
          LinearLayout,
          layout_width = "3dp",
          layout_height = "fill",
          gravity = "center";
          --  Visibility = n.VisibilityView; -- TODO;
          layout_margin = "2%w",
          {
            View,
            layout_width = "1.5dp",
            layout_height = "40dp",
            id = "vi";
            background = "#fff2f1f6",
          };
        };
        {
          LinearLayout,
          layout_width = "wrap",
          layout_height = "wrap",
          gravity = "center";
          {
            TextView,
            textColor = n.textColor,
            text = n.text;
            textSize = n.textSize,
            layout_margin = "3%w",
            layout_width = "wrap",
          },
        };
      };
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap",
        layout_gravity = "bottom",
        layout_marginBottom = "-7dp";
        {
          SeekBar;
          layout_width = "fill"; --宽度
          layout_gravity = "bottom",
          progress = 300;
          max = 300;
          style = "?android:attr/progressBarStyleHorizontal"; --长条形进度条
          id = "jdt";
        };
      };
    },
  };

  task(1,function()
    toast = PopupWindow(loadlayout(toast))
    toast.setFocusable(true)
    toast.setWidth(-1)
    toast.setHeight(-1)
    toast.setBackgroundDrawable(ColorDrawable(0x00000000))--去除默认背景黑色
    --TODO 未来将实现 SnackBar
    toast.setFocusable(n.Focusable)--true 为返回键可取消对话框。false 返回键直接finish
    --TODO

    import "android.graphics.drawable.BitmapDrawable"

    toast.setOutsideTouchable(n.OutsideTouchable) --穿透
    toast.showAtLocation(webView, Gravity.CENTER, 0, 0)
    intoAnim()--入场动画

    --TODO 动画对话框 返回键BUG

    --修改SeekBar滑条颜色
    --jdt.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFFB7299,PorterDuff.Mode.CLEAR))


    ToastAnim();
  end)
end





--function
function intoAnim()
  --定义动画变量,使用AnimationSet类，使该动画可加载多种动画
  animationSet = AnimationSet(true)
  layoutAnimationController = LayoutAnimationController(animationSet, 0.5);
  alpha = AlphaAnimation(0, 1);
  alpha.setDuration(100);
  animationSet.addAnimation(alpha);
  Dialog.startAnimation(alpha)--Star动画
  translation = TranslateAnimation(0, 0, activity.height, 0)
  translation.setDuration(250);
  animationSet.addAnimation(translation);
  Dialog.setLayoutAnimation(layoutAnimationController);
end

function OutAnim1()
  alpha = AlphaAnimation(1, 0)
  alpha.setDuration(600);
  alpha.setFillAfter(true)
  Dialog.startAnimation(alpha)--Star动画
  import "android.view.animation.Animation$AnimationListener"
  alpha.setAnimationListener(AnimationListener {
    onAnimationEnd = function()
      pop.dismiss()
      Card.setElevation(0)
    end
  })
end

function OutAnim2()
  alpha = AlphaAnimation(1, 0)
  alpha.setDuration(600);
  alpha.setFillAfter(true)
  Dialog.startAnimation(alpha)--Star动画
  import "android.view.animation.Animation$AnimationListener"
  alpha.setAnimationListener(AnimationListener {
    onAnimationEnd = function()
      toast.dismiss()
      Card.setElevation(0)
    end
  })
end



--[[ setTouchable(boolean.touchable)
 设置PopupWin.ow是否响应touch事件,
默认是true，如果设置为false
所有touch事件无响应，包括点击事件)]]

--pop.setTouchable(false)
--pop.setOutsideTouchable(true)
--该方法是单击外部区域是否消失 参数 true 为消失

function setOutsideTouchable(boolean)
  if boolean == true then
    function Dialog.onClick()
      --单击对话框任何一个区域事件
      if Mode == Warning or Mode == Ok or Mode == Err then
        li.stop()
        --   print("OutAnim2")
        OutAnim2()
       else
        --   print("OutAnim1")
        OutAnim1()
      end

    end
  end
end

function ToastAnim ()


  --   --进度条动画一推BUG
  li = Ticker()--Bar Anim
  cs = 300

  li.Period = 15
  li.onTick = function()
    cs = cs - 1
    jdt.setProgress(cs)--进度条-1变量
    if cs == 0 then
      li.stop()
      OutAnim2()
    end
  end

  旋转动画 = ObjectAnimator.ofFloat(img, "rotation", { -20, 20 })
  旋转动画.setInterpolator(AccelerateDecelerateInterpolator());--动画插值器
  旋转动画.setRepeatCount(15)--设置动画重复次数 default 15
  旋转动画.setRepeatMode(Animation.REVERSE)--设置动画循环模式
  旋转动画.start();--动画开
  li.start()
end



--封装的功能
function Alert.Updata(URL)
  --重载
  print(URL)
end

function DEFULT()
  --调用完对话框后将初始化原值
--  print(wbColor)
  cs = 200;
  n.text = nil
  n.title = nil
  n.textSize1 = "15sp"
  n.textSize3 = "15sp"
  n.Negative = nil
  n.Positive = nil
  n.W = "90%w"
  Themew = "Theme.Dialog"--初始化默认对话框
  n.H = "wrap"
  n.BottonS = "30dp"
  n.GRAVITY = "center"
  n.radius = "18dp"
  n.textColor ="#90ffffff"
  n.color = "#ffffffff"
  n.background = "#00000000"
  n.Focusable = true
  n.OutsideTouchable = true
  n.Visibility1 = nil
  n.setImage = nil
  n.VisibilityImage = "GONE" --默认隐藏图片 更新即可使用
  n.Visibility3 = nil
  System.gc()
end

function init()
  --初始化
  if n.W == nil or n.H == nil then
    n.W = "90%w"
    n.H = "wrap"
    n.BottonS = "30dp"
  end

  if n.GRAVITY == nil then
    n.GRAVITY = "center"
  end
  if n.radius == nil then
    n.radius = "18dp"
  end
  if n.OutsideTouchable == nil then
    n.OutsideTouchable = true--默认对话框外部点击可取消
   else
    if n.OutsideTouchable ~= true and n.OutsideTouchable ~= false then
      --&&  Lua center and re
      print("方法->.OutsideTouchable(err) 参数:" .. n.OutsideTouchable .. "   出现异常---值只允许boolean属性")
    end
  end

  if n.Focusable == nil then
    n.Focusable = true
  end

  --！Button
  if n.Negative == nil then
    --等于nil 没有设置事件
    n.Visibility1 = "invisible"
  end
  if n.Positive == nil then
    --确定按钮
    n.Visibility3 = "invisible" --不可见
  end
  if n.setImage ~= nil then
    --NOT NULL
    n.VisibilityImage = "visible" --设置了图片代表着图片可见
   else
    n.VisibilityImage = "invisible" --没有设置setImage
  end

  --   if Mode == nil then
  --     DEFULT()
  --end
end



function dialog(title,context,wz,on)
  AlertDialog.Builder(this)
  .setTitle(title)
  .setMessage(context)
  .setPositiveButton(wz,on)
  .show();
end

local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
local typedArray =activity.obtainStyledAttributes(attrsArray)
ripple=typedArray.getResourceId(0,0)
function 获得ColorStateList(颜色)
  return ColorStateList(
  int[0].class{int{}},
  int{颜色})
end
