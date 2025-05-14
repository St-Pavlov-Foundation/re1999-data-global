module("modules.logic.chessgame.model.ChessGameNodeModel", package.seeall)

local var_0_0 = class("ChessGameNodeModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._nodes = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.setNodeDatas(arg_3_0, arg_3_1)
	arg_3_0._nodes = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = ChessGameNodeMo.New()

		var_3_0:setNode(iter_3_1)

		if not arg_3_0._nodes[iter_3_1.x] then
			arg_3_0._nodes[iter_3_1.x] = {}
		end

		arg_3_0._nodes[iter_3_1.x][iter_3_1.y] = var_3_0
	end
end

function var_0_0.getNode(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._nodes[arg_4_1] then
		return
	end

	return arg_4_0._nodes[arg_4_1][arg_4_2]
end

function var_0_0.getAllNodes(arg_5_0)
	return arg_5_0._nodes
end

function var_0_0.clear(arg_6_0)
	arg_6_0._nodes = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
