module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RestFlow", package.seeall)

slot0 = class("Activity114RestFlow", Activity114BaseFlow)

function slot0.addEventWork(slot0)
	slot0:addWork(Activity114StoryWork.New(slot0.context.eventCo.config.successStoryId, Activity114Enum.StoryType.Result))
	slot0:addWork(Activity114StopStoryWork.New())
	slot0:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
	slot0:addWork(Activity114OpenAttrViewWork.New())
end

return slot0
