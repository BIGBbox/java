-----------------------------------------------------------------------------------------;
----- gh_斗兽场表单.lua  Powered By 孙钰淞  yqwb.com（一起玩吧）Design ----- 2019.10.16--;
-----------------------------------------------------------------------------------------;
local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")
require("system/通用配置")
lualib:SetFormAllowFunc({ "show", "EnterMap" })

local tab = {                                               --13 044 06300   00400
    --地图索引    booss索引,出生时间分钟,客户端显示复活时间      模型img   前五位id 坐标x y  复活时间分钟  推荐战力
    { "斗兽场1", "斗兽boss1", 30, "45分钟", 1304006300, 13040, -240, -200, 45, "75W", },
    { "斗兽场2", "斗兽boss2", 35, "1个小时", 1303706300, 13037, -240, -180, 60, "105W", },
    { "斗兽场3", "斗兽boss3", 40, "1小时15分钟", 1303606300, 13036, -250, -180, 75, "140W", },
    { "斗兽场4", "斗兽boss4", 45, "1小时30分钟", 1303506300, 13035, -250, -180, 90, "170W", },
    { "斗兽场5", "斗兽boss5", 50, "1小时45分钟", 1303306300, 13033, -250, -135, 105, "200W", },
    { "斗兽场6", "斗兽boss6", 55, "2小时", 1306706300, 13067, -250, -150, 120, "210W", },
    { "斗兽场7", "斗兽boss7", 60, "2小时15分钟", 1305906300, 13059, -250, -155, 135, "240W", },
    { "斗兽场8", "斗兽boss8", 65, "2小时30分钟", 1304406300, 13044, -220, -135, 150, "260W", },
    { "斗兽场9", "斗兽boss9", 70, "2小时45分钟", 1305006300, 13050, -350, -240, 165, "280W", },
    { "斗兽场10", "斗兽boss10", 75, "3小时", 1303406300, 13034, -250, -135, 180, "300W", },
    { "斗兽场11", "斗兽boss11", 80, "3小时15分钟", 1308406300, 13084, -300, -250, 195, "350W", },
    { "斗兽场12", "斗兽boss12", 85, "3小时30分钟", 1306406300, 13064, -210, -180, 210, "400W", },
    { "斗兽场13", "斗兽boss13", 90, "3小时45分钟", 1308206300, 13082, -230, -200, 225, "450W", },
    { "斗兽场14", "斗兽boss14", 95, "4小时", 1308306300, 13083, -250, -200, 240, "500W", },
    { "斗兽场15", "斗兽boss15", 100, "4小时15分钟", 1307906300, 13079, -250, -135, 255, "600W", },

}

local mapTable = {
    ["斗兽场1"] = 1,
    ["斗兽场2"] = 2,
    ["斗兽场3"] = 3,
    ["斗兽场4"] = 4,
    ["斗兽场5"] = 5,
    ["斗兽场6"] = 6,
    ["斗兽场7"] = 7,
    ["斗兽场8"] = 8,
    ["斗兽场9"] = 9,
    ["斗兽场10"] = 10,
    ["斗兽场11"] = 11,
    ["斗兽场12"] = 12,
    ["斗兽场13"] = 13,
    ["斗兽场14"] = 14,
    ["斗兽场15"] = 15,

}

function ifAddMagic(player)

    local list = GetPlayer(player)
    for i = 1, #list.Kill do
        if list.Kill[i] == 1 then
            lualib:Player_RunScript(player, "右上图标:Add_Magic", "挑战BOSS")
            return ""
        end
    end
    lualib:Player_RunScript(player, "右上图标:Del_Magic", "挑战BOSS")
end

--=============================斗兽场===========================
function show (player)
    local list = GetPlayer(player)
    lualib:ShowFormWithContent(player, "form文件表单", "gh_Colosseum#" .. serialize(list))
    return ""
end

---------------------------------------------------------------------------获取数据-----------------------------------------------------------------------------------------
function GetPlayer(player)
    local list = {}
    list.tables = tab
    list.GuaiName = {}  --怪物的名字
    list.Kill = {}     --变量 0 未刷新 1已刷新
    list.KillTimer = {} --变量 击杀时间
    list.UpTimer = {} --变量 刷新时间
    list.Powered = {} --推荐战力


    for i = 1, #list.tables do
        table.insert(list.Powered, list.tables[i][10])
        table.insert(list.GuaiName, lualib:KeyName2Name(list.tables[i][2], 2))
        local MapGuai = lualib:Map_GetMapGuid(list.tables[i][1])
        table.insert(list.Kill, lualib:GetInt(MapGuai, "BossKill"))
        table.insert(list.KillTimer, lualib:GetInt(MapGuai, "BossKillTimer"))

        if lualib:GetInt(MapGuai, "BossKillTimer") == 0 then
            lualib:SetInt(MapGuai, "BossKillTimer", lualib:GetAllTime())
        end
        table.insert(list.UpTimer, lualib:GetInt(MapGuai, "BossKillTimer") + list.tables[i][9] * 60 - lualib:GetAllTime())     ---还有多少时间刷新

    end

    return list
end

----------------------------------------------------------------------------进入地图-------------------------------------------------------------------------------
function EnterMap(player, param)
    param = tonumber(param)
    if param == nil then
        return ""
    end
    if param > #tab then
        TipsFun("请勿非法操作")
        return ""
    end
    local mapkeyname = tab[param][1]  --地图索引
    lualib:Player_RunScript(player, "通用配置:moveMapXY", mapkeyname)  --执行传送
    lualib:ShowFormWithContent(player, "脚本表单", "gh_Colosseum.Close();")

    return ""
end
-------------------------------------------------------------------------------刷怪----------------------------------------------------------------------------------------
function GenMonster(guid)

    if lualib:GetInt("0", "YuanGuBoss") == 0 then
        lualib:SetInt("0", "YuanGuBoss", 1)
        for i = 1, #tab do
            lualib:DelayCall(guid, 1000 * 60 * tab[i][3], "OnStartGenMonster", "" .. i)
        end
    end
    return ""
end

function OnStartGenMonster(guid, id)
    id = tonumber(id)
    local Mapkeyname = tab[id][1]
    local Monsterkey = tab[id][2]
    local MapGuai = lualib:Map_GetMapGuid(Mapkeyname)
    if lualib:Map_GetMonsterCount(MapGuai, Monsterkey, true, true) <= 0 then
        --地图上怪物数量
        if lualib:Map_BatchGenMonster(MapGuai, Monsterkey, 1, false) then
            lualib:SetInt(MapGuai, "BossKill", 1)  --记录哪个地图已刷新怪物
            lualib:GSRunScript("gh_斗兽场表单:ifAddMagic", "")    --更新感叹号
        end
    end
    return ""
end

----------------------------------------------------------------------------------提示方法--------------------------------------------------------------------------------------
function TipsFun(player, str, num)
    if num == 1 then
        --提示框
        lualib:MsgBox(player, "#COLORCOLOR_RED#" .. str .. "#COLORCOLOR_WHITE#")
    elseif num == 2 then
        --底部提示全局
        lualib:SysMsg_SendBroadcastMsg("#COLORCOLOR_WHITE# #COLORCOLOR_GOLD#" .. str .. "#COLORCOLOR_WHITE#", "")
    elseif num == 3 then
        --底部提示全局   + 提示框
        lualib:MsgBox(player, "#COLORCOLOR_RED#" .. str .. "#COLORCOLOR_WHITE#")
        lualib:SysMsg_SendBroadcastMsg("#COLORCOLOR_WHITE# #COLORCOLOR_GOLD#" .. str .. "#COLORCOLOR_WHITE#", "")
    elseif num == 4 then
        --底部提示全局  + 快速提示
        lualib:SysMsg_SendBroadcastMsg("#COLORCOLOR_WHITE# #COLORCOLOR_GOLD#" .. str .. "#COLORCOLOR_WHITE#", "")
        lualib:ShowFormWithContent(player, "脚本表单", "win_msg_up(" .. serialize(str) .. "," .. serialize(2500) .. ")")
    elseif num == 5 then
        --底部提示
        lualib:SysMsg_SendPromptMsg(player, "" .. str)
    elseif num == 6 then
        --底部提示 + 提示框
        lualib:SysMsg_SendPromptMsg(player, "" .. str)
        lualib:MsgBox(player, "#COLORCOLOR_RED#" .. str .. "#COLORCOLOR_WHITE#")
    elseif num == 7 then
        --底部提示 + 快速提示
        lualib:SysMsg_SendPromptMsg(player, "" .. str)
        lualib:ShowFormWithContent(player, "脚本表单", "win_msg_up(" .. serialize(str) .. "," .. serialize(2500) .. ")")
    else
        -- 快速提示
        lualib:ShowFormWithContent(player, "脚本表单", "win_msg_up(" .. serialize("#COLORCOLOR_GREENG#" .. str) .. "," .. serialize(2500) .. ")")
    end
end

function DSC_tables()
    return { tab, mapTable }
end







