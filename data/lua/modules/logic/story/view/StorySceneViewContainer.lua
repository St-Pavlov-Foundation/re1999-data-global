module("modules.logic.story.view.StorySceneViewContainer", package.seeall)

local var_0_0 = class("StorySceneViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._storyMainSceneView = StoryMainSceneView.New()

	table.insert(var_1_0, arg_1_0._storyMainSceneView)
	table.insert(var_1_0, StorySceneView.New())

	return var_1_0
end

function var_0_0.getStoryMainSceneView(arg_2_0)
	return arg_2_0._storyMainSceneView
end

return var_0_0
