module("modules.logic.seasonver.act123.view.Season123ShowHeroViewContainer", package.seeall)

local var_0_0 = class("Season123ShowHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123CheckCloseView.New(),
		Season123ShowHeroView.New()
	}
end

return var_0_0
