module("modules.logic.weekwalk_2.controller.WeekWalk_2Controller", package.seeall)

local var_0_0 = class("WeekWalk_2Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	arg_3_0._requestTask = false
end

function var_0_0.addConstEvents(arg_4_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_4_0._refreshTaskData, arg_4_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_4_0._refreshTaskData, arg_4_0)
	var_0_0.instance:registerCallback(WeekWalk_2Event.OnGetInfo, arg_4_0.startCheckTime, arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseView, arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, arg_4_0._onBreakResultViewClose, arg_4_0)
end

function var_0_0._onBreakResultViewClose(arg_5_0, arg_5_1)
	local var_5_0 = DungeonModel.instance.curSendEpisodeId
	local var_5_1 = var_5_0 and DungeonConfig.instance:getEpisodeCO(var_5_0)

	if var_5_1 and var_5_1.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
		arg_5_1.isBreak = true
	end
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 ~= ViewName.FightSuccView then
		return
	end

	local var_6_0 = DungeonModel.instance.curSendEpisodeId
	local var_6_1 = var_6_0 and DungeonConfig.instance:getEpisodeCO(var_6_0)

	if var_6_1 and var_6_1.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
		var_0_0.instance:openWeekWalk_2HeartResultView()
	end
end

function var_0_0._onDailyRefresh(arg_7_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
end

function var_0_0.startCheckTime(arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._checkTime, arg_8_0, 1)
end

function var_0_0.stopCheckTime(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._checkTime, arg_9_0)
end

function var_0_0._checkTime(arg_10_0)
	local var_10_0 = WeekWalk_2Model.instance:getInfo()

	if not var_10_0 or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		arg_10_0:stopCheckTime()

		return
	end

	local var_10_1 = var_10_0.endTime
	local var_10_2 = ServerTime.now()

	if var_10_1 > 0 and var_10_1 - var_10_2 <= 0 then
		arg_10_0:stopCheckTime()
		arg_10_0:requestTask(true)
		Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
	end
end

function var_0_0.requestTask(arg_11_0, arg_11_1)
	if arg_11_0._requestTask and not arg_11_1 then
		return
	end

	arg_11_0._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
end

function var_0_0._refreshTaskData(arg_12_0)
	WeekWalk_2TaskListModel.instance:updateTaskList()
	arg_12_0:dispatchEvent(WeekWalk_2Event.OnWeekwalkTaskUpdate)
end

function var_0_0.reInit(arg_13_0)
	return
end

function var_0_0.enterWeekwalk_2Fight(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 then
		logError("enterWeekwalk_2Fight elementId nil")
	end

	WeekWalk_2Model.instance:setBattleElementId(arg_14_1)

	local var_14_0 = WeekWalk_2Enum.episodeId

	DungeonModel.instance.curLookEpisodeId = var_14_0

	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

	DungeonFightController.instance:enterFightByBattleId(var_14_1.chapterId, var_14_0, arg_14_2)
end

function var_0_0.openWeekWalk_2HeartLayerView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartLayerView, arg_15_1, arg_15_2)
end

function var_0_0.openWeekWalk_2HeartView(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = arg_16_1 or {}

	if not arg_16_1.mapId then
		local var_16_0 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		arg_16_1.mapId = WeekWalk_2Model.instance:getCurMapId()
	end

	if arg_16_1.mapId then
		WeekWalk_2Model.instance:setCurMapId(arg_16_1.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartView, arg_16_1, arg_16_2)
end

function var_0_0.openWeekWalk_2HeartBuffView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartBuffView, arg_17_1, arg_17_2)
end

function var_0_0.openWeekWalk_2HeartResultView(arg_18_0, arg_18_1, arg_18_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartResultView, arg_18_1, arg_18_2)
end

function var_0_0.openWeekWalk_2ResetView(arg_19_0, arg_19_1, arg_19_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2ResetView, arg_19_1, arg_19_2)
end

function var_0_0.openWeekWalk_2LayerRewardView(arg_20_0, arg_20_1, arg_20_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2LayerRewardView, arg_20_1, arg_20_2)
end

function var_0_0.openWeekWalk_2RuleView(arg_21_0, arg_21_1, arg_21_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2RuleView, arg_21_1, arg_21_2)
end

function var_0_0.openWeekWalk_2DeepLayerNoticeView(arg_22_0, arg_22_1, arg_22_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2DeepLayerNoticeView, arg_22_1, arg_22_2)
end

function var_0_0.checkOpenWeekWalk_2DeepLayerNoticeView(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = WeekWalk_2Model.instance:getInfo()

	if not var_23_0 or not var_23_0.isPopSettle then
		return
	end

	if WeekWalkModel.instance:getMaxLayerId() >= WeekWalkEnum.FirstDeepLayer or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		arg_23_0:openWeekWalk_2DeepLayerNoticeView()
	end
end

function var_0_0.jumpWeekWalkHeartLayerView(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._jumpCallback = arg_24_1
	arg_24_0._jumpCallbackTarget = arg_24_2

	module_views_preloader.preloadMultiView(arg_24_0._preloadCallback, arg_24_0, {
		ViewName.DungeonView,
		ViewName.WeekWalk_2HeartLayerView
	}, {
		DungeonEnum.dungeonweekwalk_2viewPath
	})
end

function var_0_0._preloadCallback(arg_25_0)
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(arg_25_0._delayOpenLayerView, arg_25_0, 0)

	local var_25_0 = arg_25_0._jumpCallback
	local var_25_1 = arg_25_0._jumpCallbackTarget

	arg_25_0._jumpCallback = nil
	arg_25_0._jumpCallbackTarget = nil

	if var_25_0 then
		var_25_0(var_25_1)
	end
end

function var_0_0._delayOpenLayerView(arg_26_0)
	var_0_0.instance:openWeekWalk_2HeartLayerView()
end

function var_0_0.hasOnceActionKey(arg_27_0, arg_27_1)
	local var_27_0 = var_0_0._getKey(arg_27_0, arg_27_1)

	return PlayerPrefsHelper.hasKey(var_27_0)
end

function var_0_0.setOnceActionKey(arg_28_0, arg_28_1)
	local var_28_0 = var_0_0._getKey(arg_28_0, arg_28_1)

	PlayerPrefsHelper.setNumber(var_28_0, 1)
end

function var_0_0._getKey(arg_29_0, arg_29_1)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.WeekWalk_2OnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_29_0, arg_29_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
