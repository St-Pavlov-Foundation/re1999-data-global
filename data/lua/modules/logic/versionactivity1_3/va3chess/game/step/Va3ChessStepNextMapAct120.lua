module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMapAct120", package.seeall)

local var_0_0 = class("Va3ChessStepNextMapAct120", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start)
	TaskDispatcher.cancelTask(arg_1_0._onProcessNextMapStatus, arg_1_0)
	TaskDispatcher.runDelay(arg_1_0._onProcessNextMapStatus, arg_1_0, 0.5)
end

function var_0_0._onProcessNextMapStatus(arg_2_0)
	local var_2_0 = Va3ChessModel.instance:getActId()
	local var_2_1 = Va3ChessModel.instance:getEpisodeId()
	local var_2_2 = Va3ChessConfig.instance:getEpisodeCo(var_2_0, var_2_1)
	local var_2_3 = Va3ChessModel.instance:getMapId()

	if var_2_2 and var_2_2.mapIds then
		local var_2_4 = string.split(var_2_2.mapIds, "#")

		var_2_3 = tonumber(var_2_4[2])
	end

	arg_2_0.originData.id = var_2_1

	local var_2_5 = cjson.encode(arg_2_0.originData)
	local var_2_6 = cjson.decode(var_2_5)

	for iter_2_0, iter_2_1 in ipairs(var_2_6.interactObjects) do
		if type(iter_2_1.data) == "table" then
			iter_2_1.data = cjson.encode(iter_2_1.data)
		end
	end

	if not var_2_6.finishInteracts then
		var_2_6.finishInteracts = Va3ChessGameModel.instance:findInteractFinishIds()
	end

	if not var_2_6.allFinishInteracts then
		var_2_6.allFinishInteracts = Va3ChessGameModel.instance:findInteractFinishIds(true)
	end

	if not var_2_6.currentRound then
		var_2_6.currentRound = Va3ChessGameModel.instance:getRound()
	end

	Va3ChessGameController.instance:initServerMap(var_2_0, var_2_6)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameMapDataUpdate)
	Va3ChessGameController.instance:enterChessGame(var_2_0, var_2_3)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
end

function var_0_0.finish(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onProcessNextMapStatus, arg_3_0)
	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onProcessNextMapStatus, arg_4_0)
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
