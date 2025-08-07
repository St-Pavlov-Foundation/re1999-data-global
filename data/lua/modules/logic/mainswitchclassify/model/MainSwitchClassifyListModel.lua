module("modules.logic.mainswitchclassify.model.MainSwitchClassifyListModel", package.seeall)

local var_0_0 = class("MainSwitchClassifyListModel", ListScrollModel)

function var_0_0.initMoList(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(MainSwitchClassifyEnum.StyleClassifyInfo) do
		table.insert(var_1_0, iter_1_1)
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.Sort < arg_2_1.Sort
	end)
	arg_1_0:setList(var_1_0)
	arg_1_0:selectCell(1, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
