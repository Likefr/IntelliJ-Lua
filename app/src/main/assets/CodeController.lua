require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "java.io.*"
import "android.text.method.*"
import "android.net.*"
import "android.net.Uri"
import "android.content.*"
import "android.content.Intent"
import "android.graphics.drawable.*"
import "com.Likefr.widget.PullRefreshLayout"
import "android.provider.Settings"
import "android.graphics.PixelFormat"
import "android.content.Context"
import "com.michael.NoScrollListView"
R = luajava.bindClass("com.Likefr.LuaJava.R")
local cjson = import "cjson"
import "Controller/LayBox"
import "IntelliJ"
import "Controller/MyEditText"
import "com.qklua.editor.CodeEditor";
import "android.util.TypedValue"
import "Dialog"
ReturnEditConfig()
function XPageView()
 --禁止滑动
 return luajava.override(luajava.bindClass("android.widget.PageView"), {
  onInterceptTouchEvent = function(super, event)
   return false
  end,
  onTouchEvent = function(super, event)
   return false
  end
 })
end

import "layout"
activity.setContentView(loadlayout(layout.EditCode))
redo.setScaleY(-1);
checkJson =true; selectColoris = true
editor.setTypeface(字体("product-Bold"))
project_title, title_content, code, path = ...
sub_title.setText("main.lua")
title.setText(title_content)
if path == nil then
 path = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
 luapath = path .. project_title .. "/main.lua"
 else
 luapath = path .. "/main.lua"
 luapath = path .. project_title .. "/main.lua"
end
全局sc = path .. project_title .. "/"
code = 去除主题(code)

editor.setText(code)

editor.OnSelectionChangedListener = function(status, Start, End)
 if status == true then
  --判断是否选中
  opi.Visibility = 0--显示控件
  opii.Visibility = 8--显示控件
  top1.setVisibility(View.GONE)
  else
  opi.Visibility = 8--隐藏控件
  opii.Visibility = 8
  top1.setVisibility(View.VISIBLE)
 end
end

if this.getSharedData(activity.getString(R.string.night)) == "true" then
 editor.setPanelBackgroundColor(background)
 --editor.setBackgroundColor(0xFF2C303B)--面板
 editor.setPanelTextColor(0xff89CA78)
 editor.BasewordColor = 0xFFD55FDE--函数
 editor.KeywordColor = 0xFF2BBAC5--关键字
 editor.CommentColor = 0xFFE5C07B--注释
 editor.UserwordColor = 0xFF2BBAC5--用户定义的方法
 editor.StringColor = 0xFFBBBBBB--字符串
 editor.TextColor = 0xf0ffffff

 else
 editor.setPanelBackgroundColor(background)
 editor.setPanelTextColor(0xff8c8c8c)
 editor.BasewordColor = 0xFFD55FDE--函数
 editor.KeywordColor = 0xff80BB8c--关键字
 editor.CommentColor = 0xFF121314--注释
 editor.UserwordColor = 0xffff8080--用户定义的方法
 editor.StringColor = 0xFF8c8c8c--字符串 和导入的包
 editor.TextColor = 0xff414d41--文本

end

if File(path .. project_title .. "/config.json").exists() then

 look.setVisibility(View.VISIBLE)
 look.onClick = function()
  --读取json文件，模拟获取接口

  local data = io.open(path .. project_title .. "/" .. "config.json"):read("*a")

  data = cjson.decode(data)

  --转lua格式
  data = dataModel.fromJson(data.data)

  lookProject({
   lookproject = "editConfig",
   url = data.url,
   ad = data.ad,
   js = data.js,
   ua = data.ua
  })
 end
 else
 look.setVisibility(View.GONE)
end


--监听是否正在刷新
pulltwo.onRefresh = function()
 task(400, function()
  pulltwo.setRefreshing(false);
  loadFileList(path .. project_title .. projectOpenPath.Text)
  file_list.setLayoutAnimation(lac)
 end)
end
function onActivityResult(req, res, intent)
 --回调
 if res == 10000 then
  code = io.open(path .. project_title .. "/" .. sub_title.Text):read("*a")
  editor.setText(code)
  return
 end
end
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

--全选
selectAll.onClick = function()
 editor.selectAll()
end
--关闭
close.onClick = function()
 opii.Visibility = 8--显示控件
 top1.Visibility = 0--显示控件
 opi.Visibility = 8--隐藏控件
end
--剪切
Cat.onClick = function()
 editor.cut()
 opi.Visibility = 8--隐藏控件
end
Copy.onClick = function()
 editor.copy()
 opi.Visibility = 8--隐藏控件
end
--粘贴
Paste.onClick = function()
 editor.paste()
 opi.Visibility = 8--隐藏控件
end

波纹(redo, backgroundB)
波纹(undo, backgroundB)
波纹(menu, backgroundB)
波纹(icon, backgroundB)
波纹(Run, backgroundB)
波纹(sideslip, backgroundB)
pop = PopupMenu(activity, menu)
menu2 = pop.Menu


--PopupWindow
local Popup_layout = {
 LinearLayout;
 {
  CardView;
  CardElevation = "6dp";
  CardBackgroundColor = background;
  Radius = "8dp";
  layout_width = "-1";
  layout_height = "-2";
  layout_margin = "8dp";
  {
   GridView;
   layout_height = "-1";
   layout_width = "-1";
   NumColumns = 3;
   id = "Popup_list";
  };
 };
};

local pop = PopupWindow(activity)
pop.setContentView(loadlayout(Popup_layout))
pop.setWidth(dp2px(300))
pop.setHeight(-2)
pop.setOutsideTouchable(true)
pop.setBackgroundDrawable(ColorDrawable(0x00000000))
pop.onDismiss = function()
end

Popup_list_item = {
 LinearLayout;
 layout_width = "-1";
 layout_height = "48dp";
 {
  TextView;
  id = "popadp_text";
  textColor = wbColor;
  layout_width = "-1";
  layout_height = "-1";
  textSize = "14sp";
  gravity = "left|center";
  paddingLeft = "16dp";
 };
};

popadp = LuaAdapter(activity, Popup_list_item)

Popup_list.setAdapter(popadp)
popadp.add { popadp_text = "格式化", }
popadp.add { popadp_text = "搜索" }
popadp.add { popadp_text = "替换" }
popadp.add { popadp_text = "导航" }
popadp.add { popadp_text = "全局搜索", }
popadp.add { popadp_text = "打包项目" }
popadp.add { popadp_text = "导入分析", }
popadp.add { popadp_text = "API查找", }
popadp.add { popadp_text = "APK签名" }
popadp.add { popadp_text = "编译文件" }
popadp.add { popadp_text = "渐变参考" }
popadp.add { popadp_text = "颜色提取" }
popadp.add { popadp_text = "图片取色" }
popadp.add { popadp_text = "保存退出", }

function menu.onClick()
 pop.showAsDropDown(menu)
end

function icon.onClick()
 --布局助手
 luapath = path .. project_title .. "/" .. sub_title.Text
 luaproject = path .. project_title .. projectOpenPath.Text
 if luapath:find("%.aly$") then
  activity.newActivity("layouthelper/main", { luaproject, luapath })
  else
  print("当前文件不是布局文件", err)
 end
end

function Run.onClick()
 editor.save(path .. project_title .. "/" .. sub_title.getText())

 if sub_title.Text == "/config.json" then
  Dialike()
  .setGravity("center")-- 设置对话框位置
  .setWidth("90%w", "wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
  .setTitle("提示")
  .setMessage("该文件为配置文件无法运行")
  .setMessageColor(wbColor)
  .setMessageSize("18dp")
  .setElevation("14dp")
  .setRadius("3dp")
  .setOutsideTouchable(true)--false设置外部区域不可点击。
  .setFocusable(true)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
  .setOutsideTouchable(true)--设置外部区域不可点击。
  .setCardBackground(background)--设置对话框背景
  .setButtonSize(3, 20)--第1个参数为按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
  .setPositiveButton("转到主文件", function()
   sub_title.setText("main.lua")

   code = io.open(path .. project_title .. "/" .. sub_title.Text):read("*a")
   --code=去除主题(code)
   editor.setText(code)
  end)
  .setNegativeButton("取消", function()
  end)
  .show()
 end
 if check(true) then
  return
 end
 isupdate = true
 --读取json文件，模拟获取接口

 if File(path .. project_title .. "/config.json").exists() then
  local data = io.open(path .. project_title .. "/" .. "config.json"):read("*a")
  data = cjson.decode(data)
  --转lua格式
  data = dataModel.fromJson(data.data)
  if data.url == "" then
   lookProject({
    lookproject = "editConfig",
    url = data.url,
    ad = data.ad,
    js = data.js,
    ua = data.ua
   })
   else
   activity.newActivity(path .. project_title .. "/main.lua")
  end
  else
  activity.newActivity(path .. project_title .. "/main.lua")
 end
end

local gd2 = GradientDrawable()
gd2.setColor(0xff203038)
local radius = dp2px(24)
gd2.setCornerRadii({ radius, radius, radius, radius, radius, radius, radius, radius })--圆角
gd2.setShape(0)
gd2.setAlpha(100)
symbolBar.setBackgroundDrawable(gd2)

function click(v)
 if v.getText() == "←" then
  editor.setSelection(editor.getSelectionStart() - 1)
  elseif v.getText() == "→" then
  editor.setSelection(editor.getSelectionStart() + 1)
  elseif v.getText() == "Fun" then
  editor.paste("function()  end")
  else
  editor.paste(v.getText())
 end
end

function newButton(text)
 local btn = TextView()
 btn.TextSize = 15
 btn.Text = text
 btn.TextColor = Color.WHITE
 btn.width = 65
 btn.height = -1
 btn.Typeface = 字体("product-Bold")
 btn.onClick = click
 btn.setGravity(Gravity.CENTER)
 btn.setSingleLine(true)
 btn.setBackground(列表波纹(0x5FFFFFFF))
 return btn
end

local ps = { "Fun", "(", ")", "[", "]", "{", "}",
 "-", "\"", "=", ":", ".", ",", ";",
 "_", "+", "*", "\\", "/", "%", "#",
 "$", "?", "&", "|", "<", ">", "~", "'" }
for k, v in ipairs(ps) do
 ps_bar.addView(newButton(v))
end

file_adp = LuaMultiAdapter(activity, layout.file_item)
file_list.setAdapter(file_adp)

--创建一个Animation对象
animation = AnimationUtils.loadAnimation(activity, android.R.anim.slide_in_left)
--得到对象
lac = LayoutAnimationController(animation)
--设置控件显示的顺序
lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
--ORDER_NORMAL   顺序显示
--ORDER_REVERSE 反显示
--ORDER_RANDOM 随机显示
--设置控件显示间隔时间
lac.setDelay(0.1)--这里单位是秒


Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener {
 onItemClick = function(parent, v, pos, id)
  pop.dismiss()
  local s = v.Tag.popadp_text.Text
  if s == "搜索" then
   pageview.showPage(0)
   opii.Visibility = 0--显示控件
   -- SearchStartAnim(edit_Anim)
   top1.setVisibility(View.GONE)

   wbwb.EditText.addTextChangedListener {
    afterTextChanged = function(str)
     editor.findNext(wbwb.getText())
    end
   }
   elseif s == "替换" then
   local InputLayout = {
    LinearLayout;
    orientation = "vertical";
    {
     EditText;
     hint = "替换前文本";
     layout_marginTop = "5dp";
     layout_width = "80%w";
     layout_gravity = "center",
     id = "edit1";
    };
    {
     EditText;
     hint = "替换后文本";
     layout_marginTop = "5dp";
     layout_width = "80%w";
     layout_gravity = "center",
     id = "edit2";
    };
   };
   AlertDialog.Builder(this)
   .setTitle("文本替换")
   .setView(loadlayout(InputLayout))
   .setPositiveButton("开始替换", { onClick = function(v)
     import "java.lang.String"

     local 路径=path .. project_title .. "/" .. sub_title.getText()
     要替换的字符串= tostring(edit1.getText());
     替换成的字符串=tostring(edit2.getText());
     if 路径 then
      editor.selectAll();
      editor.paste(tostring(tostring(editor.getText()):gsub(要替换的字符串,替换成的字符串)))
      print("替换成功", success)
      else
      print("替换异常",err)
     end
    end })
   .setNeutralButton("取消", nil)
   .show()

   elseif s == "APK签名" then
   activity.newActivity("Controller/SignBin")
   elseif s == "打包项目" then
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   activity.newActivity("Controller/bin", { "/" .. path .. project_title .. "/" })

   elseif s == "全局搜索" then
   pageview.showPage(4)

   layouts = {
    LinearLayout;
    layout_height = "70dp";
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
       textColor = wbColor;
       id = "you";
       Typeface = 字体("product-Bold");
       textSize = "18dp";
      };
      {
       TextView;
       id = "wenjianmingpp";
       textColor = wbColor;
       textSize = "18dp";
       Typeface = 字体("product-Bold");
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
      layout_marginTop = dp2px(10);
      {
       TextView;
       text = "路径：";
       textColor = wbColor;
       textSize = "17dp";
       Typeface = 字体("product-Bold");
       layout_width = "wrap";
       singleLine = "true";
       ellipsize = "marquee",
       Selected = "true";
      };
      {
       TextView;
       textColor = wbColor;
       id = "lujingpp";
       textSize = "17dp";
       layout_gravity = "center";
       Typeface = 字体("product-Bold");
       layout_width = "wrap";
       singleLine = "true";
       ellipsize = "marquee",
       Selected = "true";
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
        else
       end
      end

     end
    end
    findf(lj, wjm)
   end

   function sousuoset.onClick()

    b = wbnr.getText()

    if b == "" then
     print("请填写好内容", info)
     else
     adp.clear()
     thread(xcxcxc, 全局sc, tostring(b))
    end
   end

   liebiaoset.onItemClick = function(p, v, i, s)
    editor.save(path .. project_title .. "/" .. sub_title.getText())
    code = io.open(v.Tag.lujingpp.Text):read("*a")
    sub_title.setText(v.Tag.wenjianmingpp.getText())
    editor.setText(code)
    editor.findNext(wbnr.getText())
    pageview.showPage(0)
    return true
   end

   elseif s == "格式化" then
   editor.format()
   elseif s == "图片取色" then
   activity.newActivity("Controller/Colorx")
   elseif s == "导航" then

   create_navi_dlg()
   local str = editor.getText().toString()
   local fs = {}
   indexs = {}
   for s, i in str:gmatch("([%w%._]* *=? *function *[%w%._]*%b())()") do
    i = utf8.len(str, 1, i) - 1
    s = s:gsub("^ +", "")
    table.insert(fs, s)
    table.insert(indexs, i)
    fs[s] = i
   end
   local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String(fs))
   navi_list.setAdapter(adapter)
   navi_dlg.show()

   elseif s == "转到行" then
   Download_layout = {
    LinearLayout;
    orientation = "vertical";
    id = "Download_father_layout",
    {
     EditText;
     id = "linkedit",
     layout_marginLeft = "10dp",
     layout_marginRight = "10dp",
     hint = "跳转到第几行？";
     layout_width = "match_parent";
    };
   };
   AlertDialog.Builder(this)
   .setTitle("跳转到")
   .setView(loadlayout(Download_layout))
   .setPositiveButton("确定", { onClick = function(v)
     editor.gotoLine(tonumber(linkedit.Text))
    end })
   .setNegativeButton("取消", nil)
   .show()

   elseif s == "编译文件" then
   if check(true) then
    return
   end
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   local path, str = console.build(luapath)
   if path then
    print("编译完成: " .. path, success)
    else
    print("编译出错: " .. str, err)
   end
   elseif s == "导入分析" then
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   activity.newActivity("Controller/fiximport", { path .. project_title, luapath })
   elseif s == "API查找" then
   JavaApi({
    对话框id = "k"
   })
   elseif s == "颜色提取" then


   items={"ColorPicker"}--创建有数据的列表，添加即在后面加上,"项目名称"
   AlertDialog.Builder(this)
   .setTitle("选择")--设置标题
   --给列表对话框设置点击事件
   .setItems(items,{onClick=function(l,v)
     --注：与创建有数据的列表项目名称必须一样
     if items[v+1]=="ColorPicker" then
      if selectColoris then
       selectColor()
      end
      selectColoris = false
      elseif items[v+1]=="ARGB" then
      activity.newActivity("Controller/Colorqs/main")
     end
    end})
   .show()--显示弹窗






   elseif s == "渐变参考" then
   activity.newActivity("Controller/Color")
   elseif s == "保存退出" then
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   this.finish();
  end
 end
})

sideslip.onClick=function()

 if Drawer.isDrawerOpen(3) then
  Drawer.closeDrawer(3)
  else
  --loadFileList(path..project_title)
  Drawer.openDrawer(3)
  file_list.setLayoutAnimation(lac)
 end

end

loadFileList(path .. projectOpenPath.Text .. project_title)

file_list.setOnItemClickListener(AdapterView.OnItemClickListener {
 onItemClick = function(parent, v, pos, id)
  if last == true then
   else
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   title_name = v.Tag.title.Text
   typesOf = v.Tag.typesOf.Text
   nilCode.setVisibility(View.GONE)
   img.setImageBitmap(loadbitmap(""))

   icon.setVisibility(View.GONE)
   if tostring(string.sub(title_name, 1, 8)) == "init.lua" then
    activity.newActivity("Controller/main", { path .. project_title });
   end


   if title_name:find("%.txt") then
    pageview.showPage(0)
    checkJson = false --不检查
    if projectOpenPath.Text == "" then
     sub_title.setText(title_name)
     else
     sub_title.setText(projectOpenPath.Text .. "/" .. title_name)
    end
    content = io.open(path .. project_title .. projectOpenPath.Text .. "/" .. title_name):read("*a")
    editor.setText(content)
    editor.save(path .. project_title .. "/" .. sub_title.getText())
    Drawer.closeDrawer(3)
   end

   if title_name:find("%.lua$") and not title_name:find("init.lua") then
    --点击列表事件
    pageview.showPage(0)
    checkJson = true
    if projectOpenPath.Text == "" then
     sub_title.setText(title_name)
     else
     sub_title.setText(projectOpenPath.Text .. "/" .. title_name)
    end
    code = io.open(path .. project_title .. "/" .. sub_title.Text):read("*a")
    --   code=去除主题(code)
    editor.setText(code)
    editor.save(path .. project_title .. "/" .. sub_title.getText())
    Drawer.closeDrawer(3)
   end

   if title_name:find("%.json$") then
    --点击列表事件
    pageview.showPage(0)
    if projectOpenPath.Text == "" then
     sub_title.setText(title_name)
     else
     sub_title.setText(projectOpenPath.Text .. "/" .. title_name)
    end
    code = io.open(path .. project_title .. projectOpenPath.Text .. "/" .. title_name):read("*a")
    editor.setText(code)
    editor.save(path .. project_title .. "/" .. sub_title.getText())
    Drawer.closeDrawer(3)
    checkJson = false
    pl.setVisibility(View.GONE)
   end

   if title_name:find("%.aly$") then
    --点击列表事件
    pageview.showPage(0)
    icon.setVisibility(View.VISIBLE)
    checkJson = true
    if projectOpenPath.Text == "" then
     sub_title.setText(title_name)
     else
     sub_title.setText(projectOpenPath.Text .. "/" .. title_name)
    end
    code = io.open(path .. project_title .. "/" .. sub_title.Text):read("*a")
    editor.setText(code)
    editor.save(path .. project_title .. "/" .. sub_title.getText())
    Drawer.closeDrawer(3)
   end

   if title_name == ".." then
    --print(tostring(File(projectOpenPath.Text).getParent()))
    if tostring(File(projectOpenPath.Text).getParent()) == "/" then
     projectOpenPath.setText("")
     loadFileList(path .. project_title)
     else
     projectOpenPath.setText(tostring(File(projectOpenPath.Text).getParent()))
     loadFileList(path .. project_title .. projectOpenPath.Text)
    end
   end

   if typesOf == "文件夹" then
    projectOpenPath.setText(projectOpenPath.Text .. "/" .. title_name)
    loadFileList(path .. project_title .. projectOpenPath.Text)
   end

   if title_name:find("%.png") or title_name:find("%.jpg") then
    Drawer.closeDrawer(3)
    pageview.showPage(2)

    if projectOpenPath.Text == "" then
     img.setImageBitmap(loadbitmap(path .. project_title .. "/" .. title_name))
     else
     img.setImageBitmap(loadbitmap(path .. project_title .. "/" .. projectOpenPath.Text .. "/" .. title_name))
    end

    import "android.graphics.Matrix"
    import "android.graphics.PointF"
    import "android.util.FloatMath"
    matrix = Matrix()
    savedMatrix = Matrix()
    mode = 0
    startPoint = PointF()
    midPoint = PointF();
    oriDis = 1
    distance = function(e)
     local x = e.getX(0) - e.getX(1)
     local y = e.getY(0) - e.getY(1)
     return FloatMath.sqrt(x * x + y * y)
    end
    middle = function(e)
     local x = e.getX(0) + e.getX(1)
     local y = e.getY(0) + e.getY(1)
     return PointF(x / 2, y / 2)
    end
    img.onTouch = function(v, e)
     local a = e.getAction() & 255
     if a == MotionEvent.ACTION_DOWN then
      matrix.set(v.getImageMatrix())
      savedMatrix.set(matrix)
      startPoint.set(e.getX(), e.getY())

      mode = 1
     end
     if a == MotionEvent.ACTION_POINTER_DOWN then
      oriDis = distance(e);
      if oriDis > 10 then
       savedMatrix.set(matrix);
       midPoint = middle(e)
       mode = 2
      end
     end
     if a == MotionEvent.ACTION_POINTER_UP then
      mode = 0
     end
     if a == MotionEvent.ACTION_MOVE then
      if (mode == 1) then
       matrix.set(savedMatrix);
       matrix.postTranslate(e.getX() - startPoint.x, e.getY() - startPoint.y);
       elseif (mode == 2) then
       newDist = distance(e);
       if (newDist > 10) then
        matrix.set(savedMatrix);
        scale = newDist / oriDis
        matrix.postScale(scale, scale, midPoint.x, midPoint.y);
       end
      end
     end
     v.setImageMatrix(matrix)
     return true
    end

    startPoint.set(70, 800)
    else
    pageview.showPage(0)
   end


   if title_name == "新建文件/文件夹" then
    side_Long({
     标题 = "新建文件/文件",
     side_Long = "sideOnLong",

     img_table = {
      "FileTypeIcons/ic_lua",
      "FileTypeIcons/ic_aly",
      "FileTypeIcons/ic_txt",
      "FileTypeIcons/ic_folder",
     },
     table = {
      "lua文件",
      "aly文件",
      "txt文件",
      "文件夹",
     },


     onclickGrid = function(parent, v, pos, id)
      titleName = v.Tag.item_title.Text
      pageview.showPage(1)
      if titleName == "lua文件" then
       createFile = 1

       sideOnLong.dismiss()
       elseif titleName == "aly文件" then
       createFile = 2
       elseif titleName == "txt文件" then
       createFile = 3

       elseif titleName == "文件夹" then
       createFile = 4

      end
      sideOnLong.dismiss()
      Drawer.closeDrawer(3)
     end })
   end
   return true
  end
 end
})

file_list.setOnItemLongClickListener(AdapterView.OnItemLongClickListener {
 onItemLongClick = function(parent, v, pos, id)
  title_name = v.Tag.title.Text
  last = true --不允许执行单击事件
  Dialike()
  .setGravity("center")-- 设置对话框位置
  .setWidth("90%w", "wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
  .setTitle("提示")
  .setMessage("您要对文件 " .. title_name .. "进行什么操作 ?")
  .setMessageColor(wbColor)
  .setMessageSize("18dp")
  .setElevation("12dp")
  .setRadius("8dp")
  .setFocusable(true)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
  .setOutsideTouchable(true)--设置外部区域不可点击。
  .setCardBackground(background)--设置对话框背景
  .setButtonSize(3, 20)--第1个参数'按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
  .setPositiveButton("重命名", function()
   last = false
   createFile = 5--重命名模式
   editFile.setText(title_name)
   editFile.setHint("请输入文件名")
   pageview.showPage(1)
   Drawer.closeDrawer(3)

  end)
  .setNegativeButton("删除", function()
   last = false
   xpcall(function()
    last = false
    if sub_title.Text == "/" .. title_name then
     File(path .. project_title .. projectOpenPath.Text .. "/" .. title_name).delete()
     sub_title.setText("main.lua")
     code = io.open(path .. project_title .. "/" .. sub_title.Text):read("*a")
     editor.setText(code)
     loadFileList(path .. project_title .. projectOpenPath.Text)
     else
     import "java.io.File"
     File(path .. project_title .. projectOpenPath.Text .. "/" .. title_name).delete()
     loadFileList(path .. project_title .. projectOpenPath.Text)
    end

   end, function(e)

   end)
  end)
  .show()
 end
})

import 'android.widget.PageView$PageTransformer'

默认参数 = 0.75--设置默认参数，后面计算动画参数
--Pageview官方动画函数
pageview.setPageTransformer(true, PageTransformer {--获取到Pageview的位置
 transformPage = function(view, position)
  pageWidth = view.getWidth()
  if position < -1 then
   view.setAlpha(0)--设置透明度
   elseif position <= 0 then
   view.setAlpha(1)
   view.setTranslationX(0)--设置偏移量(X轴平移)
   view.setScaleX(1)--设置X轴缩放
   view.setScaleY(1)--设置Y轴缩放

   elseif position <= 1 then
   view.setAlpha(1 - position)
   view.setTranslationX(pageWidth * -position)
   动画参数 = 默认参数 + (1 - 默认参数) * (1 - Math.abs(position))--动态计算动画参数
   view.setScaleX(动画参数)
   view.setScaleY(动画参数)

   else
   view.setAlpha(0)
  end
 end
})
--这个为谷歌官方开源的动画函数，类似的还有很多很多
--开源链接：https://github.com/ToxicBakery/ViewPagerTransforms
function onStart()
 --Ticker定时器
 ti = Ticker()
 ti.Period = 500
 ti.onTick = function()
  if checkJson then
   local src = editor.getText()
   src = src.toString()
   if luapath:find("%.aly$") then
    src = "return " .. src
   end
   local _, data = loadstring(src)
   pl.setVisibility(View.VISIBLE)
   --  fy.setVisibility(View.VISIBLE)
   if data then
    local _, _, line, data = data:find(".(%d+).(.+)")
    erro.setText(line .. ":" .. data)
    -- fy.setText(Translate(tostring(line .. ":" .. data)))
    pl.onClick = function()
     editor.gotoLine(tonumber(line))--跳转到报错处
    end
    else
    pl.setVisibility(View.GONE)
    fy.setVisibility(View.GONE)
   end
  end
 end

 if this.getSharedData("代码检查") == "true" and checkJson == true then
  ti.start()
 end
end

--[[function onStop()

end]]
function onPause()
 if this.getSharedData("代码检查") == "true" then
  ti.stop()
 end
 editor.save(path .. project_title .. "/" .. sub_title.getText())
end


function onKeyDown(code, event)
 if string.find(tostring(event), "KEYCODE_BACK") == nil then
  elseif Drawer.isDrawerOpen(3) then
  editor.save(path .. project_title .. "/" .. sub_title.getText())
  Drawer.closeDrawer(3)
  return true
  else
  editor.save(path .. project_title .. "/" .. sub_title.getText())
  activity.finish()
  return true
 end
end



--[[主id.OnTouchListener = function (v, e)
 local ljpe = e.getActionMasked()
 return false--窗体外触摸
end]]




--[[

--搜索框,输入法右下角搜索监听
wbwb.setOnEditorActionListener(TextView.OnEditorActionListener{
    onEditorAction=function(view,actionId,event)
        if (actionId==EditorInfo.IME_ACTION_SEARCH or (event!=null&&event.getKeyCode()== KeyEvent.KEYCODE_ENTER)) then


        SearchEndAnim(edit_Anim)

        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
        imm.toggleSoftInput(0,InputMethodManager.HIDE_NOT_ALWAYS)

        end
        return false
    end
})
]]




参数 = 0
function onKeyDown(code, event)
 save()
 if string.find(tostring(event), "KEYCODE_BACK") ~= nil
  and opii.getVisibility() == 0
  or opi.getVisibility() == 0 then

  if 参数 + 2 > tonumber(os.time()) then
   activity.finish()
   else

   last = false
   opi.Visibility = 8
   opii.Visibility = 8
   top1.Visibility = 0
   editor.save(path .. project_title .. "/" .. sub_title.getText())
   Toast.makeText(activity, "再按一次返回键退出", Toast.LENGTH_SHORT)
   .show()
   参数 = tonumber(os.time())
  end
  return true
 end
end