module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5WarmUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_5WarmUpView.New(),
		VersionActivity1_5WarmUpInteract.New()
	}
end

return var_0_0
