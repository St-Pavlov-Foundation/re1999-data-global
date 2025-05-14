module("modules.logic.explore.controller.trigger.ExploreTriggerStory", package.seeall)

local var_0_0 = class("ExploreTriggerStory", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1)
	arg_1_1 = tonumber(arg_1_1)

	logNormal("触发剧情：" .. arg_1_1)
	StoryController.instance:playStory(arg_1_1, nil, arg_1_0.playStoryEnd, arg_1_0, true)
end

function var_0_0.playStoryEnd(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

return var_0_0
