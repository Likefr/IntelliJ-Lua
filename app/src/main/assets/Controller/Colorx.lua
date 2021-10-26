require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import"Toasts"
activity.setTitle("Hello world")
activity.setTheme(android.R.style.Theme_Material_Light)
local layout={
 LinearLayout;
 layout_height="fill";
 id="buj1";
 clipChildren=false;
 orientation="vertical";
 layout_width="fill";
 {
  FrameLayout;
  layout_height="match_parent";
  layout_gravity="bottom|center";
  id="buj2";
  clipChildren=false;
  background="#ffffff";
  layout_width="match_parent";
  {
   ImageView;
   scaleType="centerInside";
   layout_height="135%w";
   id="r1";
   layout_gravity="center";
   background="#ffffffff";
   layout_width="95%w";
  };
  {
   ImageView;
   scaleType="centerInside";
   id="r2";
   layout_gravity="center";
   layout_height="30%w";
   layout_width="30%w";
  };
  {
   LinearLayout;
   gravity="center";
   layout_height="80";
   id="bup";
   background="#FF79BD9A";
   orientation="vertical";
   layout_width="fill";
   {
    TextView;
    gravity="center";
    textColor="#ffffffff";
    text="Rod  取色器";
    textSize="40px";
    layout_height="fill";
    layout_width="fill";
   };
  };

  {
   LinearLayout;
   layout_height="16%w";
   background="#ffffffff";
   layout_width="fill";
   layout_gravity="bottom|center";
   orientation="horizontal";
   elevation="20";
   {
    View;
    layout_height="match_parent";
    background="#FFE3EF";
    layout_width="1dp";
   };
   {
    TextView;
    gravity="center";
    text="0x00000000";
    layout_height="fill";
    layout_width="45%w";
    id="tx1";
    textSize="23sp";
    background="#ffffffff";
    elevation="5";
   };
   {
    View;
    layout_height="match_parent";
    background="#FFE3EF";
    layout_width="1dp";
   };
   {
    CardView;
    radius="24dp";
    elevation="3.5";
    layout_marginLeft="3%w";
    layout_gravity="center";
    {
     Button;
     textColor="#FF97777D";
     text="选择图片";
     id="bu1";
    };
   };
  
   {
    CardView;
    radius="24dp";
    elevation="3.5";
    id="ys";
    layout_marginLeft="3%w";
    layout_gravity="center";
   {
    Button;
    textColor="#FF97777D";
    text="复制";
    id="bu2";
   };
  };
  };
 };
};

activity.setContentView(loadlayout(layout))
activity.ActionBar.hide()

if Build.VERSION.SDK_INT >= 19 then
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end
activity.setRequestedOrientation(4)
bup.post(Runnable({
 run=function()
  $li = bup.getLayoutParams()
  --li.topMargin = 60
  li.height = 0
  bup.setLayoutParams(li)
 end}))

import "android.graphics.drawable.GradientDrawable"
local radiu = 10
local dr = GradientDrawable()
dr.setShape(GradientDrawable.RECTANGLE)
dr.setStroke(5,0xffe0d9ef)
dr.setColor(0xffeed9ee)
dr.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu})
bu1.setBackgroundDrawable(dr)
bu2.setBackgroundDrawable(dr)

import "android.graphics.Color"
function mek_p(xx,nn)
 if xx==nil then xx = 0xff000000 end
 return LuaDrawable(function(c,p,d)
  p.setColor(xx)
  p.setAntiAlias(true)
  p.setStrokeWidth(3)
  p.setStyle(p.Style.STROKE)
  $b = d.bounds
  local w,h = b.right,b.bottom
  --c.rotate(45,w/2,h/2)
  c.drawLines({w-30,h/2,30,h/2,
   w/2,h-30,w/2,30
  },p)
  p.setStrokeWidth(30)
  p.setAlpha(0x66)
  c.drawCircle(w/2,h/2,w/2-15,p)
  p.setStrokeWidth(3)
  p.setAlpha(0xff)
  c.drawCircle(w/2,h/2,w/2-30,p)
  c.drawCircle(w/2,h/2,w/2-2,p)
 end)
end
if r2.isHardwareAccelerated() then
 r2.setLayerType(View.LAYER_TYPE_SOFTWARE,nil)
end
mek_u = mek_p()
r2.backgroundDrawable = mek_u
import "android.content.Intent"
import "android.provider.MediaStore"
bu1.onClick=function()
 local intent = Intent(Intent.ACTION_PICK)
 intent.setType("image/*")
 intent.putExtra("return-data",true)
 cho = Intent.createChooser(intent,"请选择图片")
 this.startActivityForResult(cho,100)
end
import "android.graphics.Rect"
function hy_9k(id)
 id.destroyDrawingCache()
 id.setDrawingCacheEnabled(true)
 id.buildDrawingCache(true)
 return id.getDrawingCache()
end
function tp0(m)
 if m~=nil then
  bu1.setText("重新选图")
  r1.setImageBitmap(loadbitmap(m))
  m1 = m
  r1.post(Runnable({
   run=function()
    lo8 = hy_9k(r1)
   end}))
 end
end
import "java.net.URLDecoder"
function onActivityResult(rq,rs,data)
 if rs==Activity.RESULT_OK and data then
  --$rsv = URLDecoder.decode(tostring(data.getData()),"UTF-8")
  $cu = this.getContentResolver().query(data.getData(),{MediaStore.Images.Media.DATA},nil,nil,nil)
  $co = cu.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
  cu.moveToFirst()
  tp0(cu.getString(co))
  else
  print("取消选择",defaul)
 end
end
import "android.content.Context"
bu2.onClick=function()
 if m1~=nil then
  if 颜色~=nil then
   xpcall(function()
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(颜色)
  print("复制成功",success)
   end,function()
   end)
   else

  end
  else

  
 end
end
function getpp(a)
 local a1,r1,g1,b1 = Color.alpha(a),Color.red(a),Color.green(a),Color.blue(a)
 return (a1<<24|r1<<16|g1<<8|b1)
end

function r2.OnTouchListener(v,e)
 local ljpe = e.getAction()
 switch(ljpe)
  case MotionEvent.ACTION_DOWN
  sx,sy = tointeger(e.getRawX()),tointeger(e.getRawY())
  case MotionEvent.ACTION_MOVE
  local w2,h2 = v.getWidth(),v.getHeight()
  local 上,下,左,右 = r1.getTop(),r1.getBottom(),r1.getLeft(),r1.getRight()
  local t,b,l,r = v.getTop(),v.getBottom(),v.getLeft(),v.getRight()
  local x,y = tointeger(e.getRawX()),tointeger(e.getRawY())
  local dx = x-sx
  local dy = y-sy
  v.layout(l+dx,t+dy,r+dx,b+dy)
  sx,sy = tointeger(e.getRawX()),tointeger(e.getRawY())
  if lo8~=nil and m1~=nil then
   xpcall(function()
    local x2,y2 = tointeger(v.getX())+((w2/2)-左),tointeger(v.getY())+((h2/2)-上)
    local 色 = getpp(lo8.getPixel(x2,y2))
    v.backgroundDrawable = mek_p(色)

    mek_u.setCallback(nil)
    颜色 = "0x"..string.upper(tostring(Integer.toHexString(色)))
    tx1.setText(颜色)
   end,function()
    v.backgroundDrawable = mek_u
    mek_u.setCallback(nil)
   end)
   else
  end
  case MotionEvent.ACTION_UP
  v.postInvalidate()
 end
 return true
end

--淡紫色
function onDestroy()
 if mek_u~=nil then
  mek_u.setCallback(nil)
 end
 collectgarbage("collect")
end