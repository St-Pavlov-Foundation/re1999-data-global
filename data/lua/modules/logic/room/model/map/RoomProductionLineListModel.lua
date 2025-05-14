module("modules.logic.room.model.map.RoomProductionLineListModel", package.seeall)

local var_0_0 = class("RoomProductionLineListModel", ListScrollModel)

function var_0_0.updatePartLines(arg_1_0, arg_1_1)
	local var_1_0 = RoomConfig.instance:getProductionPartConfig(arg_1_1)
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.productionLines) do
		local var_1_2 = RoomProductionModel.instance:getLineMO(iter_1_1)

		table.insert(var_1_1, var_1_2)
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
