module("modules.logic.explore.model.mo.unit.ExploreBonusSceneUnitMO", package.seeall)

local var_0_0 = class("ExploreBonusSceneUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.triggerEffects = tabletool.copy(arg_1_0.triggerEffects)

	local var_1_0 = {
		ExploreEnum.TriggerEvent.OpenBonusView
	}

	if arg_1_0.triggerEffects[1] and arg_1_0.triggerEffects[1][1] == ExploreEnum.TriggerEvent.Dialogue then
		table.insert(arg_1_0.triggerEffects, 2, var_1_0)
	else
		table.insert(arg_1_0.triggerEffects, 1, var_1_0)
	end
end

return var_0_0
