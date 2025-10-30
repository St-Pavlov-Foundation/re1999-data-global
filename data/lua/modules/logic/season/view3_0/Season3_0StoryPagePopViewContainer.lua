module("modules.logic.season.view3_0.Season3_0StoryPagePopViewContainer", package.seeall)

local var_0_0 = class("Season3_0StoryPagePopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season3_0StoryPagePopView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
