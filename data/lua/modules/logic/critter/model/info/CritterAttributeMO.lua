module("modules.logic.critter.model.info.CritterAttributeMO", package.seeall)

local var_0_0 = pureTable("CritterAttributeMO")
local var_0_1 = {}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_1
	arg_1_0.attributeId = arg_1_1.attributeId or 0
	arg_1_0.value = arg_1_1.value and math.floor(arg_1_1.value / 10000) or 0
end

function var_0_0.setAttr(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.attributeId = arg_2_1
	arg_2_0.value = arg_2_2
end

function var_0_0.getValueNum(arg_3_0)
	return arg_3_0.value
end

return var_0_0
