module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WaitStoryCloseEndWork", package.seeall)

slot0 = class("Activity114WaitStoryCloseEndWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, slot0._onCloseViewFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		return
	end

	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, slot0._onCloseViewFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
