module("modules.logic.weekwalk.model.WeekWalkTarotListModel", package.seeall)

local var_0_0 = class("WeekWalkTarotListModel", ListScrollModel)

function var_0_0.setTarotList(arg_1_0, arg_1_1)
	arg_1_0:clear()
	arg_1_0:setList(arg_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
