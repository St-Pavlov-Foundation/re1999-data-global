module("modules.logic.versionactivity2_1.dungeon.controller.VersionActivity2_1DungeonController", package.seeall)

local var_0_0 = class("VersionActivity2_1DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function var_0_0.openTaskView(arg_3_0)
	local var_3_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_3_0, arg_3_0._openTaskViewAfterRpc, arg_3_0)
end

function var_0_0._openTaskViewAfterRpc(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_1TaskView)
end

function var_0_0.openStoreView(arg_5_0)
	local var_5_0 = VersionActivity2_1Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_5_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_5_0, arg_5_0._openStoreViewAfterRpc, arg_5_0)
end

function var_0_0._openStoreViewAfterRpc(arg_6_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_1StoreView)
end

function var_0_0.openVersionActivityDungeonMapView(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.dungeonMapViewParam = {
		chapterId = arg_7_1,
		episodeId = arg_7_2
	}
	arg_7_0.openMapViewCallback = arg_7_3
	arg_7_0.openMapViewCallbackObj = arg_7_4

	VersionActivity2_1DungeonModel.instance:init()

	arg_7_0.hasReceivedTaskInfo = false

	local var_7_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_7_0, arg_7_0._onReceiveTaskInfoReply, arg_7_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_1Enum.ActivityId.Dungeon)
end

function var_0_0._onReceiveTaskInfoReply(arg_8_0)
	arg_8_0.hasReceivedTaskInfo = true

	arg_8_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._internalOpenVersionActivityDungeonMapView(arg_9_0)
	if not arg_9_0.hasReceivedTaskInfo then
		return
	end

	arg_9_0.hasReceivedTaskInfo = false

	if not arg_9_0.dungeonMapViewParam.episodeId then
		local var_9_0 = VersionActivity2_1DungeonModel.instance:getUnFinishElementEpisodeId()
		local var_9_1 = VersionActivity2_1DungeonModel.instance:getUnFinishStoryElements()
		local var_9_2

		if var_9_1 and #var_9_1 > 0 then
			var_9_2 = DungeonConfig.instance:getEpisodeByElement(var_9_1[1])
		end

		if var_9_2 then
			arg_9_0.dungeonMapViewParam.episodeId = var_9_2
		elseif var_9_0 > 0 then
			arg_9_0.dungeonMapViewParam.episodeId = var_9_0
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapView, arg_9_0.dungeonMapViewParam)
end

function var_0_0.onVersionActivityDungeonMapViewOpen(arg_10_0)
	if not arg_10_0.openMapViewCallback then
		return
	end

	arg_10_0.openMapViewCallback(arg_10_0.openMapViewCallbackObj)

	arg_10_0.openMapViewCallback = nil
	arg_10_0.openMapViewCallbackObj = nil
end

local function var_0_1(arg_11_0)
	if string.nilorempty(arg_11_0) then
		return arg_11_0
	end

	return (string.format("2_0Dungeon_%s_%s", VersionActivity2_1Enum.ActivityId.Dungeon, arg_11_0))
end

function var_0_0.savePlayerPrefs(arg_12_0, arg_12_1, arg_12_2)
	if string.nilorempty(arg_12_1) or not arg_12_2 then
		return
	end

	local var_12_0 = var_0_1(arg_12_1)

	if type(arg_12_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_12_0, arg_12_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_12_0, arg_12_2)
	end
end

function var_0_0.getPlayerPrefs(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2 or ""

	if string.nilorempty(arg_13_1) then
		return var_13_0
	end

	local var_13_1 = var_0_1(arg_13_1)

	if type(var_13_0) == "number" then
		var_13_0 = GameUtil.playerPrefsGetNumberByUserId(var_13_1, var_13_0)
	else
		var_13_0 = GameUtil.playerPrefsGetStringByUserId(var_13_1, var_13_0)
	end

	return var_13_0
end

function var_0_0.loadDictFromStr(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if not string.nilorempty(arg_14_1) then
		var_14_0 = cjson.decode(arg_14_1)
	end

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
