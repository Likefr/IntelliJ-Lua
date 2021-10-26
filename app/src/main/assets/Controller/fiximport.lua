require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.myopicmobile.textwarrior.common.*"
import "android.content.*"
import"IntelliJ"

if this.getSharedData(activity.getString(R.string.night)) == "true" then
  activity.setTheme(android.R.style.Theme_Material_Light)
  Bar=0xFF2C303B;
  background=0xFF2C303B;--夜间背景。
  backgroundB=0xff1890ff;--按压颜色
  elevation="8dp"--阴影
  ColorFilter=0x90ffffff
  wbColor=0x90ffffff
else
  activity.setTheme(android.R.style.Theme_Material_Light)
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

classes=require "android"
import "autotheme"
activity.setTheme(autotheme())


--设置ActionBar背景颜色
import "android.graphics.drawable.ColorDrawable"
activity.ActionBar.setBackgroundDrawable(ColorDrawable(background))

--自定义ActionBar标题颜色
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
activity.setTitle('需要导入的类')--设置窗口标题

layout={
  LinearLayout;
  layout_width="fill";
  orientation="vertical";
  backgroundColor=background;
  layout_height="fill";
  {
    ProgressBar;
    layout_width="fill";
    layout_height="30%h";
  };
  {
    TextView;
    textSize="20dp";
    text="分析中...";
    gravity="center";
    layout_width="fill";
    layout_height="100dp";
  };
};

activity.setContentView(loadlayout(layout))


function fiximport(path)
  require "import"
  import "android.app.*"
  import "android.os.*"
  import "android.widget.*"
  import "android.view.*"
  import "com.myopicmobile.textwarrior.common.*"
  
  classes=require "android"
  local searchpath=path:gsub("[^/]+%.lua","?.lua;")..path:gsub("[^/]+%.lua","?.aly;")
  local cache={}
  function checkclass(path,ret)
    if cache[path] then
      return
    end
    cache[path]=true
    local f=io.open(path)
    local str=f:read("a")
    f:close()
    if not str then
      return
      end
    for s,e,t in str:gfind("(import \"[%w%.]+%*\")") do
      --local p=package.searchpath(t,searchpath)
      --print(t,p)
    end
    for s,e,t in str:gfind("import \"([%w%.]+)\"") do
      local p=package.searchpath(t,searchpath)
      if p then
        checkclass(p,ret)
      end
    end
    local lex=LuaLexer(str)
    local buf={}
    local last=nil
    while true do
      local t=lex.advance()
      if not t then
        break
      end
      if last~=LuaTokenTypes.DOT and t==LuaTokenTypes.NAME then
        local text=lex.yytext()
        buf[text]=true
      end
      last=t
    end
    table.sort(buf)

    for k,v in pairs(buf) do
      k="[%.$]"..k.."$"
      for a,b in ipairs(classes) do
        if string.find(b,k) then
          if cache[b]==nil then
            table.insert(ret,b)
            cache[b]=true
          end
        end
      end
    end
  end
  local ret={}
  checkclass(path,ret)

  return String(ret)
end
--path="/storage/emulated/0/AndroLua/draw2.lua"
--path=luajava.luapath
dir,path=...
--path=luajava.luapath
list=ListView(activity)
list.ChoiceMode=ListView.CHOICE_MODE_MULTIPLE;
task(fiximport,path,function(v)
    rs=v
  adp=ArrayListAdapter(activity,android.R.layout.simple_list_item_multiple_choice,v)
  list.Adapter=adp
  activity.setContentView(list)
end)
--Toast.makeText(activity,"正在分析。。。",1000).show()
function onCreateOptionsMenu(menu)
  menu.add("全选").setShowAsAction(1)
  menu.add("复制").setShowAsAction(1)
end

cm=activity.getSystemService(Context.CLIPBOARD_SERVICE)

function onOptionsItemSelected(item)
  if item.Title=="复制" then
    local buf={}

    local cs=list.getCheckedItemPositions()
    local buf={}
    for n=0,#rs-1 do
      if cs.get(n) then
        table.insert(buf,string.format("import \"%s\"",rs[n]))
      end
    end

    local str=table.concat(buf,"\n")
    local cd = ClipData.newPlainText("label", str)
    cm.setPrimaryClip(cd)
    Toast.makeText(activity,"已复制的剪切板",1000).show()
  else
    for n=0,#rs-1 do
      list.setItemChecked(n,not list.isItemChecked(n))
    end
  end
end
