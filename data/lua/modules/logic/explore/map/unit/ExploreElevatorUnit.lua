module("modules.logic.explore.map.unit.ExploreElevatorUnit", package.seeall)

slot0 = class("ExploreElevatorUnit", ExploreBaseDisplayUnit)

function slot0.onInit(slot0)
	slot0._stayUnitDic = {}
end

function slot0.setupMO(slot0)
	slot0._useHeight1 = slot0.mo:getInteractInfoMO().statusInfo.height == slot0.mo.height2

	slot0:_elevatorKeep()
end

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	if ExploreHeroCatchUnitFlow.instance:isInFlow() then
		ExploreController.instance:registerCallback(ExploreEvent.HeroCarryEnd, slot0._carryEnd, slot0)

		return
	end

	if slot0._stayUnitDic[slot3] == nil then
		slot0._useHeight1 = slot0.position.y == slot0.mo.height1

		slot0:_elevatorMoving()
	end

	slot0._stayUnitDic[slot3] = slot3.position.y - slot0.position.y

	slot3:clearTarget()
end

function slot0._carryEnd(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, slot0._carryEnd, slot0)
	slot0:onRoleEnter(nil, true, ExploreController.instance:getMap():getHero())
end

function slot0.onRoleLeave(slot0, slot1, slot2, slot3)
	slot0._stayUnitDic[slot3] = nil
end

function slot0.movingElevator(slot0, slot1, slot2)
	if slot0.position.y ~= slot1 then
		slot0.mo:updateNodeHeight(9999999)

		slot3 = slot1
		slot4 = slot0.position.y

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot4, slot3, slot2, slot0._setY, nil, slot0, nil, EaseType.Linear)
		slot0._tarY = slot3

		slot0:setStatusActive(true)
		TaskDispatcher.runDelay(slot0.setNodeHeightByTarY, slot0, slot2)
	end
end

function slot0._elevatorKeep(slot0)
	slot0:setStatusActive(false)
	slot0:setSpikeActive(slot0._useHeight1 == false)

	if string.nilorempty(slot0.mo.keepTime) == false then
		TaskDispatcher.runDelay(slot0._elevatorMoving, slot0, slot0.mo.keepTime)
	end
end

function slot0._elevatorMoving(slot0)
	slot0.mo:updateNodeHeight(9999999)

	if string.nilorempty(slot0.mo.intervalTime) == false then
		slot1 = slot0._useHeight1 and slot0.mo.height2 or slot0.mo.height1
		slot2 = slot0._useHeight1 and slot0.mo.height1 or slot0.mo.height2

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot1, slot0.mo.intervalTime, slot0._setY, nil, slot0, nil, EaseType.Linear)

		TaskDispatcher.runDelay(slot0._elevatorKeep, slot0, slot0.mo.intervalTime)
		slot0:setStatusActive(true)
	else
		slot0:_elevatorKeep()
	end
end

function slot0.setStatusActive(slot0, slot1)
	slot0.mo:getInteractInfoMO():setBitByIndex(ExploreEnum.InteractIndex.ActiveState, slot1 and 1 or 0)
end

function slot0.setNodeHeightByTarY(slot0)
	ZProj.TweenHelper.KillByObj(slot0.trans)
	slot0.mo:updateNodeHeight(slot0._tarY)
	slot0:_setY(slot0._tarY)
	slot0:setStatusActive(false)
end

function slot0.setSpikeActive(slot0, slot1)
	ZProj.TweenHelper.KillByObj(slot0.trans)

	slot0._useHeight1 = slot1
	slot2 = ExploreHelper.getKey(slot0.nodePos)
	slot3 = nil
	slot3 = (not slot1 or slot0.mo.height1) and slot0.mo.height2

	slot0.mo:updateNodeHeight(slot3)
	slot0:_setY(slot3)
end

function slot0._setY(slot0, slot1)
	slot0.position.y = slot1

	transformhelper.setPos(slot0.trans, slot0.position.x, slot0.position.y, slot0.position.z)
	slot0:_updateUnitRoleY()
end

function slot0._updateUnitRoleY(slot0)
	for slot4, slot5 in pairs(slot0._stayUnitDic) do
		slot4:updateSceneY(slot0.position.y + slot5)
	end
end

function slot0.onDestroy(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, slot0._carryEnd, slot0)
	ZProj.TweenHelper.KillByObj(slot0.trans)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	TaskDispatcher.cancelTask(slot0._elevatorMoving, slot0)
	TaskDispatcher.cancelTask(slot0._elevatorKeep, slot0)
	TaskDispatcher.cancelTask(slot0.setNodeHeightByTarY, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
