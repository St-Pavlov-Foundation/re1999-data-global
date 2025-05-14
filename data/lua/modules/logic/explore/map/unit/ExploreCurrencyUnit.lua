module("modules.logic.explore.map.unit.ExploreCurrencyUnit", package.seeall)

local var_0_0 = class("ExploreCurrencyUnit", ExploreBaseDisplayUnit)

function var_0_0.onRoleEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3:isRole() then
		arg_1_0:tryTrigger()
	end
end

function var_0_0.processMapIcon(arg_2_0, arg_2_1)
	arg_2_1 = string.split(arg_2_1, "#")[tonumber(arg_2_0.mo.specialDatas[1])]

	return arg_2_1
end

return var_0_0
