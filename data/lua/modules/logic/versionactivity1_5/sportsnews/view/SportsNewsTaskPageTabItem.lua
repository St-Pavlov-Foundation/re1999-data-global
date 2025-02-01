module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskPageTabItem", package.seeall)

slot0 = class("SportsNewsTaskPageTabItem", SportsNewsPageTabItem)

function slot0.initData(slot0, slot1, slot2)
	uv0.super.initData(slot0, slot1, slot2)
end

function slot0.getTabStatus(slot0)
	slot1 = ActivityWarmUpTaskListModel.instance:getSelectedDay() == slot0._index

	if ActivityWarmUpModel.instance:getCurrentDay() < slot0._index then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif slot1 then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function slot0._btnclickOnClick(slot0)
	if slot0:getTabStatus() == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpTaskController.instance:changeSelectedDay(slot0._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 2)
	end
end

function slot0.onRefresh(slot0)
	uv0.super.onRefresh(slot0)
	slot0:redDot()
end

function slot0.redDot(slot0)
	slot0:enableRedDot(slot0:isShowRedDot(), RedDotEnum.DotNode.v1a5NewsTaskBonus)
end

function slot0.isShowRedDot(slot0)
	if ActivityWarmUpModel.instance:getCurrentDay() < slot0._index then
		return false
	end

	if SportsNewsModel.instance:getSelectedDayTask(slot0._index) then
		for slot5, slot6 in ipairs(slot1) do
			if slot6:isFinished() and not slot6:alreadyGotReward() then
				return true
			end
		end
	end

	return false
end

function slot0.playTabAnim(slot0)
end

return slot0
