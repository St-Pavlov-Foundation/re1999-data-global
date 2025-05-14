module("modules.logic.explore.model.mo.unit.ExploreLightReceiverMO", package.seeall)

local var_0_0 = class("ExploreLightReceiverMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.isPhoticDir = tonumber(arg_1_0.specialDatas[1]) == 1
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreLightReceiverUnit
end

return var_0_0
