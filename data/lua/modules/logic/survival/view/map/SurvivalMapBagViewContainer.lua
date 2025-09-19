module("modules.logic.survival.view.map.SurvivalMapBagViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapBagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapBagView.New(),
		ToggleListView.New(1, "root/toggleGroup")
	}
end

return var_0_0
