require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

import "ViewUtil"
import "ColorUtil"
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
activity.setTitle("取色")


layout={
 LinearLayout,
 orientation="vertical",
 layout_width="fill",
 layout_height="fill",
 backgroundColor=0,
 {
  CardView,
  cardElevation="0dp",
  id="palette_perview",
  layout_width="fill",
  layout_margin="18dp",
  layout_height="182dp",
  radius="6dp",
  layout_marginTop="26dp",
  cardBackgroundColor=0xff000000,
 },
 {
  CardView,
  cardElevation="0dp",
  layout_width="fill",
  layout_margin="18dp",
  layout_height="48dp",
  radius="6dp",
  layout_marginTop="26dp",
  {
   LinearLayout,
   layout_height="fill",
   layout_width="fill",
   id="palette_color_show_root",
   orientation="horizontal",
   {
    Button,
    text="#FF000000",
    gravity="center",
    id="argb_text_hex",
    layout_weight="1",
    --  style=R.style.Widget_MaterialComponents_Button_UnelevatedButton,
   },
   {
    Button,
    id="argb_text_int",
    layout_weight="1",
    text="255,0,0,0",
    gravity="center",
   }
  }
 },
 {
  CardView,
  radius="6dp",
  id="palette_progressbar_root",
  layout_width="fill",
  layout_margin="18dp",
  cardElevation="0dp",
  layout_height="wrap",
  layout_marginTop="26dp",
  {
   LinearLayout,
   layout_marginLeft="8dp",
   layout_width="fill",
   orientation="vertical",
   {
    TextView,
    text="A",
    textSize="15sp",
    layout_margin="8dp",
    layout_marginLeft="10dp",
   } ,
   {
    SeekBar,
    id="argb_a",
    max=255,
    progress=255,
    layout_width="fill",
   },
   {
    TextView,
    text="R",
    textSize="15sp",
    layout_margin="8dp",
    layout_arginLeft="10dp",
   } ,
   {
    SeekBar,
    id="argb_r",
    progress="0",
    max="255",
    layout_width="fill",
   },
   {
    TextView,
    text="G",
    textSize="15sp",
    layout_margin="8dp",
    layout_marginLeft="10dp",
   } ,
   {
    SeekBar,
    id="argb_g",
    progress="0",
    max="255",
    layout_width="fill",
   },
   {
    TextView,
    text="B",
    textSize="15sp",

    layout_margin="8dp",
    layout_marginLeft="10dp",
   } ,
   {
    SeekBar,
    id="argb_b",
    progress="0",
    max="255",
    layout_marginBottom="12dp",
    layout_width="fill",
   }
  }
 }
}
activity.setContentView(loadlayout(layout))



--[[**
 * @Name: palette.lua
 * @Date: 2021-04-19 09:13:58
 * @Description: No special instructions
 *
**]]

ViewUtil.seekBarColor(argb_a,0xFF888888)
ViewUtil.seekBarColor(argb_r,0xFFFF0000)
ViewUtil.seekBarColor(argb_g,0xFF00FF00)
ViewUtil.seekBarColor(argb_b,0xFF0000FF)

argb_a.progress=255

local argb_colors={255,0,0,0}


local function changePaletteCardColor()
 local argb_int=ColorUtil.getArgbIntColor(
 argb_colors[1],argb_colors[2],
 argb_colors[3],argb_colors[4])

 palette_perview.setCardBackgroundColor(argb_int)
 argb_text_int.text=table.concat(argb_colors,",")
 argb_text_hex.text=ColorUtil.formatColorToHex(argb_int)
end


for k,v in pairs({argb_text_int,argb_text_hex}) do
 v.onClick=function(v)
  copyText(v.text)
  ViewUtil.showSnackBar("复制完成")
 end
 ViewUtil.setBaseTypeface(v)
end

for k,v in pairs({argb_a,argb_r,argb_g,argb_b}) do
 ViewUtil.addSeekBarChangeListener(v,function(view,progress)
  argb_colors[k]=progress
  changePaletteCardColor()
 end)
end
