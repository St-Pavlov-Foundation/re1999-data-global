module("modules.logic.dungeon.controller.DungeonJumpGameController", package.seeall)

local var_0_0 = class("DungeonJumpGameController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.release(arg_4_0)
	return
end

function var_0_0.openResultView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		isWin = arg_5_1,
		elementId = arg_5_2
	}

	ViewMgr.instance:openView(ViewName.DungeonJumpGameResultView, var_5_0)
end

function var_0_0.resetGame(arg_6_0)
	return
end

function var_0_0.checkIsJumpGameBattle(arg_7_0)
	return DungeonModel.instance.curSendEpisodeId == DungeonJumpGameEnum.episodeId
end

function var_0_0.returnToJumpGameView(arg_8_0)
	local var_8_0 = DungeonModel.instance.curSendEpisodeId
	local var_8_1 = DungeonModel.instance.curSendChapterId
	local var_8_2 = DungeonConfig.instance:getChapterCO(var_8_1)

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.DungeonMapView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_8_0.onOpenDungeonMapView, arg_8_0)
		JumpController.instance:jumpByParam("3#110")
	end)
end

function var_0_0.onOpenDungeonMapView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_10_0.onOpenDungeonMapView, arg_10_0)
		ViewMgr.instance:openView(ViewName.DungeonJumpGameView)
	end
end

function var_0_0.SaveCurProgress(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = string.format("%d", var_11_0)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), var_11_1)
end

function var_0_0.HasLocalProgress(arg_12_0)
	local var_12_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")

	return var_12_0 and not string.nilorempty(var_12_0)
end

function var_0_0.ClearProgress(arg_13_0)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")
end

function var_0_0.LoadProgress(arg_14_0)
	local var_14_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")

	if string.nilorempty(var_14_0) then
		return
	end

	return string.splitToNumber(var_14_0, ",")[1]
end

function var_0_0.initStatData(arg_15_0)
	arg_15_0.statMo = DungeonGameMo.New()
end

function var_0_0.sandStatData(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.statMo:sendJumpGameStatData(arg_16_1, arg_16_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
