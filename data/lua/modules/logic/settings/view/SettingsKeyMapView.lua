-- chunkname: @modules/logic/settings/view/SettingsKeyMapView.lua

module("modules.logic.settings.view.SettingsKeyMapView", package.seeall)

local SettingsKeyMapView = class("SettingsKeyMapView", BaseView)

function SettingsKeyMapView:_refreshLangTxt()
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(self._index or 1)
end

function SettingsKeyMapView:_onChangeLangTxt()
	SettingsKeyTopListModel.instance:InitList()

	self._index = 1

	self._topScroll:selectCell(self._index, true)
end

function SettingsKeyMapView:onInitView()
	self._txtdec = gohelper.findChildText(self.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#txt_dec")
	self._btnshortcuts = gohelper.findChildButtonWithAudio(self.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts")
	self._txtshortcuts = gohelper.findChildText(self.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts/#txt_shortcuts")
	self._gotopitem = gohelper.findChild(self.viewGO, "topScroll/Viewport/Content/#go_topitem")
	self._gounchoose = gohelper.findChild(self.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose")
	self._txtunchoose = gohelper.findChildText(self.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose/#txt_unchoose")
	self._gochoose = gohelper.findChild(self.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose")
	self._txtchoose = gohelper.findChildText(self.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose/#txt_choose")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._tipsBtn = gohelper.findChildButtonWithAudio(self.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn")
	self._tipsOn = gohelper.findChild(self.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/on")
	self._tipsoff = gohelper.findChild(self.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/off")
	self._tipsStatue = GameUtil.playerPrefsGetNumberByUserId("keyTips", 0)
	self._exitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_exit")

	self:refreshTips()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsKeyMapView:addEvents()
	self:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._refreshLangTxt, self)
	self._btnshortcuts:AddClickListener(self._btnshortcutsOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._tipsBtn:AddClickListener(self._tipsSwtich, self)
	self._exitgame:AddClickListener(self.exitgame, self)
	self:addEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, self.onSelectChange, self)
	self:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
end

function SettingsKeyMapView:removeEvents()
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._refreshLangTxt, self)
	self._btnshortcuts:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._exitgame:RemoveClickListener()
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, self.onSelectChange, self)
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
end

function SettingsKeyMapView:_btnshortcutsOnClick()
	return
end

function SettingsKeyMapView:_tipsSwtich()
	if self._tipsStatue == 1 then
		self._tipsStatue = 0
	else
		self._tipsStatue = 1
	end

	self:refreshTips()
	GameUtil.playerPrefsSetNumberByUserId("keyTips", self._tipsStatue)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function SettingsKeyMapView:refreshTips()
	self._tipsOn:SetActive(self._tipsStatue == 1)
	self._tipsoff:SetActive(self._tipsStatue ~= 1)
end

function SettingsKeyMapView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.PCInputReset, MsgBoxEnum.BoxType.Yes_No, self._ResetByIndex, nil, nil, self, nil, nil, self:getSelectTopMo().name)
end

function SettingsKeyMapView:_ResetByIndex()
	SettingsKeyListModel.instance:Reset(self._index)
end

function SettingsKeyMapView:_editableInitView()
	self:createTopScroll()
	self:createPCScroll()
end

function SettingsKeyMapView:onUpdateParam()
	return
end

function SettingsKeyMapView:onOpen()
	return
end

function SettingsKeyMapView:onClose()
	return
end

function SettingsKeyMapView:onDestroyView()
	return
end

SettingsKeyMapView.OffX = 0
SettingsKeyMapView.ItemW = 284
SettingsKeyMapView.ItemSpace = 0
SettingsKeyMapView.ListW = 968.8

function SettingsKeyMapView:onSelectChange(index)
	if self._index ~= index then
		self._index = index

		SettingsKeyListModel.instance:SetActivity(self._index)

		local anchorX = recthelper.getAnchorX(self._topScrollContent)
		local itemX = -(SettingsKeyMapView.OffX + (SettingsKeyMapView.ItemW + SettingsKeyMapView.ItemSpace) * (index - 1))

		if anchorX < itemX - SettingsKeyMapView.OffX or -(itemX - SettingsKeyMapView.ItemW) > -anchorX + SettingsKeyMapView.ListW then
			local newAnchorX = itemX - SettingsKeyMapView.OffX

			if newAnchorX < anchorX then
				newAnchorX = itemX + SettingsKeyMapView.ListW - SettingsKeyMapView.ItemW + SettingsKeyMapView.OffX
			end

			recthelper.setAnchorX(self._topScrollContent, newAnchorX)
		end
	end
end

function SettingsKeyMapView:createTopScroll()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "topScroll"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "topScroll/Viewport/Content/#go_topitem"
	scrollParam1.cellClass = SettingsKeyTopItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 284
	scrollParam1.cellHeight = 68
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	self._topScroll = LuaListScrollView.New(SettingsKeyTopListModel.instance, scrollParam1)
	self._topScrollContent = gohelper.findChild(self.viewGO, "topScroll/Viewport/Content").transform

	self:addChildView(self._topScroll)
	SettingsKeyTopListModel.instance:InitList()

	self._index = 1
	self._keyTopListCount = SettingsKeyTopListModel.instance:getCount()

	self._topScroll:selectCell(self._index, true)
end

function SettingsKeyMapView:createPCScroll()
	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "pcScroll"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "pcScroll/Viewport/Content/shortcutsitem"
	scrollParam2.cellClass = SettingsKeyItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirV
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 1190
	scrollParam2.cellHeight = 90
	scrollParam2.cellSpaceH = 0
	scrollParam2.cellSpaceV = 0
	scrollParam2.startSpace = 230
	self._pcScroll = LuaListScrollView.New(SettingsKeyListModel.instance, scrollParam2)

	self:addChildView(self._pcScroll)
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(self._index)
end

function SettingsKeyMapView:getSelectTopMo()
	return self._topScroll:getFirstSelect()
end

function SettingsKeyMapView:exitgame()
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function()
		ProjBooter.instance:quitGame()
	end)
end

return SettingsKeyMapView
