module("modules.logic.explore.model.mo.unit.ExplorePrismMO", package.seeall)

local var_0_0 = class("ExplorePrismMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.fixItemId = tonumber(arg_1_0.specialDatas[1])
end

function var_0_0.getUnitClass(arg_2_0)
	return ExplorePrismUnit
end

return var_0_0
