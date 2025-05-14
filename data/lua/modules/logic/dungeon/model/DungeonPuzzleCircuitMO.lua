module("modules.logic.dungeon.model.DungeonPuzzleCircuitMO", package.seeall)

local var_0_0 = pureTable("DungeonPuzzleCircuitMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.x = arg_1_1
	arg_1_0.y = arg_1_2
	arg_1_0.id = arg_1_1 * 100 + arg_1_2
	arg_1_0.value = 0
	arg_1_0.rawValue = 0
	arg_1_0.type = 0
end

function var_0_0.toString(arg_2_0)
	return string.format("id:%s,x:%s,y:%s,type:%s,value:%s", arg_2_0.id, arg_2_0.x, arg_2_0.y, arg_2_0.type, arg_2_0.value)
end

return var_0_0
