module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114EduFlow", package.seeall)

slot0 = class("Activity114EduFlow", Activity114BaseFlow)

function slot0.addEventWork(slot0)
	slot0:addWork(Activity114EduWork.New())
	slot0:addWork(Activity114StoryWork.New(nil, Activity114Enum.StoryType.Result))
	slot0:addWork(Activity114StopStoryWork.New())
	slot0:addWork(Activity114OpenTransitionViewByEventCoWork.New())
	slot0:addWork(Activity114OpenAttrViewWork.New())
end

return slot0
