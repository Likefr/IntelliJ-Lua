require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "java.util.zip.ZipOutputStream"
import "android.net.Uri"
import "java.io.File"
import "android.widget.Toast"
import "java.util.zip.CheckedInputStream"
import "java.io.FileInputStream"
import "android.content.Intent"
import "java.security.Signer"
import "java.util.ArrayList"
import "java.io.FileOutputStream"
import "java.io.BufferedOutputStream"
import "java.util.zip.ZipInputStream"
import "java.io.BufferedInputStream"
import "java.util.zip.ZipEntry"
import "android.app.ProgressDialog"
import "java.util.zip.CheckedOutputStream"
import "java.util.zip.Adler32"
import "android.widget.Toast"
mains = {
    LinearLayout;
    gravity = "center";
    layout_width = "fill";
    layout_height = "300dp";
    orientation = "vertical";
    {
        ScrollView;
        layout_height = "fill";
        layout_width = "fill";
        {
            LinearLayout;
            id = "maina";
            layout_width = "fill";
            layout_height = "fill";
            orientation = "vertical";
        };
    };
};
activity.setContentView(loadlayout(mains))

R = luajava.bindClass("com.Likefr.LuaJava.R")
if not activity.getString(R.string.Intellij) == "Intellij" then
    local toast = luajava.bindClass("android.widget.Toast")
    toast.makeText(activity, tostring(activity.getString(R.string.error)), toast.LENGTH_SHORT)
    this.finish()
end
local function
update(s)
    maina.addView(TextView().setText(s).setTextColor(0xff000000))
    --bin_dlg.setMessage(s)
end

local function callback(s)
    LuaUtil.rmDir(File(activity.getLuaExtDir("bin/.temp")))
    maina.addView(TextView().setText("删除临时文件: " .. tostring(activity.getLuaExtDir("bin/.temp"))).setTextColor(0xff000000))
end

local function binapk(luapath, apkpath)
    require "import"
    import "console"
    compile "mao"
    compile "sign"
    import "java.util.zip.*"
    import "java.io.*"
    import "mao.res.*"
    import "apksigner.*"
    import "android.app.*"
    import "android.os.*"
    import "android.widget.*"
    import "android.app.AlertDialog"
    import "android.view.Gravity"
    import "android.content.Context"
    import "Dialog"--只需要导入这个包
    import "Toasts"
    local function copy(input, output)
        LuaUtil.copyFile(input, output)
        input.close()
    end

    local function copy2(input, output)
        LuaUtil.copyFile(input, output)
    end

    local temp = File(apkpath).getParentFile();
    if (not temp.exists()) then
        if (not temp.mkdirs()) then
            error("create file " .. temp.getName() .. " fail");
        end
    end

    local tmp = luajava.luadir .. "/tmp.apk"
    local info = activity.getApplicationInfo()
    local ver = activity.getPackageManager().getPackageInfo(activity.getPackageName(), 0).versionName
    local zipFile = File(info.publicSourceDir)
    local fis = FileInputStream(zipFile);
    local zis = ZipInputStream(BufferedInputStream(fis));
    local fot = FileOutputStream(tmp)
    local out = ZipOutputStream(BufferedOutputStream(fot))
    local f = File(luapath)
    local errbuffer = {}
    local replace = {}
    local checked = {}
    local lualib = {}
    local md5s = {}
    local libs = File(activity.ApplicationInfo.nativeLibraryDir).list()
    libs = luajava.astable(libs)
    for k, v in ipairs(libs) do
        --libs[k]="lib/armeabi/"..libs[k]
        replace[v] = true
    end

    local mdp = activity.Application.MdDir
    local function getmodule(dir)
        local mds = File(activity.Application.MdDir .. dir).listFiles()
        mds = luajava.astable(mds)
        for k, v in ipairs(mds) do
            if mds[k].isDirectory() then
                getmodule(dir .. mds[k].Name .. "/")
            else
                mds[k] = "lua" .. dir .. mds[k].Name
                replace[mds[k]] = true
            end
        end
    end

    getmodule("/")

    local function checklib(path)
        if checked[path] then
            return
        end
        local cp, lp
        checked[path] = true
        local f = io.open(path)
        local s = f:read("*a")
        f:close()
        for m, n in s:gmatch("require *%(? *\"([%w_]+)%.?([%w_]*)") do
            cp = string.format("lib%s.so", m)
            if n ~= "" then
                lp = string.format("lua/%s/%s.lua", m, n)
                m = m .. '/' .. n
            else
                lp = string.format("lua/%s.lua", m)
            end
            if replace[cp] then
                replace[cp] = false
            end
            if replace[lp] then
                checklib(mdp .. "/" .. m .. ".lua")
                replace[lp] = false
                lualib[lp] = mdp .. "/" .. m .. ".lua"
            end
        end
        for m, n in s:gmatch("import *%(? *\"([%w_]+)%.?([%w_]*)") do
            cp = string.format("lib%s.so", m)
            if n ~= "" then
                lp = string.format("lua/%s/%s.lua", m, n)
                m = m .. '/' .. n
            else
                lp = string.format("lua/%s.lua", m)
            end
            if replace[cp] then
                replace[cp] = false
            end
            if replace[lp] then
                checklib(mdp .. "/" .. m .. ".lua")
                replace[lp] = false
                lualib[lp] = mdp .. "/" .. m .. ".lua"
            end
        end
    end

    replace["libluajava.so"] = false

    local function addDir(out, dir, f)
        local entry = ZipEntry("assets/" .. dir)
        out.putNextEntry(entry)
        local ls = f.listFiles()
        for n = 0, #ls - 1 do
            local name = ls[n].getName()
            if name == (".using") then
                checklib(luapath .. dir .. name)
            elseif name:find("%.apk$") or name:find("%.luac$") or name:find("^%.") then
            elseif name:find("%.lua$") then
                checklib(luapath .. dir .. name)
                local path, err = console.build(luapath .. dir .. name)
                if path then
                    if replace["assets/" .. dir .. name] then
                        table.insert(errbuffer, dir .. name .. "/.aly")
                    end
                    local entry = ZipEntry("assets/" .. dir .. name)
                    out.putNextEntry(entry)

                    replace["assets/" .. dir .. name] = true
                    copy(FileInputStream(File(path)), out)
                    table.insert(md5s, LuaUtil.getFileMD5(path))
                    os.remove(path)
                else
                    table.insert(errbuffer, err)
                end
            elseif name:find("%.aly$") then
                local path, err = console.build(luapath .. dir .. name)
                if path then
                    name = name:gsub("aly$", "lua")
                    if replace["assets/" .. dir .. name] then
                        table.insert(errbuffer, dir .. name .. "/.aly")
                    end
                    local entry = ZipEntry("assets/" .. dir .. name)
                    out.putNextEntry(entry)

                    replace["assets/" .. dir .. name] = true
                    copy(FileInputStream(File(path)), out)
                    table.insert(md5s, LuaUtil.getFileMD5(path))
                    os.remove(path)
                else
                    table.insert(errbuffer, err)
                end
            elseif ls[n].isDirectory() then
                addDir(out, dir .. name .. "/", ls[n])
            else
                local entry = ZipEntry("assets/" .. dir .. name)
                out.putNextEntry(entry)
                replace["assets/" .. dir .. name] = true
                copy(FileInputStream(ls[n]), out)
                table.insert(md5s, LuaUtil.getFileMD5(ls[n]))
            end
        end
    end

    this.update("正在编译..." .. tostring(luapath));
    if f.isDirectory() then
        require "permission"
        dofile(luapath .. "init.lua")
        if user_permission then
            for k, v in ipairs(user_permission) do
                user_permission[v] = true
                this.update("添加权限->" .. tostring(v));
            end
        end

        local ss, ee = pcall(addDir, out, "", f)
        if not ss then
            table.insert(errbuffer, ee)
        end
        --print(ee,dump(errbuffer),dump(replace))
        local wel = File(luapath .. "icon.png")

        if wel.exists() then
            local entry = ZipEntry("res/drawable/icon.png")
            out.putNextEntry(entry)
            replace["res/drawable/icon.png"] = true
            copy(FileInputStream(wel), out)
            --maina.addView(TextView().setText("注入文件: "..tostring(wel)).setTextColor(0xff000000))
        end

    else
        return "error"
    end

    --print(dump(lualib))
    for name, v in pairs(lualib) do
        local path, err = console.build(v)
        if path then
            local entry = ZipEntry(name)
            this.update("正在编译:" .. tostring(entry) .. " 文件");
            out.putNextEntry(entry)
            copy(FileInputStream(File(path)), out)
            table.insert(md5s, LuaUtil.getFileMD5(path))
            os.remove(path)
        else
            table.insert(errbuffer, err)
        end
    end

    function touint32(i)
        local code = string.format("%08x", i)
        local uint = {}
        for n in code:gmatch("..") do
            table.insert(uint, 1, string.char(tonumber(n, 16)))
        end
        return table.concat(uint)
    end

    this.update("正在打包...");
    local entry = zis.getNextEntry();
    while entry do

        local name = entry.getName()
        local lib = name:match("([^/]+%.so)$")
        if replace[name] then
        elseif lib and replace[lib] then
        elseif name:find("^assets/") then
        elseif name:find("^lua/") then
        elseif name:find("META%-INF") then
        else
            local entry = ZipEntry(name)
            out.putNextEntry(entry)
            if entry.getName() == "AndroidManifest.xml" then
                if path_pattern and #path_pattern > 1 then
                    path_pattern = ".*\\\\." .. path_pattern:match("%w+$")
                end
                local list = ArrayList()
                local xml = AXmlDecoder.read(list, zis)
                local req = {
                    [activity.getPackageName()] = packagename,
                    [info.nonLocalizedLabel] = appname,
                    [ver] = appver,
                    [".*\\\\.alp"] = path_pattern or "",
                    [".*\\\\.lua"] = "",
                    [".*\\\\.luac"] = "",
                }
                for n = 0, list.size() - 1 do
                    local v = list.get(n)
                    if req[v] then
                        list.set(n, req[v])
                    elseif user_permission then
                        local p = v:match("%.permission%.([%w_]+)$")
                        if p and (not user_permission[p]) then
                            list.set(n, "android.permission.UNKNOWN")
                        end
                    end
                end
                local pt = activity.getLuaPath(".tmp")
                local fo = FileOutputStream(pt)
                xml.write(list, fo)
                local code = activity.getPackageManager().getPackageInfo(activity.getPackageName(), 0).versionCode
                fo.close()
                local f = io.open(pt)
                local s = f:read("a")
                f:close()
                s = string.gsub(s, touint32(code), touint32(tointeger(appcode) or 1), 1)
                s = string.gsub(s, touint32(18), touint32(tointeger(appsdk) or 18), 1)

                local f = io.open(pt, "w")
                f:write(s)
                f:close()
                local fi = FileInputStream(pt)
                copy(fi, out)
                os.remove(pt)
            elseif not entry.isDirectory() then
                copy2(zis, out)
            end
        end
        entry = zis.getNextEntry()
    end
    out.setComment(table.concat(md5s))
    --print(table.concat(md5s,"/n"))
    zis.close();
    out.closeEntry()
    out.close()

    if #errbuffer == 0 then
        this.update("正在签名...");
        os.remove(apkpath)
        Signer.sign(tmp, apkpath)
        os.remove(tmp)

        Dialike()
                .setGravity("center")-- 设置对话框位置
                .setWidth("90%w", "wrap")--第1个为宽度 第2个为高度。一般不用设置 他会自适应
                .setTitle("打包完成")
                .setMessage("打包完成,是否立即安装?")
                .setMessageColor(wbColor)
                .setMessageSize("18dp")
                .setElevation("7dp")
                .setRadius("6dp")
                .setCardBackground(background)--设置对话框背景
                .setButtonSize(3, 20)--第1个参数为按钮 一共三个值分别 1-2-3  第2个为字体大小) 可重载
                .setPositiveButton("安装", function()
            activity.installApk(apkpath)
            --import "com.Likefr.LuaJava.utils.*"
            --Share.install(activity,apkpath)
        end)
                .setNegativeButton("取消", function()
            print("保存目录: /storage/emulated/0/IntelliJ Lua/apk/", success);
        end)
                .show()



        --[[        --简单对话框
                AlertDialog.Builder(this).setTitle("完成")
                           .setMessage("是否立即安装？")
                           .setPositiveButton("确定", function()
                    activity.installApk(apkpath)
                end)
                           .show();]]

        return "打包成功:" .. apkpath
    else
        os.remove(tmp)
        this.update("打包出错:\n " .. table.concat(errbuffer, "\n"));
        maina.addView(TextView().setText("打包出错").setTextColor(0xffff0000))
        return "打包出错:\n " .. table.concat(errbuffer, "\n")
    end
end

--luabindir=activity.getLuaExtDir("bin")
--print(activity.getLuaExtPath("bin","a"))
local function bin(path)
    local p = {}
    local e, s = pcall(loadfile(path .. "init.lua", "bt", p))
    if e then

        --bin_dlg.show()
        activity.newTask(binapk, update, callback).execute { path, activity.getString(R.string.localApk) .. p.appname .. "_" .. p.appver .. ".apk" }
    else
        Toast.makeText(activity, "工程配置文件错误." .. s, Toast.LENGTH_SHORT).show()
        maina.addView(TextView().setText("工程配置文件错误.").setTextColor(0xff000000))
    end
end
bin(...)
--bin(activity.getLuaExtDir("project/demo").."/")
return bin