module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaController", package.seeall)

local var_0_0 = class("AiZiLaController", BaseController)

function var_0_0.onInit(arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, arg_1_0._onDestroyViewFinish, arg_1_0)

	arg_1_0._reShowViewAnim = {
		AiZiLaMapView = UIAnimationName.Open
	}

	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0._onDestroyViewFinish(arg_4_0)
	local var_4_0 = ViewMgr.instance:getOpenViewNameList()

	if #var_4_0 > 0 then
		local var_4_1 = var_4_0[#var_4_0]

		if arg_4_0._reShowViewAnim[var_4_1] then
			AiZiLaHelper.playViewAnimator(var_4_1, arg_4_0._reShowViewAnim[var_4_1])
		end
	end
end

function var_0_0.reInit(arg_5_0)
	arg_5_0._openStoryIds = nil
end

function var_0_0.openStoryView(arg_6_0, arg_6_1)
	local var_6_0 = {
		episodeId = arg_6_1,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	}

	ViewMgr.instance:openView(ViewName.AiZiLaStoryView, var_6_0)
end

function var_0_0.openMapView(arg_7_0)
	arg_7_0._enterStoryFinish = true
	arg_7_0._openInfosFinish = false

	local var_7_0 = arg_7_0:_getOpenStoryIds()

	if not arg_7_0:_checkStoryIds(var_7_0) then
		arg_7_0._enterStoryFinish = false

		arg_7_0:_playStoryIds(var_7_0, arg_7_0._afterPlayEnterStory, arg_7_0)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleAiZiLa
	}, arg_7_0._onTaskGet, arg_7_0)
end

function var_0_0._onTaskGet(arg_8_0)
	Activity144Rpc.instance:sendGet144InfosRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, arg_8_0._onOpenMapViewRequest, arg_8_0)
end

function var_0_0.playOpenStory(arg_9_0)
	local var_9_0 = arg_9_0:_getOpenStoryIds()

	arg_9_0:_playStoryIds(var_9_0)
end

function var_0_0._playStoryIds(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		mark = true,
		isReplay = false,
		hideStartAndEndDark = true
	}

	StoryController.instance:playStories(arg_10_1, var_10_0, arg_10_2, arg_10_3)
end

function var_0_0._afterPlayEnterStory(arg_11_0)
	arg_11_0._enterStoryFinish = true

	arg_11_0:_checkOpenMapView()
end

function var_0_0._onOpenMapViewRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == 0 then
		arg_12_0._openInfosFinish = true
		arg_12_0._isInfoSettle = arg_12_3.Act144InfoNO and arg_12_3.Act144InfoNO.isSettle

		arg_12_0:_checkOpenMapView()
	end
end

var_0_0.OPEN_MAPVIEW_INFO_SETTLE = "AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE"

function var_0_0._checkOpenMapView(arg_13_0)
	if arg_13_0._enterStoryFinish and arg_13_0._openInfosFinish then
		PermanentController.instance:jump2Activity(VersionActivity1_5Enum.ActivityId.EnterView)
		arg_13_0:_onEnterViewIfNotOpened()
	end
end

function var_0_0._onEnterViewIfNotOpened(arg_14_0)
	ViewMgr.instance:openView(ViewName.AiZiLaMapView)

	if arg_14_0._isInfoSettle then
		arg_14_0._isInfoSettle = false

		AiZiLaHelper.startBlock(var_0_0.OPEN_MAPVIEW_INFO_SETTLE)
		TaskDispatcher.runDelay(arg_14_0._onInfoSettle, arg_14_0, AiZiLaEnum.AnimatorTime.MapViewOpen)
	end
end

function var_0_0._onInfoSettle(arg_15_0)
	AiZiLaGameModel.instance:reInit()
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, arg_15_0._onInfoSettleRequest, arg_15_0)
end

function var_0_0._onInfoSettleRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	AiZiLaHelper.endBlock(var_0_0.OPEN_MAPVIEW_INFO_SETTLE)

	if arg_16_2 == 0 then
		AiZiLaGameModel.instance:setEpisodeId(arg_16_3.act144Episode.episodeId)
		AiZiLaGameModel.instance:settleEpisodeReply(arg_16_3)

		if arg_16_0._lastSettlePushMsg and arg_16_0._lastSettlePushMsg.episodeId == arg_16_3.act144Episode.episodeId then
			AiZiLaGameModel.instance:settlePush(arg_16_0._lastSettlePushMsg)
		end

		AiZiLaGameController.instance:gameResult()
	end
end

function var_0_0._getOpenStoryIds(arg_17_0)
	if not arg_17_0._openStoryIds then
		arg_17_0._openStoryIds = {}

		local var_17_0 = AiZiLaConfig.instance:getStoryList(VersionActivity1_5Enum.ActivityId.AiZiLa)

		if var_17_0 then
			for iter_17_0, iter_17_1 in ipairs(var_17_0) do
				if iter_17_1.episodeId == AiZiLaEnum.OpenStoryEpisodeId then
					table.insert(arg_17_0._openStoryIds, iter_17_1.id)
				end
			end
		end
	end

	return arg_17_0._openStoryIds
end

function var_0_0._checkStoryIds(arg_18_0, arg_18_1)
	if arg_18_1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			if not StoryModel.instance:isStoryHasPlayed(iter_18_1) then
				return false
			end
		end
	end

	return true
end

function var_0_0.openEpsiodeDetailView(arg_19_0, arg_19_1)
	ViewMgr.instance:openView(ViewName.AiZiLaEpsiodeDetailView, {
		episodeId = arg_19_1,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

function var_0_0.delayReward(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0._actTaskMO == nil and arg_20_2 then
		arg_20_0._actTaskMO = arg_20_2

		TaskDispatcher.runDelay(arg_20_0._onPreFinish, arg_20_0, arg_20_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_21_0)
	local var_21_0 = arg_21_0._actTaskMO

	arg_21_0._actTaskMO = nil

	if var_21_0 and (var_21_0.id == AiZiLaEnum.TaskMOAllFinishId or var_21_0:alreadyGotReward()) then
		AiZiLaTaskListModel.instance:preFinish(var_21_0)

		arg_21_0._actTaskId = var_21_0.id

		TaskDispatcher.runDelay(arg_21_0._onRewardTask, arg_21_0, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_22_0)
	local var_22_0 = arg_22_0._actTaskId

	arg_22_0._actTaskId = nil

	if var_22_0 then
		if var_22_0 == AiZiLaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleAiZiLa)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_22_0)
		end
	end
end

function var_0_0.getInfosReply(arg_23_0, arg_23_1)
	AiZiLaModel.instance:getInfosReply(arg_23_1)
end

function var_0_0.enterEpisodeReply(arg_24_0, arg_24_1)
	AiZiLaModel.instance:enterEpisodeReply(arg_24_1)
end

function var_0_0.selectOptionReply(arg_25_0, arg_25_1)
	AiZiLaModel.instance:selectOptionReply(arg_25_1)
end

function var_0_0.nextDayReply(arg_26_0, arg_26_1)
	AiZiLaModel.instance:nextDayReply(arg_26_1)
end

function var_0_0.settleEpisodeReply(arg_27_0, arg_27_1)
	local var_27_0 = AiZiLaGameModel.instance:getEpisodeId()
	local var_27_1 = arg_27_1.act144Episode.episodeId

	if var_27_0 ~= 0 and var_27_0 == var_27_1 then
		AiZiLaGameModel.instance:settleEpisodeReply(arg_27_1)
		AiZiLaGameController.instance:gameResult()
	end
end

function var_0_0.settlePush(arg_28_0, arg_28_1)
	AiZiLaModel.instance:settlePush(arg_28_1)

	local var_28_0 = AiZiLaGameModel.instance:getEpisodeId()
	local var_28_1 = arg_28_1.episodeId

	arg_28_0._lastSettlePushMsg = nil

	if var_28_0 ~= 0 and var_28_0 == var_28_1 then
		AiZiLaGameModel.instance:settlePush(arg_28_1)
		AiZiLaGameController.instance:gameResult()
	else
		arg_28_0._lastSettlePushMsg = arg_28_1
	end
end

function var_0_0.upgradeEquipReply(arg_29_0, arg_29_1)
	AiZiLaModel.instance:upgradeEquipReply(arg_29_1)
	arg_29_0:dispatchEvent(AiZiLaEvent.OnEquipUpLevel, arg_29_1.newEquipId)
end

function var_0_0.episodePush(arg_30_0, arg_30_1)
	AiZiLaModel.instance:episodePush(arg_30_1)

	local var_30_0 = AiZiLaGameModel.instance:getEpisodeId()

	if var_30_0 ~= 0 and var_30_0 == arg_30_1.act144Episode.episodeId then
		AiZiLaGameModel.instance:updateEpisode(arg_30_1.act144Episode)
		AiZiLaGameController.instance:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	arg_30_0:dispatchEvent(AiZiLaEvent.EpisodePush)
end

function var_0_0.itemChangePush(arg_31_0, arg_31_1)
	AiZiLaModel.instance:itemChangePush(arg_31_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
