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

		arg_7_0:_recordRequestTimes()

		if arg_7_0._requestTimes > arg_7_0._maxRequestTimes then
			logError("sendGetWeekwalkInfoRequest too many times")

			return
		end

		arg_7_0:requestTask(true)
		WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()

		return
	end

	arg_7_0:_clearRequestTimes()
end

function var_0_0._recordRequestTimes(arg_8_0)
	arg_8_0._requestTimes = arg_8_0._requestTimes or 0
	arg_8_0._requestTimes = arg_8_0._requestTimes + 1
end

function var_0_0._clearRequestTimes(arg_9_0)
	arg_9_0._requestTimes = 0
end

function var_0_0.reInit(arg_10_0)
	arg_10_0:clear()
end

function var_0_0.clear(arg_11_0)
	arg_11_0._requestTask = false
	arg_11_0._requestTimes = 0
	arg_11_0._maxRequestTimes = 3
end

function var_0_0._refreshTaskData(arg_12_0)
	WeekWalkTaskListModel.instance:updateTaskList()
	arg_12_0:dispatchEvent(WeekWalkEvent.OnWeekwalkTaskUpdate)
end

function var_0_0.getTaskEndTime(arg_13_0)
	local var_13_0 = TaskConfig.instance:getWeekWalkTaskList(arg_13_0)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = WeekWalkTaskListModel.instance:getTaskMo(iter_13_1.id)

		return var_13_1 and var_13_1.expiryTime
	end
end

function var_0_0.requestTask(arg_14_0, arg_14_1)
	if arg_14_0._requestTask and not arg_14_1 then
		return
	end

	arg_14_0._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
end

function var_0_0.openWeekWalkCharacterView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.WeekWalkCharacterView, arg_15_1, arg_15_2)
end

function var_0_0.openWeekWalkTarotView(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:openView(ViewName.WeekWalkTarotView, arg_16_1, arg_16_2)
end

function var_0_0.openWeekWalkReviveView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.WeekWalkReviveView, arg_17_1, arg_17_2)
end

function var_0_0.openWeekWalkRuleView(arg_18_0, arg_18_1, arg_18_2)
	ViewMgr.instance:openView(ViewName.WeekWalkRuleView, arg_18_1, arg_18_2)
end

function var_0_0.openWeekWalkShallowSettlementView(arg_19_0, arg_19_1, arg_19_2)
	ViewMgr.instance:openView(ViewName.WeekWalkShallowSettlementView, arg_19_1, arg_19_2)
end

function var_0_0.openWeekWalkDeepLayerNoticeView(arg_20_0, arg_20_1, arg_20_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDeepLayerNoticeView, arg_20_1, arg_20_2)
end

function var_0_0.checkOpenWeekWalkDeepLayerNoticeView(arg_21_0, arg_21_1, arg_21_2)
	if WeekWalkModel.instance:getMaxLayerId() >= WeekWalkEnum.FirstDeepLayer or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		arg_21_0:openWeekWalkDeepLayerNoticeView()
	end
end

function var_0_0.openWeekWalkView(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 or {}

	if not arg_22_1.mapId then
		local var_22_0 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		arg_22_1.mapId = WeekWalkModel.instance:getCurMapId()
	end

	if arg_22_1.mapId then
		WeekWalkModel.instance:setCurMapId(arg_22_1.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalkView, arg_22_1, arg_22_2)
end

function var_0_0.openWeekWalkDegradeView(arg_23_0, arg_23_1, arg_23_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDegradeView, arg_23_1, arg_23_2)
end

function var_0_0.openWeekWalkDialogView(arg_24_0, arg_24_1, arg_24_2)
	ViewMgr.instance:openView(ViewName.WeekWalkDialogView, arg_24_1, arg_24_2)
end

function var_0_0.openWeekWalkQuestionView(arg_25_0, arg_25_1, arg_25_2)
	ViewMgr.instance:openView(ViewName.WeekWalkQuestionView, arg_25_1, arg_25_2)
end

function var_0_0.openWeekWalkResetView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.WeekWalkResetView, arg_26_1, arg_26_2)
end

function var_0_0.openWeekWalkLayerView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerView, arg_27_1, arg_27_2)
end

function var_0_0.openWeekWalkRewardView(arg_28_0, arg_28_1, arg_28_2)
	ViewMgr.instance:openView(ViewName.WeekWalkRewardView, arg_28_1, arg_28_2)
end

function var_0_0.openWeekWalkLayerRewardView(arg_29_0, arg_29_1, arg_29_2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerRewardView, arg_29_1, arg_29_2)
end

function var_0_0.openWeekWalkEnemyInfoView(arg_30_0, arg_30_1, arg_30_2)
	logError("废弃 view")
end

function var_0_0.openWeekWalkBuffBindingView(arg_31_0, arg_31_1, arg_31_2)
	ViewMgr.instance:openView(ViewName.WeekWalkBuffBindingView, arg_31_1, arg_31_2)
end

function var_0_0.openWeekWalkRespawnView(arg_32_0, arg_32_1, arg_32_2)
	if WeekWalkModel.instance:getInfo():haveDeathHero() then
		ViewMgr.instance:openView(ViewName.WeekWalkRespawnView, arg_32_1, arg_32_2)
	else
		GameFacade.showToast(ToastEnum.AdventureRespawn)
	end
end

function var_0_0.enterWeekwalkFight(arg_33_0, arg_33_1)
	local var_33_0 = WeekWalkModel.instance:getCurMapId()
	local var_33_1 = WeekWalkModel.instance:getElementInfo(var_33_0, arg_33_1):getBattleId()
	local var_33_2 = WeekWalkEnum.episodeId

	DungeonModel.instance.curLookEpisodeId = var_33_2

	local var_33_3 = DungeonConfig.instance:getEpisodeCO(var_33_2)

	DungeonFightController.instance:enterWeekwalkFight(var_33_3.chapterId, var_33_2, var_33_1)
end

function var_0_0.jumpWeekWalkDeepLayerView(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._jumpCallback = arg_34_1
	arg_34_0._jumpCallbackTarget = arg_34_2

	module_views_preloader.preloadMultiView(arg_34_0._preloadCallback, arg_34_0, {
		ViewName.DungeonView,
		ViewName.WeekWalkLayerView
	}, {
		DungeonEnum.dungeonweekwalkviewPath
	})
end

function var_0_0._preloadCallback(arg_35_0)
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(arg_35_0._delayOpenLayerView, arg_35_0, 0)

	local var_35_0 = arg_35_0._jumpCallback
	local var_35_1 = arg_35_0._jumpCallbackTarget

	arg_35_0._jumpCallback = nil
	arg_35_0._jumpCallbackTarget = nil

	if var_35_0 then
		var_35_0(var_35_1)
	end
end

function var_0_0._delayOpenLayerView(arg_36_0)
	var_0_0.instance:openWeekWalkLayerView({
		layerId = 11
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
