module("modules.logic.chessgame.game.step.ChessStepShowToast", package.seeall)

local var_0_0 = class("ChessStepShowToast", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:showToast()
	arg_2_0:onDone(true)
end

function var_0_0.showToast(arg_3_0)
	local var_3_0 = arg_3_0.originData.notifyId
	local var_3_1 = ChessModel.instance:getActId()
	local var_3_2 = ChessConfig.instance:getTipsCo(var_3_1, var_3_0)

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, var_3_2)
end

return var_0_0
