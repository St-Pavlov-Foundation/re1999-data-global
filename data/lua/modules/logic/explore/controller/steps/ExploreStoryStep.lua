module("modules.logic.explore.controller.steps.ExploreStoryStep", package.seeall)

local var_0_0 = class("ExploreStoryStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	StoryController.instance:playStory(arg_1_0._data.storyId, nil, arg_1_0.onDone, arg_1_0)
end

return var_0_0
