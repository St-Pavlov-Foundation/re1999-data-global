-- chunkname: @modules/logic/versionactivity3_2/cruise/view/ActivityCruiseMainBtnItem.lua

module("modules.logic.versionactivity3_2.cruise.view.ActivityCruiseMainBtnItem", package.seeall)

local ActivityCruiseMainBtnItem = class("ActivityCruiseMainBtnItem", ActCenterItemBase)

function ActivityCruiseMainBtnItem:onAddEvent()
	Activity218Controller.instance:registerCallback(Activity218Event.OnMsgInfoChange, self.refreshDot, self)
	Activity218Controller.instance:registerCallback(Activity218Event.OnReceiveAcceptRewardReply, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onInfoChanged, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onTaskInfoUpdate, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onBonusStateChange, self.refreshDot, self)
	Activity215Controller.instance:registerCallback(Activity215Event.onItemSubmitCountChange, self.refreshDot, self)
	Activity215Controller.instance:registerCallback(Activity215Event.OnInfoChanged, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
end

function ActivityCruiseMainBtnItem:onRemoveEvent()
	Activity218Controller.instance:unregisterCallback(Activity218Event.OnMsgInfoChange, self.refreshDot, self)
	Activity218Controller.instance:unregisterCallback(Activity218Event.OnReceiveAcceptRewardReply, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onInfoChanged, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onTaskInfoUpdate, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onBonusStateChange, self.refreshDot, self)
	Activity215Controller.instance:unregisterCallback(Activity215Event.onItemSubmitCountChange, self.refreshDot, self)
	Activity215Controller.instance:unregisterCallback(Activity215Event.OnInfoChanged, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
end

function ActivityCruiseMainBtnItem:onClick()
	CruiseController.instance:openCruiseMainView()
end

function ActivityCruiseMainBtnItem:refreshData()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseMain
	local data = {
		viewName = "CruiseMainView",
		viewParam = {
			actId = actId
		}
	}

	self:setCustomData(data)
end

function ActivityCruiseMainBtnItem:onOpen()
	self:refreshData()
	self:_addNotEventRedDot(self._checkRed, self)
end

function ActivityCruiseMainBtnItem:_checkRed()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CruiseMainBtn, 0) then
		return true
	end

	return false
end

function ActivityCruiseMainBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local atmoConfig = ActivityConfig.instance:getMainActAtmosphereConfig()
	local spriteName = isShow and atmoConfig.mainViewActBtnPrefix .. "icon_7" or "icon_7"

	if not isShow then
		local config = ActivityConfig.instance:getMainActAtmosphereConfig()

		if config then
			for _, path in ipairs(config.mainViewActBtn) do
				local go = gohelper.findChild(self.go, path)

				if go then
					gohelper.setActive(go, isShow)
				end
			end
		end
	end

	self:_setMainSprite(spriteName)
end

function ActivityCruiseMainBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function ActivityCruiseMainBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function ActivityCruiseMainBtnItem:refreshDot()
	self:_refreshRedDot()
end

return ActivityCruiseMainBtnItem
