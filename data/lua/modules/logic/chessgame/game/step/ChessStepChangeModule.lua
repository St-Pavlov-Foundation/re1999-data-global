module("modules.logic.chessgame.game.step.ChessStepChangeModule", package.seeall)

local var_0_0 = class("ChessStepChangeModule", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.originData.interactId
	local var_2_1 = arg_2_0.originData.path
	local var_2_2 = ChessGameController.instance.interactsMgr:get(var_2_0)
	local var_2_3 = ChessGameInteractModel.instance:getInteractById(var_2_0)

	if var_2_3 and var_2_3:isInCurrentMap() then
		var_2_2:changeModule(var_2_1)
	end

	arg_2_0:onDone(true)
end

return var_0_0
