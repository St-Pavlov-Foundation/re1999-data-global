module("modules.logic.weekwalk.controller.WeekWalkController", package.seeall)

local var_0_0 = class("WeekWalkController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0._refreshTaskData, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._refreshTaskData, arg_3_0)
	var_0_0.instance:registerCallback(WeekWalkEvent.OnGetInfo, arg_3_0.startCheckTime, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0, LuaEventSystem.Low)
end

function var_0_0._onDailyRefresh(arg_4_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
	WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
end

function var_0_0.startCheckTime(arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._checkTime, arg_5_0, 1)
end

function var_0_0.stopCheckTime(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._checkTime, arg_6_0)
end

function var_0_0._checkTime(arg_7_0)
	local var_7_0 = WeekWalkModel.instance:getInfo()

	if not var_7_0 or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		arg_7_0:stopCheckTime()

		return
	end

	if var_7_0.endTime - ServerTime.now() <= 0 then
		arg_7_0:stopCheckTime()

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			WeekWalkModel.instance:addOldInfo()
		end

		arg_7_0:requestTask(true)
		WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
	end
end

function var_0_0.reInit(arg_8_0)
	arg_8_0:clear()
end

function var_0_0.clear(arg_9_0)
	arg_9_0._requestTask = false
end

function var_0_0._refreshTaskData(arg_10_0)
	WeekWalkTaskListModel.instance:updateTaskList()
	arg_10_0:dispatchEvent(WeekWalkEvent.OnWeekwalkTaskUpdate)
end

function var_0_0.getTaskEndTime(arg_11_0)
	local var_11_0 = TaskConfig.instance:getWeekWalkTaskList(arg_11_0)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = WeekWalkTaskListModel.instance:getTaskMo(iter_11_1.id)

		return var_11_1 and var_11_1.expiryTime
	end
end

function var_0_0.requestTask(arg_12_0, arg_12_1)
	if arg_12_0._requestTask and not arg_12_1 then
		return
	end

	arg_12_0._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
end

function var_0_0.openWeekWalkCharacterView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.WeekWalkCharacterView, arg_13_1, arg_13_2)
end

function var_0_0.openWeekWalkTarotView(arg_14_0, arg_14_1, arg_14_2)
	ViewMgr.instance:openView(ViewName.WeekWalkTarotView, arg_14_1, arg_14_2)
end

function var_0_0.openWeekWalkReviveView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.WeekWalkReviveView, arg_15_1, arg_15_2)
end

function var_0_0.openWeekWalkRuleView(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:openView(ViewName.WeekWalkRuleView, arg_16_1, arg_16_2)
end

function var_0_0.openWeekWalkShallowSettlementView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.WeekWalkShallowSettlementView, arg_17_1, arg_17_2)
end

function var_0_0.openWeekWalkDeepLayerNoticeView(arg_18_0, arg_18_1, arg_18_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDeepLayerNoticeView, arg_18_1, arg_18_2)
end

function var_0_0.checkOpenWeekWalkDeepLayerNoticeView(arg_19_0, arg_19_1, arg_19_2)
	if WeekWalkModel.instance:getMaxLayerId() >= WeekWalkEnum.FirstDeepLayer or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		arg_19_0:openWeekWalkDeepLayerNoticeView()
	end
end

function var_0_0.openWeekWalkView(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 or {}

	if not arg_20_1.mapId then
		local var_20_0 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		arg_20_1.mapId = WeekWalkModel.instance:getCurMapId()
	end

	if arg_20_1.mapId then
		WeekWalkModel.instance:setCurMapId(arg_20_1.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalkView, arg_20_1, arg_20_2)
end

function var_0_0.openWeekWalkDegradeView(arg_21_0, arg_21_1, arg_21_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDegradeView, arg_21_1, arg_21_2)
end

function var_0_0.openWeekWalkDialogView(arg_22_0, arg_22_1, arg_22_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDialogView, arg_22_1, arg_22_2)
end

function var_0_0.openWeekWalkQuestionView(arg_23_0, arg_23_1, arg_23_2)
	ViewMgr.instance:openView(ViewName.WeekWalkQuestionView, arg_23_1, arg_23_2)
end

function var_0_0.openWeekWalkResetView(arg_24_0, arg_24_1, arg_24_2)
	ViewMgr.instance:openView(ViewName.WeekWalkResetView, arg_24_1, arg_24_2)
end

function var_0_0.openWeekWalkLayerView(arg_25_0, arg_25_1, arg_25_2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerView, arg_25_1, arg_25_2)
end

function var_0_0.openWeekWalkRewardView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.WeekWalkRewardView, arg_26_1, arg_26_2)
end

function var_0_0.openWeekWalkLayerRewardView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerRewardView, arg_27_1, arg_27_2)
end

function var_0_0.openWeekWalkEnemyInfoView(arg_28_0, arg_28_1, arg_28_2)
	logError("废弃 view")
end

function var_0_0.openWeekWalkBuffBindingView(arg_29_0, arg_29_1, arg_29_2)
	ViewMgr.instance:openView(ViewName.WeekWalkBuffBindingView, arg_29_1, arg_29_2)
end

function var_0_0.openWeekWalkRespawnView(arg_30_0, arg_30_1, arg_30_2)
	if WeekWalkModel.instance:getInfo():haveDeathHero() then
		ViewMgr.instance:openView(ViewName.WeekWalkRespawnView, arg_30_1, arg_30_2)
	else
		GameFacade.showToast(ToastEnum.AdventureRespawn)
	end
end

function var_0_0.enterWeekwalkFight(arg_31_0, arg_31_1)
	local var_31_0 = WeekWalkModel.instance:getCurMapId()
	local var_31_1 = WeekWalkModel.instance:getElementInfo(var_31_0, arg_31_1):getBattleId()
	local var_31_2 = WeekWalkEnum.episodeId

	DungeonModel.instance.curLookEpisodeId = var_31_2

	local var_31_3 = DungeonConfig.instance:getEpisodeCO(var_31_2)

	DungeonFightController.instance:enterWeekwalkFight(var_31_3.chapterId, var_31_2, var_31_1)
end

function var_0_0.jumpWeekWalkDeepLayerView(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._jumpCallback = arg_32_1
	arg_32_0._jumpCallbackTarget = arg_32_2

	module_views_preloader.preloadMultiView(arg_32_0._preloadCallback, arg_32_0, {
		ViewName.DungeonView,
		ViewName.WeekWalkLayerView
	}, {
		DungeonEnum.dungeonweekwalkviewPath
	})
end

function var_0_0._preloadCallback(arg_33_0)
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(arg_33_0._delayOpenLayerView, arg_33_0, 0)

	local var_33_0 = arg_33_0._jumpCallback
	local var_33_1 = arg_33_0._jumpCallbackTarget

	arg_33_0._jumpCallback = nil
	arg_33_0._jumpCallbackTarget = nil

	if var_33_0 then
		var_33_0(var_33_1)
	end
end

function var_0_0._delayOpenLayerView(arg_34_0)
	var_0_0.instance:openWeekWalkLayerView({
		layerId = 11
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
