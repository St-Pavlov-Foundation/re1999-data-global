module("modules.logic.summon.view.SummonEquipGainViewContainer", package.seeall)

local var_0_0 = class("SummonEquipGainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EquipGetView.New(),
		SummonEquipGainView.New()
	}
end

return var_0_0
