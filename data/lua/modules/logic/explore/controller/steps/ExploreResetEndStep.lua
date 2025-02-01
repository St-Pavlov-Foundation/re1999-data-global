module("modules.logic.explore.controller.steps.ExploreResetEndStep", package.seeall)

slot0 = class("ExploreResetEndStep", ExploreStepBase)

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0.onDone, slot0, 1)
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)

	ExploreModel.instance.isReseting = false

	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Reset)
end

return slot0
