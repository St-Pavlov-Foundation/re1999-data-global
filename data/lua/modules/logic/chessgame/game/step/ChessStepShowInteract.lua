module("modules.logic.chessgame.game.step.ChessStepShowInteract", package.seeall)

local var_0_0 = class("ChessStepShowInteract", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:appearInteract()
	arg_2_0:onDone(true)
end

function var_0_0.appearInteract(arg_3_0)
	local var_3_0 = arg_3_0.originData.interact

	var_3_0.mapIndex = var_3_0.mapIndex + 1

	if var_3_0.mapIndex == ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:addInteractObj(var_3_0)
	end
end

return var_0_0
