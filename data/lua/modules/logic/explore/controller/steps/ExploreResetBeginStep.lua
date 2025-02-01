module("modules.logic.explore.controller.steps.ExploreResetBeginStep", package.seeall)

slot0 = class("ExploreResetBeginStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreModel.instance.isReseting = true

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Reset)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.ExploreBlackView then
		TaskDispatcher.runDelay(slot0.onDone, slot0, 0.2)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	end
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
end

return slot0
