module("modules.logic.survival.view.shelter.ShelterCompositeSuccessViewContainer", package.seeall)

local var_0_0 = class("ShelterCompositeSuccessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ShelterCompositeSuccessView.New())

	return var_1_0
end

return var_0_0
