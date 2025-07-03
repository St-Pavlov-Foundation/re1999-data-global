module("modules.versionactivitybase.fixed.dungeon.controller.VersionActivityFixedDungeonController", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonController", BaseController)

function var_0_0.openTaskView(arg_1_0)
	local var_1_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_1_0, arg_1_0._openTaskViewAfterRpc, arg_1_0)
end

function var_0_0._openTaskViewAfterRpc(arg_2_0)
	local var_2_0 = VersionActivityFixedHelper.getVersionActivityTaskViewName()

	ViewMgr.instance:openView(var_2_0)
end

function var_0_0.openStoreView(arg_3_0)
	local var_3_0 = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_3_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_3_0, arg_3_0._openStoreViewAfterRpc, arg_3_0)
end

function var_0_0._openStoreViewAfterRpc(arg_4_0)
	local var_4_0 = VersionActivityFixedHelper.getVersionActivityStoreViewName()

	ViewMgr.instance:openView(var_4_0)
end

function var_0_0.openVersionActivityDungeonMapView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.dungeonMapViewParam = {
		chapterId = arg_5_1,
		episodeId = arg_5_2
	}
	arg_5_0.openMapViewCallback = arg_5_3
	arg_5_0.openMapViewCallbackObj = arg_5_4

	VersionActivityFixedDungeonModel.instance:init()

	arg_5_0.hasReceivedTaskInfo = false

	local var_5_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_5_0, arg_5_0._onReceiveTaskInfoReply, arg_5_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon)
end

function var_0_0._onReceiveTaskInfoReply(arg_6_0)
	arg_6_0.hasReceivedTaskInfo = true

	arg_6_0:_internalOpenVersionActivityDungeonMapView(arg_6_0._bigVersion, arg_6_0._smallVersion)
end

function var_0_0._internalOpenVersionActivityDungeonMapView(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.hasReceivedTaskInfo then
		return
	end

	arg_7_0.hasReceivedTaskInfo = false

	if not arg_7_0.dungeonMapViewParam.episodeId then
		local var_7_0 = VersionActivityFixedDungeonModel.instance:getInitEpisodeId()

		if var_7_0 > 0 then
			arg_7_0.dungeonMapViewParam.episodeId = var_7_0
		end
	end

	local var_7_1 = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(arg_7_1, arg_7_2)

	ViewMgr.instance:openView(var_7_1, arg_7_0.dungeonMapViewParam)
end

function var_0_0.onVersionActivityDungeonMapViewOpen(arg_8_0)
	if not arg_8_0.openMapViewCallback then
		return
	end

	arg_8_0.openMapViewCallback(arg_8_0.openMapViewCallbackObj)

	arg_8_0.openMapViewCallback = nil
	arg_8_0.openMapViewCallbackObj = nil
end

local function var_0_1(arg_9_0)
	if string.nilorempty(arg_9_0) then
		return arg_9_0
	end

	return (string.format("Dungeon_%s_%s", VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, arg_9_0))
end

function var_0_0.savePlayerPrefs(arg_10_0, arg_10_1, arg_10_2)
	if string.nilorempty(arg_10_1) or not arg_10_2 then
		return
	end

	local var_10_0 = var_0_1(arg_10_1)

	if type(arg_10_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_10_0, arg_10_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_10_0, arg_10_2)
	end
end

function var_0_0.getPlayerPrefs(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 or ""

	if string.nilorempty(arg_11_1) then
		return var_11_0
	end

	local var_11_1 = var_0_1(arg_11_1)

	if type(var_11_0) == "number" then
		var_11_0 = GameUtil.playerPrefsGetNumberByUserId(var_11_1, var_11_0)
	else
		var_11_0 = GameUtil.playerPrefsGetStringByUserId(var_11_1, var_11_0)
	end

	return var_11_0
end

function var_0_0.loadDictFromStr(arg_12_0, arg_12_1)
	local var_12_0 = {}

	if not string.nilorempty(arg_12_1) then
		var_12_0 = cjson.decode(arg_12_1)
	end

	return var_12_0
end

function var_0_0.openVersionActivityReactivityDungeonMapView(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._bigVersion, arg_13_0._smallVersion = arg_13_1, arg_13_2

	arg_13_0:openVersionActivityDungeonMapView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
