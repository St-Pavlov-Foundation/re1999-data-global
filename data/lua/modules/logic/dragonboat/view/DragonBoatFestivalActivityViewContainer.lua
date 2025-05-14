module("modules.logic.dragonboat.view.DragonBoatFestivalActivityViewContainer", package.seeall)

local var_0_0 = class("DragonBoatFestivalActivityViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DragonBoatFestivalActivityView.New()
	}
end

return var_0_0
