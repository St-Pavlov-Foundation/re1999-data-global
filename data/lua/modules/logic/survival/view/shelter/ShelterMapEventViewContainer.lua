module("modules.logic.survival.view.shelter.ShelterMapEventViewContainer", package.seeall)

local var_0_0 = class("ShelterMapEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ShelterMapEventView.New()
	}
end

return var_0_0
