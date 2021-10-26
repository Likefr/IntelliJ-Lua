--[[**
 * @Name: ViewUtil.lua
 * @Date: 2021-04-19 09:36:14
 * @Description: No special instructions
 *
**]]

-- load the "import" module,
-- which is use to import Java class and lua module
require "import"


local _M={}


_M.getViewBitmap=function(view)  
  view.destroyDrawingCache()
  view.setDrawingCacheEnabled(true)
  view.buildDrawingCache()
  return view.getDrawingCache(true)
end

_M.showSnackBar=function(text)
  import "com.google.android.material.snackbar.Snackbar"

  local anchor=activity.getUiManager().getCoordinatorLayout()

  Snackbar.make(anchor,text, Snackbar.LENGTH_LONG)
  .setAnimationMode(Snackbar.ANIMATION_MODE_SLIDE)
  .show();
end

_M.seekBarColor=function(id,color)
 
end

_M.addSeekBarChangeListener=function(id,func)
  id.setOnSeekBarChangeListener {
    onProgressChanged=function(...)
      func(...)
    end
  }
end

_M.dp2px=function(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

_M.postView=function(id,func)
  id.post{run=lambda_:func()}
end

_M.loadImage=function(id,intent)
  Glide.with(activity).load(intent.data).into(id_)
end

_M.setBaseTypeface=function(view)  
  local familyName = "sans-serif-medium";
end

_M.getBaseTypeface=function()  
  local familyName = "sans-serif-medium";
  local normalTypeface = Typeface.create(familyName, Typeface.NORMAL);
  return (normalTypeface)
end


return _M
