module("modules.logic.dragonboat.view.DragonBoatFestivalViewContainer", package.seeall)

local var_0_0 = class("DragonBoatFestivalViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DragonBoatFestivalView.New()
	}
end

return var_0_0
