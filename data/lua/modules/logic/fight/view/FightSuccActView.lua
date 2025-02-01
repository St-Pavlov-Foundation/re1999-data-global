module("modules.logic.fight.view.FightSuccActView", package.seeall)

slot0 = class("FightSuccActView", BaseView)

function slot0.showReward(slot0)
	slot0:_showAstrologyStarReward()
	slot0:_showExchangeList()
end

function slot0._showAstrologyStarReward(slot0)
	if VersionActivity1_3AstrologyModel.instance:getStarReward() then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
	end
end

function slot0._showExchangeList(slot0)
	if VersionActivity1_3AstrologyModel.instance:getExchangeList() then
		VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(slot1)
	end
end

function slot0.onClose(slot0)
	VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
	VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
end

return slot0
