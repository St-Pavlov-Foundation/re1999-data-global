module("modules.logic.equip.model.EquipBreakCostListModel", package.seeall)

local var_0_0 = class("EquipBreakCostListModel", ListScrollModel)

function var_0_0.initList(arg_1_0, arg_1_1)
	arg_1_0:setList(arg_1_1)
end

function var_0_0.clearList(arg_2_0)
	arg_2_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
