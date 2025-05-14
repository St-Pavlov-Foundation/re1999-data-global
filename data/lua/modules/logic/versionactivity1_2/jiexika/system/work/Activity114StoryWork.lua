module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StoryWork", package.seeall)

local var_0_0 = class("Activity114StoryWork", Activity114BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._storyId = arg_1_1
	arg_1_0._storyType = arg_1_2

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not arg_2_0._storyId then
		arg_2_0._storyId = arg_2_1.storyId
		arg_2_1.storyId = nil
	end

	if type(arg_2_0._storyId) == "string" then
		arg_2_0._storyId = tonumber(arg_2_0._storyId)
	end

	if not arg_2_0._storyId or arg_2_0._storyId <= 0 then
		arg_2_0:onDone(true)

		return
	end

	if Activity114Model.instance.waitStoryFinish then
		Activity114Controller.instance:registerCallback(Activity114Event.StoryFinish, arg_2_0.playStory, arg_2_0)
	else
		arg_2_0:playStory()
	end
end

function var_0_0.playStory(arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, arg_3_0.playStory, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.AllStepFinished, arg_3_0._onStoryFinish, arg_3_0)
	StoryController.instance:playStory(arg_3_0._storyId)

	arg_3_0.context.storyType = arg_3_0._storyType
end

function var_0_0.forceEndStory(arg_4_0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, arg_4_0._onStoryFinish, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._onStoryFinish(arg_5_0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, arg_5_0._onStoryFinish, arg_5_0)

	if Activity114Model.instance:isEnd() then
		arg_5_0:onDone(false)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, arg_6_0.playStory, arg_6_0)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, arg_6_0._onStoryFinish, arg_6_0)
	var_0_0.super.clearWork(arg_6_0)
end

return var_0_0
