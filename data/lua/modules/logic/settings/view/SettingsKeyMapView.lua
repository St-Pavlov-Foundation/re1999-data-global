module("modules.logic.settings.view.SettingsKeyMapView", package.seeall)

slot0 = class("SettingsKeyMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#txt_dec")
	slot0._btnshortcuts = gohelper.findChildButtonWithAudio(slot0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts")
	slot0._txtshortcuts = gohelper.findChildText(slot0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts/#txt_shortcuts")
	slot0._gotopitem = gohelper.findChild(slot0.viewGO, "topScroll/Viewport/Content/#go_topitem")
	slot0._gounchoose = gohelper.findChild(slot0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose")
	slot0._txtunchoose = gohelper.findChildText(slot0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose/#txt_unchoose")
	slot0._gochoose = gohelper.findChild(slot0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose")
	slot0._txtchoose = gohelper.findChildText(slot0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose/#txt_choose")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._tipsBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn")
	slot0._tipsOn = gohelper.findChild(slot0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/on")
	slot0._tipsoff = gohelper.findChild(slot0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/off")
	slot0._tipsStatue = PlayerPrefsHelper.getNumber("keyTips", 0)
	slot0._exitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_exit")

	slot0:refreshTips()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshortcuts:AddClickListener(slot0._btnshortcutsOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._tipsBtn:AddClickListener(slot0._tipsSwtich, slot0)
	slot0._exitgame:AddClickListener(slot0.exitgame, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, slot0.onSelectChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshortcuts:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._tipsBtn:RemoveClickListener()
	slot0._exitgame:RemoveClickListener()
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, slot0.onSelectChange, slot0)
end

function slot0._btnshortcutsOnClick(slot0)
end

function slot0._tipsSwtich(slot0)
	if slot0._tipsStatue == 1 then
		slot0._tipsStatue = 0
	else
		slot0._tipsStatue = 1
	end

	slot0:refreshTips()
	PlayerPrefsHelper.setNumber("keyTips", slot0._tipsStatue)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function slot0.refreshTips(slot0)
	slot0._tipsOn:SetActive(slot0._tipsStatue == 1)
	slot0._tipsoff:SetActive(slot0._tipsStatue ~= 1)
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.PCInputReset, MsgBoxEnum.BoxType.Yes_No, slot0._ResetByIndex, nil, , slot0, nil, , slot0:getSelectTopMo().name)
end

function slot0._ResetByIndex(slot0)
	SettingsKeyListModel.instance:Reset(slot0._index)
end

function slot0._editableInitView(slot0)
	slot0:createTopScroll()
	slot0:createPCScroll()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onSelectChange(slot0, slot1)
	if slot0._index ~= slot1 then
		slot0._index = slot1

		SettingsKeyListModel.instance:SetActivity(slot0._index)
	end
end

function slot0.createTopScroll(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "topScroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "topScroll/Viewport/Content/#go_topitem"
	slot1.cellClass = SettingsKeyTopItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 240
	slot1.cellHeight = 68
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot0._topScroll = LuaListScrollView.New(SettingsKeyTopListModel.instance, slot1)

	slot0:addChildView(slot0._topScroll)
	SettingsKeyTopListModel.instance:InitList()

	slot0._index = 1

	slot0._topScroll:selectCell(slot0._index, true)
end

function slot0.createPCScroll(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "pcScroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "pcScroll/Viewport/Content/shortcutsitem"
	slot1.cellClass = SettingsKeyItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1190
	slot1.cellHeight = 90
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 230
	slot0._pcScroll = LuaListScrollView.New(SettingsKeyListModel.instance, slot1)

	slot0:addChildView(slot0._pcScroll)
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(slot0._index)
end

function slot0.getSelectTopMo(slot0)
	return slot0._topScroll:getFirstSelect()
end

function slot0.exitgame(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function ()
		ProjBooter.instance:quitGame()
	end)
end

return slot0
