module("modules.logic.activity.view.V2a1_MoonFestival_SignItemViewContainer", package.seeall)

slot0 = class("V2a1_MoonFestival_SignItemViewContainer", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = V2a1_MoonFestival_SignItem
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -16
end

function slot0.onBuildViews(slot0)
	return {
		slot0:getMainView()
	}
end

function slot0.getCurrentTaskCO(slot0)
	return ActivityType101Config.instance:getMoonFestivalTaskCO(slot0:actId())
end

function slot0.getCurrentDayCO(slot0)
	if not ActivityModel.instance:getActMO(slot0:actId()) then
		return
	end

	if ActivityType101Config.instance:getMoonFestivalSignMaxDay(slot1) <= 0 then
		return
	end

	return ActivityType101Config.instance:getMoonFestivalByDay(slot1, GameUtil.clamp(ActivityType101Model.instance:getType101LoginCount(slot1), 1, slot3))
end

function slot0.isNone(slot0, slot1)
	return ActivityType101Model.instance:isType101SpRewardUncompleted(slot0:actId(), slot1)
end

function slot0.isFinishedTask(slot0, slot1)
	return ActivityType101Model.instance:isType101SpRewardGot(slot0:actId(), slot1)
end

function slot0.isRewardable(slot0, slot1)
	return ActivityType101Model.instance:isType101SpRewardCouldGet(slot0:actId(), slot1)
end

function slot0.sendGet101SpBonusRequest(slot0, slot1, slot2)
	if not slot0:getCurrentTaskCO() then
		return
	end

	if not ActivityType101Model.instance:isType101SpRewardCouldGet(slot0:actId(), slot3.id) then
		return
	end

	Activity101Rpc.instance:sendGet101SpBonusRequest(slot4, slot5, slot1, slot2)

	return true
end

return slot0
