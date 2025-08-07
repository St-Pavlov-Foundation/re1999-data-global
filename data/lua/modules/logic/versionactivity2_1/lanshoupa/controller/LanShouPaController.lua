module("modules.logic.versionactivity2_1.lanshoupa.controller.LanShouPaController", package.seeall)

local var_0_0 = class("LanShouPaController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ChessGameController.instance:registerCallback(ChessGameEvent.OnVictory, arg_3_0._onVictory, arg_3_0)
	ChessGameController.instance:registerCallback(ChessGameEvent.OnFail, arg_3_0._onFail, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._waitActId = nil
	arg_4_0._waitEpisodeId = nil
end

function var_0_0.openStoryView(arg_5_0, arg_5_1)
	if Activity164Model.instance:isEpisodeClear(arg_5_1) then
		ViewMgr.instance:openView(ViewName.LanShouPaStoryView, {
			actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
			episodeId = arg_5_1
		})
	end
end

var_0_0.ENTER_CHESS_GAME_BLOCK_KEY = "LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY"

function var_0_0.enterChessGame(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	UIBlockMgr.instance:startBlock(var_0_0.ENTER_CHESS_GAME_BLOCK_KEY)

	arg_6_0._waitActId = arg_6_1
	arg_6_0._waitEpisodeId = arg_6_2

	Activity164Model.instance:setCurEpisodeId(arg_6_2)
	TaskDispatcher.cancelTask(arg_6_0._onEnterChessGame, arg_6_0, arg_6_3)
	TaskDispatcher.runDelay(arg_6_0._onEnterChessGame, arg_6_0, arg_6_3 or 0.1)
end

function var_0_0._onEnterChessGame(arg_7_0)
	UIBlockMgr.instance:endBlock(var_0_0.ENTER_CHESS_GAME_BLOCK_KEY)

	if arg_7_0._waitActId and arg_7_0._waitEpisodeId then
		Activity164Rpc.instance:sendActStartEpisodeRequest(arg_7_0._waitActId, arg_7_0._waitEpisodeId, arg_7_0._onOpenGame, arg_7_0)
	end
end

function var_0_0.resetStartGame(arg_8_0)
	local var_8_0 = ChessModel.instance:getEpisodeId()
	local var_8_1 = ChessModel.instance:getActId()

	if var_8_1 and var_8_0 then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		Activity164Rpc.instance:sendActReStartEpisodeRequest(var_8_1, var_8_0, arg_8_0._onRestartCallback, arg_8_0)
	end
end

var_0_0.RETURN_POINT_GAME_BLOCK_KEY = "LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY"

function var_0_0.returnPointGame(arg_9_0, arg_9_1)
	UIBlockMgr.instance:startBlock(var_0_0.RETURN_POINT_GAME_BLOCK_KEY)

	local var_9_0 = ChessModel.instance:getActId()

	arg_9_0._isLastCheckPoint = arg_9_1 == ChessGameEnum.RollBack.CheckPoint

	local var_9_1 = ChessModel.instance:getEpisodeId()

	if var_9_0 then
		Activity164Rpc.instance:sendActRollBackRequest(var_9_0, var_9_1, arg_9_1, arg_9_0._onReurnPiontGame, arg_9_0)
	end
end

function var_0_0._onRestartCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		ChessController.onOpenGameStoryPlayOver()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameReset)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function var_0_0._onReurnPiontGame(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	UIBlockMgr.instance:endBlock(var_0_0.RETURN_POINT_GAME_BLOCK_KEY)

	if arg_11_2 ~= 0 then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	else
		if arg_11_3.dead then
			return
		end

		if arg_11_0._isLastCheckPoint then
			ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
			TaskDispatcher.runDelay(arg_11_0._eventReurnPiontGame, arg_11_0, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
			ViewMgr.instance:closeView(ViewName.LanShouPaGameResultView)
			ChessStatController.instance:startStat()
		else
			arg_11_0:_eventReurnPiontGame()
		end
	end
end

function var_0_0._eventReurnPiontGame(arg_12_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GamePointReturn)
end

function var_0_0._onOpenGame(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == 0 then
		if arg_13_3.scene and arg_13_3.scene.dead then
			local function var_13_0()
				Activity164Rpc.instance:sendActStartEpisodeRequest(arg_13_3.activityId, arg_13_3.episodeId, arg_13_0._onOpenGame, arg_13_0)
			end

			Activity164Rpc.instance:sendActAbortRequest(arg_13_3.activityId, arg_13_3.episodeId, var_13_0, arg_13_0)

			return
		end

		ChessController.instance:initMapData(arg_13_3.activityId, arg_13_3.episodeId, arg_13_3.scene)
		ChessGameController.instance:setViewName(ViewName.LanShouPaGameView)
		ChessController.instance:openGameView(arg_13_1, arg_13_2)
	end
end

function var_0_0.openActivity164GameView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.episodeId
	local var_15_1 = Activity164Config.instance:getEpisodeCo(VersionActivity2_1Enum.ActivityId.LanShouPa, var_15_0).mapIds

	ChessGameController.instance:enterGame(var_15_1, ViewName.LanShouPaGameView)
end

function var_0_0.openTaskView(arg_16_0)
	ViewMgr.instance:openView(ViewName.LanShouPaTaskView)
end

function var_0_0._onVictory(arg_17_0)
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, true)
end

function var_0_0._onFail(arg_18_0)
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, false)
end

function var_0_0.openLanShouPaMapView(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or VersionActivity2_1Enum.ActivityId.LanShouPa

	if arg_19_2 then
		Activity164Rpc.instance:sendGetActInfoRequest(arg_19_1, function(arg_20_0, arg_20_1, arg_20_2)
			if arg_20_1 == 0 then
				ViewMgr.instance:openView(ViewName.LanShouPaMapView)
			end
		end)
	else
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
