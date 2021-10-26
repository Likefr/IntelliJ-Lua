require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

activity.setTitle("签名")

local buju = {
 LinearLayout;
 orientation="vertical";
 layout_width="fill";
 layout_height="fill";
 {
  RelativeLayout;
  layout_width="fill";
  layout_height="fill";
  {
   LinearLayout;
   layout_centerInParent="true";
   orientation="vertical";
   {
    RelativeLayout;
    layout_width="200dp";
    layout_height="50dp";
    BackgroundColor="0xFFFFFFFF";
    id="选择安装包";
    {
     TextView;
     layout_centerInParent="true";
     Text="选择安装包";
     TextSize="20";
     TextColor="#ff000000";
    };
   };
  };
 };
};

activity.setContentView(loadlayout(buju))

选择安装包.onClick=function()
 import "android.widget.ArrayAdapter"
 import "android.widget.LinearLayout"
 import "android.widget.TextView"
 import "java.io.File"
 import "android.widget.ListView"
 import "android.app.AlertDialog"
 function ChoiceFile(StartPath,callback)
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择文件")
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
   path=tostring(path)
   adp.clear()--清空适配器
   cp.Text=tostring(path)--设置当前路径
   if path~="/" then--不是根目录则加上../
    adp.add("../")
   end
   ls=File(path).listFiles()
   if ls~=nil then
    ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
    table.sort(ls,function(a,b)
     return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
    end)
    else
    ls={}
   end
   for index,c in ipairs(ls) do
    if c.isDirectory() then--如果是文件夹则
     adp.add(c.Name.."/")
     else--如果是文件则
     adp.add(c.Name)
    end
   end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
   项目=tostring(v.Text)
   if tostring(cp.Text)=="/" then
    路径=ls[p+1]
    else
    路径=ls[p]
   end

   if 项目=="../" then
    SetItem(File(cp.Text).getParentFile())
    elseif 路径.isDirectory() then
    SetItem(路径)
    elseif 路径.isFile() then
    callback(tostring(路径))
    ChoiceFile_dialog.hide()
   end

  end

  SetItem(StartPath)
 end
 ChoiceFile("/storage/emulated/0/",function(a)
  if a:find("%.apk") then
   local b = a:match("(.+).apk")
   local c = b.."_Sign.apk"
   compile "sign"
   import "apksigner.*"
   Signer.sign(a,c)
   Toast.makeText(activity,"签名成功！",Toast.LENGTH_SHORT).show()
   else
   Toast.makeText(activity,"请选择APK文件",Toast.LENGTH_SHORT).show()
  end
 end)
end
