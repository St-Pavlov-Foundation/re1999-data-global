module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTransferFinish", package.seeall)

slot0 = class("WaitGuideActionExploreTransferFinish", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, slot0._onHeroStatuEnd, slot0)
end

function slot0._onHeroStatuEnd(slot0, slot1)
	if slot1 == ExploreAnimEnum.RoleAnimStatus.Entry then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, slot0._onHeroStatuEnd, slot0)
end

return slot0
