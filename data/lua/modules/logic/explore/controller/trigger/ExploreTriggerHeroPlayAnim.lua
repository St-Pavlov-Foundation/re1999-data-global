module("modules.logic.explore.controller.trigger.ExploreTriggerHeroPlayAnim", package.seeall)

slot0 = class("ExploreTriggerHeroPlayAnim", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot3 = string.splitToNumber(slot1, "#")
	slot0._state = slot3[1]
	slot0._dis = slot3[2]
	slot0._time = slot3[3]

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.PlayTriggerAnim)

	slot4 = ExploreController.instance:getMap():getHero()

	if slot0._dis then
		slot4:setMoveSpeed(slot0._time)

		slot0._moveDir = ExploreHelper.xyToDir(slot2.mo.nodePos.x - slot4.nodePos.x, slot2.mo.nodePos.y - slot4.nodePos.y)

		slot4:setTrOffset(slot0._moveDir, (slot2:getPos() - slot4:getPos()):SetNormalize():Mul(slot0._dis):Add(slot4:getPos()), slot0._time, slot0.onRoleMoveEnd, slot0)
	else
		slot0:onRoleMoveEnd()
	end
end

function slot0.onRoleMoveEnd(slot0)
	slot1 = ExploreController.instance:getMap():getHero()

	slot1:setMoveSpeed(0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, slot0.onHeroStateAnimEnd, slot0)
	slot1:setHeroStatus(slot0._state, true, true)
end

function slot0.onHeroStateAnimEnd(slot0)
	slot1 = ExploreController.instance:getMap():getHero()

	if slot0._dis then
		slot1:setMoveSpeed(slot0._time)
		slot1:setTrOffset(slot0._moveDir, slot1:getPos(), slot0._time, slot0.onRoleMoveBackEnd, slot0)
	else
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
	end

	slot0:onDone(true)
end

function slot0.onRoleMoveBackEnd(slot0)
	ExploreController.instance:getMap():getHero():setMoveSpeed(0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
end

function slot0.clearWork(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, slot0.onHeroStateAnimEnd, slot0)
end

return slot0
