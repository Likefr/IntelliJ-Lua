require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "java.io.File"
import "IntelliJ"
import "android.content.Intent"
import "android.content.Context"
import 'android.graphics.Typeface'
import "android.content.pm.PackageManager"
import "android.graphics.drawable.ColorDrawable"




if this.getSharedData(activity.getString(R.string.night)) == "true" then
  activity.setTheme(android.R.style.Theme_DeviceDefault_DialogWhenLarge_NoActionBar)
  Bar=0xFF2C303B;
  background=0xFF2C303B;--夜间背景。
  backgroundB=0xff1890ff;--按压颜色
  elevation="8dp"--阴影
  ColorFilter=0x90ffffff
  wbColor="#90ffffff"--夜间字体颜色
  filter="#44000000"--图片渲染
else
  Bar=0xFFF9F9F9
  background=0xFFF9F9F9;
  backgroundB=0xffff8080;
  ColorFilter=0xFF2C303B
  filter="#38FFFFFF"
  elevation="6dp"
  wbColor="#ff495057"
end

if this.getSharedData("显示状态栏") == "true" then
  if Build.VERSION.SDK_INT >= 21 then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(Bar);
  end
  import "android.view.WindowManager"
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
else
  if Build.VERSION.SDK_INT >= 21 then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(Bar);
  end
  --设置全屏隐藏状态栏
  import "android.view.WindowManager"
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
end

if this.getSharedData(activity.getString(R.string.FullSc)) == "true" and this.getSharedData(activity.getString(R.string.night)) ~= "true"then
  --activity.*setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar_Fullscreen)
  -- activity.ActionBar.hide()
  window = activity.getWindow();
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
  window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  xpcall(function()
    lp = window.getAttributes();
    lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
    window.setAttributes(lp);
  end, function(e)end)
else
  --activity.ActionBar.hide()
end

if this.getSharedData("Activity动画") == "true" then
  activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
      else
end
if this.getSharedData("屏幕常亮") == "true" then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
end



title,StartPath,filterTypes=...
ProgressBarMargin=utf8.len(title)*5 .."dp"
FULL()
RippleBoundary="50dp"
RippleRange=tostring(tonumber(RippleBoundary:match("%d%d"))+10).."dp"
RippleAngle=tostring(tonumber(RippleBoundary:match("%d%d"))/2).."dp"
MainColor=background--主色
SecondaryColor=0x00000000--辅助色
TextColor=0xFFFFFFFF--文本色
IconColor=0x00000000

sdk=Build.VERSION.SDK_INT
if sdk >= 19 then
  resourceId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android")
  statusHeight= activity.getResources().getDimensionPixelSize(resourceId)
 else
  statusHeight= 0
end

layout={
FrameLayout;
  {
    CardView;
    layout_gravity="bottom|right";
    radius="28dp";
    layout_marginBottom="30dp";
    layout_width="0dp";
    BackgroundColor=SecondaryColor;
    layout_height="56dp";
    CardElevation="4dp";
    layout_marginRight="15dp";
    {
      LinearLayout;
      style="?android:attr/buttonBarButtonStyle";
      layout_gravity="center";
      layout_width="74dp";
      layout_height="74dp";
      id="refresh",
    };
  };
  {
    LinearLayout;
    layout_width="fill";
    orientation="vertical";
    layout_height="fill";
    Focusable=true;
    FocusableInTouchMode=true;
    Background=Background,
    id="home",
    {
      FrameLayout;
      layout_width="fill";
      id="ActionBar";
      layout_height="80dp";
      BackgroundColor=MainColor,
 {
    LinearLayout;
    layout_width="100%w";
    layout_height="fill";
     layout_gravity="center",
       {
              LinearLayout;
              layout_height="27dp";
              layout_gravity="left|center";
                  layout_marginLeft="20dp" ,
              layout_width="10%w";
            onClick=function()
     activity.finish()
        end;
                {
                  ImageView,
                  layout_height="27dp",
                  layout_width="27dp",
                  ColorFilter=ColorFilter,
                  background="res/left.png",
          };
    },
          {TextView,
            id="subTitle",
            text=path;
              layout_width="80%w",
            textSize="18dp";
            gravity="center";
            layout_gravity="center";
            textColor=wbColor;
          };
            {
              LinearLayout;
              layout_height="27dp";
              layout_gravity="right|center";
              id="menu";
              layout_marginLeft="-20dp",
              layout_width="10%w";
              {
                ImageView;
                ColorFilter=ColorFilter,
                layout_width="27dp";
                src="res/twotone_more_vert_black_24dp.png";
                layout_height="27dp";
              };
            };
          },
             {ProgressBar;
            id="pb";
            style="?android:attr/progressBarStyleSmallTitle";
            layout_marginRight=ProgressBarMargin;
           layout_gravity="center|bottom";
            Visibility=View.INVISIBLE;
          };
  };

      {ListView;
        id="listview";
        layout_width="fill";
        Divider=ColorDrawable(0);
    };
  };
};

activity.setContentView(loadlayout(layout))

if sdk >= 21 then
  import "android.graphics.PorterDuffColorFilter"
  import "android.graphics.PorterDuff"
  pb.getIndeterminateDrawable().setColorFilter(PorterDuffColorFilter(SecondaryColor,PorterDuff.Mode.SRC_ATOP))
end

if sdk >= 21 then
    ActionBar.setElevation(15)
end

if sdk>= 19 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end


ItemLayout={
  LinearLayout;
  orientation="vertical";
  layout_width="fill";
  {
    CardView;
    CardElevation=0;
    layout_width="fill";
    layout_margin="5dp";
    layout_height="70dp";
    BackgroundColor=0;
    id="cv";
    {
      ImageView;
      layout_marginRight="150dp";
      layout_width="40dp";
      layout_gravity="center";
      layout_height="40dp";
      id="icon";
    };
    {
      TextView;
      id="name";
      Typeface=Typeface.defaultFromStyle(Typeface.BOLD),
      layout_marginBottom="15dp";
      layout_width="200dp";
      textSize="15dp";
      layout_gravity="center";
      singleLine=true;
      ellipsize="end";
    };
    {
      TextView;
      id="hint";
      layout_marginTop="10dp";
      layout_width="200dp";
      text="lasttime";
      layout_gravity="center";
      singleLine=true;
      ellipsize="end";
    };
  };
};


function ToColor(path,color)
  import "android.graphics.drawable.BitmapDrawable"
  import "android.graphics.PorterDuffColorFilter"
  import "android.graphics.PorterDuff"
  import "android.graphics.PorterDuff$Mode"
  local aa=BitmapDrawable(loadbitmap(tostring(path)))
  aa.setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP)) --渲染图标颜色
  return aa
end

--Dr
function loadList(path)
  data={}
  path=tostring(path)
  adp=LuaAdapter(activity,data,ItemLayout)
  if t==nil then
    t=thread(loadAdapter,path,adp)
  end
end


LuaDir=activity.LuaDir
ImagePath=LuaDir.."/res/FileTypeIcons/"
IconColor=SecondaryColor
IconTable={
  MusicIcon=ToColor(ImagePath.."ic_mp3.png",IconColor),
  ApkIcon=ToColor(ImagePath.."ic_apk.png",IconColor),
  FolderIcon=ToColor(ImagePath.."ic_folder.png",IconColor),
  FileIcon=ToColor(ImagePath.."ic_file.png",IconColor),
  ImageIcon=ToColor(ImagePath.."ic_pic.png",IconColor),
  PdfIcon=ToColor(ImagePath.."ic_pdf.png",IconColor),
  TextIcon=ToColor(ImagePath.."ic_txt.png",IconColor),
  VideoIcon=ToColor(ImagePath.."ic_video.png",IconColor),
  XmlIcon=ToColor(ImagePath.."ic_xml.png",IconColor),
  AlpIcon=ImagePath.."ic_alp.png",
}


pop=PopupMenu(activity,menu) menu2=pop.Menu

menu2.add("备份目录").onMenuItemClick=function(a)
  loadList("/storage/emulated/0/IntelliJ Lua/backup/")
end

menu2.add("qq目录").onMenuItemClick=function(a)
  loadList("/storage/emulated/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/")
end

function menu.onClick()
  pop.show()
end

FileTypesTable={
  MusicTypes={".mp3",".flac",".m4a",".mod"},
  CompressionTypes={".zip",".rar",".jar",".alp"},
  PictureTypes={".png",".jpg",".jpeg"},
  TextTypes={".conf",".txt",".text",".html",".ini",".rtf",".log",".sh",".rc"},
  VideoTypes={".mp4",".rmvb",".avi",".mkv"},
}
function SetList(adp)
  listview.Adapter=adp
end

function SetStart(path)
  pb.setProgress(0)
  pb.setVisibility(0)
  if path==tostring(subTitle.Text) then
    sel=listview.getFirstVisiblePosition()
   else
    sel=0
  end
end
function SetEnd(path)
  pb.setVisibility(8)
  listview.setSelection(sel)
  subTitle.setText(path)
  adp=nil
  t=nil
end

function loadAdapter(path,adp)
  require"import"
  IconTable=luajava.astable(activity.get("IconTable"))
  FileTypesTable=luajava.astable(activity.get("FileTypesTable"))
  FilterTypes=luajava.astable(activity.get("filterTypes"))
  call("SetStart",path)
  function GetFilelastTime(path)
    import "java.util.Calendar"
    f = File(path);
    cal = Calendar.getInstance();
    time = f.lastModified()
    cal.setTimeInMillis(time);
    return cal.getTime().toLocaleString()
  end
  function rotateToFit(bm,degrees)
    import "android.graphics.Matrix"
    import "android.graphics.Bitmap"
    width = bm.getWidth()
    height = bm.getHeight()
    matrix = Matrix()
    matrix.postRotate(2)
    bmResult = Bitmap.createBitmap(bm, 0, 0, width, height, matrix, true)
    return bmResult
  end

  function GetApkIcon(archiveFilePath)
    import "android.content.pm.PackageManager"
    import "android.content.pm.ApplicationInfo"
    pm = activity.getPackageManager()
    info = pm.getPackageArchiveInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
    if info ~= nil then
      appInfo = info.applicationInfo;
      icon = pm.getApplicationIcon(appInfo);--图标
      return icon
     else
      return IconTable.ApkIcon
    end
  end

  function IfType(strings,types)
    if pcall(function()luajava.astable(types)end) then
      types=luajava.astable(types)
    end
    for i,str in ipairs(types) do
      if String(tostring(strings)).endsWith(str) then
        return true
      end
    end
  end

  function run()
    import("java.io.File")
    if path=="/storage/emulated" then
      print"不能再返回.."
      return
      else
      
    Lists=luajava.astable(File(path).listFiles())
    table.sort(Lists,function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
    end)
    if path~="/" then
      adp.add({
        name="../",
        icon=IconTable.FolderIcon,
        hint="返回上级目录"})
      
    
  end
    for i,path in ipairs(Lists) do
      Tpath=tostring(path)
      if path.isDirectory() then
        adp.add({
          name=path.Name,
          icon=IconTable.FolderIcon,
          hint=GetFilelastTime(Tpath)})
       elseif IfType(path.Name,FilterTypes) then
        if IfType(path.Name,{".apk"})==true then
          adp.add({
            name=path.Name,
            icon=GetApkIcon(Tpath),
            hint=GetFilelastTime(Tpath)})

  elseif IfType(path.Name,{".alp"})==true then
          adp.add({
            name=path.Name,
            icon=IconTable.AlpIcon,
            hint=GetFilelastTime(Tpath)})

         elseif IfType(path.Name,{".xml",".Xml",".XML"})==true then
          adp.add({
            name=path.Name,
            icon=IconTable.XmlIcon,
            hint=GetFilelastTime(Tpath)})
         elseif IfType(path.Name,FileTypesTable.VideoTypes)==true then
          adp.add({
            name=path.Name,
            icon=IconTable.VideoIcon,
            hint=GetFilelastTime(Tpath)})
         elseif IfType(path.Name,FileTypesTable.TextTypes)==true then
          adp.add({
            name=path.Name,
            icon=IconTable.TextIcon,
            hint=GetFilelastTime(Tpath)})
         elseif IfType(path.Name,FileTypesTable.PictureTypes)==true then
          if loadbitmap(Tpath)~=nil then
            adp.add({
              name=path.Name,
              icon=rotateToFit(loadbitmap(Tpath),degrees),
              hint=GetFilelastTime(Tpath)})
          end
         else
          adp.add({
            name=path.Name,
            icon=IconTable.FileIcon,
            hint=GetFilelastTime(Tpath)})

        end
end
      end
    end
    call("SetList",adp)
    call("SetEnd",path)
  end
end





listview.onItemClick=function(l,v,p,s)

  if v.Tag.name.Text=="../" then
    loadList(File(subTitle.Text).getParentFile())
   else
    if subTitle.Text~="/" then
      inpath=subTitle.Text.."/"..v.Tag.name.Text
     else
      inpath=subTitle.Text..v.Tag.name.Text
    end
    if File(inpath).isDirectory() then
      loadList(inpath)
     else
      activity.result({inpath})
    end
  end
end


refresh.onClick=function()
  loadList(subTitle.Text)
end





loadList(StartPath)

