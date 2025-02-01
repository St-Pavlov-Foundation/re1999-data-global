module("modules.logic.explore.map.unit.ExploreResetUnit", package.seeall)

slot0 = class("ExploreResetUnit", ExploreBaseDisplayUnit)

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	if not slot3:isRole() then
		return
	end

	if slot3:isMoving() then
		slot3:stopMoving()
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, slot0.beginTrigger, slot0)
	else
		TaskDispatcher.runDelay(slot0.beginTrigger, slot0, 0)
	end

	slot0.animComp:playAnim(ExploreAnimEnum.AnimName.nToA)
end

function slot0.onRoleLeave(slot0, slot1, slot2, slot3)
	if not slot3:isRole() then
		return
	end

	slot0.animComp:playAnim(ExploreAnimEnum.AnimName.aToN)
end

function slot0.beginTrigger(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0.beginTrigger, slot0)
	ExploreHeroResetFlow.instance:begin(slot0.id)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.beginTrigger, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0.beginTrigger, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
