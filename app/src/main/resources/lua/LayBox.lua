import "console"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "java.io.*"
import "Dialog"--只需要导入这个包
import "DataBase"
import "android.text.method.*"
import "android.net.*"
import "IntelliJ"
import "android.graphics.Paint"
import "android.content.*"
import "java.io.File"--导入File类
import "android.os.Environment"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "android.util.Base64"
import "android.Manifest"
import "java.lang.*"
import "android.util.*"
import "android.graphics.Typeface"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.GradientDrawable"
import "android.view.WindowManager"
import "android.os.Build"
import "Toasts"
R = luajava.bindClass("com.Likefr.LuaJava.R")

activity.setTheme(android.R.style.Theme_DeviceDefault_DialogWhenLarge_NoActionBar)

local minicrypto = {}--RC4加解密算法(lua实现)
local insert, concat, modf, tostring, char = table.insert, table.concat, math.modf, tostring, string.char
local function numberToBinStr(x)
 local ret = {}
 while x ~= 1 and x ~= 0 do
  insert(ret, 1, x % 2)
  x = modf(x / 2)
 end
 insert(ret, 1, x)
 for i = 1, 8 - #ret do
  insert(ret, 1, 0)
 end
 return concat(ret)
end
local function computeBinaryKey(str)
 local t = {}
 for i = #str, 1, -1 do
  insert(t, numberToBinStr(str:byte(i, i)))
 end
 return concat(t)
end
local binaryKeys = setmetatable({}, { __mode = "k" })
local function binaryKey(key)
 local v = binaryKeys[key]
 if v == nil then
  v = computeBinaryKey(key)
  binaryKeys[key] = v
 end
 return v
end
local function initialize_state(key)
 local S = {};
 for i = 0, 255 do
  S[i] = i
 end
 key = binaryKey(key)
 local j = 0
 for i = 0, 255 do
  local idx = (i % #key) + 1
  j = (j + S[i] + tonumber(key:sub(idx, idx))) % 256
  S[i], S[j] = S[j], S[i]
 end
 S.i = 0
 S.j = 0
 return S
end

local function encrypt_one(state, byt)
 state.i = (state.i + 1) % 256
 state.j = (state.j + state[state.i]) % 256
 state[state.i], state[state.j] = state[state.j], state[state.i]
 local K = state[(state[state.i] + state[state.j]) % 256]
 return K ~ byt
end
function minicrypto.encrypt(text, key)
 local state = initialize_state(key)
 local encrypted = {}
 for i = 1, #text do
  encrypted[i] = ("%02X"):format(encrypt_one(state, text:byte(i, i)))
 end
 return concat(encrypted)
end
function minicrypto.decrypt(text, key)
 local state = initialize_state(key)
 local decrypted = {}
 for i = 1, #text, 2 do
  insert(decrypted, char(encrypt_one(state, tonumber(text:sub(i, i + 1), 16))))
 end
 return concat(decrypted)
end

path = SELECT("Project_Path", SELECT("User_option", "Value"))

if this.getSharedData("显示状态栏") == nil then
 this.setSharedData("显示状态栏", "true")--默认设置为关闭。
end

if this.getSharedData(activity.getString(R.string.FullSc)) == nil then
 this.setSharedData(activity.getString(R.string.FullSc), "false") --默认设置为开启。
end

if this.getSharedData("原生Toast") == nil then
 this.setSharedData("原生Toast", "false")
end

if this.getSharedData(activity.getString(R.string.night)) == nil then
 this.setSharedData(activity.getString(R.string.night), "false")
end

if this.getSharedData("Activity动画") == nil then
 this.setSharedData("Activity动画", "true")
end

if this.getSharedData("CodePane") == nil then
 this.setSharedData("CodePane", "false")
end

if this.getSharedData("代码检查") == nil then
 this.setSharedData("代码检查", "true")
end

if this.getSharedData("主页布局") == nil then
 this.setSharedData("主页布局", "false")
end

if this.getSharedData(activity.getString(R.string.night)) == "true" then
 Bar = 0xFF2C303B;
 background = 0xFF2C303B;--夜间背景。
 backgroundB = 0Xff292A2F;--按压颜色
 backgroundD = background;
 elevation = "8dp"--阴影
 ColorFilter = 0x90ffffff
 wbColor = 0x90ffffff--夜间字体颜色
 listColor = 0x99202020
 filter = 0xff495057
 else
 Bar = 0xffffffff
 listColor = 0xffF5F5F5
 background = 0xffffffff;
 backgroundB = 0xffff8080;
 backgroundD = 0xafffffff;
 elevation = "3dp"
 ColorFilter = 0xFF2C303B
 wbColor = 0xff495057
 filter = 0x90ffffff
end

if this.getSharedData("显示状态栏") == "true" then
 if Build.VERSION.SDK_INT >= 21 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(background);
 end
 import "android.view.WindowManager"
 activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
 activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 else
 --设置全屏隐藏状态栏
 import "android.view.WindowManager"
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
 this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

end

if this.getSharedData(activity.getString(R.string.FullSc)) == "true" and this.getSharedData(activity.getString(R.string.night)) ~= "true" then
 window = activity.getWindow();
 window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
 window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
 xpcall(function()
  lp = window.getAttributes();
  lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
  window.setAttributes(lp);
 end, function(e)
 end)
 height_Bar = 200
 else
 height_Bar = 200
end

--[[window = activity.getWindow();
window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
xpcall(function()
  lp = window.getAttributes();
  lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
  window.setAttributes(lp);
end, function(e)end)]]


if this.getSharedData("Activity动画") == "true" then
 activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
end
if this.getSharedData("屏幕常亮") == "true" then
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
end

function 去除主题(code)
 if tostring(code:match("--activity.setTheme")) == "--activity.setTheme" then
  --print("主题已注释 ")
  return code
  else

  local i = tostring(code:match("activity.setTheme((.+))"))

  if i:find("(R.Theme_Google)") or i:find("(R.AndLua1)")
   or i:find("(R.Theme_Blue)") or i:find("(R.Theme_AppLua14)") then

   dialog = AlertDialog.Builder(this)
   .setTitle("错误主题")
   .setMessage("检测到当前项目设置的Theme(主题)可能导致无法编译")
   .setPositiveButton("修改",
   { onClick = function(v)
     editor.findNext(tostring("activity.setTheme"))
    end })
   .setNeutralButton("下次再说", nil)
   .show()
  end
  return code
 end
end




--创建导航
function create_navi_dlg()
 if navi_dlg then
  return
 end
 navi_dlg = Dialog(activity)
 navi_dlg.setTitle("导航")
 navi_list = ListView(activity)
 navi_list.onItemClick = function(parent, v, pos, id)
  editor.setSelection(indexs[pos + 1])
  navi_dlg.hide()
 end
 navi_dlg.setContentView(navi_list)
end

function Add_Webview_Project(appname, kkk)

 local init = minicrypto.decrypt(activity.getString(R.string.CreatePath1), activity.getString(R.string.app_name))
 local main = minicrypto.decrypt(activity.getString(R.string.CreatePath2), activity.getString(R.string.app_name))
 local layout = minicrypto.decrypt(activity.getString(R.string.CreatePath3), activity.getString(R.string.app_name))
 local config = minicrypto.decrypt(activity.getString(R.string.CreatePath4), activity.getString(R.string.app_name))

 local back = File(path .. tostring(appname)).exists()
 if back == true then
  print(appname .. "已存在", info)
  else
  local inits = string.gsub(init, "APP名", appname)
  local inits = string.gsub(inits, "包名", kkk)
  local main = string.gsub(main, "APP名", appname)
  -- local configFile=io.open(activity.getLuaDir("/model/config")):read("*a")
  File(path .. appname).mkdir()
  io.open(path .. appname .. "/init.lua", "w"):write(inits):close()
  io.open(path .. appname .. "/main.lua", "w"):write(main):close()
  io.open(path .. appname .. "/layout.aly", "w"):write(layout):close()
  io.open(path .. appname .. "/config.json", "w"):write(config):close()
  -- io.open(path..appname.."/main.lua","a+"):write(configFile):close()
  print("创建web工程成功", success)

  Dialike()
  .setGravity("center")-- 设置对话框位置
  .setWidth("90%w", "wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
  .setTitle("提示")
  .setMessage("是否立即打开项目: " .. appname)
  .setMessageSize("18dp")
  .setElevation("12dp")
  .setMessageColor(wbColor)
  .setRadius("12dp")
  .setFocusable(true)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
  .setOutsideTouchable(true)--设置外部区域不可点击。
  --.setBackground(0xffff8080)--设置对话框底层背景
  .setCardBackground(background)--设置对话框背景
  .setButtonSize(3, 20)--第1个参数为按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
  .setPositiveButton("打开", function()
   content = io.open(path .. appname .. "/main.lua"):read("*a")
   activity.newActivity("CodeController", { appname, appname, content })
  end)
  .setNegativeButton("取消", function()
  end)
  .show()

  projectRefresh()
 end
end

function Add_Project(appname, kkk)

 local init = minicrypto.decrypt(activity.getString(R.string.CreatePath1), activity.getString(R.string.app_name))
 local main = minicrypto.decrypt(activity.getString(R.string.Create_普通2), activity.getString(R.string.app_name))
 local layout = minicrypto.decrypt(activity.getString(R.string.Create_普通), activity.getString(R.string.app_name))

 local back = File(path .. tostring(appname)).exists()
 if back == true then
  print(appname .. "已存在")
  else
  local inits = string.gsub(init, "APP名", appname)
  local inits = string.gsub(inits, "包名", kkk)
  local main = string.gsub(main, "APP名", appname)
  -- local configFile=io.open(activity.getLuaDir("/model/config")):read("*a")
  File(path .. appname).mkdir()
  io.open(path .. appname .. "/init.lua", "w"):write(inits):close()
  io.open(path .. appname .. "/main.lua", "w"):write(main):close()
  io.open(path .. appname .. "/layout.aly", "w"):write(layout):close()
  print("创建工程成功")

  Dialike()
  .setGravity("center")-- 设置对话框位置
  .setWidth("90%w", "wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
  .setTitle("提示")
  .setMessage("是否立即打开项目: " .. appname)
  .setMessageSize("18dp")
  .setElevation("12dp")
  .setMessageColor(wbColor)
  .setRadius("12dp") .setRadius("12dp")
  .setFocusable(true)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
  .setOutsideTouchable(true)--设置外部区域不可点击。
  .setCardBackground(background)--设置对话框背景
  .setButtonSize(3, 20)--第1个参数为按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
  .setPositiveButton("打开", function()
   content = io.open(path .. appname .. "/main.lua"):read("*a")
   activity.newActivity("CodeController", { appname, appname, content })
  end)
  .setNegativeButton("取消", function()
  end)
  .show()
  projectRefresh()
 end
end

function projectRefresh()
 --刷新
 path = SELECT("Project_Path", SELECT("User_option", "Value"))
 File(path).mkdirs()
 db = SQLiteDatabase.openOrCreateDatabase("/storage/emulated/0/IntelliJ Lua/.list_top.db", MODE_PRIVATE, nil);
 CreatrTableSql = "create table user(id integer primary key,project_icon varchar(60),project_name varchar(60),project_title varchar(60),project_version varchar(20),project_packageNames varchar(80),project_luaPath varchar(255))"
 if pcall(exec, CreatrTableSql) then
  else
 end
 project_adp.clear()
 project_adp置顶.clear()

 color_table = { 0xfffea64c, 0xffFe1e9a, 0xff254dde, 0xff00ffff, 0xff1976D2 }

 local a = luajava.astable(File(tostring(path)).listFiles())

 if tostring(a[1]) == "nil" then
  pulltwo.setVisibility(View.GONE)
  home.setVisibility(View.VISIBLE)
  else
  pulltwo.setVisibility(View.VISIBLE)
  home.setVisibility(View.GONE)

  sql = "select * from user"
  if pcall(raw, sql, nil) then
   while (cursor.moveToNext()) do
    userid = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
    icon = cursor.getString(1);--获取第二列的值
    name = cursor.getString(2);--获取第三列的值
    title = cursor.getString(3);--获取第二列的值
    version = cursor.getString(4);--获取第三列的值
    packages = cursor.getString(5);--获取第二列的值

    table.insert(project_data置顶, {
     project_icon = icon,
     project_name = name,
     project_title = title,
     project_version = version,
     project_packageNames = packages,
     bw={
      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0xff55b2ff}))
     },
    })
   end
   cursor.close()
   else
   print("没有置顶", defaul)
  end

  for b = 1, #a do
   local c = File(path .. a[b].Name).isDirectory()
   if c == true then
    local d = File(path .. a[b].Name .. "/init.lua").exists()
    local src = File(path .. a[b].Name .. "/icon.png").exists()
    if d == true then
     content = io.open(path .. a[b].Name .. "/init.lua"):read("*a")
     packagename = content:match("packagename=\"(.-)\"")
     version = content:match("appver=\"(.-)\"")
     if pcall(raw, "select * from where project_packageNames='" .. packagename .. "'", nil) then
      print "已置顶"
      else

      if src == true then
       table.insert(project_data, {
        project_icon = path .. a[b].Name .. "/icon.png",
        project_title = io.open(path .. a[b].Name .. "/init.lua"):read("*a"):match("appname=\"(.-)\""),
        project_name = a[b].Name,
        project_version = version,
        card = color_table[2],
        project_packageNames = packagename,
        card = {
         CardBackgroundColor = color_table[b % #color_table], --表里用了取余算法，让颜色实现循环。
        },
        bw={
         BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0xff55b2ff}))
        },
       })
       else
       table.insert(project_data, {
        project_icon = activity.getLuaDir("icon.png"),
        project_title = io.open(path .. a[b].Name .. "/init.lua"):read("*a"):match("appname=\"(.-)\""),
        project_name = a[b].Name,
        project_version = version,
        card = {
         CardBackgroundColor = color_table[b % #color_table], --表里用了取余算法，让颜色实现循环。
        },
        bw={
         BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0xff55b2ff}))
        },
        project_packageNames = packagename, })
      end
     end
    end
    else
   end
  end
 end

 project_list.Adapter = project_adp

 置顶.Adapter = project_adp置顶

 --创建一个Animation对象
 animation = AnimationUtils.loadAnimation(activity, android.R.anim.slide_in_left)
 --得到对象
 lac = LayoutAnimationController(animation)
 --设置控件显示的顺序
 lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
 lac.setDelay(0.1)--这里单位是秒
 project_list.setLayoutAnimation(lac)
end

local function CircleButton(view, InsideColor, radiu)
 import "android.graphics.drawable.GradientDrawable"
 drawable = GradientDrawable()
 drawable.setShape(GradientDrawable.RECTANGLE)
 drawable.setColor(InsideColor)
 drawable.setCornerRadii({ radiu, radiu, radiu, radiu, 0, 0, 0, 0 });
 view.setBackgroundDrawable(drawable)
end

function addProjects(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"

 --导入自定义布局
 local dialog_view = loadlayout(
 {
  LinearLayout,
  layout_width = "fill",
  layout_height = "35%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "0dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "20dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   textSize = "16dp";
   layout_gravity = "center";
   gravity = "center";
   textColor = wbColor;
   text = "创建工程";
   Typeface = 字体("mono");
  };
  {
   MyEditText({
    Hint = "工程名";
    id = "projectName";
    backgroundColor = background;
   });
   layout_width = "fill";
  },
  {
   MyEditText({
    Text = "com.",
    Hint = "包名";
    backgroundColor = background;
    id = "packageName";
   });
   layout_width = "fill";
  },
  {
   LinearLayout;
   layout_height = "match_parent";
   layout_width = "match_parent";
   layout_height = "-2";
   layout_weight = 100;
   {
    CardView;
    layout_weight = 1;
    layout_height = "40dp";
    CardElevation = "6dp";
    radius = "25dp";
    layout_marginTop = "20dp";
    id = "close";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "-1";
    CardBackgroundColor = 0xfff5f5f5;
    onClick = function()
     if t.close then
      t.close()
     end
    end,
    {
     TextView;
     Text = "取消";
     layout_gravity = "center";
     textColor = 0xff585858;
     textSize = "17dp";
    };
   };
   {
    CardView;
    layout_weight = 1;
    layout_height = "40dp";
    CardElevation = "6dp";
    radius = "25dp";
    id = "create";
    layout_marginTop = "20dp";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "-1";
    CardBackgroundColor = 0xff339af0;
    onClick = function()
     if t.create then
      t.create()
     end
    end,
    {
     TextView;
     Text = "创建";
     layout_gravity = "center";
     textColor = 0xffffffff;
     textSize = "17dp";
    };
   };
  };
 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.5 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)
 mBottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end
 --显示Dialog
 mBottomSheetDialog.show();

 CircleButton(ll, background, 45)
 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.DialogById] = mBottomSheetDialog
end

function selectColor()
 import "com.Likefr.colorpicker.*"
 import "com.Likefr.colorpicker.slider.*"
 import "android.view.animation.AnimationSet"
 import "android.graphics.drawable.BitmapDrawable"
 import "android.view.animation.AlphaAnimation"
 import "android.widget.PopupWindow"
 import "android.view.animation.TranslateAnimation"
 import "android.view.animation.LayoutAnimationController"

 Dialog_j = {
  LinearLayout,
  layout_width = "fill",
  layout_height = "fill",
  Gravity = "center",
  id = "DialogExternal",
  {
   CardView,
   layout_width = "90%w",
   layout_marginRight = "0dp";
   layout_height = "70%h",
   elevation = "0dp",
   radius = "35",
   CardBackgroundColor = 0x00000000;
   id = "DialogInternal",
   {
    LinearLayout,
    layout_width = "fill",
    layout_height = "fill",
    orientation = "vertical",
    {
     ColorPickerView;
     id = "picker";
     layout_height = "fill";
     layout_width = "fill";
    };
    {
     LightnessSlider;
     layout_height = "40dp";
     id = "ligh";
     layout_width = "fill";
    };
    {
     AlphaSlider;
     layout_height = "48dp";
     layout_width = "fill";
     id = "alpha";
    };

    {
     TextView;
     layout_gravity = "center";
     id = "wb";
     textSize = "36dp";
    };
    {
     Button;
     text = "复制颜色";
     layout_gravity = "center";
     onClick = function()
      i = Integer.toHexString(picker.getSelectedColor())
      --先导入包
      import "android.content.*"
      activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(i)
      print("已复制:" .. tostring(i), success)
      退出动画()
      return Integer.toHexString(picker.getSelectedColor())
     end
    };

   },
  },
 }
 pop = PopupWindow(activity)
 pop.setContentView(loadlayout(Dialog_j))
 pop.setWidth(-1) --设置显示宽度
 pop.setHeight(-1) --设置显示高度

 --点击PopupWindow外面区域  true为消失
 pop.setOutsideTouchable(false)

 import "android.graphics.drawable.BitmapDrawable"
 pop.setBackgroundDrawable(BitmapDrawable(loadbitmap("1.jpg")))
 pop.showAtLocation(view, Gravity.CENTER, 0, 500)


 --点击外部，取消对话框
 function DialogExternal.onClick()
  退出动画()
 end


 --穿透
 function DialogInternal.onClick()
  --pop.dismiss()
 end




 --选择事件
 picker.addOnColorSelectedListener(OnColorSelectedListener {
  onColorSelected = function(selectedColor)
   -- print(Integer.toHexString(selectedColor))
  end
 })


 --监听事件
 picker.addOnColorChangedListener(OnColorChangedListener {
  onColorChanged = function(selectedColor)
   wb.setTextColor(picker.getSelectedColor())
   wb.setText(Integer.toHexString(picker.getSelectedColor()))
  end
 })

 picker.setLightnessSlider(ligh)
 picker.setAlphaSlider(alpha)



 --定义动画变量,使用AnimationSet类，使该动画可加载多种动画
 animationSet = AnimationSet(true)
 --设置布局动画，布局动画的意思是布局里面的控件执行动画，而非单个控件动画，参数:动画名，延迟
 layoutAnimationController = LayoutAnimationController(animationSet, 0.2);
 --设置动画类型，顺序   反序   随机
 layoutAnimationController.setOrder(LayoutAnimationController.ORDER_NORMAL); --   ORDER_     NORMAL     REVERSE     RANDOM

 --渐变动画
 yuxuan_dh1 = AlphaAnimation(0, 1);
 --渐变动画时长
 yuxuan_dh1.setDuration(600);
 --添加动画
 animationSet.addAnimation(yuxuan_dh1);

 --平移动画
 yuxuan_dh2 = TranslateAnimation(0, 0, activity.height, 0)
 --动画时长
 yuxuan_dh2.setDuration(600);
 --添加动画
 animationSet.addAnimation(yuxuan_dh2);
 --id控件加载动画
 DialogExternal.setLayoutAnimation(layoutAnimationController);


end

function 退出动画()
 import "android.view.animation.LayoutAnimationController"
 import "android.view.animation.Animation"
 import "android.view.animation.AlphaAnimation"
 import "android.view.animation.TranslateAnimation"
 import "android.view.animation.AnimationSet"
 import "android.view.animation.TranslateAnimation"
 --[[
平移动画
参数类型:
1.动画开始的点离当前View X坐标上的差值
2.动画结束的点离当前View X坐标上的差值
3.动画开始的点离当前View Y坐标上的差值
4.动画结束的点离当前View Y坐标上的差值]]

 Translate_up_down = TranslateAnimation(0, activity.width, 0, 0)
 Translate_up_down.setDuration(300)
 --Translate_up_down.setFillAfter(true)
 DialogInternal.startAnimation(Translate_up_down)

 import "android.view.animation.Animation$AnimationListener"
 Translate_up_down.setAnimationListener(AnimationListener {
  onAnimationEnd = function()
   pop.dismiss()
  end
 })
end


--全局文件搜索

function 全局扫描(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"

 --导入自定义布局
 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "90%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "0dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "20dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   textSize = "16dp";
   layout_gravity = "center";
   gravity = "center";
   textColor = wbColor;
   text = "全局搜索";
  };

  {
   LinearLayout;
   orientation = "vertical";
   layout_width = "fill",

   {
    EditText;
    id = "wbnr";
    Hint = "关键字";
    singleLine = "true";
    backgroundColor = background;
    layout_width = "fill";
   };
   {
    CardView;
    layout_height = "35dp";
    CardElevation = "0dp";
    radius = "6dp";
    layout_margin = "5dp";
    layout_width = "100dp";
    layout_marginTop = "20dp";
    layout_gravity = "center";
    CardBackgroundColor = "#ffa4b0be";
    {
     TextView;
     id = "sousuoset";
     textColor = wbColor;
     text = "开始搜索";
     layout_gravity = "center";
     gravity = "center";
     layout_width = "fill";

    };
   };
   {
    ListView;
    id = "liebiaoset";
    layout_weight = "1";
    layout_width = "-1";
   };
  };
 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.4 * activity.getHeight());

 --设置禁止拖拽下滑
 mBehavior.setHideable(true)
 mBottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end

 layouts = {
  LinearLayout;
  layout_height = "-2";
  layout_width = "-1";
  gravity = "left";
  orientation = "horizontal";
  {
   LinearLayout;
   layout_height = "-2";
   layout_weight = "1";
   gravity = "center|left";
   orientation = "vertical";
   {
    RelativeLayout;
    layout_width = "fill";
    {
     TextView;
     text = "文件名：";
     id = "you";
     textColor = wbColor;
     textSize = "18dp";
    };
    {
     TextView;
     id = "wenjianmingpp";
     textSize = "18dp";
     textColor = wbColor;
     layout_toRightOf = "you";
    };
    {
     TextView;
     id = "daxiaopp";
     gravity = "right";
     layout_marginLeft = "20dp";
     textColor = wbColor;
     layout_toRightOf = "wenjianmingpp";
     textSize = "18dp";
    };
   };
   {
    LinearLayout;
    layout_width = "wrap";
    orientation = "horizontal";
    {
     TextView;
     text = "路径：";
     textColor = wbColor;
     textSize = "18dp";
    };
    {
     TextView;
     id = "lujingpp";
     textSize = "14dp";
     layout_gravity = "center";
     textColor = wbColor;
    };
   };
  };
  {
   ImageView;
   layout_width = "0dp";
   layout_height = "0dp";
   layout_gravity = "center";
   id = "yulantupp";
  };
 };

 function gxg(wjm, lj)
  if string.sub(wjm, string.len(wjm) - 7, string.len(wjm)) == "init.lua" then
   else
   if string.sub(wjm, string.len(wjm) - 3, string.len(wjm)) == ".lua" then
    adp.add { wenjianmingpp = wjm, daxiaopp = "大小：" .. GetFileSizesc(lj), lujingpp = tostring(lj), yulantupp = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_lua.png") }
    else
    if string.sub(wjm, string.len(wjm) - 3, string.len(wjm)) == ".aly" then
     adp.add { wenjianmingpp = wjm, daxiaopp = "大小：" .. GetFileSizesc(lj), lujingpp = tostring(lj), yulantupp = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_aly.png") }
     else
     if string.sub(wjm, string.len(wjm) - 4, string.len(wjm)) == ".json" then
      adp.add { wenjianmingpp = wjm, daxiaopp = "大小：" .. GetFileSizesc(lj), lujingpp = tostring(lj), yulantupp = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_json.png") }
     end
    end
   end
  end
 end

 function qc()
  adp.clear()
 end
 adp = LuaAdapter(activity, layouts)
 liebiaoset.Adapter = adp
 function xcxcxc(lj, wjm)
  require "import"
  import "java.io.*"
  function findf(lj, wjm, dx)

   local llj = File(tostring(lj)).listFiles()
   wwjm = tostring(wjm)
   for cishu = 0, #llj - 1 do
    ft = llj[cishu]
    if ft.isDirectory() then
     findf(ft, wjm)
     else
     ghg = ft.Name
     import "java.io.File"
     code = io.open(tostring(ft)):read("*a")
     if code:match(wwjm) ~= nil then
      call("gxg", ghg, ft)
     end
    end

   end
  end
  findf(lj, wjm)
 end

 function 统计行数(path)
  import "java.io.File"
  行 = 1
  function find(catalog, name)
   local n = 0
   local t = os.clock()
   local ret = {}
   require "import"
   import "java.io.File"
   import "java.lang.String"
   行 = 0
   function FindFile(catalog, name)
    local name = tostring(name)
    local ls = catalog.listFiles() or File {}
    for 次数 = 0, #ls - 1 do
     --local 目录=tostring(ls[次数])
     local f = ls[次数]
     if f.isDirectory() then
      --如果是文件夹则继续匹配
      FindFile(f, name)
      else
      --如果是文件则
      n = n + 1
      if n % 1000 == 0 then
       --print(n,os.clock()-t)
      end
      local nm = f.Name
      --xpcall(function()
      for c in io.lines(tostring(f)) do
       行 = 行 + 1
      end
      --end,function(e) end)
     end
     luajava.clear(f)
    end
   end
   FindFile(catalog, name)

   print("总代码量:" .. 行, confusing)
  end

  import "java.io.File"

  catalog = File(path)

  thread(find, catalog, "")
 end

 function Snakebar(text)

  import "android.text.Html"
  import "android.view.animation.*"
  import "android.animation.Animator"
  import "android.view.animation.AlphaAnimation"
  import "android.view.animation.AccelerateDecelerateInterpolator"
  SnackerBar = {}
  layout = {
   LinearLayout,
   orientation = "vertical";
   layout_width = "fill",
   gravity = "bottom",
   {
    ScrollView;
    layout_hight = "fill",
    layout_width = "fill",
    {
     LinearLayout,
     layout_width = "fill",
     {
      CardView,
      layout_width = "fill",
      CardBackgroundColor = 0xFF212121,
      radius = "4dp",
      Z = 0,
      layout_margin = "8dp";
      {
       TextView,
       padding = "15dp";
       paddingLeft = "25dp";
       paddingRight = "96dp";
       layout_gravity = "center|left",
       textColor = 0xFFFFFFFF,
       textSize = "14.5sp";
       text = tostring(text)
      },
      {
       TextView,
       text = "关闭",
       id = "hide",
       layout_gravity = "center|right",
       textColor = Control_Color,
       textSize = "12sp";
       layout_marginRight = "41dp";
      }
     }
    }
   }
  }

  function addView(view)
   mLayoutParams = ViewGroup.LayoutParams(-1, -1)
   activity.Window.DecorView.addView(view, mLayoutParams)
  end

  function removeView(view)
   activity.Window.DecorView.removeView(view)
  end

  function indefiniteDismiss(snackerBar)
   if nbhide ~= nil then
    hide.onClick = function()
     snackerBar:dismiss()
    end
    else
    hide.onClick = function()
     snackerBar:dismiss()
    end
    task(3000, function()
     snackerBar:dismiss()
    end)
   end
  end

  function SnackerBar:dismiss()
   local view = self.view
   Alpha = AlphaAnimation(1, 0)
   Alpha.setDuration(200)
   view.startAnimation(Alpha)
   removeView(view)
  end

  SnackerBar.__index = SnackerBar
  function SnackerBar.build()
   local mSnackerBar = {}
   setmetatable(mSnackerBar, SnackerBar)
   mSnackerBar.view = loadlayout(layout)
   return mSnackerBar
  end

  function SnackerBar:show()
   local view = self.view
   Alpha = AlphaAnimation(0, 1)
   Alpha.setDuration(300)
   view.startAnimation(Alpha)
   addView(view)
   indefiniteDismiss(self)
  end

  SnackerBar.build():show()
 end

 function sousuoset.onClick()

  b = wbnr.getText()

  if b == "" then
   print("请填写好内容")
   else
   adp.clear()
   thread(xcxcxc, tostring(t.paths), b)
  end
 end

 liebiaoset.onItemClick = function(p, v, i, s)
  code = io.open(v.Tag.lujingpp.Text):read("*a")
  sub_title.setText("/" .. v.Tag.wenjianmingpp.getText())
  editor.setText(code)
  edit_v_1.setText(code)
  editor.findNext(wbnr.getText())
  scanner.dismiss()
  return true
 end

 --显示Dialog
 mBottomSheetDialog.show();

 CircleButton(ll, background, 45)
 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.全局搜索] = mBottomSheetDialog
end

function JavaApi(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"
 local classes = require "android"

 function adapter(t)
  local ls = ArrayList()
  for k, v in ipairs(t) do
   ls.add(v)
  end
  return ArrayAdapter(activity, android.R.layout.simple_list_item_1, ls)
 end

 import "android.content.*"
 cm = activity.getSystemService(activity.CLIPBOARD_SERVICE)

 function copy(str)
  local cd = ClipData.newPlainText("label", str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity, "已复制:\n" .. tostring(str), 1000).show()
 end

 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "80%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "6dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "15dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_width = "-1";
   layout_height = "-2";
   textSize = "20dp";
   gravity = "center";
   id = "tect",
   layout_marginTop = "17dp";
   layout_marginLeft = "24dp";
   layout_marginRight = "24dp";
   layout_marginBottom = "0dp";
   Text = t.标题;
   textColor = wbColor;
  };
  {
   LinearLayout;
   orientation = "vertical";
   backgroundColor = 0xFF2C303B;
   {
    LinearLayout;
    layout_width = "fill";
    backgroundColor = 0xFF2C303B;
    {
     EditText;
     singleLine = true;
     layout_weight = "1";
     -- HintTextColor=wbColor;
     id = "medit";
     hint = "搜索";
     layout_width = "fill";
    };
   };
   {
    ListView;
    layout_width = "fill";
    id = "mlist";
    FastScrollEnabled = true;
   };
  };
 })

 local dialog_view2 = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "80%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll2",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "6dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "15dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_width = "-1";
   layout_height = "-2";
   textSize = "20dp";
   gravity = "center";
   id = "tect",
   layout_marginTop = "17dp";
   layout_marginLeft = "24dp";
   layout_marginRight = "24dp";
   layout_marginBottom = "0dp";
   Text = t.标题;
   textColor = wbColor;
  };

  {
   LinearLayout;
   backgroundColor = 0xFF2C303B;
   {
    LinearLayout;
    layout_width = "fill";
    backgroundColor = 0xFF2C303B;
    {
     EditText;
     singleLine = true;
     layout_weight = "1";
     id = "edit";
     hint = "搜索";
     layout_width = "fill";
    };
   };
   {
    ListView;
    id = "clist";
    FastScrollEnabled = true;
    layout_width = "fill";
    items = classes;
   };
   orientation = "vertical";
  };


 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.7);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.8 * activity.getHeight());

 --设置禁止拖拽下滑
 mBehavior.setHideable(false)

 mBottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 CircleButton(ll, 0xFF2C303B, 45)

 curr_class = nil
 curt_adapter = nil
 mlist.setAdapter(adapter(classes))
 local 字段 = {}
 local ms = {}

 mlist.onItemLongClick = function(l, v)
  local s = tostring(v.Text)
  copy(s)
  return true
 end

 medit.addTextChangedListener {
  onTextChanged = function(c)
   local s = tostring(c)
   if #s == 0 then
    mlist.setAdapter(adapter(classes))
   end
   local t = {}

   for k, v in ipairs(classes) do

    if v:find(s) then
     table.insert(t, v)
    end
   end

   mlist.setAdapter(adapter(t))
  end
 }

 mlist.onItemClick = function(l, v)
  local s = tostring(v.Text)
  local class = luajava.bindClass(s)
  curr_class = class
  local t = {}
  local fs = {}
  local ms = {}
  local es = {}
  local ss = {}
  local gs = {}

  local super = class.getSuperclass()
  super = super and " extends " .. tostring(super.getName()) or ""
  table.insert(t, tostring(class) .. super)

  table.insert(t, "构建方法")
  local cs = class.getConstructors()
  for n = 0, #cs - 1 do
   table.insert(t, tostring(cs[n]))
  end
  curr_ms = class.getMethods()
  for n = 0, #curr_ms - 1 do
   local str = tostring(curr_ms[n])
   table.insert(ms, str)
   local e1 = str:match("%.setOn(%a+)Listener")
   local s1, s2 = str:match("%.set(%a+)(%([%a$%.]+%))")
   local g1, g2 = str:match("([%a$%.]+) [%a$%.]+%.get(%a+)%(%)")
   if e1 then
    table.insert(es, "on" .. e1)
    elseif s1 then
    table.insert(ss, s1 .. s2)
   end
   if g1 then
    table.insert(gs, string.format("(%s)%s", g1, g2))
   end
  end
  table.insert(t, "公有事件")
  for k, v in ipairs(es) do
   table.insert(t, v)

  end
  table.insert(t, "公有getter")
  for k, v in ipairs(gs) do
   table.insert(t, v)
  end
  table.insert(t, "公有setter")
  for k, v in ipairs(ss) do
   table.insert(t, v)
  end

  curr_fs = class.getFields()
  table.insert(t, "公有字段")
  for n = 0, #curr_fs - 1 do
   table.insert(t, tostring(curr_fs[n]))
   table.insert(字段, tostring(curr_fs[n]))
  end

  table.insert(t, "公有方法")
  for k, v in ipairs(ms) do
   table.insert(t, v)
  end

  mBottomSheetDialog.setContentView(dialog_view2).getWindow().setDimAmount(0.5);
  curt_adapter = adapter(t)
  clist.setAdapter(curt_adapter)

  CircleButton(ll2, 0xFF2C303B, 45)

  clist.onItemLongClick = function(l, v)
   local s = tostring(v.Text)

   for i = 1, #字段, 1 do
    if 字段[i] == s then
     s = s:match("[A-Z_]+$")
     copy(s)
     return true
    end
   end

   if s:find("%w%(") then
    if s:match("(%([^%)]+%))") then
     s = s:match("(%w+)%(") .. s:match("(%([^%)]+%))")
     else
     s = s:match("(%w+)%(") .. "()"
    end
   end
   copy(s)
   return true
  end

  edit.addTextChangedListener {
   onTextChanged = function(c)
    local s = tostring(c)
    s = s:gsub("%(", "%%(")
    s = s:gsub("%)", "%%)")

    s = s:gsub("%.", "%%.")
    if #s == 0 then
     clist.setAdapter(curt_adapter)
     return true
    end
    local class = curr_class
    local t = {}
    local fs = curr_fs
    table.insert(t, "公有字段")
    for n = 0, #fs - 1 do
     if tostring(ms[n]):find(s) then
      table.insert(t, tostring(fs[n]))
     end
    end
    local ms = curr_ms
    table.insert(t, "公有方法")
    for n = 0, #ms - 1 do
     if tostring(ms[n]):find(s) then
      table.insert(t, tostring(ms[n]))
     end
    end
    clist.setAdapter(adapter(t))
   end
  }
 end
 mBottomSheetDialog.show();

 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.对话框id] = mBottomSheetDialog
end

function lookProject(t) --网站配置文件编辑弹窗
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"
 --导入自定义布局
 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "wrap", --Dialog最终展开高度
  orientation = "vertical",
  background = "#FFFFFFFF",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "0dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "5dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   MyEditText({
    Hint = "加载链接";
    id = "url";
    backgroundColor = background;
    Text = t.url,
   });
   layout_width = "fill";
  },
  {
   MyEditText({
    Text = t.ad,
    Hint = "class元素";
    backgroundColor = background;
    id = "ad";
   });
   layout_width = "fill";
  };

  {
   MyEditText({
    Hint = "js";
    id = "js";
    backgroundColor = background;
    Text = t.js,
   });
   layout_width = "fill";
  },
  --[[ {
    Spinner;
    id="s";
    layout_width="fill";
    layout_gravity="left";
    layout_height="56dp";
  };]]
  {
   MyEditText({
    Text = t.ua,
    Hint = "自定义ua";
    backgroundColor = background;
    id = "ua";
   });
   layout_width = "fill";
  };
  {
   CardView;
   layout_height = "40dp";
   CardElevation = "6dp";
   radius = "25dp";
   layout_width = "fill";
   CardBackgroundColor = 0xff339af0;
   onClick = function()
    OutStyle(url.getText(), ad.getText(), js.getText(), ua.getText());
   end;
   {
    TextView;
    Text = "保存";
    layout_gravity = "center";
    textColor = 0xffffffff;
    textSize = "17dp";
   };
  };
  {
   View;
   layout_width = "fill",
   layout_height = "100dp", --Dialog最终展开高度
   background = "#00000000",
  };
 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.6 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)
 mBottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end
 --[[local item={
  LinearLayout;
  layout_height="50dp";
  gravity="center";
  layout_width="match_parent";
  orientation="vertical";
  {
    TextView;
    id="text";
    --layout_marginLeft="18dp";
  };
}
adp = LuaAdapter(activity,item)
s.Adapter = adp

adp.add{text="默认"}
adp.add{text="去广告"}
adp.add{text="自定义UA"}

s.onItemSelected=function(l,v,p,i)
   if v.Tag.text.Text=="自定义UA" then

ua.setText("")
ua.setText("Mozilla/5.0 (Android 9; MI 6) AppleWebKit/537.36 (KHTML) Version/4.0 Chrome/74.0.3729.136 mobile Safari/537.36 baiduboxapp SearchCraft")
     else
     end
end]]
 --显示Dialog
 mBottomSheetDialog.show();

 CircleButton(ll, background, 50)
 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调

  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.lookproject] = mBottomSheetDialog
end






--删除项目对话框
function deletePreject(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"
 --导入自定义布局

 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "35%h", --Dialog最终展开高度
  orientation = "vertical",
  background = "#FFFFFFFF",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "0dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "10dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_marginTop = "22dp";
   textSize = "16dp";
   textColor = wbColor;
   layout_gravity = "center";
   text = "是否删除: " .. t.项目名称 .. " 这个项目";
   Typeface = 字体("product-Bold");
  };
  {
   TextView;
   layout_marginTop = "22dp";
   textSize = "16dp";
   textColor = wbColor;
   id = "backup";
   layout_gravity = "center";
   Typeface = 字体("product-Bold");
  };
  {
   CardView;
   layout_height = "35dp",
   Radius = "24dp";
   layout_gravity = "center";
   layout_margin = "10dp";
   CardElevation = "0dp";
   layout_width = "110dp",
   CardBackgroundColor = "#40c057",
   {
    TextView;
    textSize = "16dp";
    text = "备份该工程";
    textColor = "#ffffffff";
    layout_gravity = "center";
    Typeface = 字体("mono");
   };
   onClick = function()
    print "正在备份中"
    task(40, function()
     INSERT("Backup_Project", t.项目名称, "已备份")
     export(SELECT("Project_Path", SELECT("User_option", "Value")) .. t.项目名称)
     deleteDlog.dismiss()
    end)
   end
  };

  {
   RelativeLayout;
   layout_height = "match_parent";
   layout_width = "match_parent";

   layout_gravity = "center";
   gravity = "center";
   {
    CardView;
    layout_height = "40dp";
    CardElevation = "6dp";
    radius = "25dp";
    layout_marginTop = "20dp";
    id = "close";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "30%w";
    CardBackgroundColor = 0xfff5f5f5;
    onClick = function()
     if t.close then
      t.close()
     end
    end,
    {
     TextView;
     Text = "点错了";
     layout_gravity = "center";
     textColor = 0xff585858;
     textSize = "17dp";
    };
   };
   {
    CardView;
    layout_height = "40dp";
    CardElevation = "6dp";
    radius = "25dp";
    id = "delete";
    layout_marginTop = "20dp";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_toRightOf = "close";
    layout_width = "30%w";
    CardBackgroundColor = 0xff339af0;
    onClick = function()
     if t.delete then
      t.delete()
     end
    end,
    {
     TextView;
     Text = "删除";
     layout_gravity = "center";
     textColor = 0xffffffff;
     textSize = "17dp";
    };
   };
  };
 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.6 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)

 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end

 --显示Dialog
 mBottomSheetDialog.show();

 --设置用户拖拽Dialog时状态
 CircleButton(ll, background, 30)
 if SELECT("Backup_Project", t.项目名称) == "已备份" then
  backup.setText("是否备份:已备份")
  else
  backup.setText("是否备份:没有备份")
 end

 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调

  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });

 _G[t.对话框id] = mBottomSheetDialog

end

function Project_PathS(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"

 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "70%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = "6dp";
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "15dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_width = "-1";
   layout_height = "-2";
   textSize = "20dp";
   gravity = "center";
   id = "tect",
   layout_marginTop = "17dp";
   layout_marginLeft = "24dp";
   layout_marginRight = "24dp";
   layout_marginBottom = "0dp";
   Text = t.标题;
   textColor = wbColor;
  };

  {
   LinearLayout;
   layout_height = "match_parent";
   layout_width = "match_parent";
   orientation = "vertical";
   backgroundColor = 0x00000000;
   {
    CardView;
    layout_weight = 1;
    layout_height = dp2px(50);
    CardElevation = "0dp";
    radius = "8dp";
    layout_marginTop = "20dp";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "-1";
    id = "idea";
    CardBackgroundColor = background;
    onClick = function()
     if t.idea then
      t.idea()
     end
    end,
    {
     LinearLayout;
     layout_height = "match_parent";
     layout_width = "match_parent";
     gravity = "center",
     orientation = "vertical";
     {
      TextView;
      Text = "默认";
      textColor = wbColor;
      textSize = "17dp";

     };
     {
      TextView;
      Text = "/storage/emulated/0/IntelliJ Lua/project/";
      textColor = wbColor;
      textSize = "17dp";
     },
    };
   };

   {
    CardView;
    layout_weight = 1;
    layout_height = dp2px(50);
    CardElevation = "0dp";
    radius = "8dp";
    layout_marginTop = "20dp";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "-1";
    id = "andlua";
    CardBackgroundColor = background;
    onClick = function()
     if t.andlua then
      t.andlua()
     end
    end,
    {
     LinearLayout;
     layout_height = "match_parent";
     layout_width = "match_parent";
     gravity = "center",
     orientation = "vertical";
     {
      TextView;
      Text = "AndLua";
      textColor = wbColor;
      textSize = "17dp";
     };
     {
      TextView;
      Text = "/storage/emulated/0/AndLua/project/";
      textColor = wbColor;
      textSize = "17dp";
     };
    };
   };

   {
    CardView;
    layout_weight = 1;
    layout_height = dp2px(50);
    CardElevation = "0dp";
    radius = "8dp";
    layout_marginTop = "20dp";
    layout_marginRight = "40dp";
    layout_marginLeft = "40dp";
    layout_marginBottom = "50dp";
    layout_width = "-1";
    id = "androlua";
    CardBackgroundColor = background;
    onClick = function()
     if t.androlua then
      t.androlua()
     end
    end,
    {
     LinearLayout;
     layout_height = "match_parent";
     layout_width = "match_parent";
     gravity = "center",
     orientation = "vertical";
     {
      TextView;
      Text = "AndroLua";
      textColor = wbColor;
      textSize = "17dp";
     };
     {
      TextView;
      Text = "/storage/emulated/0/AndroLua/project/";
      textColor = wbColor;
      textSize = "17dp";
     };
    },
   };
   {
    LinearLayout;
    layout_weight = 1;
    layout_height = "5%h";
    layout_marginRight = "20dp";
    layout_marginBottom = "50dp";
    layout_marginLeft = "35dp";
    layout_width = "-1";
    id = "customize";
    BackgroundColor = background;
    {
     MyEditText({
      Hint = "手动输入项目路径";
      id = "editPath";
      gravity = "left|center",
      layout_gravity = "left|center",
      backgroundColor = background;
     });
     layout_gravity = "center";
     layout_width = "75%w";
    },
    {
     CardView;
     layout_weight = 1;
     layout_height = "fill";
     CardElevation = "0dp";
     layout_gravity = "center";
     CardBackgroundColor = background;
     radius = "0dp";
     onClick = function()
      if t.editPath then
       t.editPath()
      end
     end,
     {
      TextView;
      text = "确定";
      textSize = "18dp";
      textColor = wbColor;
      layout_height = "match_parent";
      layout_width = "fill";
      gravity = "center",

     };
    };
   };
  };
 })

 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.8 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)
 mBottomSheetDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end

 --显示Dialog
 mBottomSheetDialog.show();

 --设置用户拖拽Dialog时状态
 CircleButton(ll, background, 30)

 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.对话框id] = mBottomSheetDialog
end

function side_Long(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"

 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "40%h", --Dialog最终展开高度
  orientation = "vertical",
  backgroundColor = t.background,
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = elevation;
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "15dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_width = "-1";
   layout_height = "-2";
   textSize = "20dp";
   gravity = "center";
   id = "tect",
   layout_marginTop = "17dp";
   layout_marginLeft = "24dp";
   layout_marginRight = "24dp";
   layout_marginBottom = "0dp";
   Text = t.标题;
   textColor = wbColor;
  };

  {
   GridView;
   layout_height = "match_parent";
   layout_width = "match_parent";
   id = "grid";
   numColumns = 2;
  };
 })
 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.5 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)
 t.background = background;
 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end

 --显示Dialog
 mBottomSheetDialog.show();

 local item = {
  LinearLayout;
  layout_width = "match_parent";
  layout_height = "wrap";
  gravity = "center";
  padding = "15dp";
  backgroundColor = 0x00000000;

  {
   LinearLayout;
   layout_width = "match_parent";
   layout_height = "wrap";
   layout_gravity = "center";
   gravity = "center";
   padding = "15dp";
   backgroundColor = 0x00000000;
   {
    ImageView;
    id = "img";
    layout_height = "55dp";
    layout_gravity = "center";
    layout_width = "55dp";
   };
   {
    TextView;
    id = "item_title";
    layout_width = "0dp";
    Typeface = 字体("product");
    layout_height = "0dp";
    layout_gravity = "center";
    textSize = "0dp";
    textColor = wbColor;
   };
  };
 };

 local adp = LuaAdapter(activity, item)
 grid.setAdapter(adp)
 for i = 1, #t.table do
  adp.add { item_title = t.table[i], img = activity.getLuaDir() .. "/Controller/res/" .. t.img_table[i] .. ".png" }
 end

 grid.setOnItemClickListener(AdapterView.OnItemClickListener {
  onItemClick = function(parent, v, pos, id)
   t.onclickGrid(parent, v, pos, id)
  end
 })


 --设置用户拖拽Dialog时状态
 CircleButton(ll, background, 50)

 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.side_Long] = mBottomSheetDialog
end

if not activity.getString(R.string.Intellij) == "Intellij" then
 local toast = luajava.bindClass("android.widget.Toast")
 toast.makeText(activity, tostring(activity.getString(R.string.error), toast.LENGTH_SHORT))
 this.finish()
end

--首页长按事件
function list_Selet(t)
 import "android.content.res.ColorStateList"
 import "android.graphics.drawable.GradientDrawable"
 import "com.google.android.material.bottomsheet.BottomSheetDialog"
 import "com.google.android.material.bottomsheet.BottomSheetBehavior"
 import "java.io.File"--导入File类

 if File(tostring(t.pic)).exists() then
  img = t.pic
  else
  img = activity.getLuaDir("icon.png")
 end

 local dialog_view = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "42%h", --Dialog最终展开高度
  orientation = "vertical",
  id = "ll",
  {
   CardView;
   layout_height = "8dp";
   CardElevation = elevation;
   radius = "4dp";
   layout_margin = "5dp";
   layout_width = "75dp";
   layout_marginTop = "10dp";
   layout_gravity = "center";
   CardBackgroundColor = "#ffa4b0be";
  };
  {
   TextView;
   layout_width = "-1";
   layout_height = "-2";
   textSize = "20dp";
   gravity = "center";
   id = "tect",
   layout_marginTop = "17dp";
   layout_marginLeft = "24dp";
   layout_marginRight = "24dp";
   layout_marginBottom = "0dp";
   Text = t.标题;
   textColor = wbColor;
  };
  {
   LinearLayout;
   layout_width = "match_parent";
   orientation = "horizontal";
   backgroundColor = 0x00000000,
   {
    CardView;
    layout_height = "50dp";
    layout_width = "50dp";
    radius = "24%h";
    elevation = "0dp";
    layout_margin = "10dp";
    CardBackgroundColor = 0X00000000;
    {
     ImageView;
     src = img;
     scaleType = "fitXY";
     layout_height = "fill";
     layout_width = "fill";
     id = "back";
    };
   };
   {
    LinearLayout;
    layout_width = "match_parent";
    layout_height = "match_parent";
    orientation = "vertical";
    gravity = "center_vertical";
    {
     LinearLayout;
     layout_width = "-1";
     layout_height = "-2";
     {
      TextView;
      textSize = "20dp";
      --gravity="center";
      Text = t.titleName;
      Typeface = 字体("product-Bold");
      textColor = wbColor;
     };
     {
      TextView;
      textSize = "17dp";
      layout_marginLeft = "20dp";
      text = t.version,
      Typeface = 字体("product-Bold");
      textColor = wbColor;
     }; };
    {
     TextView;
     layout_width = "-1";
     layout_height = "wrap";
     textSize = "17dp";
     Text = t.package;
     Typeface = 字体("product-Bold");
     textColor = wbColor;
    };

   };
  };
  {
   GridView;
   layout_height = "match_parent";
   layout_width = "match_parent";
   id = "grid";
   numColumns = 2;
  };
 })
 local mBottomSheetDialog = BottomSheetDialog(activity);
 mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);

 --设置点击返回键与外边阴影部分与下滑Dialog不消失
 --mBottomSheetDialog.setCancelable(false);

 --设置点击Dialog外部阴影部分不消失
 --  mBottomSheetDialog.setCanceledOnTouchOutside(false);
 back.onClick = function()

  import "android.content.Intent"
  --  activity.newActivity("Controller/Dr",{"",Environment.getExternalStorageDirectory().toString(),{".png"}})
  ChooseFile("image/*", function(path)
   --所有类型文件
   copyFunc(t.pic, path)
   AttributeDlog.dismiss()
  end)

  projectRefresh()
 end

 --获得父窗体,并设置为透明
 local parent = dialog_view.getParent();
 parent.setBackgroundResource(android.R.color.transparent);

 --创建BottomSheetBehavior对象
 local mBehavior = BottomSheetBehavior.from(parent);
 --设置Dialog默认弹出高度为屏幕的0.5倍
 mBehavior.setPeekHeight(0.7 * activity.getHeight());

 --设置禁止拖拽下滑
 --mBehavior.setHideable(false)
 t.background = background;
 --解决弹出Dialog后状态栏会变黑
 if Build.VERSION.SDK_INT >= 21 then
  mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
 end

 --显示Dialog
 mBottomSheetDialog.show();

 local item = {
  LinearLayout;
  layout_width = "match_parent";
  layout_height = "7.5%h";
  gravity = "center";
  padding = "10dp";
  backgroundColor = 0x00000000;
  {
   CardView;
   layout_width = "match";
   layout_height = "5%h";
   Radius = "10dp";
   padding = "15dp";
   CardElevation = "0dp";
   CardBackgroundColor = "#EEEEEE";
   {
    LinearLayout;
    layout_width = "wrap";
    layout_height = "wrap";
    layout_gravity = "center";
    gravity = "center";
    backgroundColor = 0x00000000;
    {
     ImageView;
     id = "img";
     layout_height = "-1";
     layout_gravity = "center";
     layout_width = "35dp";

    };
    {
     TextView;
     id = "item_title";
     layout_width = "match_parent";
     Typeface = 字体("product");
     layout_height = "wrap";
     layout_gravity = "center";
     textSize = "19dp";
     textColor = "#FF7f8c8d";
    };
   };
  };
 };

 local adp = LuaAdapter(activity, item)
 grid.setAdapter(adp)
 for i = 1, #t.table do
  adp.add { item_title = t.table[i], img = activity.getLuaDir() .. "/res/" .. t.img_table[i] .. ".png" }
 end

 grid.setOnItemClickListener(AdapterView.OnItemClickListener {
  onItemClick = function(parent, v, pos, id)
   t.onclickGrid(parent, v, pos, id)
  end
 })

 --设置用户拖拽Dialog时状态
 CircleButton(ll, background, 45)

 --The View with the BottomSheetBehavior
 mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback {
  onSlide = function(view, newState)
   --状态的改变回调
  end;
  onStateChanged = function(view, slideOffset)
   --拖拽中的回调
   if (slideOffset == BottomSheetBehavior.STATE_HIDDEN) then
    mBottomSheetDialog.dismiss();
    mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
   end
  end;
 });
 _G[t.list_Selet] = mBottomSheetDialog
end

function 取文件名无后缀(path)
 return path:match(".+/(.+)%..+$")
end
--shell命令的方法
--os.execute("su")


function 缩放动画anim(id)
 缩放动画 = ScaleAnimation(0, 1, 0, 1, Animation.RELATIVE_TO_SELF, 0.5, Animation.RELATIVE_TO_SELF, 0.5)
 缩放动画.setDuration(850)--设置动画时间
 缩放动画.setFillAfter(true)--设置动画后停留位置
 缩放动画.setRepeatCount(0.5)--设置无限循环
 --绑定动画
 id.startAnimation(缩放动画)
end

code = [===[
require "import"
import "android.widget.*"
import "android.view.*"

]===]
pcode = [[
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
--activity.setTitle('IntelliJ Lua')
--activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView(loadlayout(layout))
]]

lcode = [[
{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
  {
    TextView,
    text="Hello IntelliJ Lua!",
    layout_width="fill",
  },
}
]]
upcode = [[
user_permission={
  "INTERNET",
  "WRITE_EXTERNAL_STORAGE",
}
]]

function read(path)

 local f = io.open(path, "r")
 if f == nil then
  --Toast.makeText(activity, "打开文件出错."..path, Toast.LENGTH_LONG ).show()
  error()
  return
 end
 local str = f:read("*all")
 f:close()
 local c = string.byte(str);
 if c <= 0x1c and c >= 0x1a then
  Toast.makeText(activity, "不能打开已编译文件." .. path, Toast.LENGTH_LONG).show()
  return
 end
 editor.setText(str)

 activity.getActionBar().setSubtitle(".." .. path:match("(/[^/]+/[^/]+)$"))
 luapath = path
 if history[luapath] then
  editor.setSelection(history[luapath])
 end
 table.insert(history, 1, luapath)
 for n = 2, #history do
  if n > 50 then
   history[n] = nil
   elseif history[n] == luapath then
   table.remove(history, n)
  end
 end
 write(luaconf, string.format("luapath=%q", path))
 if luaproject and path:find(luaproject, 1, true) then
  --Toast.makeText(activity, "打开文件."..path, Toast.LENGTH_SHORT ).show()
  activity.getActionBar().setSubtitle(path:sub(#luaproject))
  return
 end

 local dir = luadir
 local p = {}
 local e = pcall(loadfile(dir .. "init.lua", "bt", p))
 while not e do
  dir, n = dir:gsub("[^/]+/$", "")
  if n == 0 then
   break
  end
  e = pcall(loadfile(dir .. "init.lua", "bt", p))
 end

 if e then
  activity.setTitle(tostring(p.appname))
  luaproject = dir
  activity.getActionBar().setSubtitle(path:sub(#luaproject))
  write(luaproj, string.format("luaproject=%q", luaproject))
  --Toast.makeText(activity, "打开工程."..p.appname, Toast.LENGTH_SHORT ).show()
  else
  activity.setTitle("AndroLua+")
  luaproject = nil
  write(luaproj, "luaproject=nil")
  --Toast.makeText(activity, "打开文件."..path, Toast.LENGTH_SHORT ).show()
 end
end
function open(p)
 if p == luadir then
  return nil
 end
 if p:find("%.%./") then
  luadir = luadir:match("(.-)[^/]+/$")
  list(listview, luadir)
  elseif p:find("/") then
  luadir = luadir .. p
  list(listview, luadir)
  elseif p:find("%.alp$") then
  imports(luadir .. p)
  open_dlg.hide()
  else
  read(luadir .. p)
  open_dlg.hide()
 end
end

function adapter(t)
 return ArrayListAdapter(activity, android.R.layout.simple_list_item_1, String(t))
end

function sort(a, b)
 if string.lower(a) < string.lower(b) then
  return true
  else
  return false
 end
end

function list(v, p)
 local f = File(p)
 if not f then
  open_title.setText(p)
  local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String {})
  v.setAdapter(adapter)
  return
 end

 local fs = f.listFiles()
 fs = fs or String[0]
 Arrays.sort(fs)
 local t = {}
 local td = {}
 local tf = {}
 if p ~= "/" then
  table.insert(td, "../")
 end
 for n = 0, #fs - 1 do
  local name = fs[n].getName()
  if fs[n].isDirectory() then
   table.insert(td, name .. "/")
   elseif name:find("%.lua$") or name:find("%.aly$") or name:find("%.alp$") then
   table.insert(tf, name)
  end
 end
 table.sort(td, sort)
 table.sort(tf, sort)
 for k, v in ipairs(tf) do
  table.insert(td, v)
 end
 open_title.setText(p)
 --local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(td))
 --v.setAdapter(adapter)
 open_dlg.setItems(td)
end

function click(s)
 func[s.getText()]()
end

function create_aly()
 luapath = luadir .. create_e.getText().toString() .. ".aly"
 if not pcall(read, luapath) then
  f = io.open(luapath, "a")
  f:write(lcode)
  f:close()
  table.insert(history, 1, luapath)
  editor.setText(lcode)
  write(luaconf, string.format("luapath=%q", luapath))
  Toast.makeText(activity, "新建文件." .. luapath, Toast.LENGTH_SHORT).show()
  else
  Toast.makeText(activity, "打开文件." .. luapath, Toast.LENGTH_SHORT).show()
 end
 write(luaconf, string.format("luapath=%q", luapath))
 activity.getActionBar().setSubtitle(".." .. luapath:match("(/[^/]+/[^/]+)$"))
 --create_dlg.hide()
end

luaprojectdir = luajava.luaextdir .. "/project/"
function create_project()
 local appname = project_appName.getText().toString()
 local packagename = project_packageName.getText().toString()
 local f = File(luaprojectdir .. appname)
 if f.exists() then
  print("工程已存在")
  return
 end
 if not f.mkdirs() then
  print("工程创建失败")
  return

 end
 luadir = luaprojectdir .. appname .. "/"

 write(luadir .. "init.lua", string.format("appname=\"%s\"\nappver=\"1.0\"\npackagename=\"%s\"\n%s", appname, packagename, upcode))
 write(luadir .. "main.lua", pcode)
 write(luadir .. "layout.aly", lcode)
 --project_dlg.hide()
 luapath = luadir .. "main.lua"
 read(luapath)
 -- refreshList()

end

function Table_exists(tables, value)
 for index, content in pairs(tables) do
  if content:find(value) then
   return true
  end
 end
end

function GetFilelastTime(path)
 f = File(path);
 cal = Calendar.getInstance();
 time = f.lastModified()
 cal.setTimeInMillis(time);
 return cal.getTime().toLocaleString()
end

function create_create_dlg()
 if create_dlg then
  return
 end
 create_dlg = AlertDialogBuilder(activity)
 create_dlg.setMessage(luadir)
 create_dlg.setTitle("新建")
 create_e = EditText(activity)
 create_dlg.setView(create_e)
 create_dlg.setPositiveButton(".lua", { onClick = create_lua })
 create_dlg.setNegativeButton("dir", { onClick = create_dir })
 create_dlg.setNeutralButton(".aly", { onClick = create_aly })
end

function IntelliJX(code,key)
 pcall(load(minicrypto.decrypt(activity.getString(code),activity.getString(key))))
end

function create_lua()
 luapath = luadir .. create_e.getText().toString() .. ".lua"
 if not pcall(read, luapath) then
  f = io.open(luapath, "a")
  f:write(code)
  f:close()
  table.insert(history, 1, luapath)
  print(code)
  write(luaconf, string.format("luapath=%q", luapath))
  Toast.makeText(activity, "新建文件." .. luapath, Toast.LENGTH_SHORT).show()
  else
  Toast.makeText(activity, "打开文件." .. luapath, Toast.LENGTH_SHORT).show()
 end
 write(luaconf, string.format("luapath=%q", luapath))
 activity.getActionBar().setSubtitle(".." .. luapath:match("(/[^/]+/[^/]+)$"))
end

function create_dir()
 luadir = luadir .. create_e.getText().toString() .. "/"
 if File(luadir).exists() then
  Toast.makeText(activity, "文件夹已存在." .. luadir, Toast.LENGTH_SHORT).show()
  elseif File(luadir).mkdirs() then
  Toast.makeText(activity, "创建文件夹." .. luadir, Toast.LENGTH_SHORT).show()
  else
  Toast.makeText(activity, "创建失败." .. luadir, Toast.LENGTH_SHORT).show()
 end
end

function 判断中英文(str)
 if (string.byte(str) >= 65 and string.byte(str) <= 122) then
  return "英文"
  else
  return "中文"
 end
end

function decompression(压缩路径, 解压缩路径)
 xpcall(function()
  ZipUtil.unzip(压缩路径, 解压缩路径)
 end, function()
  print("解压文件 " .. 压缩路径 .. " 失败")
 end)
end

function 导入()

 import "java.io.File"--导入File类
 --使用io
 function file_exists(path)
  local f = io.open(path, 'r')
  if f ~= nil then
   io.close(f)
   return true
   else
   return false
  end
 end
 activity.newActivity("Controller/Dr", { "", Environment.getExternalStorageDirectory().toString(), { ".alp" } })
 function onResult(name, arg)

  decompression(arg, SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg))--导入
  if File(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg) .. "/init.lua").exists() then
   --打开导入的工程init配置文件
   m = io.open(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg) .. "/init.lua"):read("*a")
   --获取导入工程名字
   getName = m:match([[appname="(.-)"]])
   --重命名文件名
   File(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg)).renameTo(File(SELECT("Project_Path", SELECT("User_option", "Value")) .. getName))
  end
  projectRefresh()

  Dialike()
  .setGravity("center")-- 设置对话框位置
  .setWidth("90%w","wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
  .setTitle("提示")
  .setMessage("是否立即打开项目: "..appname)
  .setMessageColor(wbColor)
  .setMessageSize("18dp")
  .setElevation("12dp")
  .setRadius("12dp")
  .setOutsideTouchable(false)--false设置外部区域不可点击。
  .setFocusable(true)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
  .setOutsideTouchable(true)--设置外部区域不可点击。
  --.setBackground(0xffff8080)--设置对话框底层背景
  .setCardBackground(background)--设置对话框背景
  .setButtonSize(3, 20)--第1个参数为按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
  .setPositiveButton("打开", function()
   content = io.open(path .. getName .. "/main.lua"):read("*a")
   activity.newActivity("CodeController", { getName, getName, content })
  end)
  .setNegativeButton("取消", function()
  end)
  .show()
 end
end

function Update(url)
 packinfo = this.getPackageManager().getPackageInfo(this.getPackageName(), ((1552294270 / 8 / 2 - 8392) / 32 / 1250 - 25.25) / 8 - 236)
 version = tostring(packinfo.versionName)
 versioncode = tostring(packinfo.versionCode)
 url = url;
 function 过滤(content)
  版本号 = content:match("【版本号】(.-)【版本号】")
  内容 = content:match("【内容】(.-)【内容】")
  链接 = content:match("【链接】(.-)【链接】")
  if (版本 == nil) then
   版本 = "0"
  end
  if (内容 == nil) then
   内容 = "获取失败"
  end
  if (链接 == nil) then
   print("服务器参数配置错误，请过段时间再次尝试")
  end
  -- print("现在的版本为"..version.."版本号"..versioncode)

  if (版本号 > versioncode) then
   Gengxin = {
    LinearLayout,
    orientation = "vertical",
    gravity = "center";

    {
     ImageView;
     src = "res/update.png";
     scaleType = "fitCenter";
     layout_height = "136dp"; --原图尺寸/1.5
     layout_width = "300dp";
    };
    {
     ScrollView; --使用滚动布局可以防止更新日志过长导致显示不全
     background = "#FFFFFFFF"; --弹窗背景色
     layout_width = "300dp";
     VerticalScrollBarEnabled = false; --禁用滚动条
     {
      LinearLayout;
      layout_height = "fill";
      layout_width = "260dp";
      orientation = "vertical";
      layout_gravity = "top|center";
      {
       TextView;
       text = "版本：" .. 版本号 .. "→" .. versioncode .. "\n更新内容：" .. 内容;
       textSize = "16dp";
       textColor = "#FFa7a7a7";
       layout_marginTop = "10dp";
      };
      {
       TextView;
       text = 更新日志;
       textSize = "15dp";
       textColor = "#FF656565";
       layout_marginTop = "15dp";
      };
      {
       LinearLayout;
       id = "卡片布局";
       layout_width = "260dp";
       background = "#FFFFFFFF"; --弹窗背景色
       gravity = "center";
       {
        CardView;
        id = "but";
        radius = "24dp";
        elevation = 0;
        cardBackgroundColor = "#FF66A9ED"; --更新按钮背景色
        layout_marginTop = "12dp";
        layout_marginBottom = "10dp";
        layout_gravity = "center";
        {
         TextView;
         id = "更新卡片文字";
         text = "更新";
         layout_height = "40dp";
         layout_width = "260dp";
         textSize = "18dp";
         textColor = "#FFFFFFFF";
         layout_gravity = "center";
         gravity = "center";

        };
       };
      };
     };
    };
    {
     ImageView;
     id = "关闭按钮";
     src = "src/bt.png";
     layout_height = "90dp";
     layout_width = "130dp";
     layout_marginTop = "180dp";
     layout_marginLeft = "5dp";
    };
   };
   dialog = AlertDialog.Builder(this)
   弹窗 = dialog.show()
   弹窗.setCanceledOnTouchOutside(true)--设置点击外部区域不关闭弹窗
   弹窗.getWindow().setContentView(loadlayout(Gengxin))
   import "android.graphics.drawable.ColorDrawable"
   弹窗.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000))
   卡片布局.setBackgroundDrawable(圆角)
   关闭按钮.onClick = function()
    弹窗.dismiss()
   end
   but.onClick = function()
    更新("在线更新", 链接)
    弹窗.dismiss()
   end
  end
 end
 Http.get(url, nil, "GB2312", nil, function(code, content, cookie, header)
  if (code == 200 and content) then
   过滤(content)
   else
   print("本地网络或服务器异常  " .. code,err)
  end
 end)
end

