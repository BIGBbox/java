-----------------------------------------------------------------------------------------;
----- �ʺ��ؾ�_�ͻ��˽ű��ļ�  Powered By ������  yqwb.com��һ����ɣ�Design ----- 2019.10.15--;
-----------------------------------------------------------------------------------------;
RainbowSecret = {}
RainbowSecret.WndHandle = 0
RainbowSecret.x = 0
RainbowSecret.y = 0
function RainbowSecret.main()
    RainbowSecret.cengshu = deserialize(FormParam[1])
    ----���ú����ɰ棬�����ֱ�ӹرմ���
    local SizeX = 790
    local SizeY = 570
    local _DeviceSizeX = CL:GetScreenWidth()
    local _DeviceSizeY = CL:GetScreenHeight()
    local setoffX = (_DeviceSizeX - SizeX) / 2 - 10  ---����λ�� ���豸��С-�����С��ȡһ�� ����;����ˣ�+50 +70
    local setoffY = (_DeviceSizeY - SizeY) / 2 - 60
    RainbowSecret.x = setoffX
    RainbowSecret.y = setoffY

    local ui = [[
        <form><dialog id="�ʺ��ؾ�" x=]] .. setoffX .. [[ y=]] .. setoffY .. [[ w=]] .. SizeX .. [[ h=]] .. SizeY .. [[ drag=true esc_close=true fitsize=true image="4000030000"  close="false"  magic="2" OnInit="RainbowSecret.UIInit" >
            <button id="�ر�" x=643 y=42 image="4000230000"  OnLButtonClick="RainbowSecret.wndClose" />
            <image id="�󱳾���" w=390 h=270 x=65 y=115 fitsize=true image="
            1800830000,
            1800830001,
            1800830002,
            1800830003,
            1800830008,
            1800830004,
            1800830005,
            1800830006,
            1800830007" />
            <image id="�淨����" w=260 h=270 x=456 y=115 fitsize=true image="1855011000,
            1855011002,
            1855011006,
            1855011008,
            1855011004,
            1855011001,
            1855011007,
            1855011003,
            1855011005" />
            <static id="����" x=350 y=58 w=200 h=20 text="�ʺ��ؾ�" text_color="YELLOW" font="SIMLI18" />
            <image id="��ť��" w=654 h=90 x=64 y=385 fitsize=true image="1850700035,1850700037,1850700041,1850700043,1850700039,1850700036,1850700042,1850700038,1850700040" type="around" center="true" />
            </dialog>
        </form>
    ]]
    local handle = GetWindow(0, "�ʺ��ؾ�")
    if handle ~= 0 then
        GUI:WndClose(handle)
    else
        GenFormByString(ui)
    end
end

function RainbowSecret.UIInit(_Handle)
    RainbowSecret.WndHandle = _Handle

    local jb = GetWindow(_Handle, "��ť����")
    if jb ~= 0 then
        GUI:ImageSetAlpha(jb, 100)
    end
    jb = GetWindow(_Handle, "�󱳾�")
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
            _GUIHandle = GUI:ItemCtrlCreate(_Parent, "��ƷIcon" .. i, 0, x + 5, 333 + 70, 55, 55)
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
            str = str .. "#COLORCOLOR_GREENG#1.����ʺ��ؾ���Ҫ�����㹻�Ĳʺ�Կ��\n\n"
            str = str .. "#COLORCOLOR_GREENG#2.��ɱ�㹻�����Ĺ��ｫ�ٻ��ز�boss\n\n"
            str = str .. "#COLORCOLOR_GREENG#3.�����ز�boss�󣬽���ˢ���ز�npc���Ի����ɲʺ�Կ�׼��ɽ�����һ��\n\n"
            str = str .. "#COLORCOLOR_GREENG#4.npc���ڽ�5���ӣ���ʧ�����ٴδ���ٻ�boss�����ܺ�Ż�ˢ��\n\n"
            str = str .. "#COLORCOLOR_GREENG#5.ÿ�ν����ؾ����Դ��ϴν���Ĳ�����ʼ����ѡ����ͷ����\n\n"
            str = str .. "#COLORCOLOR_GREENG#6.������¼ÿ����գ����ͷ��ʼ\n\n"
            GUI:WndSetEnableM(_GUIHandle, false)
            GUI:RichEditAppendString(_GUIHandle, str)
        end
        _GUIHandle = GUI:EditCreate(_Parent, "�������", 450 + 50, 270 + 70, 340, 40)
        if _GUIHandle ~= 0 then
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:EditSetTextM(_GUIHandle, "�������:")
            GUI:WndSetCanRevMsg(_GUIHandle, false)
        end

        _GUIHandle = GUI:ButtonCreate(_Parent, "BuyBtn", 1807700006, 535 + 50, 275 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.BuyBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "����ʺ�Կ��")
        end

        _GUIHandle = GUI:ButtonCreate(_Parent, "AgainBtn", 1807700006, 440 + 50, 345 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.AgainBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "��ͷ����(1��)")
        end
        _GUIHandle = GUI:ButtonCreate(_Parent, "ContinueBtn", 1807700006, 560 + 50, 345 + 70)
        if _GUIHandle ~= 0 then
            GUI:WndRegistScript(_GUIHandle, RDWndBaseCL_mouse_lbUp, "RainbowSecret.ContinueBtn")
            GUI:WndSetTextColorM(_GUIHandle, COLOR_YELLOW)
            GUI:WndSetTextM(_GUIHandle, "������ս")
        end
    end
    CL:DoSubmitForm("�ʺ��ؾ���", "Update", "")
end

--ˢ������
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
    jb = GetWindow(RainbowSecret.WndHandle, "�������")
    if jb ~= 0 then
        GUI:EditSetTextM(jb, "�������:" .. weekLayer)
    end

    for i = 1, #list.Item do
        jb = GetWindow(RainbowSecret.WndHandle, "��ƷIcon" .. i)
        if jb ~= 0 then
            RDItemCtrlSetGUIDataPropByKeyName(jb, nil, list.Item[i])
        end
    end
    jb = GetWindow(RainbowSecret.WndHandle, "ContinueBtn")
    if jb ~= 0 then
        GUI:WndSetTextM(jb, "������ս(" .. weekLayer .. "��)")
    end
end

--�����ħ�ť
function RainbowSecret.BuyBtn()
    CL:DoSubmitForm("��ݹ����", "show", "2")
end

--��ͷ������ť
function RainbowSecret.AgainBtn()
    local cengshu = RainbowSecret.cengshu
    local list = RainbowSecret.list
    local str = "#COLORCOLOR_WHITE#��ȷ��Ҫ��ͷ��������ս#COLORCOLOR_GREENG#1#COLORCOLOR_WHITE#�㣩���⽫����#COLORCOLOR_GOLD#[" .. cengshu[1][5] .. "]#COLORCOLOR_WHITE#���ʺ�Կ�ס�"
    MessageBox(1, str, "RainbowSecret.Again()", nil, false)
end

function RainbowSecret.Again()
    CL:DoSubmitForm("�ʺ��ؾ���", "MoveMap", "1")
end

--������ս��ť
function RainbowSecret.ContinueBtn()
    local cengshu = RainbowSecret.cengshu
    local list = RainbowSecret.list
    local str = "#COLORCOLOR_WHITE#��ȷ��Ҫ������ս��#COLORCOLOR_GREENG#" .. list.weekLayer .. "#COLORCOLOR_WHITE#�㣩���⽫����#COLORCOLOR_GOLD#[" .. cengshu[list.weekLayer][5] .. "]#COLORCOLOR_WHITE#���ʺ�Կ�ס�"
    MessageBox(1, str, "RainbowSecret.Continue(" .. list.weekLayer .. ")", nil, false)
end

function RainbowSecret.Continue(index)
    CL:DoSubmitForm("�ʺ��ؾ���", "MoveMap", "" .. index)
end

--�رմ���
function RainbowSecret.wndClose()
    if RainbowSecret.WndHandle ~= 0 then
        GUI:WndClose(RainbowSecret.WndHandle)
    end
end

RainbowSecret.main()