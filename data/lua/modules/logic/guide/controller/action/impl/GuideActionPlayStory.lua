module("modules.logic.guide.controller.action.impl.GuideActionPlayStory", package.seeall)

local var_0_0 = class("GuideActionPlayStory", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._storyId = tonumber(arg_1_3) or nil

	if arg_1_0._storyId == nil then
		arg_1_0._storyIds = string.splitToNumber(arg_1_3, "#")
	end
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._storyId then
		if StoryModel.instance:isPrologueSkip(arg_2_0._storyId) then
			StoryController.instance:setStoryFinished(arg_2_0._storyId)
			StoryRpc.instance:sendUpdateStoryRequest(arg_2_0._storyId, -1, 0)
			StoryController.instance:dispatchEvent(StoryEvent.Finish, arg_2_0._storyId)
		else
			local var_2_0 = {}

			var_2_0.mark = true

			StoryController.instance:playStory(arg_2_0._storyId, var_2_0)
		end

		arg_2_0:onDone(true)
	elseif arg_2_0._storyIds and #arg_2_0._storyIds > 0 then
		local var_2_1 = {}

		var_2_1.mark = true

		StoryController.instance:playStories(arg_2_0._storyIds, var_2_1)
		arg_2_0:onDone(true)
	else
		logError("Guide story id nil, guide_" .. arg_2_0.guideId .. "_" .. arg_2_0.stepId)
		arg_2_0:onDone(false)
	end
end

return var_0_0
