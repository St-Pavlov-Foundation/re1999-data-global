module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114BaseFlow", package.seeall)

local var_0_0 = class("Activity114BaseFlow", FlowSequence)

function var_0_0.initParams(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.context = arg_1_1

	if arg_1_0.context.eventId then
		arg_1_0.context.eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, arg_1_0.context.eventId)
	end

	arg_1_0.context.nowWeek = Activity114Model.instance.serverData.week
	arg_1_0.context.nowDay = arg_1_0.context.nowDay or Activity114Model.instance.serverData.day
	arg_1_0.context.nowRound = arg_1_0.context.nowRound or Activity114Model.instance.serverData.round
	arg_1_0.context.preAttention = arg_1_0.context.preAttention or Activity114Model.instance.serverData.attention
	arg_1_0.context.preAttrs = tabletool.copy(Activity114Model.instance.attrDict)

	arg_1_0:setup(arg_1_1, arg_1_2)
end

function var_0_0.setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:addWork(Activity114WaitStoryCloseEndWork.New())
	arg_2_0:addWork(Activity114DelayWork.New(0))

	if not arg_2_2 then
		arg_2_0:addNoSkipWork()
	else
		arg_2_0:addSkipWork()
	end

	arg_2_0:addRoundEndStory()
	arg_2_0:addRoundEndTransition()
	arg_2_0:addWork(Activity114ChangeEventWork.New())
	arg_2_0:addWork(Activity114WaitStoryCloseEndWork.New())
	arg_2_0:start(arg_2_0.context)
end

function var_0_0.addNoSkipWork(arg_3_0)
	arg_3_0:addEventBeginStory()
	arg_3_0:addEventWork()
end

function var_0_0.addSkipWork(arg_4_0)
	arg_4_0:addEventBeginStory()
	arg_4_0:addEventWork()
end

function var_0_0.addEventWork(arg_5_0)
	return
end

function var_0_0.getContext(arg_6_0)
	return arg_6_0.context
end

function var_0_0.canFinishStory(arg_7_0)
	local var_7_0 = arg_7_0._workList[arg_7_0._curIndex]

	if not var_7_0 then
		return true
	end

	local var_7_1 = arg_7_0.context.eventCo

	if not var_7_1 then
		return true
	end

	if arg_7_0.context.storyType == Activity114Enum.StoryType.Event and (var_7_1.config.isCheckEvent > 0 or var_7_1.config.testId > 0) then
		arg_7_0:_closeCurStoryWork(var_7_0)

		return false
	end

	return true
end

function var_0_0._closeCurStoryWork(arg_8_0, arg_8_1)
	arg_8_0.context.storyWorkEnd = true

	arg_8_1:forceEndStory()
end

function var_0_0.addEventBeginStory(arg_9_0)
	local var_9_0 = arg_9_0.context.eventCo

	if not var_9_0 then
		return
	end

	if var_9_0.config.storyId <= 0 then
		return
	end

	arg_9_0:addWork(Activity114StoryWork.New(var_9_0.config.storyId, Activity114Enum.StoryType.Event))
end

function var_0_0.addRoundEndStory(arg_10_0)
	local var_10_0 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, arg_10_0.context.nowDay, arg_10_0.context.nowRound)

	if not var_10_0 then
		return
	end

	if var_10_0.storyId <= 0 then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	arg_10_0:addWork(Activity114StoryWork.New(var_10_0.storyId, Activity114Enum.StoryType.RoundEnd))
end

function var_0_0.addRoundEndTransition(arg_11_0)
	local var_11_0 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, arg_11_0.context.nowDay, arg_11_0.context.nowRound)

	if not var_11_0 then
		return
	end

	if var_11_0.transition <= 0 then
		return
	end

	arg_11_0:addWork(Activity114OpenTransitionViewWork.New(var_11_0.transition))
end

return var_0_0
