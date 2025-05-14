module("modules.logic.achievement.controller.AchievementStatController", package.seeall)

local var_0_0 = class("AchievementStatController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.startTime = nil
	arg_1_0.entrance = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.startTime = nil
	arg_2_0.entrance = nil
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenViewCallBack, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onCloseViewCallBack, arg_3_0)
end

function var_0_0.onOpenViewCallBack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:onOpenTragetView(arg_4_1, arg_4_2)

	if arg_4_1 == ViewName.AchievementMainView then
		arg_4_0:onEnterAchievementMainView()
	end
end

function var_0_0.onCloseViewCallBack(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.AchievementMainView then
		arg_5_0:onExitAchievementMainView()
	end
end

function var_0_0.onExitAchievementMainView(arg_6_0)
	if not arg_6_0.startTime then
		return
	end

	local var_6_0 = Mathf.Ceil(Time.realtimeSinceStartup - arg_6_0.startTime)
	local var_6_1 = arg_6_0:getCollectAchievementList()
	local var_6_2 = arg_6_0.entrance or ""

	StatController.instance:track(StatEnum.EventName.ExitAchievementMainView, {
		[StatEnum.EventProperties.Time] = var_6_0 or 0,
		[StatEnum.EventProperties.CollectAchievmentsName] = var_6_1,
		[StatEnum.EventProperties.Entrance] = tostring(var_6_2)
	})

	arg_6_0.startTime = nil
end

function var_0_0.onSaveDisplayAchievementsSucc(arg_7_0)
	local var_7_0 = PlayerModel.instance:getShowAchievement()
	local var_7_1, var_7_2 = AchievementUtils.decodeShowStr(var_7_0)
	local var_7_3 = arg_7_0:getAchievementNameListByTaskId(var_7_1)
	local var_7_4 = arg_7_0:getGroupNameListByTaskId(var_7_2)

	StatController.instance:track(StatEnum.EventName.SaveDisplayAchievementSucc, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = var_7_3,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = var_7_4
	})
end

function var_0_0.getAchievementNameListByTaskId(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}

	if arg_8_1 and #arg_8_1 > 0 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			local var_8_2 = AchievementConfig.instance:getTask(iter_8_1)

			if var_8_2 and not var_8_1[var_8_2.achievementId] then
				local var_8_3 = AchievementConfig.instance:getAchievement(var_8_2.achievementId)
				local var_8_4 = var_8_3 and var_8_3.name or ""

				table.insert(var_8_0, var_8_4)

				var_8_1[var_8_2.achievementId] = true
			end
		end
	end

	return var_8_0
end

function var_0_0.getGroupNameListByTaskId(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	if arg_9_1 and #arg_9_1 > 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_2 = AchievementConfig.instance:getTask(iter_9_1)

			if var_9_2 then
				local var_9_3 = AchievementConfig.instance:getAchievement(var_9_2.achievementId)
				local var_9_4 = var_9_3 and var_9_3.groupId
				local var_9_5 = AchievementConfig.instance:getGroup(var_9_4)

				if var_9_5 and not var_9_1[var_9_4] then
					local var_9_6 = var_9_5 and var_9_5.name or ""

					table.insert(var_9_0, var_9_6)

					var_9_1[var_9_4] = true
				end
			end
		end
	end

	return var_9_0
end

function var_0_0.getCollectAchievementList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = AchievementModel.instance:getList()

	if var_10_2 then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if iter_10_1.hasFinished and not var_10_1[iter_10_1.cfg.achievementId] then
				local var_10_3 = AchievementConfig.instance:getAchievement(iter_10_1.cfg.achievementId)

				var_10_1[iter_10_1.cfg.achievementId] = true

				table.insert(var_10_0, var_10_3.name)
			end
		end
	end

	return var_10_0
end

function var_0_0.onOpenAchievementGroupPreView(arg_11_0, arg_11_1)
	local var_11_0 = ViewMgr.instance:getContainer(arg_11_1)

	if var_11_0 then
		local var_11_1 = var_11_0.viewParam and var_11_0.viewParam.activityId

		if var_11_1 and var_11_1 ~= 0 then
			local var_11_2 = ActivityConfig.instance:getActivityCo(var_11_1)

			if var_11_2 then
				return string.format("Activity_%s", var_11_2.name)
			end
		end
	end
end

function var_0_0.setAchievementEntrance(arg_12_0, arg_12_1)
	return arg_12_1
end

function var_0_0.checkBuildEntranceOpenHandleFuncDict(arg_13_0)
	if not arg_13_0._entranceOpenHandleFuncDict then
		arg_13_0._entranceOpenHandleFuncDict = {
			[ViewName.MainView] = var_0_0.setAchievementEntrance,
			[ViewName.PlayerView] = var_0_0.setAchievementEntrance,
			[ViewName.AchievementGroupPreView] = var_0_0.onOpenAchievementGroupPreView
		}
	end
end

function var_0_0.onOpenTragetView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:checkBuildEntranceOpenHandleFuncDict()

	if arg_14_1 and arg_14_0._entranceOpenHandleFuncDict[arg_14_1] then
		return arg_14_0._entranceOpenHandleFuncDict[arg_14_1](arg_14_0, arg_14_1, arg_14_2) or ""
	end
end

function var_0_0.onEnterAchievementMainView(arg_15_0)
	arg_15_0.startTime = Time.realtimeSinceStartup

	local var_15_0 = ViewMgr.instance:getOpenViewNameList()

	if var_15_0 then
		for iter_15_0 = #var_15_0, 1, -1 do
			local var_15_1 = var_15_0[iter_15_0]
			local var_15_2 = arg_15_0._entranceOpenHandleFuncDict[var_15_1]

			if var_15_2 then
				arg_15_0.entrance = var_15_2(arg_15_0, var_15_1)

				break
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
