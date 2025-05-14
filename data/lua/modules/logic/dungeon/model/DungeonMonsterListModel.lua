module("modules.logic.dungeon.model.DungeonMonsterListModel", package.seeall)

local var_0_0 = class("DungeonMonsterListModel", ListScrollModel)

function var_0_0.setMonsterList(arg_1_0, arg_1_1)
	local var_1_0 = DungeonModel.instance:getMonsterDisplayList(arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_0[iter_1_0] = {
			config = iter_1_1
		}
	end

	arg_1_0:setList(var_1_0)

	arg_1_0.initSelectMO = var_1_0[1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
