module("modules.logic.rouge.dlc.101.model.RougeLimiterDebuffOverListModel", package.seeall)

local var_0_0 = class("RougeLimiterDebuffOverListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0, arg_1_1)
	arg_1_0:initLimiterGroupList(arg_1_1)
end

function var_0_0.initLimiterGroupList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1 or {}) do
		local var_2_1 = RougeDLCConfig101.instance:getLimiterCo(iter_2_1)

		table.insert(var_2_0, var_2_1)
	end

	table.sort(var_2_0, arg_2_0._debuffSortFunc)
	arg_2_0:setList(var_2_0)
end

function var_0_0._debuffSortFunc(arg_3_0, arg_3_1)
	return arg_3_0.id < arg_3_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
