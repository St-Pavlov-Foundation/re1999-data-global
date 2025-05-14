module("modules.logic.versionactivity.view.VersionActivityExchangeTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivityExchangeTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivityExchangeTaskView.New()
	}
end

return var_0_0
