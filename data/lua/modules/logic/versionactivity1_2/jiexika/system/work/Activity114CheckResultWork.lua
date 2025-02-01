module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckResultWork", package.seeall)

slot0 = class("Activity114CheckResultWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	if slot0.context.eventCo.config.isCheckEvent == 1 then
		slot0:getFlow():addWork(Activity114StopStoryWork.New())
	end

	if slot0.context.result == Activity114Enum.Result.None then
		slot0.context.storyId = nil
	elseif slot0.context.result == Activity114Enum.Result.Success then
		slot0:getFlow():addWork(Activity114StoryWork.New(slot2.config.successStoryId, Activity114Enum.StoryType.Result))
		slot0:getFlow():addWork(Activity114StopStoryWork.New())
		slot0:getFlow():addWork(Activity114OpenAttrViewWork.New())
	elseif slot0.context.result == Activity114Enum.Result.Fail then
		slot0:getFlow():addWork(Activity114StoryWork.New(slot2.config.failureStoryId, Activity114Enum.StoryType.Result))

		if slot2.config.battleId > 0 then
			slot0:getFlow():addWork(Activity114StopStoryWork.New())
			slot0:getFlow():addWork(Activity114FightWork.New())
			slot0:getFlow():addWork(Activity114FightResultWork.New())
			slot0:getFlow():addWork(Activity114OpenAttrViewWork.New())
		else
			slot0:getFlow():addWork(Activity114StopStoryWork.New())
			slot0:getFlow():addWork(Activity114OpenAttrViewWork.New())
		end
	end

	slot0:startFlow()
end

return slot0
