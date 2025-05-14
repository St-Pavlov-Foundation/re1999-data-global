module("modules.logic.chessgame.game.step.ChessStepTransport", package.seeall)

local var_0_0 = class("ChessStepTransport", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:_transPortMap()
end

function var_0_0._transPortMap(arg_3_0)
	local var_3_0 = arg_3_0.originData.interact

	if arg_3_0.originData.newMapId + 1 ~= ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:deleteInteractObj(var_3_0.id)
	else
		ChessGameController.instance:addInteractObj(var_3_0)
	end

	arg_3_0:onDone(true)
end

return var_0_0
