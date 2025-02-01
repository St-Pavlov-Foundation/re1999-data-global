module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114BaseFlow", package.seeall)

slot0 = class("Activity114BaseFlow", FlowSequence)

function slot0.initParams(slot0, slot1, slot2)
	slot0.context = slot1

	if slot0.context.eventId then
		slot0.context.eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot0.context.eventId)
	end

	slot0.context.nowWeek = Activity114Model.instance.serverData.week
	slot0.context.nowDay = slot0.context.nowDay or Activity114Model.instance.serverData.day
	slot0.context.nowRound = slot0.context.nowRound or Activity114Model.instance.serverData.round
	slot0.context.preAttention = slot0.context.preAttention or Activity114Model.instance.serverData.attention
	slot0.context.preAttrs = tabletool.copy(Activity114Model.instance.attrDict)

	slot0:setup(slot1, slot2)
end

function slot0.setup(slot0, slot1, slot2)
	slot0:addWork(Activity114WaitStoryCloseEndWork.New())
	slot0:addWork(Activity114DelayWork.New(0))

	if not slot2 then
		slot0:addNoSkipWork()
	else
		slot0:addSkipWork()
	end

	slot0:addRoundEndStory()
	slot0:addRoundEndTransition()
	slot0:addWork(Activity114ChangeEventWork.New())
	slot0:addWork(Activity114WaitStoryCloseEndWork.New())
	slot0:start(slot0.context)
end

function slot0.addNoSkipWork(slot0)
	slot0:addEventBeginStory()
	slot0:addEventWork()
end

function slot0.addSkipWork(slot0)
	slot0:addEventBeginStory()
	slot0:addEventWork()
end

function slot0.addEventWork(slot0)
end

function slot0.getContext(slot0)
	return slot0.context
end

function slot0.canFinishStory(slot0)
	if not slot0._workList[slot0._curIndex] then
		return true
	end

	if not slot0.context.eventCo then
		return true
	end

	if slot0.context.storyType == Activity114Enum.StoryType.Event and (slot2.config.isCheckEvent > 0 or slot2.config.testId > 0) then
		slot0:_closeCurStoryWork(slot1)

		return false
	end

	return true
end

function slot0._closeCurStoryWork(slot0, slot1)
	slot0.context.storyWorkEnd = true

	slot1:forceEndStory()
end

function slot0.addEventBeginStory(slot0)
	if not slot0.context.eventCo then
		return
	end

	if slot1.config.storyId <= 0 then
		return
	end

	slot0:addWork(Activity114StoryWork.New(slot1.config.storyId, Activity114Enum.StoryType.Event))
end

function slot0.addRoundEndStory(slot0)
	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot0.context.nowDay, slot0.context.nowRound) then
		return
	end

	if slot1.storyId <= 0 then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	slot0:addWork(Activity114StoryWork.New(slot1.storyId, Activity114Enum.StoryType.RoundEnd))
end

function slot0.addRoundEndTransition(slot0)
	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot0.context.nowDay, slot0.context.nowRound) then
		return
	end

	if slot1.transition <= 0 then
		return
	end

	slot0:addWork(Activity114OpenTransitionViewWork.New(slot1.transition))
end

return slot0
