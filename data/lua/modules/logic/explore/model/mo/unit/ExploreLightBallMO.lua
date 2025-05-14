module("modules.logic.explore.model.mo.unit.ExploreLightBallMO", package.seeall)

local var_0_0 = class("ExploreLightBallMO", ExploreObstacleMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.triggerByClick = false
	arg_1_0.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.LightBall].asset
	arg_1_0.isPhotic = true
	arg_1_0.triggerEffects = {}

	local var_1_0 = {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	}

	table.insert(arg_1_0.triggerEffects, var_1_0)
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreLightBallUnit
end

function var_0_0.isInteractEnabled(arg_3_0)
	return true
end

return var_0_0
