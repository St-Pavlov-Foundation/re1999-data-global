module("modules.logic.room.model.critter.RoomSummonPoolCritterListModel", package.seeall)

local var_0_0 = class("RoomSummonPoolCritterListModel", ListScrollModel)

function var_0_0.setDataList(arg_1_0, arg_1_1)
	table.sort(arg_1_1, arg_1_0._sortFunction)
	arg_1_0:setList(arg_1_1)
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getPoolCount() <= 0
	local var_2_1 = arg_2_1:getPoolCount() <= 0

	if var_2_0 ~= var_2_1 then
		return var_2_1
	end

	return arg_2_0.rare > arg_2_1.rare
end

var_0_0.instance = var_0_0.New()

return var_0_0
