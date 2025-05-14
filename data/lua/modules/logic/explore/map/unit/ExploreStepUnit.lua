module("modules.logic.explore.map.unit.ExploreStepUnit", package.seeall)

local var_0_0 = class("ExploreStepUnit", ExploreBaseDisplayUnit)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onRoleEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_2 then
		return
	end

	if not arg_2_0:canTrigger() then
		return
	end

	if not arg_2_3:isRole() then
		return
	end

	arg_2_0:tryTrigger()
end

return var_0_0
