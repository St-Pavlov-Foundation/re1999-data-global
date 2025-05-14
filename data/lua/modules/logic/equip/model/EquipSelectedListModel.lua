module("modules.logic.equip.model.EquipSelectedListModel", package.seeall)

local var_0_0 = class("EquipSelectedListModel", ListScrollModel)

function var_0_0.initList(arg_1_0)
	arg_1_0:updateList()
end

function var_0_0.updateList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = 1, EquipEnum.StrengthenMaxCount do
		table.insert(var_2_0, arg_2_1 and arg_2_1[iter_2_0] or {})
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0.clearList(arg_3_0)
	arg_3_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
