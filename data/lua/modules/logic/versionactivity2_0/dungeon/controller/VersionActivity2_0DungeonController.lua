module("modules.logic.versionactivity2_0.dungeon.controller.VersionActivity2_0DungeonController", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonController", BaseController)

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
	ViewMgr.instance:openView(ViewName.VersionActivity2_0TaskView)
end

function var_0_0.openStoreView(arg_5_0)
	local var_5_0 = VersionActivity2_0Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(var_5_0) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_5_0, arg_5_0._openStoreViewAfterRpc, arg_5_0)
end

function var_0_0._openStoreViewAfterRpc(arg_6_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0StoreView)
end

function var_0_0.openVersionActivityDungeonMapView(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.dungeonMapViewParam = {
		chapterId = arg_7_1,
		episodeId = arg_7_2
	}
	arg_7_0.openMapViewCallback = arg_7_3
	arg_7_0.openMapViewCallbackObj = arg_7_4

	VersionActivity2_0DungeonModel.instance:init()

	arg_7_0.hasReceivedTaskInfo = false
	arg_7_0.hasReceivedAct161Info = false

	local var_7_0 = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_7_0, arg_7_0._onReceiveTaskInfoReply, arg_7_0)
	Activity161Controller.instance:initAct161Info(false, true, arg_7_0._onReceiveAct161InfoReply, arg_7_0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_0Enum.ActivityId.Dungeon)
end

function var_0_0._onReceiveTaskInfoReply(arg_8_0)
	arg_8_0.hasReceivedTaskInfo = true

	arg_8_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._onReceiveAct161InfoReply(arg_9_0)
	arg_9_0.hasReceivedAct161Info = true

	arg_9_0:_internalOpenVersionActivityDungeonMapView()
end

function var_0_0._internalOpenVersionActivityDungeonMapView(arg_10_0)
	if not arg_10_0.hasReceivedTaskInfo or not arg_10_0.hasReceivedAct161Info then
		return
	end

	arg_10_0.hasReceivedTaskInfo = false
	arg_10_0.hasReceivedAct161Info = false

	local var_10_0 = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()
	local var_10_1 = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()
	local var_10_2 = VersionActivity2_0DungeonEnum.PlayerPrefsKey.DungeonLastSelectEpisode
	local var_10_3 = var_0_0.instance:getPlayerPrefs(var_10_2, VersionActivity2_0DungeonEnum.restaurantChapterMap)

	if var_10_0 and not arg_10_0.dungeonMapViewParam.episodeId then
		arg_10_0.dungeonMapViewParam.episodeId = var_10_1 and VersionActivity2_0DungeonEnum.restaurantChapterMap or tonumber(var_10_3)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapView, arg_10_0.dungeonMapViewParam)
end

function var_0_0.onVersionActivityDungeonMapViewOpen(arg_11_0)
	if not arg_11_0.openMapViewCallback then
		return
	end

	arg_11_0.openMapViewCallback(arg_11_0.openMapViewCallbackObj)

	arg_11_0.openMapViewCallback = nil
	arg_11_0.openMapViewCallbackObj = nil
end

local function var_0_1(arg_12_0)
	if string.nilorempty(arg_12_0) then
		return arg_12_0
	end

	return (string.format("2_0Dungeon_%s_%s", VersionActivity2_0Enum.ActivityId.Dungeon, arg_12_0))
end

function var_0_0.savePlayerPrefs(arg_13_0, arg_13_1, arg_13_2)
	if string.nilorempty(arg_13_1) or not arg_13_2 then
		return
	end

	local var_13_0 = var_0_1(arg_13_1)

	if type(arg_13_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_13_0, arg_13_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_13_0, arg_13_2)
	end
end

function var_0_0.getPlayerPrefs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2 or ""

	if string.nilorempty(arg_14_1) then
		return var_14_0
	end

	local var_14_1 = var_0_1(arg_14_1)

	if type(var_14_0) == "number" then
		var_14_0 = GameUtil.playerPrefsGetNumberByUserId(var_14_1, var_14_0)
	else
		var_14_0 = GameUtil.playerPrefsGetStringByUserId(var_14_1, var_14_0)
	end

	return var_14_0
end

function var_0_0.loadDictFromStr(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if not string.nilorempty(arg_15_1) then
		var_15_0 = cjson.decode(arg_15_1)
	end

	return var_15_0
end

function var_0_0.openDialogueView(arg_16_0, arg_16_1)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DialogueView, {
		dialogueId = arg_16_1
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
