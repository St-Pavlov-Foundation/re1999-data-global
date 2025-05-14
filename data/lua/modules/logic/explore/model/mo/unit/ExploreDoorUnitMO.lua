module("modules.logic.explore.model.mo.unit.ExploreDoorUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreDoorUnitMO", ExploreBaseUnitMO)

function var_0_0.getUnitClass(arg_1_0)
	return ExploreDoor
end

function var_0_0.isWalkable(arg_2_0)
	return arg_2_0:isDoorOpen()
end

function var_0_0.initTypeData(arg_3_0)
	arg_3_0.isPreventItem = tonumber(arg_3_0.specialDatas[1]) == 1
end

function var_0_0.updateWalkable(arg_4_0)
	arg_4_0:setNodeOpenKey(arg_4_0:isWalkable())
end

function var_0_0.isDoorOpen(arg_5_0)
	return arg_5_0:isInteractActiveState()
end

return var_0_0
