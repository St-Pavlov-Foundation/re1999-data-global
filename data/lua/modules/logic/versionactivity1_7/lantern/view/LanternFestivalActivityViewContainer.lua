module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalActivityViewContainer", package.seeall)

local var_0_0 = class("LanternFestivalActivityViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LanternFestivalActivityView.New()
	}
end

return var_0_0
