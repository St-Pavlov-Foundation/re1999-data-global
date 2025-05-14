module("modules.logic.activity.model.ActivityNormalCategoryListModel", package.seeall)

local var_0_0 = class("ActivityNormalCategoryListModel", ListScrollModel)

function var_0_0.setCategoryList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	table.sort(arg_1_0._moList, function(arg_2_0, arg_2_1)
		return arg_2_0.co.displayPriority < arg_2_1.co.displayPriority
	end)
	arg_1_0:setList(arg_1_0._moList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
