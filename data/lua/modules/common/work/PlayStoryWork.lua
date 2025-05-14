module("modules.common.work.PlayStoryWork", package.seeall)

local var_0_0 = class("PlayStoryWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.storyId = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	StoryController.instance:playStory(arg_2_0.storyId, nil, arg_2_0.onPlayStoryDone, arg_2_0)
end

function var_0_0.onPlayStoryDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
