module("modules.logic.versionactivity1_5.dungeon.controller.VersionActivity1_5DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenMapViewDone, arg_2_0)
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.openViewParam = {
		chapterId = arg_3_1,
		episodeId = arg_3_2
	}
	arg_3_0.rpcCallback = arg_3_3
	arg_3_0.rpcCallbackObj = arg_3_4
	arg_3_0.receiveTaskReply = nil
	arg_3_0.receiveAct139InfoReply = nil

	VersionActivity1_5DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_3_0._onReceiveTaskReply, arg_3_0)
	VersionActivity1_5DungeonRpc.instance:sendGet139InfosRequest(arg_3_0._onReceiveAct139InfoReply, arg_3_0)
end

function var_0_0._onReceiveTaskReply(arg_4_0)
	arg_4_0.receiveTaskReply = true

	arg_4_0:_openVersionActivityDungeonMapView()
end

function var_0_0._onReceiveAct139InfoReply(arg_5_0)
	arg_5_0.receiveAct139InfoReply = true

	arg_5_0:_openVersionActivityDungeonMapView()
end

function var_0_0._openVersionActivityDungeonMapView(arg_6_0)
	if not arg_6_0.receiveTaskReply or not arg_6_0.receiveAct139InfoReply then
		return
	end

	arg_6_0.receiveTaskReply = nil
	arg_6_0.receiveAct139InfoReply = nil

	if arg_6_0.rpcCallback then
		arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenMapViewDone, arg_6_0)
		arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_6_0._onOpenMapViewDone, arg_6_0)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapView, arg_6_0.openViewParam)
end

function var_0_0._onOpenMapViewDone(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.VersionActivity1_5DungeonMapView then
		arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_7_0._onOpenMapViewDone, arg_7_0)
		arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_7_0._onOpenMapViewDone, arg_7_0)

		local var_7_0 = arg_7_0.rpcCallback
		local var_7_1 = arg_7_0.rpcCallbackObj

		arg_7_0.rpcCallback = nil
		arg_7_0.rpcCallbackObj = nil

		if var_7_0 then
			var_7_0(var_7_1)
		end
	end
end

function var_0_0.getEpisodeMapConfig(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getStoryEpisodeCo(arg_8_1)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_5DungeonEnum.DungeonChapterId.Story, var_8_0.preEpisode)
end

function var_0_0.getEpisodeIndex(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryEpisodeCo(arg_9_1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_9_0.chapterId, var_9_0.id)
end

function var_0_0.getStoryEpisodeCo(arg_10_0, arg_10_1)
	local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_1)

	if var_10_0.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Hard then
		arg_10_1 = arg_10_1 - 10000
		var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_1)
	elseif var_10_0.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		-- block empty
	else
		while var_10_0.chapterId ~= VersionActivity1_5DungeonEnum.DungeonChapterId.Story do
			var_10_0 = DungeonConfig.instance:getEpisodeCO(var_10_0.preEpisode)
		end
	end

	return var_10_0
end

function var_0_0.openTaskView(arg_11_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_5TaskView)
end

function var_0_0.openStoreView(arg_12_0)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_5Enum.ActivityId.DungeonStore, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_5StoreView)
	end)
end

function var_0_0.openDispatchView(arg_14_0, arg_14_1)
	if VersionActivity1_5DungeonModel.instance:getDispatchStatus(arg_14_1) == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		return
	end

	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(ViewName.VersionActivity1_5DispatchView, {
		dispatchId = arg_14_1
	})
end

function var_0_0.openRevivalTaskView(arg_15_0)
	local var_15_0 = VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId

	if not DungeonModel.instance:hasPassLevelAndStory(var_15_0) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.revivalTaskLockToastId)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5RevivalTaskView)
end

function var_0_0.openBuildView(arg_16_0)
	local var_16_0 = VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId

	if not DungeonModel.instance:hasPassLevelAndStory(var_16_0) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.buildLockToastId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(arg_16_0._openBuildView, arg_16_0)
end

function var_0_0._openBuildView(arg_17_0)
	ViewMgr.instance:openView(ViewName.V1a5BuildingView)
end

function var_0_0.setLastEpisodeId(arg_18_0, arg_18_1)
	arg_18_0.lastEpisodeId = arg_18_1
end

function var_0_0.getLastEpisodeId(arg_19_0)
	return arg_19_0.lastEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
