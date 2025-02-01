module("modules.common.unit.UnitMoverEase", package.seeall)

slot0 = class("UnitMoverEase", LuaCompBase)

function slot0.ctor(slot0)
	slot0._timeScale = 1
	slot0._currTime = 0
	slot0._duration = 0
	slot0._wayPointBegin = nil
	slot0._wayPointEnd = nil
	slot0._wayPointValue = nil
	slot0._easeType = EaseType.Linear
	slot0._getTimeFunction = nil
	slot0._getTimeObject = nil

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.setEaseType(slot0, slot1)
	slot0._easeType = slot1
end

function slot0.setTimeScale(slot0, slot1)
	slot0._timeScale = slot1
end

function slot0.simpleMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0:setPosDirectly(slot1, slot2, slot3)

	slot0._currTime = 0
	slot0._duration = slot7
	slot0._wayPointBegin = {
		x = slot1,
		y = slot2,
		z = slot3
	}
	slot0._wayPointEnd = {
		x = slot4,
		y = slot5,
		z = slot6
	}
	slot0._wayPointValue = {
		x = slot4 - slot1,
		y = slot5 - slot2,
		z = slot6 - slot3
	}
end

function slot0.setPosDirectly(slot0, slot1, slot2, slot3)
	slot0._wayPointBegin = nil
	slot0._wayPointValue = nil
	slot0._posX = slot1
	slot0._posY = slot2
	slot0._posZ = slot3

	slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
end

function slot0.setGetTimeFunction(slot0, slot1, slot2)
	slot0._getTimeFunction = slot1
	slot0._getTimeObject = slot2
end

function slot0.getCurWayPoint(slot0)
	return slot0._curWayPoint
end

function slot0.getPos(slot0)
	return slot0._posX, slot0._posY, slot0._posZ
end

function slot0.onUpdate(slot0)
	if not slot0._wayPointBegin then
		return
	end

	if slot0._getTimeFunction then
		slot0._currTime = slot0._getTimeFunction(slot0._getTimeObject)
	else
		slot0._currTime = slot0._currTime + Time.deltaTime * slot0._timeScale
	end

	if slot0._duration <= slot0._currTime then
		slot0._posX = slot0._wayPointEnd.x
		slot0._posY = slot0._wayPointEnd.y
		slot0._posZ = slot0._wayPointEnd.z
		slot0._wayPointBegin = nil
		slot0._wayPointEnd = nil
		slot0._wayPointValue = nil

		slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
		slot0:dispatchEvent(UnitMoveEvent.Arrive, slot0)
	else
		slot0._posX = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.x, slot0._wayPointValue.x, slot0._duration, slot0._easeType)
		slot0._posY = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.y, slot0._wayPointValue.y, slot0._duration, slot0._easeType)
		slot0._posZ = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.z, slot0._wayPointValue.z, slot0._duration, slot0._easeType)

		slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
	end
end

return slot0
