module("modules.versionactivitybase.fixed.dungeon.controller.VersionActivityFixedDungeonController", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonController", BaseController)

function var_0_0.openTaskView(arg_1_0)
	local var_1_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_1_0, arg_1_0._openTaskViewAfterRpc, arg_1_0)
end

function var_0_0._openTaskViewAfterRpc(arg_2_0)
	local var_2_0 = VersionActivityFixedHelper.getVersionActivityTaskViewName(arg_2_0._bigVersion, arg_2_0._smallVersion)

	ViewMgr.instance:openView(var_2_0)
end

function var_0_0.openStoreView(arg_3_0)
	local var_3_0 = VersionActivityFixedHelper.getVersionActivityEnum(arg_3_0._bigVersion, arg_3_0._smallVersion).ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_3_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_3_0, arg_3_0._openStoreViewAfterRpc, arg_3_0)
end

function var_0_0._openStoreViewAfterRpc(arg_4_0)
	local var_4_0 = VersionActivityFixedHelper.getVersionActivityStoreViewName(arg_4_0._bigVersion, arg_4_0._smallVersion)

	ViewMgr.instance:openView(var_4_0)
end

function var_0_0.openVersionActivityDungeonMapView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:setEnterVerison()
	arg_5_0:_openVersionActivityDungeonMapView(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
end

function var_0_0._openVersionActivityDungeonMapView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.dungeonMapViewParam = {
		chapterId = arg_6_1,
		episodeId = arg_6_2
	}
	arg_6_0.openMapViewCallback = arg_6_3
	arg_6_0.openMapViewCallbackObj = arg_6_4

	VersionActivityFixedDungeonModel.instance:init()

	arg_6_0.hasReceivedTaskInfo = false

	local var_6_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_6_0, arg_6_0._onReceiveTaskInfoReply, arg_6_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon)
end

function var_0_0._onReceiveTaskInfoReply(arg_7_0)
	arg_7_0.hasReceivedTaskInfo = true

	arg_7_0:_internalOpenVersionActivityDungeonMapView(arg_7_0._bigVersion, arg_7_0._smallVersion)
end

function var_0_0._internalOpenVersionActivityDungeonMapView(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.hasReceivedTaskInfo then
		return
	end

	arg_8_0.hasReceivedTaskInfo = false

	if not arg_8_0.dungeonMapViewParam.episodeId then
		local var_8_0 = VersionActivityFixedDungeonModel.instance:getInitEpisodeId()

		if var_8_0 > 0 then
			arg_8_0.dungeonMapViewParam.episodeId = var_8_0
		end
	end

	local var_8_1 = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(arg_8_1, arg_8_2)

	ViewMgr.instance:openView(var_8_1, arg_8_0.dungeonMapViewParam)
end

function var_0_0.onVersionActivityDungeonMapViewOpen(arg_9_0)
	if not arg_9_0.openMapViewCallback then
		return
	end

	arg_9_0.openMapViewCallback(arg_9_0.openMapViewCallbackObj)

	arg_9_0.openMapViewCallback = nil
	arg_9_0.openMapViewCallbackObj = nil
end

local function var_0_1(arg_10_0)
	if string.nilorempty(arg_10_0) then
		return arg_10_0
	end

	local var_10_0, var_10_1 = var_0_0.instance:getEnterVerison()

	return (string.format("Dungeon_%s_%s", VersionActivityFixedHelper.getVersionActivityEnum(var_10_0, var_10_1).ActivityId.Dungeon, arg_10_0))
end

function var_0_0.savePlayerPrefs(arg_11_0, arg_11_1, arg_11_2)
	if string.nilorempty(arg_11_1) or not arg_11_2 then
		return
	end

	local var_11_0 = var_0_1(arg_11_1)

	if type(arg_11_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_11_0, arg_11_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_11_0, arg_11_2)
	end
end

function var_0_0.getPlayerPrefs(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2 or ""

	if string.nilorempty(arg_12_1) then
		return var_12_0
	end

	local var_12_1 = var_0_1(arg_12_1)

	if type(var_12_0) == "number" then
		var_12_0 = GameUtil.playerPrefsGetNumberByUserId(var_12_1, var_12_0)
	else
		var_12_0 = GameUtil.playerPrefsGetStringByUserId(var_12_1, var_12_0)
	end

	return var_12_0
end

function var_0_0.loadDictFromStr(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if not string.nilorempty(arg_13_1) then
		var_13_0 = cjson.decode(arg_13_1)
	end

	return var_13_0
end

function var_0_0.openVersionActivityReactivityDungeonMapView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:setEnterVerison(arg_14_1, arg_14_2)
	arg_14_0:_openVersionActivityDungeonMapView()
end

function var_0_0.setEnterVerison(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._bigVersion, arg_15_0._smallVersion = arg_15_1, arg_15_2
end

function var_0_0.getEnterVerison(arg_16_0)
	return arg_16_0._bigVersion, arg_16_0._smallVersion
end

var_0_0.instance = var_0_0.New()

return var_0_0
