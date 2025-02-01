module("modules.logic.explore.controller.trigger.ExploreTriggerGuide", package.seeall)

slot0 = class("ExploreTriggerGuide", ExploreTriggerBase)

function slot0.handle(slot0, slot1)
	slot0._guideId = tonumber(slot1)

	if GuideModel.instance:getById(slot0._guideId) and slot2.isFinish or not slot2 then
		if not slot2 then
			logError("指引没有接？？？")
		end

		slot0:onDone(true)

		return
	end

	if ExploreController.instance:getMap():getHero():isMoving() then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Guide)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, slot0.beginGuide, slot0)
		slot3:stopMoving()
	else
		slot0:beginGuide()
	end
end

function slot0.beginGuide(slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Guide)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreTriggerGuide, slot0._guideId)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0.beginGuide, slot0)
end

return slot0
