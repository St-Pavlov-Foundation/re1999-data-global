module("modules.logic.chessgame.game.step.ChessStepCompleted", package.seeall)

local var_0_0 = class("ChessStepCompleted", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = ChessGameInteractModel.instance:getInteractById(arg_2_0.originData.interactId)

	if var_2_0 then
		var_2_0.isFinish = true

		ChessGameController.instance.interactsMgr:getMainPlayer():getHandler():calCanWalkArea()
		ChessGameInteractModel.instance:setInteractFinishMap()
	end

	arg_2_0:onDone(true)
end

return var_0_0
