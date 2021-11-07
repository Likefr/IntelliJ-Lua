require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "java.io.*"
import "java.io.File"
import "android.Manifest"
require "Controller/LayBox"
import "Controller/MyEditText"
import "android.database.sqlite.*"
import "com.Likefr.LuaJava.utils.*"
import "com.michael.NoScrollListView"
import "android.text.SpannableString"
import "com.Likefr.hitomi.cmlibrary.*"
import "android.tool.PermissionHelper"
import "android.text.style.UnderlineSpan"
import "com.Likefr.widget.PullRefreshLayout"
import "com.Likefr.LuaJava.utils.Share"
--import "com.Likefr.overscroll.*"
import "com.getkeepsafe.taptargetview.*"
import "com.Likefr.blur.BlurringView"
import "layout"
import "Toasts"






--[[

-- Copyright (c) 2018.  likefr(likefr@forxmail.com)
--
-- Licensed under the Apache License, Version 2.0 (the "License"); you may not
-- use this file except in compliance with the License. You may obtain a copy of
-- the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
-- WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
-- License for the specific language governing permissions and limitations under
-- the License.
             
* Info:      IntelliJ Idea Build
* Date:      21/03/22 10:00
* Author:      Likefr   	
* Description:  1.0.9

 _____      _       _   _   ____    _
|_   _|    | |     | | (_) |_  |   | |
  | | _ __ | |_ ___| | |_    | |   | |    _ _ __  _
  | || '_ \| __/ _ \ | | |   | |   | |   | | | |/ _` |
 _| || | | | ||  __/ | | /\__/ /   | |___| |_| | (_| |
 \___/_| |_|\__\___|_|_|_\____/    \_____/\__,_|\__,_|


]]

File(activity.getString(R.string.localBackup)).mkdirs()
File(activity.getString(R.string.localApk)).mkdirs()
File(activity.getString(R.string.localBin)).mkdirs()
File(activity.getString(R.string.DefaultPath)).mkdirs()
Update(activity.getString(R.string.updata))
path = SELECT("Project_Path", SELECT("User_option", "Value"))
R=luajava.bindClass("com.Likefr.LuaJava.R")
activity.setContentView(loadlayout(layout.home))

----⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠
function Rc4X(Value)
local minicrypto = {}--RC4
local insert, concat, modf, tostring, char = table.insert, table.concat, math.modf, tostring, string.char
local function numberToBinStr(x)
    local ret = {}
    while x ~= 1 and x ~= 0 do
        insert(ret, 1, x % 2)
        x = modf(x / 2)
    end
    insert(ret, 1, x)
    for i = 1, 8 - #ret do
        insert(ret, 1, 0)
    end
    return concat(ret)
end
local function computeBinaryKey(str)
    local t = {}
    for i = #str, 1, -1 do
        insert(t, numberToBinStr(str:byte(i, i)))
    end
    return concat(t)
end
local binaryKeys = setmetatable({}, { __mode = "k" })
local function binaryKey(key)
    local v = binaryKeys[key]
    if v == nil then
        v = computeBinaryKey(key)
        binaryKeys[key] = v
    end
    return v
end
local function initialize_state(key)
    local S = {};
    for i = 0, 255 do
        S[i] = i
    end
    key = binaryKey(key)
    local j = 0
    for i = 0, 255 do
        local idx = (i % #key) + 1
        j = (j + S[i] + tonumber(key:sub(idx, idx))) % 256
        S[i], S[j] = S[j], S[i]
    end
    S.i = 0
    S.j = 0
    return S
end

local function encrypt_one(state, byt)
    state.i = (state.i + 1) % 256
    state.j = (state.j + state[state.i]) % 256
    state[state.i], state[state.j] = state[state.j], state[state.i]
    local K = state[(state[state.i] + state[state.j]) % 256]
    return K ~ byt
end
function minicrypto.encrypt(text, key)
    local state = initialize_state(key)
    local encrypted = {}
    for i = 1, #text do
        encrypted[i] = ("%02X"):format(encrypt_one(state, text:byte(i, i)))
    end
    return concat(encrypted)
end
function minicrypto.decrypt(text, key)
    local state = initialize_state(key)
    local decrypted = {}
    for i = 1, #text, 2 do
        insert(decrypted, char(encrypt_one(state, tonumber(text:sub(i, i + 1), 16))))
    end
    return concat(decrypted)
end
end
--Rc4X("@Likefr")

if this.getSharedData(activity.getString(R.string.night)) == "true" then
    BlurView.setVisibility(View.INVISIBLE)
else
    BlurView.setVisibility(View.VISIBLE)
    BlurView.setBlurredView(project_list);
    BlurView.setBlurRadius(5);
    BlurView.setDownsampleFactor(20);--采样点
    BlurView.setOverlayColor(backgroundD);
end

if this.getSharedData(activity.getString(R.string.FullSc)) == "true" then
    --同理设置高度
    linearParams = mToolbar.getLayoutParams()
    linearParams.height = height_Bar
    mToolbar.setLayoutParams(linearParams)
else
    --同理设置高度
    linearParams = mToolbar.getLayoutParams()
    linearParams.height = height_Bar
    mToolbar.setLayoutParams(linearParams)
end
--⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠
--IntelliJX(R.string.Main_Home,R.string.app_name)
--⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠⚠


--一行代码解决滚动效果
--OverScrollDecoratorHelper.setUpOverScroll(project_list);


--监听列表并刷新
project_list.getViewTreeObserver().addOnScrollChangedListener(ViewTreeObserver.OnScrollChangedListener {
    onScrollChanged = function()
        BlurView.invalidate();
    end })

an.setMainMenu(Color.parseColor("#9B90BC"), R.mipmap.icon_home, R.mipmap.icon_home)
  .addSubMenu(Color.parseColor("#258CFF"), R.mipmap.ic_create)
  .addSubMenu(Color.parseColor("#30A400"), R.mipmap.icon_search)
  .addSubMenu(Color.parseColor("#FF4B32"), R.mipmap.icon_notify)
  .addSubMenu(Color.parseColor("#8A39FF"), R.mipmap.icon_setting)
  .addSubMenu(Color.parseColor("#FF6A00"), R.mipmap.ic_choice)
  .addSubMenu(Color.parseColor("#FF6A00"), R.mipmap.ic_add)
  .setOnMenuSelectedListener(OnMenuSelectedListener {
    onMenuSelected = function(i)
        if i == 0 then
            local items = { "普通工程", "网页工程" }--创建有数据的列表，添加即在后面加上,"项目名称"
            AlertDialog.Builder(this)
                       .setTitle("列表对话框")--设置标题
                       .setItems(items, { onClick = function(l, v)
                if items[v + 1] == "网页工程" then
                    addProjects({
                        DialogById = "dia",
                        create = function()
                            if projectName.getText() == nil or projectName.getText() == "" then
                                projectName.EditText.Error = "请输入名称"
                                return
                            end
                            if #packageName.getText() == 4 then
                                local pinyin = require 'pinyin'
                                packageName.setText("com." .. pinyin(projectName.getText(), true, ""))
                                print("自动输入包名", success)
                            else
                                Add_Webview_Project(projectName.getText(), packageName.getText());
                                dia.dismiss();
                            end
                        end,
                        close = function()
                            dia.dismiss();
                        end,
                    })
                elseif items[v + 1] == "普通工程" then
                    addProjects({
                        DialogById = "dia",
                        create = function()
                            if projectName.getText() == nil or projectName.getText() == "" then
                                projectName.EditText.Error = "请输入名称"
                                return
                            end
                            if #packageName.getText() == 4 then
                                local pinyin = require 'pinyin'
                                packageName.setText("com." .. pinyin(projectName.getText(), true, ""))
                                print("自动输入包名", success)
                            else
                                Add_Project(projectName.getText(), packageName.getText());
                                dia.dismiss();
                            end
                        end,
                        close = function()
                            dia.dismiss();
                        end,
                    })
                end
            end })
                       .show()--显示弹窗
        elseif i == 1 then
            eds.setVisibility(View.VISIBLE)
            import "android.view.animation.*"
            eds.startAnimation(TranslateAnimation(0, 0, -eds.height, 0).setDuration(800))
            task(10000, function()
                eds.startAnimation(TranslateAnimation(0, 0, 0, -eds.height).setDuration(200))
                ed.setText("")
                eds.setVisibility(View.GONE)
            end)
        elseif i == 2 then
            activity.newActivity("layouthelper/help")
        elseif i == 3 then
            activity.newActivity("Controller/SettingController")
        elseif i == 4 then
            choicePath();
        elseif i == 5 then
            导入()
        end

    end


}).setOnMenuStatusChangeListener(OnMenuStatusChangeListener {
    onMenuOpened = function()
        -- print"已打开"
    end;

    onMenuClosed = function()
        --print"关闭"
        an.setVisibility(View.GONE)
    end

});

listdraw = RippleDrawable(ColorStateList(int[0].class { int {} }, int { 0x00000000 }), nil, ColorDrawable(0xffff8080))
project_list.setSelector(listdraw)

project_data = {}
project_data置顶 = {}
if this.getSharedData("主页布局") == "true" then
    project_list.numColumns = 1;
    project_adp = LuaAdapter(activity, project_data, layout.item2)

    project_adp置顶 = LuaAdapter(activity, project_data置顶, layout.item2)
    setFilter(project_adp)
    setFilter(project_adp置顶)
else
    project_list.numColumns = 1;
    project_adp = LuaAdapter(activity, project_data, layout.item3)

    project_adp置顶 = LuaAdapter(activity, project_data置顶, layout.item3)
    setFilter(project_adp)
    setFilter(project_adp置顶)
end

ed.EditText.addTextChangedListener {
    afterTextChanged = function(str)
        project_adp.filter(tostring(str))
        project_adp置顶.filter(tostring(str))
    end
}

project_list.setOnScrollListener {
    onScrollStateChanged = function(l, s)
        if project_list.getLastVisiblePosition() == project_list.getCount() - 1 then
            --   eds.setVisibility(View.VISIBLE)
        end
    end }

if path == "" then
    --没有路径加载
    --span字
    spannedDesc = SpannableString("长按可重新切换项目路径");
    --字体下划线
    --spannedDesc.setSpan(UnderlineSpan(),spannedDesc.length() - #"TapTargetView", spannedDesc.length(), 0)
    --创建一个TapTargetView
    --后面的参数,控件id,标题,内容
    TapTargetView.showFor(activity, TapTarget.forView(ooo, "IntelliJ Lua", spannedDesc)
    --外部背景色
                                             .dimColor(android.R.color.white)
    --标题和内容的文字颜色
                                             .textColor(android.R.color.black)
    --圆环背景色
                                             .outerCircleColor(android.R.color.white)
    --中间背景
                                             .transparentTarget(true)
    --true,返回键取消显示
                                             .cancelable(true)
                                             .drawShadow(true)
                                             .tintTarget(false))
    choicePath()

    ChoosePath.setVisibility(View.VISIBLE)--选择路径按钮
    importProject.setVisibility(View.INVISIBLE)--隐藏导入工程按钮
else
    ChoosePath.setVisibility(View.GONE)
    importProject.setVisibility(View.VISIBLE)
    水珠动画(importProject, 850)
    projectRefresh()
end
ooo.onLongClick = function()
    choicePath()
end
pulltwo.setRefreshStyle(PullRefreshLayout.STYLE_MATERIAL);

pulltwo.onRefresh = function()
    projectRefresh()
    task(300, function()
        pulltwo.setRefreshing(false);
    end)
end
last = false
project_list.setOnItemClickListener(AdapterView.OnItemClickListener { --点击工程进入编辑模式
    onItemClick = function(parent, v, pos, id)
        name2 = v.Tag.project_name.Text
        if 文件是否存在(path .. name2 .. "/main.lua") then
            content = io.open(path .. name2 .. "/main.lua"):read("*a")
            activity.newActivity("CodeController", { name2, name2, content, nil })
        else
            Dialike("toast", Err)
                    .setGravity("bottom|center")
                    .setMessage("该工程目录\n没有main文件")
                    .setMessageColor(0xffd81e06)
                    .setMessageSize("15sp")
                    .setRadius("3dp")
                    .setElevation("30dp")
                    .setFocusable(false)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
                    .setOutsideTouchable(false)--设置外部区域不可点击 建议关闭
                    .show()
        end
    end
})

置顶.setOnItemClickListener(AdapterView.OnItemClickListener { --点击工程进入编辑模式
    onItemClick = function(parent, v, pos, id)
        name2 = v.Tag.project_name.Text
        project_packageNames = v.Tag.project_packageNames.Text

        if pcall(raw, "select * from user where project_packageNames='" .. project_packageNames .. "'", nil) and last == false then
            while (cursor.moveToNext()) do
                local luapath = cursor.getString(6);--获取第二列的值

                if 文件是否存在(luapath .. name2 .. "/main.lua") then
                    content = io.open(luapath .. name2 .. "/main.lua"):read("*a")
                    activity.newActivity("CodeController", { name, name2, content, luapath })
                else
                    Dialike("toast", Err)
                            .setGravity("bottom|center")
                            .setMessage("该工程目录\n没有main文件")
                            .setMessageColor(0xffd81e06)
                            .setMessageSize("15sp")
                            .setRadius("3dp")
                            .setElevation("30dp")
                            .setFocusable(false)--false 返回键直接终止该程序。默认为true 即允许返回键关闭对话框
                            .setOutsideTouchable(false)--设置外部区域不可点击 建议关闭
                            .show()
                end
            end
        end
    end
})

置顶.setOnItemLongClickListener(AdapterView.OnItemLongClickListener {
    onItemLongClick = function(parent, v, pos, id)
        project_title = v.Tag.project_title.Text
        project_name = v.Tag.project_name.Text
        icon = path .. project_name .. "/icon.png"
        project_version = v.Tag.project_version.Text
        project_packageNames = v.Tag.project_packageNames.Text
        last = true
        dialog = AlertDialog.Builder(this)
                            .setTitle("正在移除项目: " .. project_name)
                            .setMessage("移除该置顶并不会删除该项目")
                            .setPositiveButton("删除",
                { onClick = function(v)
                    last = false;
                    if pcall(exec, "delete from user where project_packageNames='" .. project_packageNames .. "'") then
                        print("移除置顶 " .. project_title .. " 成功", success)
                        projectRefresh()
                    else
                        print("移除置顶失败", err)
                    end
                end })
                            .setNeutralButton("取消", { onClick = function(v)
            last = false;
        end
        })
        argbDialog = dialog.create()
        argbDialog.setCanceledOnTouchOutside(false)
                  .show()
    end
})
project_list.setOnItemLongClickListener(AdapterView.OnItemLongClickListener {--列表长按事件
    onItemLongClick = function(parent, v, pos, id)
        project_title = v.Tag.project_title.Text
        project_name = v.Tag.project_name.Text
        icon = path .. project_name .. "/icon.png"
        project_version = v.Tag.project_version.Text
        project_packageNames = v.Tag.project_packageNames.Text
        project_luaPath = path
        list_Selet({
            list_Selet = "AttributeDlog",
            titleName = v.Tag.project_name.Text,
            project_title = v.Tag.project_title.Text,
            package = v.Tag.project_packageNames.Text,
            version = v.Tag.project_version.Text,
            pic = path .. project_title .. "/icon.png",
            table = { "置顶", "属性", "分享", "打包", "备份", "删除", },
            img_table = {
                "ic_attribute", "ic_attribute", "ic_share", "ic_pack", "ic_pack", "ic_remove", },
            onclickGrid = function(parent, v, pos, id)
                titleName = v.Tag.item_title.Text
                if titleName == "置顶" then
                    k = "'" .. icon .. "','" .. project_name .. "','" .. project_title .. "','" .. project_version .. "','" .. project_packageNames .. "','" .. project_luaPath .. "'"
                    sql = "insert into user(project_icon,project_name,project_title,project_version,project_packageNames,project_luaPath) values(" .. k .. ")"
                    if pcall(exec, sql) then
                        print("置顶成功", success)
                    else
                        print("置顶失败", err)
                    end
                    projectRefresh()
                    AttributeDlog.dismiss()
                end
                if titleName == "属性" then
                    activity.newActivity("Controller/main", { path .. project_name });
                    AttributeDlog.dismiss()
                end
                if titleName == "备份" then

                    INSERT("Backup_Project", project_name, "已备份")
                    export(SELECT("Project_Path", SELECT("User_option", "Value")) .. project_name)
                    print("已备份到 storage/emulated/0/IntelliJ Lua/backup", info)
                    AttributeDlog.dismiss()
                end
                if titleName == "分享" then
                    --print(export(SELECT("Project_Path", SELECT("User_option", "Value")) .. project_name))
                    --Share.shareFile(this,export(SELECT("Project_Path", SELECT("User_option", "Value")) .. project_name))
                   print("遇到了点问题",err)
                    AttributeDlog.dismiss()
                end
                if titleName == "打包" then
                    --import "bin"
                    --bin(path..project_title.."/")
                    activity.newActivity("Controller/bin", { path .. project_name .. "/" })
                    AttributeDlog.dismiss()
                end
                if titleName == "统计" then
                    print("该功能出现了一些小问题", err)
                end
                if titleName == "删除" then
                    deletePreject({
                        标题 = title,
                        项目名称 = project_title,
                        对话框id = "deleteDlog",
                        close = function()
                            deleteDlog.dismiss()
                        end,
                        delete = function()
                            version_release = Build.VERSION.RELEASE --设备的系统版本
                            if tonumber(version_release) == tonumber(11) then
                                print("由于Google限制 安卓11 扫描及删除性能下降,请耐心等待", defaul)
                            end
                            pcall(function()
                                LuaUtil.rmDir(File(path .. project_name .. "/"))
                                projectRefresh()
                            end)
                            deleteDlog.dismiss()
                        end, })
                    AttributeDlog.dismiss()
                end
            end })
        return true
    end
})

function getalpinfo(path)
    local app = {}
    loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()
    local str = string.format("名称: %s\
        版本: %s\
        包名: %s\
        作者: %s\
        说明: %s\
        路径: %s",
            app.appname,
            app.appver,
            app.packagename,
            app.developer,
            app.description,
            path
    )
    return str, app.mode
end

function imports(path)
    create_imports_dlg()
    local mode
    imports_dlg.Message, mode = getalpinfo(path)
    if mode == "plugin" or path:match("^([^%._]+)_plugin") then
        imports_dlg.setTitle("导入插件")
    elseif mode == "build" or path:match("^([^%._]+)_build") then
        imports_dlg.setTitle("打包安装")
    end
    imports_dlg.show()
end

function importx(path, tp)
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
        output.close()
    end

    local f = File(path)
    local app = {}
    loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()

    local s = app.appname or f.Name:match("^([^%._]+)")
    local out = activity.getLuaExtDir("project") .. "/" .. s

    if tp == "build" then
        out = activity.getLuaExtDir("bin/.temp") .. "/" .. s
    elseif tp == "plugin" then
        out = activity.getLuaExtDir("plugin") .. "/" .. s
    end
    local d = File(out)
    if autorm then
        local n = 1
        while d.exists() do
            n = n + 1
            d = File(out .. "-" .. n)
        end
    end
    if not d.exists() then
        d.mkdirs()
    end
    out = out .. "/"
    local zip = ZipFile(f)
    local entries = zip.entries()
    for entry in enum(entries) do
        local name = entry.Name
        local tmp = File(out .. name)
        local pf = tmp.ParentFile
        if not pf.exists() then
            pf.mkdirs()
        end
        if entry.isDirectory() then
            if not tmp.exists() then
                tmp.mkdirs()
            end
        else
            copy(zip.getInputStream(entry), FileOutputStream(out .. name))
        end
    end
    zip.close()
    function callback2(s)
        LuaUtil.rmDir(File(activity.getLuaExtDir("bin/.temp")))
        bin_dlg.hide()
        bin_dlg.Message = ""
        if s == nil or not s:find("成功") then
            create_error_dlg()
            error_dlg.Message = s
            error_dlg.show()
        end
    end

    if tp == "build" then
        bin(out)
        return out
    elseif tp == "plugin" then
        Toast.makeText(activity, "导入插件." .. s, Toast.LENGTH_SHORT).show()
        return out
    end
    luadir = out
    luapath = luadir .. "main.lua"
    read(luapath)
    Toast.makeText(activity, "导入工程." .. luadir, Toast.LENGTH_SHORT).show()
    return out
end

function create_imports_dlg()
    if imports_dlg then
        return
    end
    imports_dlg = AlertDialogBuilder(activity)
    imports_dlg.setTitle("导入工程")
    imports_dlg.setPositiveButton("确定", {
        onClick = function()
            local arg = imports_dlg.Message:match("路径: (.+)$")
            decompression(arg, SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg))
            if File(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg) .. "/init.lua").exists() then
                m = io.open(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg) .. "/init.lua"):read("*a")
                getName = m:match([[appname="(.-)"]])
                File(SELECT("Project_Path", SELECT("User_option", "Value")) .. 取文件名无后缀(arg)).renameTo(File(SELECT("Project_Path", SELECT("User_option", "Value")) .. getName))
            end
            projectRefresh()
        end })
    imports_dlg.setNegativeButton("取消", nil)
end

function onNewIntent(intent)
    local uri = intent.getData()
    if uri and uri.getPath():find("%.alp$") then
        imports(uri.getPath():match("/storage.+") or uri.getPath())
    end
end

参数 = 0
function onKeyDown(code, event)
    if string.find(tostring(event), "KEYCODE_BACK") ~= nil then

        if 参数 + 2 > tonumber(os.time()) then
            activity.finish()
        else
            if an.isOpened() then
                an.closeMenu()
            else

                print("再按一次退出", success)
                参数 = tonumber(os.time())

            end
        end
        return true
    end
end