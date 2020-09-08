<form>
<script_entry><![CDATA[
Time_num = 15    --倒计时穿戴时间

Del_item = {    --不需要提示引导的装备
--"神武之刃",
}

Att_item = {
{ITEM_PROP_MAXPHYDEF, ITEM_PROP_MINPHYDEF},    --物防上限，物防下限
{ITEM_PROP_MAXMAGDEF, ITEM_PROP_MINMAGDEF},    --魔防上限，魔防下限
{ITEM_PROP_MAXPHYATK, ITEM_PROP_MINPHYATK},        --攻击上限，攻击下限
{ITEM_PROP_HP, ITEM_PROP_HP},                    --生命
{ITEM_PROP_MP, ITEM_PROP_MP},                    --魔法
{ITEM_PROP_HIT, ITEM_PROP_HIT},                --命中
{ITEM_PROP_BURST, ITEM_PROP_BURST},                --爆击率
{ITEM_PROP_ATTACKSPEED, ITEM_PROP_ATTACKSPEED},    --攻击速度
{ITEM_PROP_MAGMISS, ITEM_PROP_MAGMISS},            --魔法躲避
{ITEM_PROP_MISS, ITEM_PROP_MISS},                --敏捷（闪避）
{ITEM_PROP_MAXMAGATK, ITEM_PROP_MINMAGATK},        --魔攻上限，魔攻下限
{ITEM_PROP_MAXTAOATK, ITEM_PROP_MINTAOATK},        --道术上限，道术下限
}

Att_Name = {
{"物防:", ""},
{"魔防:", ""},
{"物攻:", ""},
{"生命:", ""},
{"魔法:", ""},
{"命中:", ""},
{"暴击:", ""},
{"攻速:", "%"},
{"魔免:", ""},
{"闪避:", ""},
{"魔攻:", ""},
{"道术:", ""},
}


]]></script_entry>

<dialog id= "装备引导2" x = "0" y = "0" w ="256" h = "191" image = "1804600001" close = "0" magic = "1" OnInit = "zhuangbei_yindao2.Init" OnDestroy = "zhuangbei_yindao2.OnClose" >
<richedit id = "文字1" x = "80" y ="11" w = "200" h = "30" text = "获得更高级装备" font = "TitleFont1" text_color = "GOLD" />
<edit id = "物品名" x = "0" y = "33" w= "256" h = "22" align = "center" />
<button id = "关闭" x = "220" y ="1" image = "1803400011" tip = "关闭|暂不穿戴" OnLButtonClick = "zhuangbei_yindao2.Close"/>
<wnd id = "文本" x = "86" y = "76" w = "700" h = "155" >
</wnd>
<wnd id = "文本2" x= "159" y = "76" w = "700" h ="155">
</wnd>
<image id ="背景" x = "21" y = "74" image = "1803100002" />
<itemctrl id = "物品" x = "27" y = "80" w = "48" h = "48" count= "1" use_back = "0" fitsize = "true" />
<image id = "物品框BG" x = "20" y ="73" w = "60" h = "60" image = "0" fitsize = "true" />
<image id = "加号" x = "42" y = "80" image = "1900414100" visible= "0" />
<image id = "数字1" x= "61" y = "80" />
<image id= "数字2" x = "51" y = "80" />
<button id = "按钮" x = "60" y ="143" w = "50" h = "50" image = "1804600002" OnLButtonClick = "zhuangbei_yindao2.Ok" />
<image id = "倒计时" x = "200" y = "143" image = "1800000162" />
<edit id = "时间" x = "203" y= "149" w = "31" h = "20" text ="5" align = "center" />
</dialog>

<script_entry><![CDATA[
local this_file = "装备引导2.laye:"
local arg = FormParam
local t = zhuangbei_yindao2
if nil == zhuangbei_yindao2 then
zhuangbei_yindao2 = {}
t = zhuangbei_yindao2
t.list = {}
t.OnCallBack = function () --回调
t.data = nil
local count = #t.list
if count > 0 then
local guid = t.list[count]
table.remove(t.list, count)
GenForm("装备引导2#"..guid)
end
end
end

if not UI:Lua_GetPlayerStatus() or LuaRet ~= 2 then
return false
end

if not UI:Lua_GetPlayerSelfProperty32(ROLE_PROP32_JOB) then
--log(this_file.."获取职业失败")
return false
end

if LuaRet == 0 then
return false
end

-- local job = RDJOBName[LuaRet]
if #arg ~= 1 then
--log(this_file.."传递参数格式不正确，期望1个参数。")
return false
end

local guid = arg[1]
if zhuangbei_yindao2.data ~= nil then
table.insert(zhuangbei_yindao2.list, 1, guid)
return false
end

if guid == "" or guid == nil then
t.OnCallBack()
return false
end

if not UI:Lua_GetItemTemplateHandleByGUID(guid) or LuaRet == 0 then
--log(this_file.."参数传递错误，无法获取装备信息。")
t.OnCallBack()
return false
end
local th = LuaRet --模版句柄
if not UI:Lua_GetItemTemplatePropByHandle(th, ITEM_PROP_TYPE) then
--log(this_file.."根据模版句柄获取装备主类型失败")
t.OnCallBack()
return false
end
local type = LuaRet
if type ~= 1 then
return false
end --非装备

if not UI:Lua_GetItemTemplatePropByHandle(th, ITEM_PROP_SUBTYPE) then
--log(this_file.."根据模版句柄获取装备子类型失败")
t.OnCallBack()
return false
end
local sub = LuaRet
--local ItemGUIData = CL:GetEquimentItemDataPart(446)
--CL:GetItemGUIDataPropByType(ItemGUIData, 3)
--local cs = LuaRet
--CL:GetItemTemplatePropByID(cs, 1)
--msg(""..LuaRet)
local config =
{
[1] = 1,
[2] = 2,
[3] = 3,
[4] = 3,
[5] = 4,
[6] = 5,
[7] = 6,
[8] = 7,
[9] = 8,
[10] = 9,
[11] = 9,
[12] = 10,
[13] = 11,
[14] = 12,
[15] = 13,
[16] = 14,
[17] = 15,
[18] = 16,
[19] = 17,
[20] = 18,
[21] = 19,
[22] = 20,
[23] = 21,
[24] = 21,
[25] = 22,
[26] = 23,
[27] = 24,
[28] = 25,
[29] = 26,
[30] = 27,
[31] = 28,
[32] = 29,
[33] = 30,
[34] = 31,
[35] = 32,
[36] = 33,
[37] = 34,
[38] = 35,
[39] = 36,
[40] = 37,
[41] = 38,
[42] = 39,
[43] = 40,
[44] = 41,
[45] = 42,
[46] = 43,
[47] = 44,
[48] = 45,
[49] = 46,
[50] = 47,
[51] = 48,
[52] = 49,
[53] = 50,
[54] = 51,
[55] = 52,
[56] = 53,
[57] = 54,
[58] = 55,
[59] = 56,
[60] = 57,
[61] = 58,
[62] = 59,
[63] = 60,
[64] = 61,
}


if config[sub] == nil then
t.OnCallBack()
return false
end

--获取装备的索引名字
if not UI:Lua_GetItemTemplatePropByHandle(th, ITEM_PROP_KEYNAME) then
--log(this_file.."根据模版句柄获取装备索引名失败")
t.OnCallBack()
return false
end
local key = LuaRet
--检查是否有不提示的道具
for i = 1, #Del_item do
if key == Del_item[i] then
t.OnCallBack()
return false
end
end

--获取装备的攻击下限
if not UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_MINPHYATK) then
t.OnCallBack()
return false
end
local Att_1 = LuaRet

--获取装备的攻击上限
if not UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_MAXPHYATK) then
t.OnCallBack()
return false
end
local Att_2 = LuaRet

local Lv_idx = 0
for k, v in ipairs(Att_item) do
for i = 1, #v do
if UI:Lua_GetItemEntityPropByGUID(guid, v[i]) and LuaRet ~= 0 then
Lv_idx = Lv_idx + LuaRet
end
end
end

--给翅膀用 by:张魁-------
if not CL:GetItemEntityPropByGUID(guid, ITEM_PROP_SUBTYPE) then
return false
end
local subType = LuaRet
--if Lv_idx <= 0 and subType ~= 12 then
if Lv_idx <= 0 then
return false
end

-- 跟踪级别
local idx_num = 0
--if UI:Lua_GetItemTemplatePropByHandle(th, ITEM_PROP_TRACK) then
--if LuaRet ~= "" and LuaRet ~= "0" then
--idx_num = tonumber(LuaRet)*99999999
--end
--end

local val = Lv_idx + idx_num

---使用性别
if not UI:Lua_GetItemTemplatePropByHandle(th, ITEM_PROP_GENDER) then
t.OnCallBack()
return false
end

local r_sex = LuaRet
if not UI:Lua_GetPlayerSelfPropBase(ROLE_PROP_SEX) then
--获取玩家性别
t.OnCallBack()
return false
end

if r_sex ~= 0 and r_sex ~= LuaRet then
t.OnCallBack()
return false
end

if not UI:Lua_GetPlayerSelfEquipData() then
--获取玩家装备数据
t.OnCallBack()
return false
end

local tbl = LuaRet
local num1 = 0
for k, v in pairs(config) do
if v == sub then
num1 = k
break
end
end
for i = 1, #tbl do
local guid2 = tbl[i]
------测试装备位置----------
--UI:Lua_GetItemEntityPropByGUID(guid2, ITEM_PROP_ENTITY_NAME)
--local cesname = LuaRet
--msg(i.."--"..tostring(cesname))
-----------------------------
if "0" == guid2 or "" == guid2 then
local legal = false
if i == num1 then
legal = true
end


if legal then
UI:Lua_GUID2Str(guid); guid = LuaRet
zhuangbei_yindao2.data = {guid, ""}
break
end
else
local type2, sub2
if UI:Lua_GetItemEntityPropByGUID(guid2, ITEM_PROP_TYPE) then
--装备类型
type2 = LuaRet
end
if UI:Lua_GetItemEntityPropByGUID(guid2, ITEM_PROP_SUBTYPE) then
--装备子类型
sub2 = LuaRet
end

local refine, refine2
if UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_EQUIP_REFINELEVEL) then
--拾取的装备精炼等级[自动穿戴]
refine = LuaRet
end
if UI:Lua_GetItemEntityPropByGUID(guid2,ITEM_PROP_EQUIP_REFINELEVEL) then
--玩家身上的装备精炼等级
refine2 = LuaRet
end
if type2 ~= nil and sub2 ~= nil and type == type2 and sub == sub2 then
local Lv_idx2 = 0
for k, v in ipairs(Att_item) do
for i= 1, #v do
if UI:Lua_GetItemEntityPropByGUID(guid2, v[i]) and LuaRet ~= 0 then
Lv_idx2 = Lv_idx2 + LuaRet
end
end
end
local idx_num2 = 0
--if UI:Lua_GetItemEntityPropByGUID(guid2, ITEM_PROP_TRACK) then
--if LuaRet ~= "" and LuaRet ~= "0" then
--idx_num2 = tonumber(LuaRet)*99999999
--end
--end
Lv_idx2 = Lv_idx2 + idx_num2
if Lv_idx2 ~= "" and Lv_idx2 ~= "0" and Lv_idx2 < val or refine > refine2 and Lv_idx2 <= val then
UI:Lua_GUID2Str(guid); guid = LuaRet
UI:Lua_GUID2Str(guid2); guid2 = LuaRet
zhuangbei_yindao2.data = {guid, guid2}
break
end
--张魁，翅膀
--[[if sub == 12 and sub2 == 12 then
    local isShow = t.isShow(guid,guid2)
    if isShow then
        UI:Lua_GUID2Str(guid); guid = LuaRet
        UI:Lua_GUID2Str(guid2); guid2 = LuaRet
        zhuangbei_yindao2.data = {guid, guid2}
        break
    end
end--]]
end
end
end
if zhuangbei_yindao2.data == nil then
t.OnCallBack()
return false
end
return true
]]></script_entry>

<script><![CDATA[
local this_file = "装备引导2.laye:"
local t = zhuangbei_yindao2
local img_Num = {1900413200, 1900413300, 1900413400, 1900413500, 1900413600,1900413700, 1900413800, 1900413900, 1900414000, 1900413100}
local tItemCtrlCircle = {
["WHITE"] = 1855810048,
["GREENG"] = 1855810049,
["BLUE"] = 1855810050,
["PURPLE"] = 1855810051,
["GOLD"] = 1855810052,
["RED"] = 1855810053
}
t.Init = function (this)
UI:Lua_GetScreenSize()
local width = LuaRet[1]
local height = LuaRet[2]
WndSetPosM(this, "parent,装备引导2", width /2 +184, height * 0.47)
------------------------------------------
EditSetText(nil, "装备引导2,时间", tostring(Time_num))
if t.data == nil then
--log(this_file.."Init 表中数据异常，未检测到数据")
WndClose(this)
return
end
UI:Lua_Str2GUID(t.data[1])
local guid = LuaRet                --获得的装备
UI:Lua_Str2GUID(t.data[2])
local guid2 = LuaRet            --穿戴的装备
RDItemCtrlSetGUIDataPropByGUID(this, "物品", guid)
local name = ""
local color = "WHITE"
local Lv_num = 0
if UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_ENTITY_NAME) then
name = LuaRet
end
for k, v in pairs(Att_item) do
local kongwei_t = {}
for i = 1, #Att_item do
local txt_zhi = EditGetTextM(nil, "装备引导2,文本,说明"..i)
if txt_zhi == "" then
kongwei_t[#kongwei_t+1] = i
end
end
local Att_1, Att_2,Atts_1, Atts_2, Att_3 = 0, 0,0, 0, 0
if guid2 ~= "" then
if UI:Lua_GetItemEntityPropByGUID(guid2, v[1]) and LuaRet ~= 0 then
--身上的装备(上限)
Atts_1 = LuaRet
end
if UI:Lua_GetItemEntityPropByGUID(guid2, v[2]) and LuaRet ~= "" or LuaRet ~= nil then
--身上的装备(下限)
Atts_2 = LuaRet
end
end

if UI:Lua_GetItemEntityPropByGUID(guid, v[1]) and LuaRet ~= 0 then
--获得的装备(上限)
Att_1 = LuaRet
if UI:Lua_GetItemEntityPropByGUID(guid, v[2]) and LuaRet ~= "" or LuaRet ~= nil then
--获得的装备(下限)
Att_2 = LuaRet
if UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_EQUIP_REFINELEVEL) then
--获得的装备精炼等级
Att_3 = tonumber(LuaRet)
local str = "<form default_parent=装备引导2,文本>"
if kongwei_t[1] <= 3 then
str = str .. "<edit id=说明"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 - 5).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 24).." w=80 h=20 text="..Att_Name[k][1].." text_color=BROWN />"
if v[1] == v[2] then
Atts_1 = Att_1 - Atts_1
Att_1 = t.SetValue(Att_1)
Atts_1 = t.SetValue(Atts_1)
str = str .. "<edit id=属性"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 + 25).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 24).." w=80 h=20 text=+"..Att_1..Att_Name[k][2].." text_color=GREENG />"
str = str .. "<edit id=提升"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 + 103).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 24).." w=80 h=20 text=(+"..Atts_1..Att_Name[k][2]..") text_color=BROWN />"
else
Atts_1 = Att_1 - Atts_1
Atts_2 = Att_1 - Atts_2
Att_1 = t.SetValue(Att_1)
Att_2 = t.SetValue(Att_2)
Atts_1 = t.SetValue(Atts_1)
str = str .. "<edit id=属性"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 + 25).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 24).." w=80 h=20 text="..Att_2.."-"..Att_1.." text_color=GREENG />"
str = str .. "<edit id=提升"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 + 103).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 24).." w=80 h=20 text=(+"..Atts_1..") text_color=BROWN />"
end
str = str .. "<image id=上升"..kongwei_t[1].." x="..(((kongwei_t[1] - 1) % 1) * 75 + 93).." y="..(math.ceil(kongwei_t[1] / 1) * 20 - 22).." image=1803100004 />"
end
str = str .. "</form>"
GenFormByString(str)
t.Setshu(Att_3)
table.remove(kongwei_t, 1)
end
end
end
end
--张魁，翅膀

--[[if not CL:GetItemEntityPropByGUID(guid,ITEM_PROP_SUBTYPE) then
    return
end
local subType = LuaRet
if subType == 12 then
    local str = "<form default_parent=装备引导2,文本>"
    local isShow,quality1 = t.isShow(guid,guid2)
    if isShow then
        local str1 = quality1.."阶翅膀"
        str = str .. "<edit id=说明 x=40 y=20 w=80 h=20 text="..str1.." text_color=BROWN />"
    end
    str = str .. "</form>"
    GenFormByString(str)
end--]]
if UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_COLOR) then
--获取装备的颜色
color = LuaRet
end
--if UI:Lua_GetItemEntityPropByGUID(guid, ITEM_PROP_TRACK) and LuaRet ~= "" and LuaRet ~= "0" then --获取装备的跟踪级别
--Lv_num = LuaRet
--name = name.."（"..Lv_num.."阶）"
--end
-- t.SetItem(this,guid)
local imageID = tItemCtrlCircle[color]
if imageID == nil then
imageID = 1855810048
end
ImageSetImageID(this, "物品框BG", imageID)
--物品框BG
EditSetText(this, "物品名", name)
EditSetTextColor(this, "物品名", mkcolor(color))
WndAddTimer(this, nil, 1, 1000, "zhuangbei_yindao2.shijian")
end
--自动穿戴
t.Ok = function (this)
if t.data == nil then
--log(this_file.."提交表单数据异常，guid信息丢失！")
else
UI:Lua_SubmitForm("服务端操作", "chuandai", t.data[2].."#"..t.data[1])
end
WndClose(this, "parent")
end
--设置装备

--[[t.SetItem = function(this,guid)
    if UI:Lua_GetItemTemplateHandleByGUID(guid) then
        local _Handle = LuaRet
        if UI:Lua_GetItemTemplatePropByHandle(_Handle,ITEM_PROP_TIPSICON) then
            local _TipsIcon = LuaRet
            if IsTextureExists(_TipsIcon) then
                ImageSetImageID(nil, "装备引导2,物品", 1990000000)
                ImageSetImageID(nil, "装备引导2,物品", _TipsIcon)
            end
        end
    end
end--]]

--字符分割函数
--[[function string.split(str, delimiter)
    if str==nil or str=="" or delimiter==nil then
        return nil
    end
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end--]]

--关闭界面
t.OnClose = function (this)
UI:Lua_AddDelayTask("zhuangbei_yindao2.OnCallBack()", 1000, 1)
end

zhuangbei_yindao2.Close = function (this)
WndClose(this, "parent")
end

local num = 0
zhuangbei_yindao2.shijian = function(this, timer_id)
num = num + 1
if num > Time_num then
WndClick(nil, "装备引导2,按钮")
WndClose(nil, "装备引导2")
num = 0
end
EditSetText(nil, "装备引导2,时间", ""..(Time_num-num).."")
end

--设置装备精炼星数
t.Setshu = function (Nums)
local Nums = tonumber(Nums)
ImageSetImageID(nil, "装备引导2,数字1", 0)
ImageSetImageID(nil, "装备引导2,数字2", 0)
if Nums > 0 then
WndSetVisible(nil, "装备引导2,加号", true)
end
local leftNum = 0
local tb_leftNum = {}
local posFlag = 1
while Nums > 0 do
leftNum = Nums % 10
Nums = math.floor(Nums/10)
if leftNum == 0 then
leftNum = 10
end
tb_leftNum[posFlag] = leftNum
posFlag = posFlag + 1
end
local startPoint = 2 - #tb_leftNum + 1
local pointFlag = 1
for i = startPoint, 2 do
ImageSetImageID(nil, "装备引导2,数字"..i, img_Num[tb_leftNum[pointFlag]])
pointFlag = pointFlag + 1
end
end

--物攻魔攻之类的，超过10万数值进行缩减 by：张魁----------------------
function t.SetValue(value)
local str1 = ""
if value >= 100000 then
local num11, num12 = 0, 0
num11 = math.floor(value/10000)
num12 = math.floor((value - num11*10000)/1000)
str1 = num11.."."..num12.."W"
else
str1 = tostring(value)
end
return str1
--return value
end

--判断是否显示翅膀 by:张魁------------
--[[function t.isShow(guid,guid2)
    local ehandle1,ehandle2,quality1,quality2 = 0,0,0,0
    if UI:Lua_GetItemEntityHandleByGUID(guid) then
        ehandle1 = LuaRet
    end
    if UI:Lua_GetItemEntityCustomVarInt(ehandle1, "wingQuality") then
        if LuaRet > 0 then
            quality1 = LuaRet
        end
    end
    if guid2 ~= nil and tonumber(guid2) ~= 0 then
        if UI:Lua_GetItemEntityHandleByGUID(guid2) then
            ehandle2 = LuaRet
        end
        if UI:Lua_GetItemEntityCustomVarInt(ehandle2, "wingQuality") then
            if LuaRet > 0 then
                quality2 = LuaRet
            end
        end
    end
    return quality1 > quality2,quality1
end--]]

]]></script>
</form>