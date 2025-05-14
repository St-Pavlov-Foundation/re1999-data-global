module("modules.logic.settings.view.SettingsKeyMapView", package.seeall)

local var_0_0 = class("SettingsKeyMapView", BaseView)

function var_0_0._refreshLangTxt(arg_1_0)
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(arg_1_0._index or 1)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._txtdec = gohelper.findChildText(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#txt_dec")
	arg_2_0._btnshortcuts = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts")
	arg_2_0._txtshortcuts = gohelper.findChildText(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts/#txt_shortcuts")
	arg_2_0._gotopitem = gohelper.findChild(arg_2_0.viewGO, "topScroll/Viewport/Content/#go_topitem")
	arg_2_0._gounchoose = gohelper.findChild(arg_2_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose")
	arg_2_0._txtunchoose = gohelper.findChildText(arg_2_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose/#txt_unchoose")
	arg_2_0._gochoose = gohelper.findChild(arg_2_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose")
	arg_2_0._txtchoose = gohelper.findChildText(arg_2_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose/#txt_choose")
	arg_2_0._btnreset = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_reset")
	arg_2_0._goarrow = gohelper.findChild(arg_2_0.viewGO, "#go_arrow")
	arg_2_0._tipsBtn = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn")
	arg_2_0._tipsOn = gohelper.findChild(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/on")
	arg_2_0._tipsoff = gohelper.findChild(arg_2_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/off")
	arg_2_0._tipsStatue = PlayerPrefsHelper.getNumber("keyTips", 0)
	arg_2_0._exitgame = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_exit")

	arg_2_0:refreshTips()

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_3_0._refreshLangTxt, arg_3_0)
	arg_3_0._btnshortcuts:AddClickListener(arg_3_0._btnshortcutsOnClick, arg_3_0)
	arg_3_0._btnreset:AddClickListener(arg_3_0._btnresetOnClick, arg_3_0)
	arg_3_0._tipsBtn:AddClickListener(arg_3_0._tipsSwtich, arg_3_0)
	arg_3_0._exitgame:AddClickListener(arg_3_0.exitgame, arg_3_0)
	arg_3_0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, arg_3_0.onSelectChange, arg_3_0)
	arg_3_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_3_0._onChangeLangTxt, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_4_0._refreshLangTxt, arg_4_0)
	arg_4_0._btnshortcuts:RemoveClickListener()
	arg_4_0._btnreset:RemoveClickListener()
	arg_4_0._tipsBtn:RemoveClickListener()
	arg_4_0._exitgame:RemoveClickListener()
	arg_4_0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, arg_4_0.onSelectChange, arg_4_0)
	arg_4_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_4_0._onChangeLangTxt, arg_4_0)
end

function var_0_0._onChangeLangTxt(arg_5_0)
	SettingsKeyTopListModel.instance:InitList()

	arg_5_0._index = 1

	arg_5_0._topScroll:selectCell(arg_5_0._index, true)
end

function var_0_0._btnshortcutsOnClick(arg_6_0)
	return
end

function var_0_0._tipsSwtich(arg_7_0)
	if arg_7_0._tipsStatue == 1 then
		arg_7_0._tipsStatue = 0
	else
		arg_7_0._tipsStatue = 1
	end

	arg_7_0:refreshTips()
	PlayerPrefsHelper.setNumber("keyTips", arg_7_0._tipsStatue)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function var_0_0.refreshTips(arg_8_0)
	arg_8_0._tipsOn:SetActive(arg_8_0._tipsStatue == 1)
	arg_8_0._tipsoff:SetActive(arg_8_0._tipsStatue ~= 1)
end

function var_0_0._btnresetOnClick(arg_9_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.PCInputReset, MsgBoxEnum.BoxType.Yes_No, arg_9_0._ResetByIndex, nil, nil, arg_9_0, nil, nil, arg_9_0:getSelectTopMo().name)
end

function var_0_0._ResetByIndex(arg_10_0)
	SettingsKeyListModel.instance:Reset(arg_10_0._index)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:createTopScroll()
	arg_11_0:createPCScroll()
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

var_0_0.OffX = 0
var_0_0.ItemW = 284
var_0_0.ItemSpace = 0
var_0_0.ListW = 968.8

function var_0_0.onSelectChange(arg_16_0, arg_16_1)
	if arg_16_0._index ~= arg_16_1 then
		arg_16_0._index = arg_16_1

		SettingsKeyListModel.instance:SetActivity(arg_16_0._index)

		local var_16_0 = recthelper.getAnchorX(arg_16_0._topScrollContent)
		local var_16_1 = -(var_0_0.OffX + (var_0_0.ItemW + var_0_0.ItemSpace) * (arg_16_1 - 1))

		if var_16_0 < var_16_1 - var_0_0.OffX or -(var_16_1 - var_0_0.ItemW) > -var_16_0 + var_0_0.ListW then
			local var_16_2 = var_16_1 - var_0_0.OffX

			if var_16_2 < var_16_0 then
				var_16_2 = var_16_1 + var_0_0.ListW - var_0_0.ItemW + var_0_0.OffX
			end

			recthelper.setAnchorX(arg_16_0._topScrollContent, var_16_2)
		end
	end
end

function var_0_0.createTopScroll(arg_17_0)
	local var_17_0 = ListScrollParam.New()

	var_17_0.scrollGOPath = "topScroll"
	var_17_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_17_0.prefabUrl = "topScroll/Viewport/Content/#go_topitem"
	var_17_0.cellClass = SettingsKeyTopItem
	var_17_0.scrollDir = ScrollEnum.ScrollDirH
	var_17_0.lineCount = 1
	var_17_0.cellWidth = 284
	var_17_0.cellHeight = 68
	var_17_0.cellSpaceH = 0
	var_17_0.cellSpaceV = 0
	arg_17_0._topScroll = LuaListScrollView.New(SettingsKeyTopListModel.instance, var_17_0)
	arg_17_0._topScrollContent = gohelper.findChild(arg_17_0.viewGO, "topScroll/Viewport/Content").transform

	arg_17_0:addChildView(arg_17_0._topScroll)
	SettingsKeyTopListModel.instance:InitList()

	arg_17_0._index = 1
	arg_17_0._keyTopListCount = SettingsKeyTopListModel.instance:getCount()

	arg_17_0._topScroll:selectCell(arg_17_0._index, true)
end

function var_0_0.createPCScroll(arg_18_0)
	local var_18_0 = ListScrollParam.New()

	var_18_0.scrollGOPath = "pcScroll"
	var_18_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_18_0.prefabUrl = "pcScroll/Viewport/Content/shortcutsitem"
	var_18_0.cellClass = SettingsKeyItem
	var_18_0.scrollDir = ScrollEnum.ScrollDirV
	var_18_0.lineCount = 1
	var_18_0.cellWidth = 1190
	var_18_0.cellHeight = 90
	var_18_0.cellSpaceH = 0
	var_18_0.cellSpaceV = 0
	var_18_0.startSpace = 230
	arg_18_0._pcScroll = LuaListScrollView.New(SettingsKeyListModel.instance, var_18_0)

	arg_18_0:addChildView(arg_18_0._pcScroll)
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(arg_18_0._index)
end

function var_0_0.getSelectTopMo(arg_19_0)
	return arg_19_0._topScroll:getFirstSelect()
end

function var_0_0.exitgame(arg_20_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function()
		ProjBooter.instance:quitGame()
	end)
end

return var_0_0
