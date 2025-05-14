module("modules.logic.explore.map.unit.ExploreGravityTriggerUnit", package.seeall)

local var_0_0 = class("ExploreGravityTriggerUnit", ExploreBaseDisplayUnit)

function var_0_0.onRoleEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3:isRole() or arg_1_3.mo.canTriggerGear then
		arg_1_0:tryTrigger()
	end
end

return var_0_0
