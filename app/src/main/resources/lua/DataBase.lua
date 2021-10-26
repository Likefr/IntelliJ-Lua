
--[[
 INSERT INSERT("likefr","test","123456")
--print(SELECT("Key","values"))
--删除(库名,键)
--清空(库名)
--导入(库名,数组)
--导出(库名)--返回数组
--列表()--返回配置列表，数组类型
print(列表("likefr"))--返回配置的所有键,数组类型

--本模块只支持存储string boolean number function类型数据，其他类型将会以string类型存储
--数据存储在文件中，只有卸载APP，或使用清空()函数，否则数据不会丢失
--©2019-2020 狸猫版权所有
]]



function INSERT(a,b,str)
  import "android.content.Context"
  --获取SharedPreferences文件，后面的第一个参数就是文件名，没有会自己创建，有就读取
  sp = activity.getSharedPreferences(a, Context.MODE_PRIVATE)
  --设置编辑
  sped = sp.edit()
  sp_str=str
  sp_str1=str1
  --设置键值对
  switch type(str)
   case "boolean"
    sped.putBoolean(b,sp_str)
   case "number"
    sped.putFloat(b,sp_str)
   case "function"
    sped.putString(b,"(Lua_Function)"..string.dump(sp_str))
   case
    sped.putString(b,tostring(sp_str))
  end
  --提交保存数据
  sped.commit()
end


function SELECT(a,b)

  import "android.content.Context"
  --获取SharedPreferences文件
  sp = activity.getSharedPreferences(a, Context .MODE_PRIVATE)
  --打印对应的值
  sp_str=tostring(b)
  sp_str11={"String","Boolean","Float"}
  sp_str12={"",true,0}
  sp_str2=0
  function sp_str3(b1)
    sp_str2=sp_str2+1
    xpcall(function()
      b1(sp_str11[sp_str2],sp_str12[sp_str2])
    end,function()
      sp_str3(b1)
    end)
  end

  sp_str3(function(a2,b2)
    sp_str4=sp["get"..a2](sp_str,b2)
    if a2=="String" and sp_str4:find("^%(Lua_Function%)")~=nil then
      sp_str4=loadstring(sp_str4:gsub("^%(Lua_Function%)",""))
    end
  end)
  return sp_str4
end
function DELETE(a,b)
  local c=io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml"):read("*a")
  local d=string.gsub(c,[[[%s]-<string name="]]..b..[[">.-</string>%s-]],"")
  io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml","w"):write(d):close()
  local c=io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml"):read("*a")
  local e=string.match(c,[[[%s]-<string name=".-">.-</string>%s-]])
  if e==nil then
    os.remove("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml")
  end
end

function CLEAR(a)
  os.remove("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml")
end
function 导入(a,b)
  if type(b)=="table" then
    cbc=b
   else
    local function 调用(fun)
      import "java.io.File"
      io.open("/storage/emulated/0/android/dofile.l","w"):write(fun):close()
      dofile("/storage/emulated/0/android/dofile.l")
    end
    调用("cbc="..b)
  end
  for k,v in pairs(cbc)
    写入(a,tostring(k),v)
  end
end
function 导出(a)
  local function 高级截取(内容,str)
    local ii=0
    local 截取1={}

    for i in 内容:gmatch(str)
      ii=ii+1
      截取1[ii]=i
    end
    return 截取1
  end
  截取2={}
  for k,v in pairs(高级截取(io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml"):read("*a"),[[[%s]-<%w- name="(.-)">?.-<?/%w->%s-]]))
    截取2[v]=读取(a,v)
  end
  return 截取2
end

function List_Data(a)--列表
  if a==nil then
    function 数组(str, split_char)
      数量=#split_char
      local sub_str_tab = {}
      while (true) do
        local pos = string.find(str, split_char)
        if (not pos) then
          sub_str_tab[#sub_str_tab + 数量] = str
          break
        end
        local sub_str = string.sub(str, 1, pos-数量)
        sub_str_tab[#sub_str_tab + 数量] = sub_str
        str = string.sub(str, pos + 数量, #str)
      end
      return sub_str_tab
    end
    import("java.io.File")
    local b=luajava.astable(File("/data/data/"..activity.getPackageName().."/shared_prefs/").listFiles())
    local c={}
    local function 高级截取(内容,str)
      local ii=0
      local 截取1={}

      for i in 内容:gmatch(str)
        截取1[#截取1+1]=i
      end
      return 截取1
    end
    for k,v in pairs(b)
      v=数组(tostring(v),"/")
      v=v[#v]
      c[string.match(v,"(.-)%.xml")]=高级截取(io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..string.match(v,"(.-)%.xml")..".xml"):read("*a"),[[[%s]-<%w- name="(.-)">?.-<?/%w->%s-]])
    end
    return c

   else

    local function 高级截取(内容,str)
      local ii=0
      local 截取1={}

      for i in 内容:gmatch(str)
        截取1[#截取1+1]=i
      end
      return 截取1
    end
    return {a,高级截取(io.open("/data/data/"..activity.getPackageName().."/shared_prefs/"..a..".xml"):read("*a"),[[[%s]-<%w- name="(.-)">?.-<?/%w->%s-]])}

  end
end