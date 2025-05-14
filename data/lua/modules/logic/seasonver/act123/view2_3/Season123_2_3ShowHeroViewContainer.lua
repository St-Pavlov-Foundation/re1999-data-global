module("modules.logic.seasonver.act123.view2_3.Season123_2_3ShowHeroViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3ShowHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3ShowHeroView.New()
	}
end

return var_0_0
