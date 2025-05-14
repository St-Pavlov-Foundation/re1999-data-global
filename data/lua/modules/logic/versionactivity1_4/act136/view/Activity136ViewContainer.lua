module("modules.logic.versionactivity1_4.act136.view.Activity136ViewContainer", package.seeall)

local var_0_0 = class("Activity136ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity136View.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
