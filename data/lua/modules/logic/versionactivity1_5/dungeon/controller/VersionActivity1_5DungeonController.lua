module("modules.logic.versionactivity1_5.dungeon.controller.VersionActivity1_5DungeonController", package.seeall)

slot0 = class("VersionActivity1_5DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)
	slot0.openViewParam = {
		chapterId = slot1,
		episodeId = slot2
	}
	slot0.rpcCallback = slot3
	slot0.rpcCallbackObj = slot4
	slot0.receiveTaskReply = nil
	slot0.receiveAct139InfoReply = nil

	VersionActivity1_5DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onReceiveTaskReply, slot0)
	VersionActivity1_5DungeonRpc.instance:sendGet139InfosRequest(slot0._onReceiveAct139InfoReply, slot0)
end

function slot0._onReceiveTaskReply(slot0)
	slot0.receiveTaskReply = true

	slot0:_openVersionActivityDungeonMapView()
end

function slot0._onReceiveAct139InfoReply(slot0)
	slot0.receiveAct139InfoReply = true

	slot0:_openVersionActivityDungeonMapView()
end

function slot0._openVersionActivityDungeonMapView(slot0)
	if not slot0.receiveTaskReply or not slot0.receiveAct139InfoReply then
		return
	end

	slot0.receiveTaskReply = nil
	slot0.receiveAct139InfoReply = nil

	if slot0.rpcCallback then
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)
		slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._onOpenMapViewDone, slot0)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapView, slot0.openViewParam)
end

function slot0._onOpenMapViewDone(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._onOpenMapViewDone, slot0)

		slot0.rpcCallback = nil
		slot0.rpcCallbackObj = nil

		if slot0.rpcCallback then
			slot2(slot0.rpcCallbackObj)
		end
	end
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_5DungeonEnum.DungeonChapterId.Story, slot0:getStoryEpisodeCo(slot1).preEpisode)
end

function slot0.getEpisodeIndex(slot0, slot1)
	slot2 = slot0:getStoryEpisodeCo(slot1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot2.chapterId, slot2.id)
end

function slot0.getStoryEpisodeCo(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Hard then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot1 - 10000)
	elseif slot2.chapterId ~= VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		while slot2.chapterId ~= VersionActivity1_5DungeonEnum.DungeonChapterId.Story do
			slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
		end
	end

	return slot2
end

function slot0.openTaskView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_5TaskView)
end

function slot0.openStoreView(slot0)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_5Enum.ActivityId.DungeonStore, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_5StoreView)
	end)
end

function slot0.openDispatchView(slot0, slot1)
	if VersionActivity1_5DungeonModel.instance:getDispatchStatus(slot1) == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		return
	end

	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(ViewName.VersionActivity1_5DispatchView, {
		dispatchId = slot1
	})
end

function slot0.openRevivalTaskView(slot0)
	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.revivalTaskLockToastId)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5RevivalTaskView)
end

function slot0.openBuildView(slot0)
	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.buildLockToastId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(slot0._openBuildView, slot0)
end

function slot0._openBuildView(slot0)
	ViewMgr.instance:openView(ViewName.V1a5BuildingView)
end

function slot0.setLastEpisodeId(slot0, slot1)
	slot0.lastEpisodeId = slot1
end

function slot0.getLastEpisodeId(slot0)
	return slot0.lastEpisodeId
end

slot0.instance = slot0.New()

return slot0
