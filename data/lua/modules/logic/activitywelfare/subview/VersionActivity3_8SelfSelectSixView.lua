-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8SelfSelectSixView.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8SelfSelectSixView", package.seeall)

local VersionActivity3_8SelfSelectSixView = class("VersionActivity3_8SelfSelectSixView", BaseView)

function VersionActivity3_8SelfSelectSixView:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._gocanget = gohelper.findChild(self.viewGO, "root/reward/#go_canget")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#go_canget/#btn_get")
	self._btncanuse = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#btn_canuse")
	self._goused = gohelper.findChild(self.viewGO, "root/reward/#go_used")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8SelfSelectSixView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btncanuse:AddClickListener(self._btncanuseOnClick, self)
end

function VersionActivity3_8SelfSelectSixView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btncanuse:RemoveClickListener()
end

function VersionActivity3_8SelfSelectSixView:_btncheckOnClick()
	local itemco = ItemConfig.instance:getItemCo(VersionActivity3_8SelfSelectSixModel.ItemId)

	if string.nilorempty(itemco.effect) then
		return
	end

	VersionActivity3_8SelfSelectSixController.instance:openHeroChoicePreview()
end

function VersionActivity3_8SelfSelectSixView:_btngetOnClick()
	local hasGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)

	if hasGet then
		return
	end

	local canGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if not canGet then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
end

function VersionActivity3_8SelfSelectSixView:_btncanuseOnClick()
	local itemcount = ItemModel.instance:getItemCount(VersionActivity3_8SelfSelectSixModel.ItemId)

	if itemcount <= 0 then
		return
	end

	VersionActivity3_8SelfSelectSixController.instance:openHeroChoiceView()
end

function VersionActivity3_8SelfSelectSixView:_addSelfEvents()
	self:addEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self._refresh, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity3_8SelfSelectSixView:_removeSelfEvents()
	self:removeEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self._refresh, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity3_8SelfSelectSixView:_onCloseView(viewName)
	if viewName == ViewName.CharacterGetView then
		self:_refresh()
	end
end

function VersionActivity3_8SelfSelectSixView:_editableInitView()
	self:_addSelfEvents()
end

function VersionActivity3_8SelfSelectSixView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	self._actId = self.viewParam.actId

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self:_refresh()
end

function VersionActivity3_8SelfSelectSixView:_refresh()
	local hasGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)
	local itemcount = ItemModel.instance:getItemCount(VersionActivity3_8SelfSelectSixModel.ItemId)
	local canUse = itemcount > 0

	gohelper.setActive(self._gocanget, not hasGet)
	gohelper.setActive(self._btncanuse.gameObject, hasGet and canUse)
	gohelper.setActive(self._goused, hasGet and not canUse)
end

function VersionActivity3_8SelfSelectSixView:onClose()
	return
end

function VersionActivity3_8SelfSelectSixView:onDestroyView()
	self:_removeSelfEvents()
end

return VersionActivity3_8SelfSelectSixView
