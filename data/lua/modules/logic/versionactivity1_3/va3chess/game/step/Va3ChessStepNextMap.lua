module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMap", package.seeall)

local var_0_0 = class("Va3ChessStepNextMap", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processNextMapStatus()
end

function var_0_0.processNextMapStatus(arg_2_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.BeforeEnterNextMap)
	TaskDispatcher.runDelay(arg_2_0.beginEnterNextMap, arg_2_0, 0.5)
end

function var_0_0.beginEnterNextMap(arg_3_0)
	local var_3_0 = Va3ChessModel.instance:getActId()
	local var_3_1 = Va3ChessModel.instance:getEpisodeId()
	local var_3_2 = Va3ChessConfig.instance:getEpisodeCo(var_3_0, var_3_1)
	local var_3_3 = Va3ChessModel.instance:getMapId()

	if var_3_2 and var_3_2.mapIds then
		local var_3_4 = string.split(var_3_2.mapIds, "#")

		var_3_3 = tonumber(var_3_4[2])
	end

	Va3ChessGameModel.instance:recordLastMapRound()
	Va3ChessController.instance:initMapData(var_3_0, arg_3_0.originData.act122Map)
	Va3ChessGameController.instance:enterChessGame(var_3_0, var_3_3, ViewName.Activity1_3ChessGameView)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
	arg_3_0:finish()
end

return var_0_0
