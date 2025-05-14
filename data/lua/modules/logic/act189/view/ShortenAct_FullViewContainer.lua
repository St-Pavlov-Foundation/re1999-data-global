module("modules.logic.act189.view.ShortenAct_FullViewContainer", package.seeall)

local var_0_0 = class("ShortenAct_FullViewContainer", ShortenActViewContainer_impl)

function var_0_0.buildViews(arg_1_0)
	return {
		arg_1_0:taskScrollView(),
		ShortenAct_FullView.New()
	}
end

return var_0_0
