module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryPagePopViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3StoryPagePopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3StoryPagePopView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
