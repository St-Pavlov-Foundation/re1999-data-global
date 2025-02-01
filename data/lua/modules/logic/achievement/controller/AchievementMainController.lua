module("modules.logic.achievement.controller.AchievementMainController", package.seeall)

slot0 = class("AchievementMainController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 or AchievementEnum.Type.Story

	AchievementMainCommonModel.instance:initDatas(slot1, slot2, slot3, slot4)
	slot0:cleanTabNew(slot1)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, slot0.notifyUpdateView, slot0)
end

function slot0.updateAchievementState(slot0)
	AchievementMainCommonModel.instance:initDatas(AchievementMainCommonModel.instance:getCurrentCategory(), AchievementMainCommonModel.instance:getCurrentViewType(), AchievementMainCommonModel.instance:getCurrentSortType(), AchievementMainCommonModel.instance:getCurrentFilterType())
end

function slot0.onCloseView(slot0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, slot0.notifyUpdateView, slot0)
	slot0:cleanCategoryNewFlag(AchievementMainCommonModel.instance:getCurrentCategory())
end

function slot0.setCategory(slot0, slot1)
	AchievementMainTileModel.instance:resetScrollFocusIndex()
	AchievementMainTileModel.instance:setHasPlayOpenAnim(false)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)
	AchievementMainCommonModel.instance:switchCategory(slot1)
	slot0:cleanCategoryNewFlag(AchievementMainCommonModel.instance:getCurrentCategory())
	slot0:cleanTabNew(slot1)
	slot0:dispatchEvent(AchievementEvent.OnSwitchCategory)
	slot0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function slot0.switchViewType(slot0, slot1)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)
	AchievementMainCommonModel.instance:switchViewType(slot1)
	slot0:dispatchEvent(AchievementEvent.OnSwitchViewType)
	slot0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function slot0.switchSortType(slot0, slot1)
	AchievementMainCommonModel.instance:switchSortType(slot1)
	slot0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function slot0.switchSearchFilterType(slot0, slot1)
	AchievementMainCommonModel.instance:switchSearchFilterType(slot1)
	slot0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function slot0.cleanTabNew(slot0, slot1)
	AchievementMainCommonModel.instance.categoryNewDict[slot1] = false
end

function slot0.cleanCategoryNewFlag(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(AchievementMainCommonModel.instance:getCategoryAchievementConfigList(slot1)) do
		if AchievementModel.instance:getAchievementTaskCoList(slot8.id) then
			for slot13, slot14 in ipairs(slot9) do
				if AchievementModel.instance:getById(slot14.id) and slot15.isNew then
					table.insert(slot3, slot14.id)
				end
			end
		end
	end

	if #slot3 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(slot3)
	end
end

function slot0.notifyUpdateView(slot0)
	AchievementMainTileModel.instance:onModelUpdate()
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
