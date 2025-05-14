module("modules.logic.chessgame.game.step.ChessStepInteractDelete", package.seeall)

local var_0_0 = class("ChessStepInteractDelete", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:deleteInteractObj()
end

function var_0_0.deleteInteractObj(arg_3_0)
	local var_3_0 = arg_3_0.originData.id
	local var_3_1 = ChessGameInteractModel.instance:getInteractById(var_3_0)

	if var_3_1 and var_3_1:isInCurrentMap() then
		ChessGameController.instance.interactsMgr:get(var_3_0):getHandler():showDestoryAni(arg_3_0._deleteAnimCallback, arg_3_0)
	else
		arg_3_0:_deleteAnimCallback()
	end
end

function var_0_0._deleteAnimCallback(arg_4_0)
	local var_4_0 = arg_4_0.originData.id

	ChessGameController.instance:deleteInteractObj(var_4_0)
	arg_4_0:onDone(true)
end

return var_0_0
