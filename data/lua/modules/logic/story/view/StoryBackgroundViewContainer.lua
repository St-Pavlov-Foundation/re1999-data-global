module("modules.logic.story.view.StoryBackgroundViewContainer", package.seeall)

local var_0_0 = class("StoryBackgroundViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, StoryBackgroundView.New())

	return var_1_0
end

return var_0_0
