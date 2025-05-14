module("modules.logic.seasonver.act123.view2_0.Season123_2_0ShowHeroViewContainer", package.seeall)

local var_0_0 = class("Season123_2_0ShowHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0ShowHeroView.New()
	}
end

return var_0_0
