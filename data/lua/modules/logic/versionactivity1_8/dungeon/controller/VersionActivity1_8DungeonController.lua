module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8DungeonController", package.seeall)

slot0 = class("VersionActivity1_8DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)
	slot0.dungeonMapViewParam = {
		chapterId = slot1,
		episodeId = slot2
	}
	slot0.openMapViewCallback = slot3
	slot0.openMapViewCallbackObj = slot4

	VersionActivity1_8DungeonModel.instance:init()

	slot0.hasReceivedTaskInfo = false
	slot0.hasReceivedDispatchInfo = false
	slot0.hasReceivedAct157Info = false

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onReceiveTaskInfoReply, slot0)
	DispatchRpc.instance:sendGetDispatchInfoRequest(slot0._onReceiveDispatchInfoReply, slot0)
	Activity157Controller.instance:getAct157ActInfo(false, true, slot0._onReceiveAct157InfoReply, slot0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_8Enum.ActivityId.Dungeon)
end

function slot0._onReceiveTaskInfoReply(slot0)
	slot0.hasReceivedTaskInfo = true

	slot0:_internalOpenVersionActivityDungeonMapView()
end

function slot0._onReceiveDispatchInfoReply(slot0)
	slot0.hasReceivedDispatchInfo = true

	slot0:_internalOpenVersionActivityDungeonMapView()
end

function slot0._onReceiveAct157InfoReply(slot0)
	slot0.hasReceivedAct157Info = true

	slot0:_internalOpenVersionActivityDungeonMapView()
end

function slot0._internalOpenVersionActivityDungeonMapView(slot0)
	if not slot0.hasReceivedTaskInfo or not slot0.hasReceivedDispatchInfo or not slot0.hasReceivedAct157Info then
		return
	end

	slot0.hasReceivedTaskInfo = false
	slot0.hasReceivedDispatchInfo = false
	slot0.hasReceivedAct157Info = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapView, slot0.dungeonMapViewParam)
end

function slot0.openTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._openTaskViewAfterRpc, slot0)
end

function slot0._openTaskViewAfterRpc(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8TaskView)
end

function slot0.openStoreView(slot0)
	if not VersionActivityEnterHelper.checkCanOpen(VersionActivity1_8Enum.ActivityId.DungeonStore) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot1, slot0._openStoreViewAfterRpc, slot0)
end

function slot0._openStoreViewAfterRpc(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8StoreView)
end

function slot0.onVersionActivityDungeonMapViewOpen(slot0)
	if not slot0.openMapViewCallback then
		return
	end

	slot0.openMapViewCallback(slot0.openMapViewCallbackObj)

	slot0.openMapViewCallback = nil
	slot0.openMapViewCallbackObj = nil
end

function slot1(slot0)
	if string.nilorempty(slot0) then
		return slot0
	end

	return string.format("1_8Dungeon_%s_%s", VersionActivity1_8Enum.ActivityId.Dungeon, slot0)
end

function slot0.savePlayerPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) or not slot2 then
		return
	end

	if type(slot2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(uv0(slot1), slot2)
	else
		GameUtil.playerPrefsSetStringByUserId(slot3, slot2)
	end
end

function slot0.getPlayerPrefs(slot0, slot1, slot2)
	slot3 = slot2 or ""

	if string.nilorempty(slot1) then
		return slot3
	end

	slot4 = uv0(slot1)

	return (not (type(slot3) == "number") or GameUtil.playerPrefsGetNumberByUserId(slot4, slot3)) and GameUtil.playerPrefsGetStringByUserId(slot4, slot3)
end

function slot0.loadDictFromStr(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		slot2 = cjson.decode(slot1)
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
