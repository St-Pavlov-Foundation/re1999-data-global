module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameGridMO", package.seeall)

local var_0_0 = class("AssassinStealthGameGridMO")

function var_0_0.updateData(arg_1_0, arg_1_1)
	arg_1_0.gridId = arg_1_1.gridId
	arg_1_0.hasFog = arg_1_1.hasFog

	arg_1_0:updateTrapList(arg_1_1.traps)

	arg_1_0.tracePoint = arg_1_1.tracePoint
end

function var_0_0.updateTrapList(arg_2_0, arg_2_1)
	arg_2_0._trapDict = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0._trapDict[iter_2_1.id] = iter_2_1.duration
	end
end

function var_0_0.hasTrapType(arg_3_0, arg_3_1)
	local var_3_0 = false

	if arg_3_0._trapDict then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._trapDict) do
			if AssassinConfig.instance:getAssassinTrapType(iter_3_0) == arg_3_1 then
				var_3_0 = true

				break
			end
		end
	end

	return var_3_0
end

function var_0_0.hasTrap(arg_4_0, arg_4_1)
	return arg_4_0._trapDict and arg_4_0._trapDict[arg_4_1]
end

function var_0_0.getHasFog(arg_5_0)
	return arg_5_0.hasFog > 0 and true or false
end

function var_0_0.getTracePointIndex(arg_6_0)
	return arg_6_0.tracePoint
end

return var_0_0
