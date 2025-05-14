module("modules.logic.achievement.controller.AchievementController", package.seeall)

local var_0_0 = class("AchievementController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.onUpdateAchievements(arg_5_0)
	return
end

function var_0_0.getMaxLevelFinishTask(arg_6_0, arg_6_1)
	local var_6_0 = AchievementModel.instance:getAchievementLevel(arg_6_1)
	local var_6_1

	if var_6_0 > 0 then
		var_6_1 = AchievementConfig.instance:getTaskByAchievementLevel(arg_6_1, var_6_0)
	else
		var_6_1 = AchievementConfig.instance:getAchievementFirstTask(arg_6_1)
	end

	return var_6_1
end

function var_0_0.openAchievementMainView(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = {
		categoryType = arg_7_1,
		viewType = arg_7_2,
		sortType = arg_7_3,
		filterType = arg_7_4
	}

	ViewMgr.instance:openView(ViewName.AchievementMainView, var_7_0, arg_7_5)
end

function var_0_0.openAchievementMainViewAndFocus(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0

	if arg_8_1 == AchievementEnum.AchievementType.Single then
		local var_8_1 = AchievementConfig.instance:getAchievement(arg_8_2)

		var_8_0 = var_8_1 and var_8_1.category
	elseif arg_8_1 == AchievementEnum.AchievementType.Group then
		local var_8_2 = AchievementConfig.instance:getGroup(arg_8_2)

		var_8_0 = var_8_2 and var_8_2.category
	end

	local var_8_3 = {
		categoryType = var_8_0,
		achievementType = arg_8_1,
		focusDataId = arg_8_2,
		filterType = AchievementEnum.SearchFilterType.All,
		isOpenLevelView = arg_8_3
	}

	ViewMgr.instance:openView(ViewName.AchievementMainView, var_8_3, arg_8_4)
end

function var_0_0.openAchievementLevelView(arg_9_0, arg_9_1)
	if not AchievementConfig.instance:getAchievement(arg_9_1) then
		return
	end

	local var_9_0 = AchievementMainTileModel.instance:getCurrentAchievementIds()
	local var_9_1 = {
		achievementId = arg_9_1,
		achievementIds = var_9_0
	}

	ViewMgr.instance:openView(ViewName.AchievementLevelView, var_9_1)
end

function var_0_0.openAchievementGroupPreView(arg_10_0, arg_10_1, arg_10_2)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))

		return
	end

	local var_10_0 = ViewMgr.instance:getSetting(ViewName.AchievementGroupPreView)

	if not var_10_0 then
		logError("cannot find AchievementGroupPreView Setting, please check module_views.AchievementGroupPreView")

		return
	end

	if not AchievementConfig.instance:getGroup(arg_10_1) or string.nilorempty(arg_10_2) then
		logError(string.format("AchievementConfig Error, groupId = %s, groupPreViewUrl = %s", arg_10_1, arg_10_2))

		return
	end

	var_10_0.mainRes = string.format("%s/%s.prefab", AchievementEnum.AchievementPreViewPrefabPath, arg_10_2)

	ViewMgr.instance:openView(ViewName.AchievementGroupPreView, {
		groupId = arg_10_1
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
