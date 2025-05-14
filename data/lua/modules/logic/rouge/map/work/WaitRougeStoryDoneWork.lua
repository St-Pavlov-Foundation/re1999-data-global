module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

local var_0_0 = class("WaitRougeStoryDoneWork", BaseWork)
local var_0_1 = 9.99
local var_0_2 = "starWaitRougeStoryDoneWorktBlock"

function var_0_0._onStoryStart(arg_1_0, arg_1_1)
	if arg_1_0.storyId ~= arg_1_1 then
		return
	end

	UIBlockHelper.instance:endBlock(var_0_2)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.storyId = arg_2_1
end

function var_0_0.onStart(arg_3_0)
	if not arg_3_0.storyId or arg_3_0.storyId == 0 then
		return arg_3_0:onDone(true)
	end

	StoryController.instance:registerCallback(StoryEvent.Start, arg_3_0._onStoryStart, arg_3_0)
	UIBlockHelper.instance:startBlock(var_0_2, var_0_1)
	StoryController.instance:playStory(arg_3_0.storyId, nil, arg_3_0.onStoryDone, arg_3_0)
end

function var_0_0.onStoryDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_5_0._onStoryStart, arg_5_0)
end

return var_0_0
