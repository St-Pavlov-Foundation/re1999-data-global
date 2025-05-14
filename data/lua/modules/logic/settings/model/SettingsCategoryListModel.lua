module("modules.logic.settings.model.SettingsCategoryListModel", package.seeall)

local var_0_0 = class("SettingsCategoryListModel", ListScrollModel)

function var_0_0.setCategoryList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 and arg_1_1 or {}

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)
	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
