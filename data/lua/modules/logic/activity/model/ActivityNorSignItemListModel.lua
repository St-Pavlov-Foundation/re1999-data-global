module("modules.logic.activity.model.ActivityNorSignItemListModel", package.seeall)

local var_0_0 = class("ActivityNorSignItemListModel", ListScrollModel)

function var_0_0.setDayList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	arg_1_0:setList(arg_1_0._moList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
