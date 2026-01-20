-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndBtnItem.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndBtnItem", package.seeall)

local Activity2ndBtnItem = class("Activity2ndBtnItem", ActCenterItemBase)

function Activity2ndBtnItem:onOpen()
	self:_addNotEventRedDot(self._checkRed, self)
end

function Activity2ndBtnItem:onInit()
	self:refresh()
end

function Activity2ndBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local atmoConfig = ActivityConfig.instance:getMainActAtmosphereConfig()
	local spriteName = isShow and atmoConfig.mainViewActBtnPrefix .. "icon_7" or "act_icon_7"

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

function Activity2ndBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity2ndBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity2ndBtnItem:onClick()
	Activity2ndController.instance:enterActivity2ndMainView()
end

function Activity2ndBtnItem:_checkRed()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity2ndEnter, 0) then
		return true
	end

	if Activity2ndModel.instance:checkAnnualReviewShowRed() then
		return true
	end

	return false
end

function Activity2ndBtnItem:refreshDot()
	self:_refreshRedDot()
end

return Activity2ndBtnItem
