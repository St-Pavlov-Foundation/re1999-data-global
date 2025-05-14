module("modules.logic.chessgame.model.ChessGameNodeMo", package.seeall)

local var_0_0 = pureTable("ChessGameNodeMo")

function var_0_0.setNode(arg_1_0, arg_1_1)
	arg_1_0.x = arg_1_1.x
	arg_1_0.y = arg_1_1.y
	arg_1_0.noWalkCount = 0
	arg_1_0.noWalkCanDestoryCount = 0
end

function var_0_0.addNoWalkCount(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		arg_2_0.noWalkCanDestoryCount = arg_2_0.noWalkCanDestoryCount + arg_2_1
	else
		arg_2_0.noWalkCount = arg_2_0.noWalkCount + arg_2_1
	end
end

function var_0_0.isCanWalk(arg_3_0, arg_3_1)
	if arg_3_0.noWalkCount > 0 then
		return false
	end

	if arg_3_1 then
		return true
	else
		return arg_3_0.noWalkCanDestoryCount > 0
	end
end

return var_0_0
