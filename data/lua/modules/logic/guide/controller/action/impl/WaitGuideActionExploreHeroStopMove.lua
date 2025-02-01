module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreHeroStopMove", package.seeall)

slot0 = class("WaitGuideActionExploreHeroStopMove", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	if not ExploreController.instance:getMap() then
		slot0:onDone(true)

		return
	end

	if not slot2:getHero():isMoving() then
		slot0:onDone(true)

		return
	end

	GuideBlockMgr.instance:startBlock(99999999)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, slot0.onMoveEnd, slot0)
end

function slot0.onMoveEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideBlockMgr.instance:removeBlock()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0.onMoveEnd, slot0)
end

return slot0
