-- chunkname: @modules/logic/rouge2/map/view/itemrefresh/Rouge2_ItemRefreshComp.lua

module("modules.logic.rouge2.map.view.itemrefresh.Rouge2_ItemRefreshComp", package.seeall)

local Rouge2_ItemRefreshComp = class("Rouge2_ItemRefreshComp", LuaCompBase)

function Rouge2_ItemRefreshComp:init(go)
	self.go = go
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#btn_Refresh")
	self._goActive = gohelper.findChild(self.go, "#go_Root/#btn_Refresh/#go_Active")
	self._goDisactive = gohelper.findChild(self.go, "#go_Root/#btn_Refresh/#go_Disactive")
	self._txtRefreshCost = gohelper.findChildText(self.go, "#go_Root/#txt_RefreshCost")

	gohelper.setActive(self.go, false)
end

function Rouge2_ItemRefreshComp:addEventListeners()
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateRevivalCoin, self._onUpdateMapInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateMapInfo, self)
end

function Rouge2_ItemRefreshComp:removeEventListeners()
	self._btnRefresh:RemoveClickListener()
end

function Rouge2_ItemRefreshComp:_btnRefreshOnClick()
	if not self._visible then
		return
	end

	if not self._canRefresh then
		GameFacade.showToast(ToastEnum.Rouge2CantRefreshDrop)

		return
	end

	if self._refreshCb then
		local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
		local dropList = curInteract and curInteract.dropCollectList

		self._refreshCb(self._refreshCbObj, dropList, self)
	end
end

function Rouge2_ItemRefreshComp:initRefreshCallback(callback, callbackObj)
	self._refreshCb = callback
	self._refreshCbObj = callbackObj
end

function Rouge2_ItemRefreshComp:refresh()
	gohelper.setActive(self.go, self._visible)

	if not self._visible then
		return
	end

	local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
	local dropType = curInteract and curInteract.dropType
	local refreshNum = curInteract and curInteract.refreshDropNum or 0
	local refreshCost = Rouge2_MapConfig.instance:getItemRefreshCost(dropType, refreshNum + 1)
	local showRefreshOp = refreshCost and refreshCost > 0

	gohelper.setActive(self.go, showRefreshOp)

	if not showRefreshOp then
		return
	end

	local revivalCoin = Rouge2_Model.instance:getRevivalCoin()

	self._canRefresh = refreshCost <= revivalCoin
	self._txtRefreshCost.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_itemrefreshview_refreshcost"), refreshCost)

	gohelper.setActive(self._goActive, self._canRefresh)
	gohelper.setActive(self._goDisactive, not self._canRefresh)
end

function Rouge2_ItemRefreshComp:show(visible)
	self._visible = visible

	self:refresh()
end

function Rouge2_ItemRefreshComp:_onUpdateMapInfo()
	self:refresh()
end

function Rouge2_ItemRefreshComp:onDestroy()
	self._refreshCb = nil
	self._refreshCbObj = nil
end

return Rouge2_ItemRefreshComp
