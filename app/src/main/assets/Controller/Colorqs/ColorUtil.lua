--[[**
 * @Name: ColorUtil.lua
 * @Date: 2021-04-19 09:43:04
 * @Description: No special instructions
 *
**]]

-- load the "import" module,
-- which is use to import Java class and lua module
require "import"

-- Android base class library
-- if you don't need these, please remove them
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"


local _M={}


_M.getColorByBitmapPixel=function(bitmap,x,y)
 return bitmap.getPixel(x,y)
end

_M.formatColorToHex=function(color)
 local t=string.format("%#x", color<0 and -color or color):gsub("0x","#"):lower()
 if #t<9 then
  local insert=string.rep("F",9-#t)
  t=t:gsub("#","#"..insert)
 end
 return t
end

_M.formatColorToRGB=function(color)
 return table.concat({Color.alpha(color),Color.red(color),Color.green(color),Color.blue(color)},",")
end

_M.getArgbIntColor=function(a,r,g,b)
 return a<<24|r<<16|g<<8|b
end

_M.formatColor=function(t)
 return "#"..t:match("0xFF(.+)")
end

_M.isDarkColor=function(color)

 return (0.299 * Color.red(color) + 0.587 * Color.green(color) + 0.114 * Color.blue(color)) <192
end

return _M


