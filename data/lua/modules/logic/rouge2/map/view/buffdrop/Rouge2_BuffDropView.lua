-- chunkname: @modules/logic/rouge2/map/view/buffdrop/Rouge2_BuffDropView.lua

module("modules.logic.rouge2.map.view.buffdrop.Rouge2_BuffDropView", package.seeall)

local Rouge2_BuffDropView = class("Rouge2_BuffDropView", BaseView)

function Rouge2_BuffDropView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content")
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Toolbar")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BuffDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_BuffDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_BuffDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_BuffDropView:_editableInitView()
	Rouge2_AttributeToolBar.Load(self._goToolbar, Rouge2_Enum.AttributeToolType.Default)

	self._goBuffItem = self:getResInst(Rouge2_Enum.ResPath.BuffDropItem, self._goContent)
end

function Rouge2_BuffDropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DropBuff)
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_BuffDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_BuffDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType
	self._buffList = self.viewParam and self.viewParam.itemList or {}

	NavigateMgr.instance:removeEscape(self.viewName)

	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end
end

function Rouge2_BuffDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshBuffList()
end

function Rouge2_BuffDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
end

function Rouge2_BuffDropView:refreshButton()
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_BuffDropView:refreshBuffList()
	gohelper.CreateObjList(self, self._refreshBuffItem, self._buffList, self._goContent, self._goBuffItem, Rouge2_BuffDropItem)
end

function Rouge2_BuffDropView:_refreshBuffItem(buffItem, buffId, index)
	buffItem:onUpdateMO(index, self._viewEnum, self._dataType, buffId, self)
end

return Rouge2_BuffDropView
