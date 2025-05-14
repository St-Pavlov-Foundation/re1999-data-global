module("modules.logic.turnback.model.TurnbackBeginnerCategoryListModel", package.seeall)

local var_0_0 = class("TurnbackBeginnerCategoryListModel", ListScrollModel)

function var_0_0.setCategoryList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	table.sort(arg_1_0._moList, function(arg_2_0, arg_2_1)
		return arg_2_0.order < arg_2_1.order
	end)
	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.setOpenViewTime(arg_3_0)
	arg_3_0.openViewTime = Time.realtimeSinceStartup
end

var_0_0.instance = var_0_0.New()

return var_0_0
