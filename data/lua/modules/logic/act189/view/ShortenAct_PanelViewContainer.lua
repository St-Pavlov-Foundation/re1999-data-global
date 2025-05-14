module("modules.logic.act189.view.ShortenAct_PanelViewContainer", package.seeall)

local var_0_0 = class("ShortenAct_PanelViewContainer", ShortenActViewContainer_impl)

function var_0_0.buildViews(arg_1_0)
	return {
		arg_1_0:taskScrollView(),
		ShortenAct_PanelView.New()
	}
end

return var_0_0
