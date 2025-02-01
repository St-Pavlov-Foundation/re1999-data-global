module("modules.logic.versionactivity1_9.dungeon.controller.VersionActivity1_9DungeonController", package.seeall)

slot0 = class("VersionActivity1_9DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityDungeonMapView(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.Dungeon
	})

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_7) then
		DungeonController.instance:enterDungeonView(true, true)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_7))
	end
end

function slot0.openStoreView(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.DungeonStore)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_9Enum.ActivityId.DungeonStore, slot0._openStoreView, slot0)
end

function slot0._openStoreView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_9StoreView)
end

function slot0.openTaskView(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_9TaskView)
end

slot0.instance = slot0.New()

return slot0
