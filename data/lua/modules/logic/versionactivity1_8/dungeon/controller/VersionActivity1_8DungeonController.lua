module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8DungeonController", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.dungeonMapViewParam = {
		chapterId = arg_3_1,
		episodeId = arg_3_2
	}
	arg_3_0.openMapViewCallback = arg_3_3
	arg_3_0.openMapViewCallbackObj = arg_3_4

	VersionActivity1_8DungeonModel.instance:init()

	arg_3_0.hasReceivedTaskInfo = false
	arg_3_0.hasReceivedDispatchInfo = false
	arg_3_0.hasReceivedAct157Info = false

	local var_3_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_3_0, arg_3_0._onReceiveTaskInfoReply, arg_3_0)
	DispatchRpc.instance:sendGetDispatchInfoRequest(arg_3_0._onReceiveDispatchInfoReply, arg_3_0)
	Activity157Controller.instance:getAct157ActInfo(false, true, arg_3_0._onReceiveAct157InfoReply, arg_3_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_8Enum.ActivityId.Dungeon)
end

function var_0_0._onReceiveTaskInfoReply(arg_4_0)
	arg_4_0.hasReceivedTaskInfo = true

	arg_4_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._onReceiveDispatchInfoReply(arg_5_0)
	arg_5_0.hasReceivedDispatchInfo = true

	arg_5_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._onReceiveAct157InfoReply(arg_6_0)
	arg_6_0.hasReceivedAct157Info = true

	arg_6_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._internalOpenVersionActivityDungeonMapView(arg_7_0)
	if not arg_7_0.hasReceivedTaskInfo or not arg_7_0.hasReceivedDispatchInfo or not arg_7_0.hasReceivedAct157Info then
		return
	end

	arg_7_0.hasReceivedTaskInfo = false
	arg_7_0.hasReceivedDispatchInfo = false
	arg_7_0.hasReceivedAct157Info = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapView, arg_7_0.dungeonMapViewParam)
end

function var_0_0.openTaskView(arg_8_0)
	local var_8_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_8_0, arg_8_0._openTaskViewAfterRpc, arg_8_0)
end

function var_0_0._openTaskViewAfterRpc(arg_9_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8TaskView)
end

function var_0_0.openStoreView(arg_10_0)
	local var_10_0 = VersionActivity1_8Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_10_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_10_0, arg_10_0._openStoreViewAfterRpc, arg_10_0)
end

function var_0_0._openStoreViewAfterRpc(arg_11_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8StoreView)
end

function var_0_0.onVersionActivityDungeonMapViewOpen(arg_12_0)
	if not arg_12_0.openMapViewCallback then
		return
	end

	arg_12_0.openMapViewCallback(arg_12_0.openMapViewCallbackObj)

	arg_12_0.openMapViewCallback = nil
	arg_12_0.openMapViewCallbackObj = nil
end

local function var_0_1(arg_13_0)
	if string.nilorempty(arg_13_0) then
		return arg_13_0
	end

	return (string.format("1_8Dungeon_%s_%s", VersionActivity1_8Enum.ActivityId.Dungeon, arg_13_0))
end

function var_0_0.savePlayerPrefs(arg_14_0, arg_14_1, arg_14_2)
	if string.nilorempty(arg_14_1) or not arg_14_2 then
		return
	end

	local var_14_0 = var_0_1(arg_14_1)

	if type(arg_14_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_14_0, arg_14_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_14_0, arg_14_2)
	end
end

function var_0_0.getPlayerPrefs(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2 or ""

	if string.nilorempty(arg_15_1) then
		return var_15_0
	end

	local var_15_1 = var_0_1(arg_15_1)

	if type(var_15_0) == "number" then
		var_15_0 = GameUtil.playerPrefsGetNumberByUserId(var_15_1, var_15_0)
	else
		var_15_0 = GameUtil.playerPrefsGetStringByUserId(var_15_1, var_15_0)
	end

	return var_15_0
end

function var_0_0.loadDictFromStr(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if not string.nilorempty(arg_16_1) then
		var_16_0 = cjson.decode(arg_16_1)
	end

	return var_16_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
