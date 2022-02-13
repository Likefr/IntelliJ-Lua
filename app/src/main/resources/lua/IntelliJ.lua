require "import"
import "DataBase"
import "Dialog"
import "anoid.app.*"
import "android.os.*"
import "java.lang.*"
import "java.io.File"
import "android.view.*"
import "android.util.*"
cjson = require "cjson"
import "android.widget.*"
import "android.content.*"
import "android.os.Build"
import "android.util.Base64"
import "android.widget.Button"
import "android.os.Environment"
import "android.content.Context"
import "android.graphics.Typeface"
import "android.view.WindowManager"
import "com.Likefr.tencentx5.WebViewX"
import "android.graphics.drawable.*"
import "android.widget.LinearLayout"
import "android.Manifest"
import "android.graphics.PorterDuff"
import "android.content.res.ColorStateList"
import "com.Likefr.Bootstrap.View.*"
import "com.Likefr.LuaJava.utils.*"
import "com.Likefr.Bootstrap.View.font.*"
import "com.Likefr.Bootstrap.View.api.defaults.*"
import "view_mode"
R = luajava.bindClass("com.Likefr.LuaJava.R")
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.drawable.GradientDrawable"
import "com.google.android.material.bottomsheet.BottomSheetDialog"
import "com.google.android.material.bottomsheet.BottomSheetBehavior"
import "Toasts"
path = SELECT("Project_Path", SELECT("User_option", "Value")) or nil

TypefaceProvider.registerDefaultIconSets();--载入icon

function OutText(path, str)
    local file = io.output(path)
    io.write(tostring(str))
    io.flush()
    io.close()
    editConfig.dismiss();
end

function OutStyle(status,url, ad, js, ua)
    Config = [[
  {
  "data":{
  "status":"]] .. status .. [[",
  "url":"]] .. url .. [[",
   "ad":"]] .. ad .. [[",
   "js":"]] .. js .. [[",
   "ua":"]] .. ua .. [["
  }
}
]]
    OutText(path .. project_title .. "/" .. "config.json", Config)
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == '') then
        return false
    end
    local pos, arr = 0, {}
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end--函数结束

function ReturnEditConfig()
    dataModel = {}
    dataModel._TYPE = {
        "status",
        "url",
        "ad",
        "js",
        "ua",
    }
    function dataModel.fromJson(data)
        local _resultData = {}
        for k, v in pairs(dataModel._TYPE) do
            _resultData[v] = data[v]
        end
        return _resultData
    end
    return dataModel;
end

function ReturnConfig()
    if File(activity.getLuaDir() .. "/config.json").exists() then

        dataModel = {}
        dataModel._TYPE = {
            "status",
            "url",
            "ad",
            "js",
            "ua",
        }
        --转换方法
        function dataModel.fromJson(data)
            local _resultData = {}
            for k, v in pairs(dataModel._TYPE) do
                _resultData[v] = data[v]
            end
            return _resultData
        end
        data = io.open(activity.getLuaDir() .. "/config.json"):read("*a")
        data = cjson.decode(data)
        data = dataModel.fromJson(data.data)

        webSettings = webview.getSettings();
        webSettings.setJavaScriptEnabled(true)
        webSettings.setUseWideViewPort(true);
        --webSettings.setLoadWithOverviewMode(true);
        --webSettings.setDomStorageEnabled(true);

        if (data.ua ~= nil) then
            newUserAgent = data.ua
        else
            newUserAgent = ''
           -- newUserAgent = "Mozilla/5.0 (Linux; Android 6.0; NEM-AL10 Build/HONORNEM-AL10; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/63.0.3239.111 Mobile Safari/537.36 lite baiduboxapp/2.7.0.10 (Baidu; P1 6.0)";
        end
        webSettings.setUserAgentString(newUserAgent);
        webSettings.setTextZoom(100)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) then
            webSettings.setMixedContentMode(webSettings.MIXED_CONTENT_COMPATIBILITY_MODE);
            webSettings.setMixedContentMode(webSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        end





function 加载js(id,js)
  if js==nil then
   else
      id.loadUrl("javascript:".."(function() {"..js.."})()")
  end
end


function 屏蔽元素(id,table)
  for i,V in pairs(table) do
    加载js(id,[[document.getElementsByClassName(']]..V..[[')[0].style.display='none';]])
     end
end
        if (data.status == "WebViewX") then
            webview.loadUrl(data.url,data.ad)--加载网页
        else
--状态监听
webview.setWebViewClient{
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    local likefr=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
    if likefr== nil then
     print"请连接网络后重试"
     参数="data:text/html;base64,PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlvbmFsLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5zaXRpb25hbC5kdGQiPg08aHRtbCB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCI+DTxoZWFkPg08bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCIgLz4NPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAsIHVzZXItc2NhbGFibGU9bm8sIG1pbmltdW0tc2NhbGU9MS4wLCBtYXhpbXVtLXNjYWxlPTEuMCIvPjx0aXRsZT7plJnor6/mj5DnpLo8L3RpdGxlPg08c3R5bGUgdHlwZT0idGV4dC9jc3MiPg0KKnsgcGFkZGluZzogMDsgbWFyZ2luOiAwOyB9DQpib2R5eyBiYWNrZ3JvdW5kOiAjZmZmOyBmb250LWZhbWlseTogJ+W+rui9r+mbhem7kSc7IGNvbG9yOiAjMzMzOyBmb250LXNpemU6IDE2cHg7IH0NCi5zeXN0ZW0tbWVzc2FnZXsgcGFkZGluZzogMjRweCA0OHB4OyB9DQouc3lzdGVtLW1lc3NhZ2UgaDF7IGZvbnQtc2l6ZTogMTAwcHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGxpbmUtaGVpZ2h0OiAxMjBweDsgbWFyZ2luLWJvdHRvbTogMTJweDsgfQ0KLnN5c3RlbS1tZXNzYWdlIC5qdW1weyBwYWRkaW5nLXRvcDogMTBweH0NCi5zeXN0ZW0tbWVzc2FnZSAuc3VjY2Vzcywuc3lzdGVtLW1lc3NhZ2UgLmVycm9yeyBsaW5lLWhlaWdodDogMS44ZW07IGZvbnQtc2l6ZTogMzZweCB9DQo8L3N0eWxlPg08L2hlYWQ+DTxib2R5Pg08ZGl2IGNsYXNzPSJzeXN0ZW0tbWVzc2FnZSI+DTxoMT46KDwvaDE+DTxwIGNsYXNzPSJlcnJvciI+572R57uc6L+e5o6l5byC5bi4PC9wPjxwIGNsYXNzPSJkZXRhaWwiPjwvcD4NPHAgY2xhc3M9Imp1bXAiPg3ml6Dms5Xov57mjqXliLDmnI3liqHlmajvvIzor7fmo4Dmn6XmgqjnmoTnvZHnu5zov57mjqUNPC9kaXY+DTwvYm9keT4NPC9odG1sPg=="
     webview.loadUrl(参数)
    end

  end,
  onPageStarted=function(view,url,favicon)
    --网页加载
   屏蔽元素(webview,{data.ad})
  end,
  onPageFinished=function(view,url)
    --网页加载完成
      屏蔽元素(webview,{data.ad})
  end}



                webview.loadUrl(data.url)--加载网页
        end

        return data;
    else
        return "该工程没有config文件"
    end
end
--[[import "android.graphics.drawable.GradientDrawable"
function print(内容, 内容色, 背景色, 位置, x偏移量, y偏移量)

  local toast = luajava.bindClass("android.widget.Toast")
  toast.makeText(activity, tostring(背景色), toast.LENGTH_SHORT).show()
 if this.getSharedData("原生Toast") == "true" then
  local toast = luajava.bindClass("android.widget.Toast")
  toast.makeText(activity, tostring(内容), toast.LENGTH_SHORT).show()
  else
  local toast = luajava.bindClass("android.widget.Toast")
  toast = toast.makeText(activity, tostring(内容), toast.LENGTH_SHORT)
  位置 = Gravity.BOTTOM
  if 内容色 == nil then
   内容色 = 0xffffffff
  end
  if 背景色 == nil then
   背景色 = 0xFF66A9ED
  end
  if 内容 == nil then
   内容 = "消息内容"
  end
  if x偏移量 == nil then
   x偏移量 = 0
  end
  if y偏移量 == nil then
   y偏移量 = 200
  end
  if 位置 == nil then
   位置 = 底部
  end
  --   local toast=Toast.makeText(activity,"", 时长)
  toast.setView(loadlayout({
   LinearLayout,
   layout_width = "wrap",
   id = "kk";
   gravity = "center",
   BackgroundColor = "",
   orientation = "horizontal",
   {
    CardView;
    radius = "24dp";
    elevation = 0;
    cardBackgroundColor = 背景色;
    layout_marginTop = "12dp";
    layout_marginBottom = "10dp";
    layout_gravity = "center";
    {
     TextView,
     text = tostring(内容),
     layout_height = "fill",
     textColor = 内容色,
     layout_margin = "3%w",
     layout_width = "wrap",
     layout_gravity = "center",
     gravity = "center",
    },
   };
  }))
  toast.setGravity(位置, 0, 100);
  toast.show()
 end
end]]

function export(pdir)
    require "import"
    import "java.util.zip.*"
    import "java.io.*"
    local function copy(input, output)
        local b = byte[2 ^ 16]
        local l = input.read(b)
        while l > 1 do
            output.write(b, 0, l)
            l = input.read(b)
        end
        input.close()
    end

    local f = File(pdir)
    local date = os.date("%y%m%d%H%M%S")
    local tmp = "/storage/emulated/0/IntelliJ Lua/backup" .. "/" .. f.Name .. "_" .. date .. ".alp"
    local p = {}
    local e, s = pcall(loadfile(f.Path .. "/init.lua", "bt", p))
    if e then
        if p.mode then
            tmp = string.format("%s/%s_%s_%s-%s.%s", "/storage/emulated/0/IntelliJ Lua/backup", p.appname, p.mode, p.appver:gsub("%.", "_"), date, p.ext or "alp")
        else
            tmp = string.format("%s/%s_%s-%s.%s", "/storage/emulated/0/IntelliJ Lua/backup", p.appname, p.appver:gsub("%.", "_"), date, p.ext or "alp")
        end
    end
    local out = ZipOutputStream(FileOutputStream(tmp))
    local using = {}
    local using_tmp = {}
    function addDir(out, dir, f)
        local ls = f.listFiles()
        --entry=ZipEntry(dir)
        --out.putNextEntry(entry)
        for n = 0, #ls - 1 do
            local name = ls[n].getName()
            if name:find("%.apk$") or name:find("%.luac$") or name:find("^%.") then
            elseif p.mode and name:find("%.lua$") and name ~= "init.lua" then
                local ff = io.open(ls[n].Path)
                local ss = ff:read("a")
                ff:close()
                for u in ss:gmatch([[require *%b""]]) do
                    if using_tmp[u] == nil then
                        table.insert(using, u)
                        using_tmp[u] = true
                    end
                end
                local path, err = console.build(ls[n].Path)
                if path then
                    entry = ZipEntry(dir .. name)
                    out.putNextEntry(entry)
                    copy(FileInputStream(File(path)), out)
                    os.remove(path)
                else
                    error(err)
                end
            elseif p.mode and name:find("%.aly$") then
                name = name:gsub("aly$", "lua")
                local path, err = console.build_aly(ls[n].Path)
                if path then
                    entry = ZipEntry(dir .. name)
                    out.putNextEntry(entry)
                    copy(FileInputStream(File(path)), out)
                    os.remove(path)
                else
                    error(err)
                end
            elseif ls[n].isDirectory() then
                addDir(out, dir .. name .. "/", ls[n])
            else
                entry = ZipEntry(dir .. name)
                out.putNextEntry(entry)
                copy(FileInputStream(ls[n]), out)
            end
        end
    end

    addDir(out, "", f)
    local ff = io.open(f.Path .. "/.using", "w")
    ff:write(table.concat(using, "\n"))
    ff:close()
    entry = ZipEntry(".using")
    out.putNextEntry(entry)
    copy(FileInputStream(f.Path .. "/.using"), out)

    out.closeEntry()
    out.close()
    return tmp
end

import "android.Manifest"
import "android.content.pm.PackageManager"
function 权限(ass)
    if Build.VERSION.SDK_INT >= 23 then
        local clazz = Class.forName("android.content.Context")
        local method = clazz.getMethod("checkSelfPermission", Class.forName("java.lang.String"))
        if method.invoke(this, { ass }) == PackageManager.PERMISSION_GRANTED then
            return true
        else
            return false
        end
    else
        if this.getPackageManager().checkPermission(ass, this.getPackageName()) == PackageManager.PERMISSION_GRANTED then
            return true
        end
    end
    return false
end

function choicePath()
    --搓一丝怕死
    Project_PathS({
        标题 = "请选择工程目录",
        对话框id = "ssk",
        idea = function()
            ChoosePath.setVisibility(View.GONE)
            importProject.setVisibility(View.VISIBLE)
            INSERT("Project_Path", "IntelliJ Lua", activity.getString(R.string.DefaultPath))
            INSERT("User_option", "Value", "IntelliJ Lua")
            idea.setBackgroundColor(backgroundB)
            andlua.setBackgroundColor(background)
            androlua.setBackgroundColor(background)
            task(200, function()
                path = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
                ssk.dismiss()
                projectRefresh()
            end)
        end,
        andlua = function()

            ChoosePath.setVisibility(View.GONE)
            importProject.setVisibility(View.VISIBLE)
            INSERT("Project_Path", "AndLua", activity.getString(R.string.AndLuaPath))
            INSERT("User_option", "Value", "AndLua")
            idea.setBackgroundColor(background)
            andlua.setBackgroundColor(backgroundB)
            androlua.setBackgroundColor(background)
            task(200, function()
                path = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
                ssk.dismiss()
                projectRefresh()
            end)
        end,
        androlua = function()

            ChoosePath.setVisibility(View.GONE)
            importProject.setVisibility(View.VISIBLE)
            INSERT("Project_Path", "Androlua", activity.getString(R.string.AndroLuaPath))
            INSERT("User_option", "Value", "Androlua")
            idea.setBackgroundColor(background)
            andlua.setBackgroundColor(background)
            androlua.setBackgroundColor(backgroundB)
            task(100, function()
                path = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
                ssk.dismiss()
                projectRefresh()
            end)
        end,
        editPath = function()
            if editPath.Text == "" or editPath.Text == nil then
                editPath.setText("请输入路径！")
            elseif editPath.Text == "请输入路径！" then
                Toast.makeText(activity, "请输入路径", Toast.LENGTH_SHORT).show()
            elseif string.find(tostring(editPath.Text), "project") == 1 or
                    string.find(tostring(editPath.Text), "project/") == 1 then
                INSERT("Project_Path", "editPath", tostring(editPath.Text))
                INSERT("User_option", "Value", "editPath")
                task(200, function()
                    path = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
                    ssk.dismiss()
                    projectRefresh()
                    ChoosePath.setVisibility(View.GONE)
                    importProject.setVisibility(View.VISIBLE)
                end)
            elseif string.find(tostring(editPath.Text), "project") == nil or string.find(tostring(editPath.Text), "project/") == nil then
                print("请输入正确格式！")
                ssk.dismiss()
            end
        end,
    })


    --TODO判断是否获取了权限
    --需要申请的权限(权限组)
    permissions = { Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.ACCESS_NETWORK_STATE,
                    Manifest.permission.READ_PHONE_STATE,
                    Manifest.permission.WRITE_SETTINGS,
    }
    --新建PermissionHelper
    ph = PermissionHelper()
    ph.request(activity, permissions, function(state)
        --state为boolean值
    end)

    --Activity申请权限回调
    function onRequestPermissionsResult(code, permissions, results)
        --调用PermissionHelper中方法检测是否申请了所有权限
        ph.onRequestPermissionsResult(code, permissions, results)
    end
end

function CircleButton(view, InsideColor, radiu)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({ radiu, radiu, radiu, radiu, 0, 0, 0, 0 });
    view.setBackgroundDrawable(drawable)
end

function write(path, str)
    local sw = io.open(path, "wb")
    if sw then
        sw:write(str)
        sw:close()
    else
        Toast.makeText(activity, "." .. path .. project_title .. "/" .. sub_title.Text, Toast.LENGTH_SHORT).show()
    end
    return str
end

function save()
    --已经废弃 已使用编辑器save
    local str = ""
    local f = io.open(path .. project_title .. "/" .. sub_title.Text, "r")
    if f then
        str = f:read("*all")
        f:close()
    end
    local src = tostring(editor.Text)
    if src ~= str then
        write(path .. project_title .. "/" .. sub_title.Text, src)
    end
    return src
end

function ToolbarDrawer(id)
    id.setDrawerListener(DrawerLayout.DrawerListener {
        onDrawerSlide = function(v, i)
            all.Rotation = i * 180
            a.Rotation = i * 40
            c.Rotation = -i * 40
            a.scaleX = (1 - i / 4)
            c.scaleX = (1 - i / 4)
            b.scaleX = (1 - i / 5)
            b.setTranslationX(-i * 12)
            a.setTranslationY(i * 4.2)
            c.setTranslationY(-i * 4.2)
        end })
end

function GetFileSize(path)
    import "java.io.File"
    import "android.text.format.Formatter"
    if path:find("init.lua") ~= nil then
        Sizes = "配置文件"
    elseif path:find("main.lua") ~= nil then
        Sizes = "主入口文件"

    else
        size = File(tostring(path)).length()
        Sizes = Formatter.formatFileSize(activity, size)
    end
    return Sizes
end

function setFilter(id)
    id.setFilter(function(t, b, c)
        for i, v in ipairs(t) do
            if tostring(v.project_title):find(tostring(c), 0, true) then
                b[#b + 1] = v
            end
        end
    end)
end

--调用系统文件选择
function ChooseFile(type, Callback)
    intent = Intent(Intent.ACTION_GET_CONTENT)
    intent.setType(type);
    intent.addCategory(Intent.CATEGORY_OPENABLE)
    activity.startActivityForResult(intent, 1);
    function onActivityResult(requestCode, resultCode, data)
        if resultCode == Activity.RESULT_OK then
            local uri = data.getData()
            import "com.library.Module"--导入模块
            Callback(Module.UriToFilePath(this, uri))
        end
    end
end

function dp2px(dpValue)
    local scale = activity.getResources().getDisplayMetrics().scaledDensity
    return dpValue * scale + 0.5
end

function px2dp(pxValue)
    local scale = activity.getResources().getDisplayMetrics().scaledDensity
    return pxValue / scale + 0.5
end

function px2sp(pxValue)
    local scale = activity.getResources().getDisplayMetrics().scaledDensity;
    return pxValue / scale + 0.5
end

function sp2px(spValue)
    local scale = activity.getResources().getDisplayMetrics().scaledDensity
    return spValue * scale + 0.5
end

function GetFileSizesc(path)
    import "java.io.File"
    import "android.text.format.Formatter"
    size = File(tostring(path)).length()
    Sizes = Formatter.formatFileSize(activity, size)
    return Sizes
end

function loadFileList(path)


    FileSizePath = SELECT("Project_Path", SELECT("User_option", "Value"))--全局加载目录
    file_adp.clear()
    ls = File(path).listFiles()
    if ls ~= nil then
        ls = luajava.astable(File(path).listFiles())
        table.sort(ls, function(a, b)
            return (a.isDirectory() ~= b.isDirectory() and a.isDirectory()) or ((a.isDirectory() == b.isDirectory()) and a.Name < b.Name)
        end)
    else
        ls = {}
    end

    file_adp.add { __type = 1,
                   icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_add.png"),
                   title = "新建文件/文件夹",
                   count = "",
                   typesOf = "新建文件/文件夹",
    }

    if projectOpenPath.Text:find("/") ~= nil then
        file_adp.add { __type = 1,
                       icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_folder.png"),
                       title = "..",
                       typesOf = projectOpenPath.Text,
        }
    end
    for index, c in ipairs(ls) do
        if c.isDirectory() then
            file_adp.add { __type = 1,
                           icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_folder.png"),
                           title = c.Name,
                           typesOf = "文件夹",
            }
        end
        --图i
        if c.isFile() then

            if c.Name:find("%.mp3") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_mp3.png"),
                               title = c.Name,
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.png$") then
                file_adp.add { __type = 1,
                               icon = path .. "/" .. c.Name,
                               title = c.Name,
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.mp4$") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_video.png"),
                               title = c.Name,
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.txt") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_txt.png"),
                               title = c.Name,
                               count = Hei().getCount(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.json") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_json.png"),
                               title = c.Name,
                               count = Hei().getCount(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.jpg") then
                file_adp.add { __type = 1,
                               icon = path .. "/" .. c.Name;
                               title = c.Name,
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.lua") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_lua.png"),
                               title = c.Name,
                               count = Hei().getCount(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            elseif c.Name:find("%.aly") then
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_aly.png"),
                               title = c.Name,
                               count = Hei().getCount(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }
            else
                file_adp.add { __type = 1,
                               icon = activity.getLuaDir("/Controller/res/FileTypeIcons/ic_file.png"),
                               title = c.Name,
                               count = "",
                               typesOf = GetFileSize(FileSizePath .. project_title .. projectOpenPath.Text .. "/" .. c.Name),
                }


                --[[不高亮
                    if c.Name:find("%.mp3") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_mp3.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.png$") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_pic.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.mp4$") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_video.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.txt") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_txt.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.json") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_json.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.jpg") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_pic.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.lua") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_lua.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     elseif c.Name:find("%.aly") then
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_aly.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                     else
                      file_adp.add{__type=2,
                        icon=activity.getLuaDir("/Controller/res/FileTypeIcons/ic_file.png"),
                        title=c.Name,
                        typesOf=GetFileSize(FileSizePath..project_title..projectOpenPath.Text.."/"..c.Name),
                      }
                    end]]
            end
        end
    end
end

function check(b)
    local src = editor.getText()
    src = src.toString()
    if luapath:find("%.aly$") then
        src = "return " .. src
    end
    local _, data = loadstring(src)

    if data then
        local _, _, line, data = data:find(".(%d+).(.+)")
        editor.gotoLine(tonumber(line))
        Toast.makeText(activity, line .. ":" .. data, Toast.LENGTH_SHORT).show()
        return true
    elseif b then
    else
        Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT).show()
    end
end

function click(v)
    if v.Text == "←" then
        editor.setSelection(editor.getSelectionStart() - 1)
    elseif v.Text == "→" then
        editor.setSelection(editor.getSelectionStart() + 1)
    elseif v.Text == "Fun" then
        editor.paste("function")
    else
        editor.paste(v.Text)
    end
end

function 转0x(j)
    if #j == 7 then
        jj = j:match("#(.+)")
        jjj = tonumber("0xff" .. jj)
    else
        jj = j:match("#(.+)")
        jjj = tonumber("0x" .. jj)
    end
    return jjj
end

function 图标(n)
    return "res/twotone_" .. n .. "_black_24dp.png"
end

function 通知图库更新图片(图片路径)
    import "android.media.MediaScannerConnection"
    MediaScannerConnection.scanFile(activity, { File(图片路径).getAbsolutePath() }, nil, nil)
end

function 取出中文文本(s)
    local ss = {}
    for k = 1, #s do
        local c = string.byte(s, k)
        if not c then
            break
        end
        if (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122) then
            if not string.char(c):find("%w") then
                table.insert(ss, string.char(c))
            end
        elseif c >= 228 and c <= 233 then
            local c1 = string.byte(s, k + 1)
            local c2 = string.byte(s, k + 2)
            if c1 and c2 then
                local a1, a2, a3, a4 = 128, 191, 128, 191
                if c == 228 then
                    a1 = 184
                elseif c == 233 then
                    a2, a4 = 190, c1 ~= 190 and 191 or 165
                end
                if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
                    k = k + 2
                    table.insert(ss, string.char(c, c1, c2))
                end
            end
        end
    end
    return table.concat(ss)
end

function 悬浮按钮(ID, 父布局, 图片, 颜色, 边距, 事件)
    布局 = {
        RelativeLayout;
        layout_height = "match_parent";
        layout_width = "match_parent";
        {
            CardView;
            layout_alignParentBottom = "true";
            layout_width = "56dp";
            layout_height = "56dp";
            backgroundColor = 颜色;
            layout_alignParentRight = "true";
            layout_margin = 边距;
            CardElevation = "4dp";
            radius = "28dp";
            id = ID;
            {
                LinearLayout;
                layout_width = "74dp";
                layout_height = "74dp";
                style = "?android:attr/buttonBarButtonStyle";
                id = "button";
                layout_gravity = "center";
                onClick = 事件;
                {
                    ImageView;
                    layout_width = "25dp";
                    layout_height = "25dp";
                    src = 图片;
                    layout_gravity = "center";
                    colorFilter = filter;
                };
            };
        };
    };
    父布局.addView(loadlayout(布局))
end

function 悬浮窗权限()
    local object = activity.getSystemService(Context.APP_OPS_SERVICE)
    if object == nil then
        return false
    else
        local method = object.getClass().getMethod("checkOp", Class { Integer.TYPE, Integer.TYPE, String })
        if method == nil then
            return false
        else
            local arra1 = Object { 24, Binder.getCallingUid(), activity.getPackageName() }
            return method.invoke(object, arra1) == AppOpsManager.MODE_ALLOWED
        end
    end
    return false
end
function 禁止截屏()
    this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE)
end

function 打开输入法(view)
    --参数是编辑框控件的ID
    import "android.widget.*"
    import "android.view.*"
    import "android.content.*"
    import "android.view.inputmethod.InputMethodManager"
    im = view.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
    im.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
    --以下是设置焦点到编辑框
    local btn = view
    btn.setFocusable(true);
    btn.setFocusableInTouchMode(true);
    btn.requestFocus();
    btn.requestFocusFromTouch();
end

function 是否包含(包含, 被包含)
    if string.find(包含, 被包含) == nil then
        return false
    else
        return true
    end
end

function 字体(t)
    return Typeface.createFromFile(File(activity.getLuaDir() .. "/res/" .. t .. ".ttf"))
end

function dp2px(dpValue)
    local scale = activity.getResources().getDisplayMetrics().scaledDensity
    return dpValue * scale + 0.5
end

function 浏览器打开网页(url)
    import "android.content.Intent"
    import "android.net.Uri"
    viewIntent = Intent("android.intent.action.VIEW", Uri.parse(url))
    activity.startActivity(viewIntent)
end

function 获取软件版本(包名)
    import "android.content.pm.PackageManager"
    local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName
    return 版本号
end

function 颜色字体(文本, 颜色)
    import "android.text.SpannableString"
    import "android.text.style.ForegroundColorSpan"
    import "android.text.Spannable"
    local sp = SpannableString(文本)
    sp.setSpan(ForegroundColorSpan(颜色), 0, #sp, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
    return sp
end

function 获取控件图片(view)
    import "android.graphics.Bitmap"
    local linearParams = view.getLayoutParams()
    local vw = linearParams.width
    local linearParams = view.getLayoutParams()
    local vh = linearParams.height
    view.setDrawingCacheEnabled(true)
    view.layout(0, 0, vw, vh)
    return Bitmap.createBitmap(view.getDrawingCache())
end

function 光标颜色(id, 颜色)
    import "android.graphics.*"
    local mEditorField = TextView.getDeclaredField("mEditor")
    mEditorField.setAccessible(true)
    local mEditor = mEditorField.get(id)
    local field = Editor.getDeclaredField("mCursorDrawable")
    field.setAccessible(true)
    local mCursorDrawable = field.get(mEditor)
    local mccdf = TextView.getDeclaredField("mCursorDrawableRes")
    mccdf.setAccessible(true)
    local mccd = activity.getResources().getDrawable(mccdf.getInt(id))
    mccd.setColorFilter(PorterDuffColorFilter(颜色, PorterDuff.Mode.SRC_Adecompression))
    mCursorDrawable[0] = mccd
    mCursorDrawable[1] = mccd
end

function 写指定行(路径, 内容, 行, 模式)
    import "java.io.*"
    file, err = io.open(路径)
    if err == nil then
        a = {}
        n = 0
        for v, s in io.lines(路径) do
            n = n + 1
            table.insert(a, v)
        end
        if 模式 == 0 then
            table.remove(a, 行)
            table.insert(a, 行, 内容)
        elseif 模式 == 1 then
            内容 = a[行] .. 内容
            table.remove(a, 行)
            table.insert(a, 行, 内容)
        else
            print("无效操作")
            return true
        end
        内容 = ""
        for v, c in pairs(a) do
            if n == v then
                内容 = 内容 .. c
            else
                内容 = 内容 .. c .. "\n"
            end
        end
        import "java.io.File"
        f = File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
        io.open(tostring(路径), "w"):write(tostring(内容)):close()
    else
        print("文件不存在")
    end
end

function 开关颜色(id, 颜色)
    id.ThumbDrawable.setColorFilter(PorterDuffColorFilter(颜色, PorterDuff.Mode.SRC_ATOP));
    id.TrackDrawable.setColorFilter(PorterDuffColorFilter(颜色, PorterDuff.Mode.SRC_ATOP))
end

function 拖动条颜色(id, 颜色)
    id.ProgressDrawable.setColorFilter(PorterDuffColorFilter(颜色, PorterDuff.Mode.SRC_ATOP))
    --修改SeekBar滑块颜色
    id.Thumb.setColorFilter(PorterDuffColorFilter(颜色, PorterDuff.Mode.SRC_ATOP))
end

function 读文件内容(路径)
    return io.open(路径):read("*a")
end

function 内置存储路径()
    return Environment.getExternalStorageDirectory().toString()
end

function 创建文件(a)
    import "java.io.File"
    return File(a).createNewFile()
end

function 创建文件夹(a)
    import "java.io.File"
    return File(a).mkdir()
end

function 创建多级文件夹(a)
    import "java.io.File"
    return File(a).mkdirs()
end

function copyFunc(destFilePath, sourceFilePath)
    local sourceFile, errorString = io.open(sourceFilePath, "rb")
    assert(sourceFile ~= nil, errorString)
    local data = sourceFile:read("a")
    sourceFile:close()
    local destFile = io.open(destFilePath, "wb")
    destFile:write(data)
    destFile:close()
end

function 文件是否存在(id)
    import "java.io.File"
    return File(id).exists()
end

主题色 = 0xFF2196F3

function 本地所有图片()
    import "android.provider.MediaStore"
    cursor = activity.ContentResolver
    mImageUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
    mCursor = cursor.query(mImageUri, nil, nil, nil, MediaStore.Images.Media.DATE_TAKEN)
    mCursor.moveToLast()
    imageTable = {}
    while mCursor.moveToPrevious() do
        path = mCursor.getString(mCursor.getColumnIndex(MediaStore.Images.Media.DATA))
        table.insert(imageTable, tostring(path))
    end
    mCursor.close()
    return imageTable
end

function activity背景颜色(color)
    import "android.graphics.drawable.ColorDrawable"
    _window = activity.getWindow();
    _window.setBackgroundDrawable(ColorDrawable(color));
    _wlp = _window.getAttributes();
    _wlp.gravity = Gravity.BOTTOM;
    _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
    _window.setAttributes(_wlp);
end

function 输入法不影响布局()
    activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
end

function 输入法影响布局()
    activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
end

ripple = activity.obtainStyledAttributes({ android.R.attr.selectableItemBackgroundBorderless }).getResourceId(0, 0)
ripples = activity.obtainStyledAttributes({ android.R.attr.selectableItemBackground }).getResourceId(0, 0)

function 波纹2(id, lx)
    xpcall(function()
        for index, content in pairs(id) do
            if lx == "圆白" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class { int {} }, int { 0x3fffffff })))
            end
            if lx == "方白" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class { int {} }, int { 0x3fffffff })))
            end
            if lx == "圆黑" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class { int {} }, int { 0x3f000000 })))
            end
            if lx == "方黑" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class { int {} }, int { 0x3f000000 })))
            end
            if lx == "圆主题" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class { int {} }, int { 主题色 })))
            end
            if lx == "方主题" then
                content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class { int {} }, int { 主题色 })))
            end
        end
    end, function(e)
    end)
end

function 弹窗圆角(控件, 背景色, 上角度, 下角度)
    if not 上角度 then
        上角度 = 25
    end
    if not 下角度 then
        下角度 = 上角度
    end
    控件.setBackgroundDrawable(GradientDrawable()
            .setShape(GradientDrawable.RECTANGLE)
            .setColor(背景色)
            .setCornerRadii({ 上角度, 上角度, 上角度, 上角度, 下角度, 下角度, 下角度, 下角度 }))
end

function 选择路径(提示, StartPath, callback)
    import "android.widget.ArrayAdapter"
    import "android.widget.LinearLayout"
    import "android.widget.TextView"
    import "java.io.File"
    import "android.widget.ListView"
    import "android.app.AlertDialog"
    --创建ListView作为文件列表
    lv = ListView(activity).setFastScrollEnabled(true)
    --创建路径标签
    cp = TextView(activity)
    lay = LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
    ChoiceFile_dialog = AlertDialog.Builder(activity)--创建对话框
    --弹窗圆角(ChoiceFile_dialog.getWindow(),0xffffffff)
                                   .setTitle(提示)
                                   .setPositiveButton("确定", {
        onClick = function()
            callback(tostring(cp.Text))
        end })
                                   .setNegativeButton("取消", nil)
                                   .setView(lay)
                                   .show()
    p = ChoiceFile_dialog.getWindow().getAttributes()
    p.width = (activity.Width - 200);
    --p.height=(activity.Height/2-200);
    ChoiceFile_dialog.getWindow().setAttributes(p);
    adp = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
    lv.setAdapter(adp)
    function SetItem(path)
        path = tostring(path)
        adp.clear()--清空适配器
        cp.Text = tostring(path)--设置当前路径
        if path ~= "/" then
            --不是根目录则加上../
            adp.add("../")
        end
        ls = File(path).listFiles()
        if ls ~= nil then
            ls = luajava.astable(File(path).listFiles()) --全局文件列表变量
            table.sort(ls, function(a, b)
                return (a.isDirectory() ~= b.isDirectory() and a.isDirectory()) or ((a.isDirectory() == b.isDirectory()) and a.Name < b.Name)
            end)
        else
            ls = {}
        end
        for index, c in ipairs(ls) do
            if c.isDirectory() then
                --如果是文件夹则
                adp.add(c.Name .. "/")
            end
        end
    end
    lv.onItemClick = function(l, v, p, s)
        --列表点击事件
        项目 = tostring(v.Text)
        if tostring(cp.Text) == "/" then
            路径 = ls[p + 1]
        else
            路径 = ls[p]
        end
        if 项目 == "../" then
            SetItem(File(cp.Text).getParentFile())
        elseif 路径.isDirectory() then
            SetItem(路径)
        elseif 路径.isFile() then
            callback(tostring(路径))
            ChoiceFile_dialog.hide()
        end
    end
    import "android.graphics.Color"
    ChoiceFile_dialog.getButton(ChoiceFile_dialog.BUTTON_POSITIVE).setTextColor(主题色)
    ChoiceFile_dialog.getButton(ChoiceFile_dialog.BUTTON_NEGATIVE).setTextColor(主题色)
    SetItem(StartPath)
end

function 控件转图片(view)
    import "android.graphics.Bitmap"
    local linearParams = view.getLayoutParams()
    local vw = linearParams.width
    local linearParams = view.getLayoutParams()
    local vh = linearParams.height
    view.setDrawingCacheEnabled(true)
    view.layout(0, 0, vw, vh)
    return Bitmap.createBitmap(view.getDrawingCache())
end

function MD5加密(str)
    local HexTable = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" }
    local A = 0x67452301
    local B = 0xefcdab89
    local C = 0x98badcfe
    local D = 0x10325476
    local S11 = 7
    local S12 = 12
    local S13 = 17
    local S14 = 22
    local S21 = 5
    local S22 = 9
    local S23 = 14
    local S24 = 20
    local S31 = 4
    local S32 = 11
    local S33 = 16
    local S34 = 23
    local S41 = 6
    local S42 = 10
    local S43 = 15
    local S44 = 21
    local function F(x, y, z)
        return (x & y) | ((~x) & z)
    end
    local function G(x, y, z)
        return (x & z) | (y & (~z))
    end
    local function H(x, y, z)
        return x ~ y ~ z
    end
    local function I(x, y, z)
        return y ~ (x | (~z))
    end
    local function FF(a, b, c, d, x, s, ac)
        a = a + F(b, c, d) + x + ac
        a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
        return a & 0xffffffff
    end
    local function GG(a, b, c, d, x, s, ac)
        a = a + G(b, c, d) + x + ac
        a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
        return a & 0xffffffff
    end
    local function HH(a, b, c, d, x, s, ac)
        a = a + H(b, c, d) + x + ac
        a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
        return a & 0xffffffff
    end
    local function II(a, b, c, d, x, s, ac)
        a = a + I(b, c, d) + x + ac
        a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
        return a & 0xffffffff
    end
    local function MD5StringFill(s)
        local len = s:len()
        local mod512 = len * 8 % 512
        --需要填充的字节数
        local fillSize = (448 - mod512) // 8
        if mod512 > 448 then
            fillSize = (960 - mod512) // 8
        end
        local rTab = {}
        --记录当前byte在4个字节的偏移
        local byteIndex = 1
        for i = 1, len do
            local index = (i - 1) // 4 + 1
            rTab[index] = rTab[index] or 0
            rTab[index] = rTab[index] | (s:byte(i) << (byteIndex - 1) * 8)
            byteIndex = byteIndex + 1
            if byteIndex == 5 then
                byteIndex = 1
            end
        end
        --先将最后一个字节组成4字节一组
        --表示0x80是否已插入
        local b0x80 = false
        local tLen = #rTab
        if byteIndex ~= 1 then
            rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
            b0x80 = true
        end
        --将余下的字节补齐
        for i = 1, fillSize // 4 do
            if not b0x80 and i == 1 then
                rTab[tLen + i] = 0x80
            else
                rTab[tLen + i] = 0x0
            end
        end
        --后面加原始数据bit长度
        local bitLen = math.floor(len * 8)
        tLen = #rTab
        rTab[tLen + 1] = bitLen & 0xffffffff
        rTab[tLen + 2] = bitLen >> 32
        return rTab
    end
    --	Func:	计算MD5
    --	Param:	string
    --	Return:	string
    ---------------------------------------------
    function string.md5(s)
        --填充
        local fillTab = MD5StringFill(s)
        local result = { A, B, C, D }
        for i = 1, #fillTab // 16 do
            local a = result[1]
            local b = result[2]
            local c = result[3]
            local d = result[4]
            local offset = (i - 1) * 16 + 1
            --第一轮
            a = FF(a, b, c, d, fillTab[offset + 0], S11, 0xd76aa478)
            d = FF(d, a, b, c, fillTab[offset + 1], S12, 0xe8c7b756)
            c = FF(c, d, a, b, fillTab[offset + 2], S13, 0x242070db)
            b = FF(b, c, d, a, fillTab[offset + 3], S14, 0xc1bdceee)
            a = FF(a, b, c, d, fillTab[offset + 4], S11, 0xf57c0faf)
            d = FF(d, a, b, c, fillTab[offset + 5], S12, 0x4787c62a)
            c = FF(c, d, a, b, fillTab[offset + 6], S13, 0xa8304613)
            b = FF(b, c, d, a, fillTab[offset + 7], S14, 0xfd469501)
            a = FF(a, b, c, d, fillTab[offset + 8], S11, 0x698098d8)
            d = FF(d, a, b, c, fillTab[offset + 9], S12, 0x8b44f7af)
            c = FF(c, d, a, b, fillTab[offset + 10], S13, 0xffff5bb1)
            b = FF(b, c, d, a, fillTab[offset + 11], S14, 0x895cd7be)
            a = FF(a, b, c, d, fillTab[offset + 12], S11, 0x6b901122)
            d = FF(d, a, b, c, fillTab[offset + 13], S12, 0xfd987193)
            c = FF(c, d, a, b, fillTab[offset + 14], S13, 0xa679438e)
            b = FF(b, c, d, a, fillTab[offset + 15], S14, 0x49b40821)
            --第二轮
            a = GG(a, b, c, d, fillTab[offset + 1], S21, 0xf61e2562)
            d = GG(d, a, b, c, fillTab[offset + 6], S22, 0xc040b340)
            c = GG(c, d, a, b, fillTab[offset + 11], S23, 0x265e5a51)
            b = GG(b, c, d, a, fillTab[offset + 0], S24, 0xe9b6c7aa)
            a = GG(a, b, c, d, fillTab[offset + 5], S21, 0xd62f105d)
            d = GG(d, a, b, c, fillTab[offset + 10], S22, 0x2441453)
            c = GG(c, d, a, b, fillTab[offset + 15], S23, 0xd8a1e681)
            b = GG(b, c, d, a, fillTab[offset + 4], S24, 0xe7d3fbc8)
            a = GG(a, b, c, d, fillTab[offset + 9], S21, 0x21e1cde6)
            d = GG(d, a, b, c, fillTab[offset + 14], S22, 0xc33707d6)
            c = GG(c, d, a, b, fillTab[offset + 3], S23, 0xf4d50d87)
            b = GG(b, c, d, a, fillTab[offset + 8], S24, 0x455a14ed)
            a = GG(a, b, c, d, fillTab[offset + 13], S21, 0xa9e3e905)
            d = GG(d, a, b, c, fillTab[offset + 2], S22, 0xfcefa3f8)
            c = GG(c, d, a, b, fillTab[offset + 7], S23, 0x676f02d9)
            b = GG(b, c, d, a, fillTab[offset + 12], S24, 0x8d2a4c8a)
            --第三轮
            a = HH(a, b, c, d, fillTab[offset + 5], S31, 0xfffa3942)
            d = HH(d, a, b, c, fillTab[offset + 8], S32, 0x8771f681)
            c = HH(c, d, a, b, fillTab[offset + 11], S33, 0x6d9d6122)
            b = HH(b, c, d, a, fillTab[offset + 14], S34, 0xfde5380c)
            a = HH(a, b, c, d, fillTab[offset + 1], S31, 0xa4beea44)
            d = HH(d, a, b, c, fillTab[offset + 4], S32, 0x4bdecfa9)
            c = HH(c, d, a, b, fillTab[offset + 7], S33, 0xf6bb4b60)
            b = HH(b, c, d, a, fillTab[offset + 10], S34, 0xbebfbc70)
            a = HH(a, b, c, d, fillTab[offset + 13], S31, 0x289b7ec6)
            d = HH(d, a, b, c, fillTab[offset + 0], S32, 0xeaa127fa)
            c = HH(c, d, a, b, fillTab[offset + 3], S33, 0xd4ef3085)
            b = HH(b, c, d, a, fillTab[offset + 6], S34, 0x4881d05)
            a = HH(a, b, c, d, fillTab[offset + 9], S31, 0xd9d4d039)
            d = HH(d, a, b, c, fillTab[offset + 12], S32, 0xe6db99e5)
            c = HH(c, d, a, b, fillTab[offset + 15], S33, 0x1fa27cf8)
            b = HH(b, c, d, a, fillTab[offset + 2], S34, 0xc4ac5665)
            --第四轮
            a = II(a, b, c, d, fillTab[offset + 0], S41, 0xf4292244)
            d = II(d, a, b, c, fillTab[offset + 7], S42, 0x432aff97)
            c = II(c, d, a, b, fillTab[offset + 14], S43, 0xab9423a7)
            b = II(b, c, d, a, fillTab[offset + 5], S44, 0xfc93a039)
            a = II(a, b, c, d, fillTab[offset + 12], S41, 0x655b59c3)
            d = II(d, a, b, c, fillTab[offset + 3], S42, 0x8f0ccc92)
            c = II(c, d, a, b, fillTab[offset + 10], S43, 0xffeff47d)
            b = II(b, c, d, a, fillTab[offset + 1], S44, 0x85845dd1)
            a = II(a, b, c, d, fillTab[offset + 8], S41, 0x6fa87e4f)
            d = II(d, a, b, c, fillTab[offset + 15], S42, 0xfe2ce6e0)
            c = II(c, d, a, b, fillTab[offset + 6], S43, 0xa3014314)
            b = II(b, c, d, a, fillTab[offset + 13], S44, 0x4e0811a1)
            a = II(a, b, c, d, fillTab[offset + 4], S41, 0xf7537e82)
            d = II(d, a, b, c, fillTab[offset + 11], S42, 0xbd3af235)
            c = II(c, d, a, b, fillTab[offset + 2], S43, 0x2ad7d2bb)
            b = II(b, c, d, a, fillTab[offset + 9], S44, 0xeb86d391)
            --加入到之前计算的结果当中
            result[1] = result[1] + a
            result[2] = result[2] + b
            result[3] = result[3] + c
            result[4] = result[4] + d
            result[1] = result[1] & 0xffffffff
            result[2] = result[2] & 0xffffffff
            result[3] = result[3] & 0xffffffff
            result[4] = result[4] & 0xffffffff
        end
        --将Hash值转换成十六进制的字符串
        local retStr = ""
        for i = 1, 4 do
            for _ = 1, 4 do
                local temp = result[i] & 0x0F
                local str = HexTable[temp + 1]
                result[i] = result[i] >> 4
                temp = result[i] & 0x0F
                retStr = retStr .. HexTable[temp + 1] .. str
                result[i] = result[i] >> 4
            end
        end
        return retStr
    end
    return string.md5(str)
end

function 获取本身包名()
    --获取软件包名--本身
    包名 = activity.getPackageName()
    return 包名
end

function 自定义布局对话框(标题, 布局名)
    --布局对话框
    local dialog = AlertDialog.Builder(activity)
                              .setTitle(标题)
                              .setView(loadlayout(布局名))
    dialog.show()
end

function 控件边框(id, r, t, y)
    --控件的边框
    import "android.graphics.Color"
    InsideColor = Color.parseColor(t)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    --设置填充色
    drawable.setColor(InsideColor)
    --设置圆角 : 左上 右上 右下 左下
    drawable.setCornerRadii({ r, r, r, r, r, r, r, r });
    --设置边框 : 宽度 颜色
    drawable.setStroke(2, Color.parseColor(y))
    view.setBackgroundDrawable(drawable)

    --例:控件边框(bt,5,"#ffffffff","#42A5F5")--id，度数，内框透明，边框颜色
end

function 渐变(id, left_jb, right_jb)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable(GradientDrawable.Orientation.TR_BL, {
        right_jb, --右色
        left_jb, --左色
    });
    id.setBackgroundDrawable(drawable)
end

function 检测输入法()
    imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
    isOpen = imm.isActive()
    return isOpen == true or false
end

function 隐藏输入法()
    activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function 显示输入法(id)
    activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function 获取应用信息(archiveFilePath)
    pm = activity.getPackageManager()
    info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
    if info ~= nil then
        appInfo = info.applicationInfo;
        appName = tostring(pm.getApplicationLabel(appInfo))
        packageName = appInfo.packageName; --安装包名称
        version = info.versionName; --版本信息
        icon = pm.getApplicationIcon(appInfo);--图标
    end
    return packageName, version, icon
end


function Base64加密(data)
    --编码
    import "android.util.Base64"
    import "java.lang.*"
    import "android.util.*"
    import "android.content.*"
    local Base64 = luajava.bindClass("android.util.Base64")
    return Base64.encodeToString(String(data).getBytes(), Base64.NO_WRAP);
end

function Base64解密(data)
    --解码
    local Base64 = luajava.bindClass("android.util.Base64")
    return String(Base64.decode(data, Base64.DEFAULT)).toString()
end

function 控件缩放(ID)
    import "android.view.animation.*"
    import "android.view.animation.Animation"
    animationSet = AnimationSet(true); --动画集合
    scale = ScaleAnimation(1, 0.9, 1, 0.9)--缩放动画
    scale.setDuration(90); --动画时长
    scale.setRepeatCount(1); --重复次数
    scale.setRepeatMode(Animation.REVERSE); --是否反向动画
    animationSet.addAnimation(scale);
    ID.startAnimation(scale);
end

function 设置文本颜色(ID, Color)
    ID.setTextColor(Color)
end

function FULL()
    --[[  window = activity.getWindow();
     window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
     window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
     xpcall(function()
       lp = window.getAttributes();
       lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
       window.setAttributes(lp); end,function(e)end)]]
    activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 取消全屏()
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 返回桌面()
    activity.moveTaskToBack(true)
end

function printT(a)
    Toast.makeText(activity, a, Toast.LENGTH_SHORT).show()
end

function 截取(str, str1, str2)
    str1 = str1:gsub("%p", function(s)
        return ("%" .. s)
    end)
    return (str:match(str1 .. "(.-)" .. str2))
end

function 替换(str, str1, str2)
    str1 = str1:gsub("%p", function(s)
        return ("%" .. s)
    end)
    str2 = str2:gsub("%%", "%%%%")
    return (str:gsub(str1, str2))
end

function 字符串长度(str)
    return (utf8.len(str))
end

function sgg(s, i, j)
    i, j = tonumber(i), tonumber(j)
    i = utf8.offset(s, i)
    j = ((j or -1) == -1 and -1) or utf8.offset(s, j + 1) - 1
    return string.sub(s, i, j)
end

function 沉浸状态栏()
    if Build.VERSION.SDK_INT >= 19 then
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
    end
end


--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
function exec(sql)
    db.execSQL(sql);
end

--rawQuery()方法用于执行select语句。
function raw(sql, text)
    cursor = db.rawQuery(sql, text)
end

function 控件圆角(view, InsideColor, radiu)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({ radiu, radiu, radiu, radiu, radiu, radiu, radiu, radiu });
    view.setBackgroundDrawable(drawable)
end

function 获取设备标识码()
    import "android.provider.Settings$Secure"
    return Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)
end

function 获取IMEI()
    import "android.content.Context"
    return activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()
end

function 控件背景渐变动画(a, b, c, d, e)
    view = a
    color1 = b
    color2 = c
    color3 = d
    color4 = e
    import "android.animation.ObjectAnimator"
    import "android.animation.ArgbEvaluator"
    import "android.animation.ValueAnimator"
    import "android.graphics.Color"
    colorAnim = ObjectAnimator.ofInt(view, "backgroundColor", { color1, color2, color3, color4 })
    colorAnim.setDuration(3000)
    colorAnim.setEvaluator(ArgbEvaluator())
    colorAnim.setRepeatCount(ValueAnimator.INFINITE)
    colorAnim.setRepeatMode(ValueAnimator.REVERSE)
    colorAnim.start()
end

function 获取屏幕尺寸(ctx)
    import "android.util.DisplayMetrics"
    dm = DisplayMetrics();
    ctx.getWindowManager().getDefaultDisplay().getMetrics(dm);
    diagonalPixels = Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2));
    return diagonalPixels / (160 * dm.density);
end

function isInstall(a)
    if pcall(function()
        activity.getPackageManager().getPackageInfo(a, 0)
    end) then
        return true
    else
        return false
    end
end
graph = {}

function graph.Ripple(id, color, t)
    local ripple
    if t == "圆" or t == nil then
        if not (RippleCircular) then
            RippleCircular = activity.obtainStyledAttributes({ android.R.attr.selectableItemBackgroundBorderless }).getResourceId(0, 0)
        end
        ripple = RippleCircular
    elseif t == "方" then
        if not (RippleSquare) then
            RippleSquare = activity.obtainStyledAttributes({ android.R.attr.selectableItemBackground }).getResourceId(0, 0)
        end
        ripple = RippleSquare
    end
    local Pretend = activity.Resources.getDrawable(ripple)
    if id then
        id.setBackground(Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color })))
    else
        return Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color }))
    end

end

function 设置中划线(a)
    import "android.graphics.Paint"
    a.getPaint().setFlags(Paint. STRIKE_THRU_TEXT_FLAG)
end

function 设置下划线(a)
    import "android.graphics.Paint"
    a.getPaint().setFlags(Paint. UNDERLINE_TEXT_FLAG)
end

function 设置字体加粗(a)
    import "android.graphics.Paint"
    a.getPaint().setFakeBoldText(true)
end

function 设置斜体(a)
    import "android.graphics.Paint"
    a.getPaint().setTextSkewX(0.2)
end

function Sharing(path)
    import "android.webkit.MimeTypeMap"
    import "android.content.Intent"
    import "android.net.Uri"
    import "java.io.File"
    FileName = tostring(File(path).Name)
    ExtensionName = FileName:match("%.(.+)")
    Mime = MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
    intent = Intent()
    intent.setAction(Intent.ACTION_SEND)
    intent.setType(Mime)
    file = File(path)
    uri = Uri.fromFile(file)
    intent.putExtra(Intent.EXTRA_STREAM, uri)
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    activity.startActivity(Intent.createChooser(intent, "分享到:"))
end

function 分享(a)
    text = a
    intent = Intent(Intent.ACTION_SEND);
    intent.setType("text/plain");
    intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
    intent.putExtra(Intent.EXTRA_TEXT, text);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    activity.startActivity(Intent.createChooser(intent, "分享到:"));
end

function 加群(a)
    import "android.net.Uri"
    import "android.content.Intent"
    url = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=" .. a .. "&card_type=group&source=qrcode"
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ聊天(a)
    import "android.net.Uri"
    import "android.content.Intent"
    url = "mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin=" .. a
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 发送短信(a, b)
    require "import"
    import "android.telephony.*"
    SmsManager.getDefault().sendTextMessage(tostring(a), nil, tostring(b), nil, nil)
end

function 获取剪切板()
    import "android.content.Context"
    return activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
end

function 写入剪切板(a)
    import "android.content.Context"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(a)
end

function 开启WIFI()
    import "android.content.Context"
    wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
    wifi.setWifiEnabled(true)
end

function 关闭WIFI()
    import "android.content.Context"
    wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
    wifi.setWifiEnabled(false)
end

function 断开网络()
    import "android.content.Context"
    wifi = activity.Context.getSystemService(Context.WIFI_SERVICE)
    wifi.disconnect()
end

function 按钮颜色(aa, id)
    aa.getBackground().setColorFilter(PorterDuffColorFilter(id, PorterDuff.Mode.SRC_ATOP))
end

function 编辑框颜色(id, cc)
    id.getBackground().setColorFilter(PorterDuffColorFilter(cc, PorterDuff.Mode.SRC_ATOP));
end

function 进度条颜色(id, cc)
    id.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(cc, PorterDuff.Mode.SRC_ATOP))
end

function 控件颜色(id, cc)
    id.setBackgroundColor(cc)
end

function 获取手机存储路径()
    return Environment.getExternalStorageDirectory().toString()
end

function 获取屏幕宽()
    return activity.getWidth()
end

function 获取屏幕高()
    return activity.getHeight()
end

function 关闭侧滑()
    ch.closeDrawer(3)
end

function 打开侧滑()
    ch.openDrawer(3)
end

function 显示(id)
    id.setVisibility(0)
end

function 隐藏(id)
    id.setVisibility(8)
end

function 打开app(id)
    packageName = id
    import "android.content.Intent"
    import "android.content.pm.PackageManager"
    manager = activity.getPackageManager()
    open = manager.getLaunchIntentForPackage(packageName)
    this.startActivity(open)
end

function dp(n)
    local TypedValue = luajava.bindClass("android.util.TypedValue")
    local dm = activity.getResources().getDisplayMetrics()
    return TypedValue.applyDimension(1, n, dm)
end
function animateBack()
    --  取消其他动画
    if (mAnimatorSetHide ~= null and mAnimatorSetHide.isRunning()) then
        mAnimatorSetHide.cancel();
    end
    if (mAnimatorSetBack ~= null and mAnimatorSetBack.isRunning()) then
    else
        import "android.animation.AnimatorSet"
        mAnimatorSetBack = AnimatorSet();
        import "android.animation.ObjectAnimator"
        animateHeader = ObjectAnimator.ofFloat(mToolbar, "translationY", { mToolbar.getTranslationY(), 0 });
        animators = ArrayList();
        animators.add(animateHeader);
        mAnimatorSetBack.setDuration(300);
        mAnimatorSetBack.playTogether(animators);
        mAnimatorSetBack.start();
    end
end
function animateHide()
    --取消其他动画
    if (mAnimatorSetBack ~= null and mAnimatorSetBack.isRunning()) then
        mAnimatorSetBack.cancel();
    end
    if not (mAnimatorSetHide ~= null and mAnimatorSetHide.isRunning()) then
        mAnimatorSetHide = AnimatorSet();
        animateHeader = ObjectAnimator.ofFloat(mToolbar, "translationY",
                { mToolbar.getTranslationY(), -dp(56) })
        animators = ArrayList();
        animators.add(animateHeader);
        mAnimatorSetHide.setDuration(300);
        mAnimatorSetHide.playTogether(animators);
        mAnimatorSetHide.start();
    end
end

function 卸载app(id)
    import "android.net.Uri"
    import "android.content.Intent"
    包名 = id
    uri = Uri.parse("package:" .. 包名)
    intent = Intent(Intent.ACTION_DELETE, uri)
    activity.startActivity(intent)
end

function 安装app(path)
installApk(this,path)
end

function 系统下载文件(a, b, c)
    import "android.content.Context"
    import "android.net.Uri"
    downloadManager = activity.getSystemService(Context.DOWNLOAD_SERVICE);
    url = Uri.parse(a);
    request = DownloadManager.Request(url);
    request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE | DownloadManager.Request.NETWORK_WIFI);
    request.setDestinationInExternalPublicDir(b, c);
    request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
    downloadManager.enqueue(request);
end

function 对话框(a, b, c, functions)
    dialog = AlertDialog.Builder(this)
                        .setTitle(a)
                        .setMessage(b)
                        .setPositiveButton(c, { onClick = function(v)
        functions()
    end })
                        .show()
    dialog.create()
end

function Translate(str)
    local body = import "http".get("http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i=" .. tostring(str))
    return import "json".decode(body)
end

function 波纹(id, color)
--     import "android.content.res.ColorStateList"
--     local attrsArray = { android.R.attr.selectableItemBackgroundBorderless }
--     local typedArray = activity.obtainStyledAttributes(attrsArray)
--     ripple = typedArray.getResourceId(0, 0)
--     Pretend = activity.Resources.getDrawable(ripple)
--     Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color }))
--     id.setBackground(Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color })))
end

function 列表波纹(color)
--     import "android.content.res.ColorStateList"
--     local attrsArray = { android.R.attr.selectableItemBackgroundBorderless }
--     local typedArray = activity.obtainStyledAttributes(attrsArray)
--     ripple = typedArray.getResourceId(0, 0)
--     Pretend = activity.Resources.getDrawable(ripple)
--     Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color }))
--     return Pretend.setColor(ColorStateList(int[0].class { int {} }, int { color }))
end

function 随机数(a, b)
    return math.random(a, b)
end

function 删除控件(a, b)
    return (a).removeView(b)
end

function 状态栏亮色()
    if Build.VERSION.SDK_INT >= 23 then
        activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
    end
end

function 颜色渐变(控件, 颜色1, 颜色2, 颜色3, 颜色4)
    import "android.graphics.drawable.GradientDrawable"
    控件.setBackgroundDrawable(GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM, { 颜色1, 颜色2, 颜色3, 颜色4, }))
end

function 水珠动画(控件, 时间)
    import "android.animation.ObjectAnimator"
    ObjectAnimator().ofFloat(控件, "scaleX", { 1, .8, 1.3, .9, 1 }).setDuration(时间).start()
    ObjectAnimator().ofFloat(控件, "scaleY", { 1, .8, 1.3, .9, 1 }).setDuration(时间).start()
end

function 透明动画(对象, a, b, 时长)
    import "android.animation.ObjectAnimator"
    ObjectAnimator().ofFloat(对象, "alpha", { a, b }).setDuration(时长).start()
    ObjectAnimator().ofFloat(对象, "alpha", { a, b }).setDuration(时长).start()
end

function 波纹动画(控件, 颜色)
    import "android.widget.RippleHelper"
    RippleHelper(控件).RippleColor = tonumber(颜色)
end

主页动画 = (PageView.PageTransformer {

    transformPage = function(page, position)

        width = page.getWidth();

        pivotX = 0;

        if (position <= 1 and position > 0) then

            pivotX = 0

        elseif (position == 0) then

        elseif (position < 0 and position >= -1) then

            pivotX = width

        end

        page.setPivotX(pivotX);

        page.setPivotY(activity.getHeight() / 2);

        page.setRotationY(90 * position);

    end

})

悬浮动画 = (PageView.PageTransformer {

    transformPage = function(page, position)

        width = page.getWidth();

        height = page.getHeight()

        pivotX = 0;

        if (position <= 1 and position > 0) then

            pivotX = 0

            pivotY = 0

        elseif (position == 0) then

        elseif (position < 0 and position >= -1) then

            pivotX = width

            pivotY = height

        end

        page.setPivotX(pivotX);

        page.setPivotY(pivotY / 2);

        page.setRotationY(90 * position);

    end

})

function 屏幕沉浸(颜色一, 颜色二)
    import "android.view.WindowManager"
    import "android.view.View"
    activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
    activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);--View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(颜色一).setNavigationBarColor(颜色二);
end

function 状态栏高()
    local h = activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
    return h
end

function 控件旋转(view, 速度, 次数)
    import 'android.view.animation.Animation'
    import 'android.view.animation.RotateAnimation'
    rotate = RotateAnimation(0, 360,
            Animation.RELATIVE_TO_SELF, 0.5,
            Animation.RELATIVE_TO_SELF, 0.5)
    rotate.setDuration(速度)--设置毫秒1000=1秒
    rotate.setRepeatCount(次数)
    view.startAnimation(rotate)
end

--颜色整理--
靛蓝色 = 0xFF3F51B5
粉色 = 0xFFE91E63
蓝色 = 0xFF2196F3
青绿色 = 0xFF009688
暗橙色 = 0xFFFF5722
酸橙色 = 0xFFCDDC39
深紫色 = 0xFF673AB7
青色 = 0xFF0097A7
红色 = 0xFFF44336
亮蓝 = 0xFF03A9F4
白色 = 0xFFFFFFFF
黑色 = 0xFF000000
--颜色整理--

import "android.widget.ProgressBar"
import "android.graphics.Color"
import "android.view.ViewGroup"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "android.app.ProgressDialog"

local function getProgressDialogProgressBar(dialog)
    local decor, views = dialog.getWindow().getDecorView(), {}
    local function getChild(v)
        if luajava.instanceof(v, ProgressBar) then
            table.insert(views, v)
        elseif luajava.instanceof(v, ViewGroup) then
            for k = 0, v.getChildCount() - 1 do
                getChild(v.getChildAt(k))
            end
        end
    end
    getChild(decor)
    return views
end

local function setProgressBarColor(v, c)
    local f = PorterDuffColorFilter(c, PorterDuff.Mode.SRC_ATOP)
    pcall(function()
        v.IndeterminateDrawable.setColorFilter(f)
    end)
    pcall(function()
        v.ProgressDrawable.setColorFilter(f)
    end)
    pcall(function()
        v.Thumb.setColorFilter(f)
    end)
end

local function 设置弹窗进度条颜色(dialog, color)
    for k, v in ipairs(getProgressDialogProgressBar(dialog)) do
        setProgressBarColor(v, color)
    end
end
--[[
function 加载弹窗(内容)
  dialog = ProgressDialog(activity);
  dialog.Message =内容
  dialog.setMax(100);
  dialog1=dialog.show()
  dialog.getWindow().getDecorView().getChildAt(0).setPadding(30,30,30,30)
  p=dialog1.getWindow().getAttributes()
  p.width=(activity.Width-200);
  dialog1.getWindow().setAttributes(p);
  设置弹窗进度条颜色(dialog,主题色)
  弹窗圆角(dialog.getWindow(),白色)
end
]]--

function 加载弹窗(内容)
    layout = {
        LinearLayout;
        layout_height = "50dp";
        layout_width = "-1";
        id = "关闭";
        {
            ProgressBar;
            layout_margin = "10dp";
            id = "进度条";
        };
        {
            TextView;
            text = 内容;
            textSize = "14sp";
            layout_gravity = "center";
        };
    };
    dl = AlertDialog.Builder(activity)
    --.setTitle("自定义布局对话框")
                    .setView(loadlayout(layout))
    dl.setCancelable(false)
    dialog = dl.show()
    进度条颜色(进度条, 主题色)
    弹窗圆角(dialog.getWindow(), 白色)
    p = dialog.getWindow().getAttributes()
    p.width = (activity.Width - 200);
    dialog.getWindow().setAttributes(p);
    function 关闭.onClick()
        关闭对话框(dialog)
    end
end

function 关闭弹窗(id)
    id.dismiss()
end

import "android.widget.*"
import "android.view.*"
import "android.view.animation.*"
import "android.graphics.drawable.ColorDrawable"
import "android.view.animation.Animation$AnimationListener"
import "android.view.animation.AccelerateDecelerateInterpolator"
import "android.view.inputmethod.InputMethodManager"
--import"IntelliJ"
--
import "android.view.animation.Animation$AnimationListener"
import "android.view.animation.AlphaAnimation"

function installApk(content,path)
    import "com.Likefr.LuaJava.utils.*"
    Share.install(content,path)
end

function 下载文件(链接, 文件名)
    --导入包
    import "android.content.Context"
    import "android.net.Uri"
    downloadManager = activity.getSystemService(Context.DOWNLOAD_SERVICE);
    url = Uri.parse(链接);
    request = DownloadManager.Request(url);
    request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE | DownloadManager.Request.NETWORK_WIFI);
    request.setDestinationInExternalPublicDir("Download", 文件名);
    request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
    downloadManager.enqueue(request);
    print("正在下载，下载到：" .. "/storage/emulated/0/Download/" .. 文件名 .. "\n请查看通知栏以查看下载进度。")
end

function xdc(url, path)
    require "import"
    import "java.net.URL"
    local ur = URL(url)
    import "java.io.File"
    file = File(path);
    local con = ur.openConnection();
    local co = con.getContentLength();
    local is = con.getInputStream();
    local bs = byte[1024]
    local len, read = 0, 0
    import "java.io.FileOutputStream"
    local wj = FileOutputStream(path);
    len = is.read(bs)
    while len ~= -1 do
        wj.write(bs, 0, len);
        read = read + len
        pcall(call, "ding", read, co)
        len = is.read(bs)
    end
    wj.close();
    is.close();
    pcall(call, "dstop", co)
end
function appDownload(url, path)
    xpcall(function()
        thread(xdc, url, path)
    end, function(error)
        print("错误:" .. error)
    end)
end

function 下载文件对话框(title, url, path)
    if 是否包含(path, ".mp3") then
    elseif 是否包含(path, ".apk") then
        path = 内置存储路径() .. "/Download/" .. path
    else

    end
    appDownload(url, path)
    local gd2 = GradientDrawable()
    gd2.setColor(白色)--填充
    local radius = dp2px(16)
    gd2.setCornerRadii({ radius, radius, radius, radius, 0, 0, 0, 0 })--圆角
    gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
    local 布局 = {
        LinearLayout,
        id = "appdownbg",
        layout_width = "fill",
        layout_height = "fill",
        orientation = "vertical",
        BackgroundDrawable = gd2;
        {
            TextView,
            id = "appdownsong",
            text = title,
            --  typeface=Typeface.DEFAULT_BOLD,
            layout_marginTop = "24dp",
            layout_marginLeft = "24dp",
            layout_marginRight = "24dp",
            layout_marginBottom = "8dp",
            --textColor=primaryc,
            textSize = "20sp",
        },
        {
            TextView,
            id = "appdowninfo",
            text = "已下载：0MB/0MB\n下载状态：准备下载",
            --id="显示信息",
            --  typeface=Typeface.MONOSPACE,
            layout_marginRight = "24dp",
            layout_marginLeft = "24dp",
            layout_marginBottom = "8dp",
            textSize = "14sp",
            --textColor=textc;
        },
        {
            ProgressBar,
            id = "进度条",
            style = "?android:attr/progressBarStyleHorizontal",
            layout_width = "fill",
            progress = 0,
            max = 100;
            layout_marginRight = "24dp",
            layout_marginLeft = "24dp",
            layout_marginBottom = "24dp",
        },
    }
    local dldown = AlertDialog.Builder(activity)
    dldown.setView(loadlayout(布局))
    dldown.setCancelable(false)
    local ao = dldown.show()
    window = ao.getWindow();
    window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
    wlp = window.getAttributes();
    wlp.gravity = Gravity.BOTTOM;
    wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
    window.setAttributes(wlp);
    进度条.ProgressDrawable.setColorFilter(PorterDuffColorFilter(主题色, PorterDuff.Mode.SRC_ATOP))
    function ding(a, b)
        --已下载，总长度(byte)
        appdowninfo.Text = string.format("%0.2f", a / 1024 / 1024) .. "MB/" .. string.format("%0.2f", b / 1024 / 1024) .. "MB" .. "\n下载状态：正在下载"
        进度条.progress = (a / b * 100)
    end

    function dstop(c)
        --总长度
        关闭对话框(ao)
        print("下载完成，大小" .. string.format("%0.2f", c / 1024 / 1024) .. "MB，储存在：" .. path)
        if path:find(".apk$") ~= nil then
            install(this,path)
        end
    end
end

function 调用QQ打开链接(链接)
    import "android.net.Uri"
    import "android.content.Intent"
    链接 = Base64加密(链接)
    url = "mqqapi://forward/url?url_prefix=" .. 链接
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function Sharing(path)
    --分享文字
    import "android.webkit.MimeTypeMap"
    import "android.content.Intent"
    import "android.net.Uri"
    import "java.io.File"
    FileName = path
    ExtensionName = FileName:match("%.(.+)")
    Mime = MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
    intent = Intent()
    intent.setAction(Intent.ACTION_SEND)
    intent.setType(Mime)
    file = File(path)
    uri = Uri.fromFile(file)
    intent.putExtra(Intent.EXTRA_STREAM, uri)
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    activity.startActivity(Intent.createChooser(intent, "分享到:"))
end

function 更新(title, url)
    path = "/storage/emulated/0/Download/IntelliJ Lua.apk"
    local ts = true
    appDownload(url, path)
    local 布局 = {
        FrameLayout;
        {
            CardView;
            radius = "30";
            layout_marginTop = "5%w";
            layout_width = "65%w";
            layout_height = "20%w";
            layout_marginLeft = "20%w";
            {
                LinearLayout;
                layout_marginLeft = "10%w";
                orientation = "vertical";
                layout_width = "fill";
                layout_height = "fill";
                gravity = "center";
                {
                    TextView;
                    layout_marginRight = "8dp";
                    textSize = "17dp";
                    layout_marginLeft = "8dp";
                    layout_height = "10%w";
                    id = "bt";
                    text = "标题";
                    layout_width = "fill";
                    textColor = TextColor;
                    gravity = "left|center";
                };
                {
                    LinearLayout;
                    layout_height = "5%w";
                    layout_width = "fill";
                    {
                        TextView;
                        id = "appdowninfo";
                        textSize = "10sp";
                        text = "已下载:0MB/0MB";
                        layout_marginLeft = "8dp";
                        layout_marginRight = "8dp";
                        gravity = "left|center";
                    };
                    {
                        TextView;
                        id = "tus";
                        textSize = "10sp";
                    };
                };
                {
                    LinearLayout;
                    id = "jdu";
                    layout_marginLeft = "8dp";
                    layout_marginRight = "8dp";
                    layout_width = "fill";
                    layout_height = "5%w";
                    gravity = "left";
                    {
                        TextView;
                        background = "#02A9F4";
                        id = "jdt";
                        layout_height = "5dp";
                    };
                };
            };
        };
        {
            CardView;
            radius = "100dp";
            layout_width = "30%w";
            layout_height = "30%w";
            {
                RelativeLayout;
                layout_height = "fill";
                layout_width = "fill";
                {
                    LinearLayout;
                    layout_width = "fill";
                    layout_height = "fill";
                    gravity = "center";
                    {
                        ImageView;
                        layout_height = "25%w";
                        layout_width = "25%w";
                        id = "bt1";
                        src = "res/load.png";
                    };
                };
                {
                    LinearLayout;
                    layout_width = "fill";
                    layout_height = "fill";
                    gravity = "center";
                    {
                        TextView;
                        text = "100%";
                        id = "jdv";
                        textSize = "18sp";
                    };
                };
            };
        };
    };
    dialog = Dialog(activity)
    import "android.text.SpannableString"
    import "android.text.style.ForegroundColorSpan"
    import "android.text.Spannable"
    dialog1 = dialog.show()
    dialog1.getWindow().setContentView(loadlayout(布局));
    --  doalog1.setCancelable(false)
    dialog1.setCanceledOnTouchOutside(false)
    dialog1.setCancelable(false)
    dialog1.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
    import "android.graphics.drawable.ColorDrawable"
    dialog1.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000));
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    import "android.net.TrafficStats"
    import "android.view.animation.Animation"
    import "android.view.animation.RotateAnimation"
    旋转动画 = RotateAnimation(0, 18000,
            Animation.RELATIVE_TO_SELF, 0.5,
            Animation.RELATIVE_TO_SELF, 0.5)
    旋转动画.setDuration(30000)
    旋转动画.setFillAfter(true)
    旋转动画.setRepeatCount(-1)
    bt1.startAnimation(旋转动画)
    --  进度条.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
    bt.Text = title

    function ding(a, b)
        appdowninfo.Text = string.format("%0.2f", a / 1024 / 1024) .. "MB/" .. string.format("%0.2f", b / 1024 / 1024) .. "MB"

        local s = a / b
        local w = jdu.Width * s
        jdt.Width = w
        jdv.text = math.ceil(s * 100) .. "%"

    end

    function dstop(c)
        if ts then
            appdowninfo.Text = "下载完成，总长度" .. string.format("%0.2f", c / 1024 / 1024) .. "MB"
            dialog1.dismiss()
            print("已下载到/storage/emulated/0/Download")
            luajava.clear(ts)
          installApk(this,path)
        else
            print("已下载到/storage/emulated/0/Download")
            luajava.clear(ts)
           installApk(this,path)
        end
    end

    function update(s)
        tus.Text = s .. "k/s"
    end

    function f()
        require "import"
        import "android.net.TrafficStats"
        s = TrafficStats.getTotalRxBytes()
        Thread.sleep(500)
        call("update", (TrafficStats.getTotalRxBytes() - s) * 2 / 1000)
    end
    timer(f, 0, 1000)

end

function 复制文本(文本)
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(文本)
end



--dp转px
function dpTopx(sdp)
    dm = this.getResources().getDisplayMetrics()
    types = { px = 0, dp = 1, sp = 2, pt = 3, ["in"] = 4, mm = 5 }
    n, ty = sdp:match("^(%-?[%.%d]+)(%a%a)$")
    return TypedValue.applyDimension(types[ty], tonumber(n), dm)
end




--搜索开始动画
function SearchStartAnim(Id)
    w = activity.width
    x = w - dpTopx("28dp") * 3
    y = dpTopx("28dp")
    animator = ViewAnimationUtils.createCircularReveal(Id, x, y, 0, w);
    animator.setInterpolator(LinearInterpolator())
    animator.setDuration(350)
    animator.start()

    Id.setVisibility(View.VISIBLE)

    --自动显示输入法
    task(350, function()
        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
        imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS)
        wbwb.requestFocus()
    end)
end




import "android.content.res.ColorStateList"
import "android.graphics.drawable.ColorDrawable"
import "android.content.Intent"
import "android.graphics.drawable.ColorDrawable"
import "android.net.Uri"
import "com.androlua.Http"
import"json"
cjson=require ("json") --解析json字符

function update(id)
    packinfo=this.getPackageManager().getPackageInfo(this.getPackageName(),((1552294270/8/2-8392)/32/1250-25.25)/8-236)
    version=tostring(packinfo.versionName)
    versioncode= packinfo.versionCode

    url="http://aaa.likefr.com:8868/api/update/" ..id
    Http.get(url,nil,"utf8",nil,function(code,content,cookie,header)
        if code==200 then
            data = cjson.decode(content).obj
            版本=data.version
            内容 = data.data
            群号码 = data.qqq
            esl = data.esl
            if(版本==nil) then
                版本="0"
            end
            if(内容==nil) then
                内容="获取失败"
            end
            if(群号码==nil) then
                print("服务器参数配置错误，请过段时间再次尝试")
            end

            if(tonumber(版本) > tonumber(versioncode)) then
                Gengxin=
                {
                    LinearLayout,
                    orientation="vertical",
                    gravity="center";
                    {
                        ImageView;
                        src="http://aaa.likefr.com/res/1.png";
                        scaleType="fitCenter";
                        layout_height="136dp";--原图尺寸/1.5
                        layout_width="300dp";
                    };
                    {
                        ScrollView;--使用滚动布局可以防止更新日志过长导致显示不全
                        background="#FFFFFFFF";--弹窗背景色
                        layout_width="300dp";
                        VerticalScrollBarEnabled=false;--禁用滚动条
                        {
                            LinearLayout;
                            layout_height="fill";
                            layout_width="260dp";
                            orientation="vertical";
                            layout_gravity="top|center";
                            {
                                TextView;
                                text="当前版本："..versioncode.."→"..版本.."\n更新内容："..内容;
                                textSize="16dp";
                                textColor="#FFa7a7a7";
                                layout_marginTop="10dp";
                            };
                            {
                                TextView;
                                text=更新日志;
                                textSize="15dp";
                                textColor="#FF656565";
                                layout_marginTop="15dp";
                            };
                        };
                    };
                    {
                        LinearLayout;
                        id="卡片布局";
                        layout_width="300dp";
                        background="#FFFFFFFF";--弹窗背景色
                        gravity="center";
                        {
                            CardView;
                            id="更新卡片";
                            radius="24dp";
                            elevation=0;
                            cardBackgroundColor="#FF66A9ED";--更新按钮背景色
                            layout_marginTop="12dp";
                            layout_marginBottom="10dp";
                            layout_gravity="center";
                            {
                                TextView;
                                id="更新卡片文字";
                                text="更新";
                                layout_height="40dp";
                                layout_width="260dp";
                                textSize="18dp";
                                textColor="#FFFFFFFF";
                                layout_gravity="center";
                                gravity="center";

                            };
                            onClick=function()
                                import "android.net.Uri"
                                import "android.content.Intent"
                                url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..群号码.."&card_type=group&source=qrcode"
                                activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                                this.finish()
                            end

                        };
                    };

                };
                dialog= AlertDialog.Builder(this)
                弹窗=dialog.show()
                if (esl==1) then
                    弹窗.setCancelable(false);
                    弹窗.setCanceledOnTouchOutside(false)--设置点击外部区域不关闭弹窗
                end
                弹窗.getWindow().setContentView(loadlayout(Gengxin))
                import "android.graphics.drawable.ColorDrawable"
                弹窗.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000))
            end
        end
    end)

end


--搜索结束动画
function SearchEndAnim(Id)
    w = activity.width
    x = w - dpTopx("28dp") * 3
    y = dpTopx("28dp")
    animator = ViewAnimationUtils.createCircularReveal(Id, x, y, w, 0);
    animator.setInterpolator(LinearInterpolator())
    animator.setDuration(350)
    animator.start()

    animator.addListener(Animator.AnimatorListener {
        onAnimationEnd = function(animation)
            Id.setVisibility(View.GONE)


        end
    })

end
