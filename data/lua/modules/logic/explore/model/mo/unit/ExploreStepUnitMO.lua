module("modules.logic.explore.model.mo.unit.ExploreStepUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreStepUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.enterTriggerType = true
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreStepUnit
end

function var_0_0.isInActive(arg_3_0)
	return arg_3_0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

return var_0_0
