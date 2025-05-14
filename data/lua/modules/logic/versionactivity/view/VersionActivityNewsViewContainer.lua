module("modules.logic.versionactivity.view.VersionActivityNewsViewContainer", package.seeall)

local var_0_0 = class("VersionActivityNewsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivityNewsView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

return var_0_0
