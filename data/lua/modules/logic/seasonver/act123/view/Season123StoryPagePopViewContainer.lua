module("modules.logic.seasonver.act123.view.Season123StoryPagePopViewContainer", package.seeall)

local var_0_0 = class("Season123StoryPagePopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123StoryPagePopView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
