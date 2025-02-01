module("modules.logic.achievement.controller.AchievementController", package.seeall)

slot0 = class("AchievementController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onUpdateAchievements(slot0)
end

function slot0.getMaxLevelFinishTask(slot0, slot1)
	slot3 = nil

	return (AchievementModel.instance:getAchievementLevel(slot1) <= 0 or AchievementConfig.instance:getTaskByAchievementLevel(slot1, slot2)) and AchievementConfig.instance:getAchievementFirstTask(slot1)
end

function slot0.openAchievementMainView(slot0, slot1, slot2, slot3, slot4, slot5)
	ViewMgr.instance:openView(ViewName.AchievementMainView, {
		categoryType = slot1,
		viewType = slot2,
		sortType = slot3,
		filterType = slot4
	}, slot5)
end

function slot0.openAchievementMainViewAndFocus(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil

	if slot1 == AchievementEnum.AchievementType.Single then
		slot5 = AchievementConfig.instance:getAchievement(slot2) and slot6.category
	elseif slot1 == AchievementEnum.AchievementType.Group then
		slot5 = AchievementConfig.instance:getGroup(slot2) and slot6.category
	end

	ViewMgr.instance:openView(ViewName.AchievementMainView, {
		categoryType = slot5,
		achievementType = slot1,
		focusDataId = slot2,
		filterType = AchievementEnum.SearchFilterType.All,
		isOpenLevelView = slot3
	}, slot4)
end

function slot0.openAchievementLevelView(slot0, slot1)
	if not AchievementConfig.instance:getAchievement(slot1) then
		return
	end

	ViewMgr.instance:openView(ViewName.AchievementLevelView, {
		achievementId = slot1,
		achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()
	})
end

function slot0.openAchievementGroupPreView(slot0, slot1, slot2)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))

		return
	end

	if not ViewMgr.instance:getSetting(ViewName.AchievementGroupPreView) then
		logError("cannot find AchievementGroupPreView Setting, please check module_views.AchievementGroupPreView")

		return
	end

	if not AchievementConfig.instance:getGroup(slot1) or string.nilorempty(slot2) then
		logError(string.format("AchievementConfig Error, groupId = %s, groupPreViewUrl = %s", slot1, slot2))

		return
	end

	slot3.mainRes = string.format("%s/%s.prefab", AchievementEnum.AchievementPreViewPrefabPath, slot2)

	ViewMgr.instance:openView(ViewName.AchievementGroupPreView, {
		groupId = slot1
	})
end

slot0.instance = slot0.New()

return slot0
