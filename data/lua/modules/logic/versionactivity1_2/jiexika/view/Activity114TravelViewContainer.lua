module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelViewContainer", package.seeall)

local var_0_0 = class("Activity114TravelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity114TravelView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
