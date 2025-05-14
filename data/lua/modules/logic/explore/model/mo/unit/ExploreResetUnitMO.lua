module("modules.logic.explore.model.mo.unit.ExploreResetUnitMO", package.seeall)

local var_0_0 = class("ExploreResetUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	local var_1_0 = string.splitToNumber(arg_1_0.specialDatas[1], "#")

	arg_1_0.targetX = var_1_0[1] or 0
	arg_1_0.targetY = var_1_0[2] or 0
	arg_1_0.targetDir = var_1_0[3] or 0
end

return var_0_0
