-----------------------------------------------------------------------------------------;
----- 彩虹秘境_客户端脚本文件  Powered By 孙钰淞  yqwb.com（一起玩吧）Design ----- 2019.10.15--;
-----------------------------------------------------------------------------------------;
RainbowSecret = {}
RainbowSecret.WndHandle = 0
RainbowSecret.x = 0
RainbowSecret.y = 0
function RainbowSecret.main()
    RainbowSecret.cengshu = deserialize(FormParam[1])
    ----设置后置蒙版，点击后直接关闭窗口
    local SizeX = 790
    local SizeY = 570
    local _DeviceSizeX = CL:GetScreenWidth()
    local _DeviceSizeY = CL:GetScreenHeight()
    local setoffX = (_DeviceSizeX - SizeX) / 2 - 10  ---界面位置 （设备大小-界面大小在取一半 界面就居中了）+50 +70
    local setoffY = (_DeviceSizeY - SizeY) / 2 - 60
    RainbowSecret.x = setoffX
    RainbowSecret.y = setoffY

    local ui = [[
        <form><dialog id="彩虹秘境" x=]] .. setoffX .. [[ y=]] .. setoffY .. [[ w=]] .. SizeX .. [[ h=]] .. SizeY .. [[ drag=true esc_close=true fitsize=true image="4000030000"  close="false"  magic="2" OnInit="RainbowSecret.UIInit" >
            <button id="关闭" x=643 y=42 image="4000230000"  OnLButtonClick="RainbowSecret.wndClose" />
            <image id="大背景框" w=390 h=270 x=65 y=115 fitsize=true image="
            1800830000,
            1800830001,
            1800830002,
            1800830003,
            1800830008,
            1800830004,
            1800830005,
            1800830006,
            1800830007" />
            <image id="玩法背景" w=260 h=270 x=456 y=115 fitsize=true image="1855011000,
            1855011002,
            1855011006,
            1855011008,
            1855011004,
            1855011001,
            1855011007,
            1855011003,
            1855011005" />
            <static id="标题" x=350 y=58 w=200 h=20 text="彩虹秘境" text_color="YELLOW" font="SIMLI18" />
            <image id="按钮框" w=654 h=90 x=64 y=385 fitsize=true image="1850700035,1850700037,1850700041,1850700043,1850700039,1850700036,1850700042,1850700038,1850700040" type="around" center="true" />
            </dialog>
        </form>
    ]]
    local handle = GetWindow(0, "彩虹秘境")
    if handle ~= 0 then
        GUI:WndClose(handle)
    else
        GenFormByString(ui)
    end
end

function RainbowSecret.UIInit(_Handle)
    RainbowSecret.WndHandle = _Handle

    local jb = GetWindow(_Handle, "按钮背景")
    if jb ~= 0 then
        GUI:ImageSetAlpha(jb, 100)
    end
    jb = GetWindow(_Handle, "大背景")
    if jb ~= 0 then
        GUI:ImageSetAlpha(jb, 25)
    end
    RainbowSecret.UISet(_Handle)
end

function RainbowSecret.UISet(_Handle)
    local _Parent = GetWindow(_Handle, "")
    local _GUIHandle = 0
    if _Parent ~= 0 then
        _GUIHandle = GUI:ImageCreate(_Parent, "map", 0, 21 + 50, 51 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndSetSizeM(_GUIHandle, 378, 260)
            GUI:ImageSetFitSize(_GUIHandle, true)
        end
        local x = 40 + 50
        local disx = 75
        for i = 1, 5 do
            local item_bg = GUI:ImageCreate(_Parent, "item_bg" .. i, 1808800004, x + 0, 325 + 70)
            if item_bg ~= 0 then
                GUI:ImageSetFitSize(item_bg, true)
                GUI:WndSetSizeM(item_bg, 70, 70)
            end
            _GUIHandle = GUI:ItemCtrlCreate(_Parent, "物品Icon" .. i, 0, x + 5, 333 + 70, 55, 55)
            if _GUIHandle ~= 0 then
                GUI:ItemCtrlSetItemDataAutoManager(_GUIHandle, true)
                RDItemCtrlSetGUIDataEnable(_GUIHandle, nil, true)
                GUI:ItemCtrlSetShowItemCount(_GUIHandle, false)
            end
            x = x + disx
        end
        _GUIHandle = GUI:RichEditCreate(_Parent, "introduceText", 425 + 50, 70 + 70, 225, 335)
        if _GUIHandle ~= 0 then
            local str = ""
            str = str .. "#COLORCOLOR_GREENG#1.进入彩虹秘境需要缴纳足够的彩虹钥匙\n\n"
            str = str .. "#COLORCOLOR_GREENG#2.击杀足够数量的怪物将召唤守层boss\n\n"
            str = str .. "#COLORCOLOR_GREENG#3.击败守层boss后，将会刷新守层npc，对话缴纳彩虹钥匙即可进入下一层\n\n"
            str = str .. "#COLORCOLOR_GREENG#4.npc存在仅5分钟，消失后续再次打怪召唤boss并击败后才会刷新\n\n"
            str = str .. "#COLORCOLOR_GREENG#5.每次进入秘境可以从上次进入的层数开始，或选择重头再来\n\n"
            str = str .. "#COLORCOLOR_GREENG#6.层数记录每周清空，需从头开始\n\n"
            GUI:WndSetEnableM(_GUIHandle, false)
            GUI:RichEditAppendString(_GUIHandle, str)
        end
        _GUIHandle = GUI:EditCreate(_Parent, "本周最高", 450 + 50, 270 + 70, 340, 40)
        if _GUIHandle ~= 0 then
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:EditSetTextM(_GUIHandle, "本周最高:")
            GUI:WndSetCanRevMsg(_GUIHandle, false)
        end

        _GUIHandle = GUI:ButtonCreate(_Parent, "BuyBtn", 1807700006, 535 + 50, 275 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.BuyBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "购买彩虹钥匙")
        end

        _GUIHandle = GUI:ButtonCreate(_Parent, "AgainBtn", 1807700006, 440 + 50, 345 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.AgainBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "重头再来(1层)")
        end
        _GUIHandle = GUI:ButtonCreate(_Parent, "ContinueBtn", 1807700006, 560 + 50, 345 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.ContinueBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "继续挑战")
        end
    end
    CL:DoSubmitForm("彩虹秘境表单", "Update", "")
end

--刷新数据
function RainbowSecret.Update(list)
    local jb = 0
    local weekLayer = list.weekLayer
    local map = list.map
    local leftCount = list.leftCount
    local str = ""
    RainbowSecret.list = list
    jb = GetWindow(RainbowSecret.WndHandle, "map")
    if jb ~= 0 then
        ImageSetImageID(jb, nil, map)
    end
    jb = GetWindow(RainbowSecret.WndHandle, "本周最高")
    if jb ~= 0 then
        GUI:EditSetTextM(jb, "本周最高:" .. weekLayer)
    end

    for i = 1, #list.Item do
        jb = GetWindow(RainbowSecret.WndHandle, "物品Icon" .. i)
        if jb ~= 0 then
            RDItemCtrlSetGUIDataPropByKeyName(jb, nil, list.Item[i])
        end
    end
    jb = GetWindow(RainbowSecret.WndHandle, "ContinueBtn")
    if jb ~= 0 then
        GUI:WndSetTextM(jb, "继续挑战(" .. weekLayer .. "层)")
    end
end

--购买封魔令按钮
function RainbowSecret.BuyBtn()
    CL:DoSubmitForm("快捷购买表单", "show", "2")
end

--重头再来按钮
function RainbowSecret.AgainBtn()
    local cengshu = RainbowSecret.cengshu
    local list = RainbowSecret.list
    local str = "#COLORCOLOR_WHITE#你确定要重头再来（挑战#COLORCOLOR_GREENG#1#COLORCOLOR_WHITE#层）吗？这将消耗#COLORCOLOR_GOLD#[" .. cengshu[1][5] .. "]#COLORCOLOR_WHITE#个彩虹钥匙。"
    MessageBox(1, str, "RainbowSecret.Again()", nil, false)
end

function RainbowSecret.Again()
    CL:DoSubmitForm("彩虹秘境表单", "MoveMap", "1")
end

--继续挑战按钮
function RainbowSecret.ContinueBtn()
    local cengshu = RainbowSecret.cengshu
    local list = RainbowSecret.list
    local str = "#COLORCOLOR_WHITE#你确定要继续挑战（#COLORCOLOR_GREENG#" .. list.weekLayer .. "#COLORCOLOR_WHITE#层）吗？这将消耗#COLORCOLOR_GOLD#[" .. cengshu[list.weekLayer][5] .. "]#COLORCOLOR_WHITE#个彩虹钥匙。"
    MessageBox(1, str, "RainbowSecret.Continue(" .. list.weekLayer .. ")", nil, false)
end

function RainbowSecret.Continue(index)
    CL:DoSubmitForm("彩虹秘境表单", "MoveMap", "" .. index)
end

--关闭窗口
function RainbowSecret.wndClose()
    if RainbowSecret.WndHandle ~= 0 then
        GUI:WndClose(RainbowSecret.WndHandle)
    end
end

RainbowSecret.main()