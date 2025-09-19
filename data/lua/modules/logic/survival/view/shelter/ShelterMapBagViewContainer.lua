module("modules.logic.survival.view.shelter.ShelterMapBagViewContainer", package.seeall)

local var_0_0 = class("ShelterMapBagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ShelterMapBagView.New(),
		ToggleListView.New(1, "root/toggleGroup")
	}
end

return var_0_0
