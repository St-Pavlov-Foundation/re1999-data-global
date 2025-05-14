module("modules.logic.chessgame.game.step.ChessStepCurrMapRefresh", package.seeall)

local var_0_0 = class("ChessStepCurrMapRefresh", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = ChessModel.instance:getActId()
	local var_2_1 = arg_2_0.originData.scene.episodeId
	local var_2_2 = arg_2_0.originData.scene.currMapIndex
	local var_2_3 = arg_2_0.originData.scene.currRound
	local var_2_4 = arg_2_0.originData.scene.maps[var_2_2 + 1].interacts
	local var_2_5 = arg_2_0.originData.scene.win
	local var_2_6 = arg_2_0.originData.scene.dead

	if var_2_2 + 1 ~= ChessGameModel.instance:getNowMapIndex() then
		local var_2_7 = {
			episodeId = var_2_1,
			currMapIndex = var_2_2,
			currentRound = var_2_3,
			completedCount = arg_2_0.originData.scene.completedCount,
			interact = var_2_4,
			win = var_2_5,
			dead = var_2_6
		}

		ChessGameController.instance:registerCallback(ChessGameEvent.GameLoadingMapStateUpdate, arg_2_0._onLoadFinish, arg_2_0)
		ChessGameController.instance:initServerMap(var_2_0, var_2_7)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start)
		ChessGameController.instance:setLoadingScene(true)

		local var_2_8 = ChessGameModel.instance:getNowMapResPath()

		ChessGameController.instance:dispatchEvent(ChessGameEvent.ChangeMap, var_2_8)
	end
end

function var_0_0._onLoadFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ChessGameEvent.LoadingMapState.Finish then
		arg_3_0:onDone(true)
		ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, arg_3_0._onLoadFinish, arg_3_0)
	end
end

function var_0_0.cleanWork(arg_4_0)
	ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, arg_4_0._onLoadFinish, arg_4_0)
end

return var_0_0
