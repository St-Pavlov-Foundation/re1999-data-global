module("modules.logic.explore.model.mo.unit.ExploreRockUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreRockUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.canTriggerGear = true
	arg_1_0.triggerByClick = true
	arg_1_0.preNodeKey = nil
	arg_1_0.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.Rock].asset
	arg_1_0.triggerEffects = {}

	local var_1_0 = {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	}

	table.insert(arg_1_0.triggerEffects, var_1_0)
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreRockUnit
end

function var_0_0.isInteractEnabled(arg_3_0)
	return true
end

function var_0_0.isWalkable(arg_4_0)
	return false
end

return var_0_0
