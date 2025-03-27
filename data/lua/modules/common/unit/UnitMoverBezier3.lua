module("modules.common.unit.UnitMoverBezier3", package.seeall)

slot0 = class("UnitMoverBezier3", LuaCompBase)

function slot0.ctor(slot0)
	slot0._timeScale = 1
	slot0._currTime = 0
	slot0._duration = 0
	slot0._getTimeFunction = nil
	slot0._getTimeObject = nil
	slot0._start = nil

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.setEaseType(slot0, slot1)
	slot0._easeType = slot1 or EaseType.Linear
end

function slot0.setTimeScale(slot0, slot1)
	slot0._timeScale = slot1
end

function slot0.simpleMove(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:setPosDirectly(slot1.x, slot1.y, slot1.z)

	slot0.p1 = slot1
	slot0.p2 = slot2
	slot0.p3 = slot3
	slot0.p4 = slot4
	slot0.startPos = slot1
	slot0.endPos = slot4
	slot0._duration = slot5
	slot0._currTime = 0
	slot0._start = true
end

function slot0.setPosDirectly(slot0, slot1, slot2, slot3)
	slot0._posX = slot1
	slot0._posY = slot2
	slot0._posZ = slot3

	slot0:updatePrePos()
	slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
end

function slot0.updatePrePos(slot0)
	slot0.prePosX = slot0._posX
	slot0.prePosY = slot0._posY
	slot0.prePosZ = slot0._posZ
end

function slot0.setGetTimeFunction(slot0, slot1, slot2)
	slot0._getTimeFunction = slot1
	slot0._getTimeObject = slot2
end

function slot0.getPos(slot0)
	return slot0._posX, slot0._posY, slot0._posZ
end

function slot0.getPrePos(slot0)
	return slot0.prePosX, slot0.prePosY, slot0.prePosZ
end

function slot0.onUpdate(slot0)
	if not slot0._start then
		return
	end

	slot0:updatePrePos()

	if slot0._getTimeFunction then
		slot0._currTime = slot0._getTimeFunction(slot0._getTimeObject)
	else
		slot0._currTime = slot0._currTime + Time.deltaTime * slot0._timeScale
	end

	if slot0._duration <= slot0._currTime then
		slot0._posX = slot0.endPos.x
		slot0._posY = slot0.endPos.y
		slot0._posZ = slot0.endPos.z

		slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
		slot0:dispatchEvent(UnitMoveEvent.Arrive, slot0)

		slot0._start = nil
	else
		slot2 = LuaTween.tween(slot0._currTime / slot0._duration, 0, 1, 1, slot0._easeType)
		slot0._posX = slot0:calculateValue(slot2, slot0.p1.x, slot0.p2.x, slot0.p3.x, slot0.p4.x)
		slot0._posY = slot0:calculateValue(slot2, slot0.p1.y, slot0.p2.y, slot0.p3.y, slot0.p4.y)
		slot0._posZ = slot0:calculateValue(slot2, slot0.p1.z, slot0.p2.z, slot0.p3.z, slot0.p4.z)

		slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
	end
end

function slot0.calculateValue(slot0, slot1, slot2, slot3, slot4, slot5)
	return (1 - slot1) * (1 - slot1) * (1 - slot1) * slot2 + 3 * slot1 * (1 - slot1) * (1 - slot1) * slot3 + 3 * slot1 * slot1 * (1 - slot1) * slot4 + slot1 * slot1 * slot1 * slot5
end

function slot0.onDestroy(slot0)
	slot0._start = nil
	slot0._animationCurve = nil
end

return slot0
