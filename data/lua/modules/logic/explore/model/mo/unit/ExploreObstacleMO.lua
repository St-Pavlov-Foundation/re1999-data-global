module("modules.logic.explore.model.mo.unit.ExploreObstacleMO", package.seeall)

local var_0_0 = pureTable("ExploreObstacleMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.triggerByClick = false
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreBaseDisplayUnit
end

function var_0_0.isWalkable(arg_3_0)
	return false
end

return var_0_0
