require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
require "permission"
import "MyEditText"
import "android.content.res.ColorStateList"
import "IntelliJ"
import"Toasts"
FULL()
if this.getSharedData(activity.getString(R.string.night)) == "true" then
 Bar = 0xFF2C303B;
 background = 0xFF2C303B;--夜间背景。
 backgroundB = 0xff1890ff;--按压颜色
 elevation = "8dp"--阴影
 wbColor = 0x90ffffff--夜间字体颜色
 else
 Bar = 0xFFF9F9F9
 background = 0xFFF9F9F9;
 backgroundB = 0xffff8080;
 ColorFilter = 0xFF2C303B
 elevation = "3dp"
 wbColor = 0xff495057
end
import "layout"
import "android.graphics.drawable.ColorDrawable"
activity.setTitle('工程属性')--设置窗口标题

if this.getSharedData("Activity动画") == "true" then
 activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
end
if this.getSharedData("屏幕常亮") == "true" then
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
end

activity.setContentView(loadlayout(layout))

projectdir = ...

plist = ListView(activity)
dlg = LuaDialog(activity)
dlg.title = "更改权限"
dlg.view = plist
dlg.setButton("确定", nil)

btn.setBackground(--设置背景
LuaDrawable(--设置自绘制
function(画布, 画笔)
 --绘制函数
 画笔.setColor(0xff0396FF)--设置画笔
 画笔.setShadowLayer(30, 0, 0, 0x600396FF)
 画布.translate(120, 55);
 画布.drawRoundRect(RectF(10, 0, 350, 95), 50, 50, 画笔)--画布绘制圆角矩形
 画笔.setColor(0xffffffff)
 画笔.setTextSize(40)
 画布.drawText("更改权限", 105, 60, 画笔)--画布绘制
end))

Savek.setBackground(--设置背景
LuaDrawable(--设置自绘制
function(画布, 画笔)
 --绘制函数
 画笔.setColor(0xff0396FF)--设置画笔
 画笔.setShadowLayer(30, 0, 0, 0x600396FF)
 画布.translate(55, 55);
 画布.drawRoundRect(RectF(0, 0, 350, 95), 50, 50, 画笔)--画布绘制圆角矩形
 画笔.setColor(0xffffffff)
 画笔.setTextSize(40)
 画布.drawText("保存", 138, 60, 画笔)--画布绘制
end))

btn.onClick = function()
 dlg.show()
end
img.onClick = function()
 --[[    ChooseFile("image/*", function(path)
        --所有类型文件
        copyFunc(projectdir .. "/icon.png", path)
    end)]]

 print("选取图标目前出现了问题哦",err)

end

if 文件是否存在(projectdir .. "/icon.png") then
 img.setImageBitmap(loadbitmap(projectdir .. "/icon.png"));
 else

 img.setImageBitmap(loadbitmap(activity.getLuaDir("/icon.png")));
 print("该工程没有图标 请选择一个图标",err)
end
luaproject = projectdir .. "/init.lua"
app = {}
loadfile(luaproject, "bt", app)()
appname.setText(app.appname or "未设置名称")
appver.setText(app.appver or "1.0")
appcode.setText(app.appcode or "1")
appsdk.setText(app.appsdk or "15")
packagename.setText(app.packagename or "com.Intellij Lua")
developer.setText(app.developer or "")
description.setText(app.description or "")
debugmode.Checked = app.debugmode == nil or app.debugmode
app_key.setText(app.app_key or "")
app_channel.setText(app.app_channel or "")

plist.ChoiceMode = ListView.CHOICE_MODE_MULTIPLE;
pss = {}
ps = {}
for k, v in pairs(permission_info) do
 table.insert(ps, k)
end
table.sort(ps)

for k, v in ipairs(ps) do
 table.insert(pss, permission_info[v])
end

adp = ArrayListAdapter(activity, android.R.layout.simple_list_item_multiple_choice, String(pss))
plist.Adapter = adp

pcs = {}
for k, v in ipairs(app.user_permission or {}) do
 pcs[v] = true
end
for k, v in ipairs(ps) do
 if pcs[v] then
  plist.setItemChecked(k - 1, true)
 end
end

local fs = luajava.astable(android.R.style.getFields())
local tss = { "Theme" }
for k, v in ipairs(fs) do
 local nm = v.Name
 if nm:find("^Theme_") then
  table.insert(tss, nm)
 end
end

local tadp = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String(tss))
tlist.Adapter = tadp

for k, v in ipairs(tss) do
 if v == app.theme then
  tlist.setSelection(k - 1)
 end
end

function callback(c, j)
 print(dump(j))
end

local template = [[
appname="%s"
appver="%s"
appcode="%s"
appsdk="%s"
packagename="%s"
theme="%s"
app_key="%s"
app_channel="%s"
developer="%s"
description="%s"
debugmode=%s
user_permission={
  %s
}
]]
local function dump(t)
 for k, v in ipairs(t) do
  t[k] = string.format("%q", v)
 end
 return table.concat(t, ",\n  ")
end

Savek.onClick = function()
 if appname.getText() == "" or appver.getText() == "" or packagename.getText() == "" then
  Toast.makeText(activity, "项目不能为空", 500).show()
  return true
 end

 local cs = plist.getCheckedItemPositions()
 local rs = {}
 for n = 1, #ps do
  if cs.get(n - 1) then
   table.insert(rs, ps[n])
  end
 end
 local thm = tss[tlist.getSelectedItemPosition() + 1]
 local ss = string.format(template, appname.getText(), appver.getText(), appcode.getText(), appsdk.getText(), packagename.getText(), thm, app_key.getText(), app_channel.getText(), developer.getText(), description.getText(), debugmode.isChecked(), dump(rs))
 local f = io.open(luaproject, "w")
 f:write(ss)
 f:close()
 Toast.makeText(activity, "已保存.", Toast.LENGTH_SHORT).show()
 activity.result({ appname.getText() })
end

lastclick = os.time() - 2
function onKeyDown(e)
 local now = os.time()
 if e == 4 then
  if now - lastclick > 2 then
   Toast.makeText(activity, "再按一次返回.", Toast.LENGTH_SHORT).show()
   lastclick = now
   return true
  end
 end
end
