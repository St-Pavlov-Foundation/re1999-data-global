module("modules.logic.explore.model.mo.unit.ExploreGravityGearUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreGravityGearUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.keyUnitTypes = string.splitToNumber(arg_1_0.specialDatas[1], "#")
	arg_1_0.enterTriggerType = true
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreGravityTriggerUnit
end

return var_0_0
