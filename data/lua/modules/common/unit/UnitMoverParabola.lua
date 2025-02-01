module("modules.common.unit.UnitMoverParabola", package.seeall)

slot0 = class("UnitMoverParabola", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._speed = 0
	slot0._speedX = 0
	slot0._speedY = 0
	slot0._speedZ = 0
	slot0._gravity = 0
	slot0._posX = 0
	slot0._posY = 0
	slot0._posZ = 0
	slot0._wayPoint = nil
	slot0._getFrameFunction = nil
	slot0._getFrameObject = nil
	slot0._timeScale = 1

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.setPosDirectly(slot0, slot1, slot2, slot3)
	slot0:clearWayPoints()

	slot0._posX = slot1
	slot0._posY = slot2
	slot0._posZ = slot3

	slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
end

function slot0.setGetFrameFunction(slot0, slot1, slot2)
	slot0._getFrameFunction = slot1
	slot0._getFrameObject = slot2
	slot0._frame = 0
end

function slot0.getCurWayPoint(slot0)
	return slot0._wayPoint
end

function slot0.getPos(slot0)
	return slot0._posX, slot0._posY, slot0._posZ
end

function slot0.setWayPoint(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._wayPoint = {
		x = slot1,
		y = slot2,
		z = slot3
	}

	slot0:_setHoriSpeed(slot4)
	slot0:_calcSpeedYAndGravity(slot5)

	slot0._startMoveTime = Time.time

	slot0:dispatchEvent(UnitMoveEvent.StartMove, slot0)
end

function slot0.simpleMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0._duration = slot7

	slot0:setPosDirectly(slot1, slot2, slot3)
	slot0:setWayPoint(slot4, slot5, slot6, math.sqrt((slot1 - slot4)^2 + (slot2 - slot5)^2 + (slot3 - slot6)^2) > 0 and slot9 / slot7 or 100000000, slot8)
end

function slot0.clearWayPoints(slot0)
	if slot0._wayPoint then
		slot0._wayPoint = nil

		slot0:dispatchEvent(UnitMoveEvent.Interrupt, slot0)
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot1 > 0 then
		slot0._timeScale = slot1
	else
		logError("argument illegal, timeScale = " .. slot1)
	end
end

function slot0._setHoriSpeed(slot0, slot1)
	slot0._speed = slot1

	if not slot0._wayPoint then
		slot0._speedX = 0
		slot0._speedZ = 0
	else
		slot2 = slot0._wayPoint.x - slot0._posX
		slot3 = slot0._wayPoint.z - slot0._posZ
		slot4 = math.sqrt(slot2 * slot2 + slot3 * slot3)
		slot0._speedX = slot2 / slot4 * slot0._speed
		slot0._speedZ = slot3 / slot4 * slot0._speed
	end
end

function slot0._calcSpeedYAndGravity(slot0, slot1)
	slot1 = (slot0._wayPoint.y <= slot0._posY and slot0._posY or slot0._wayPoint.y) + slot1
	slot4 = slot1 - slot0._posY
	slot6 = math.sqrt((slot0._posX - slot0._wayPoint.x)^2 + (slot0._posZ - slot0._wayPoint.z)^2) / slot0._speed / (1 + math.sqrt((slot1 - slot0._wayPoint.y) / slot4))
	slot0._gravity = 2 * slot4 / slot6^2
	slot0._speedY = slot0._gravity * slot6
end

function slot0.getDeltaTime(slot0)
	slot1, slot2, slot3 = slot0._getFrameFunction(slot0._getFrameObject)

	if slot1 <= slot2 then
		return 0
	end

	if slot3 <= 0 then
		return slot0._duration
	end

	slot0._frame = slot1

	return (slot1 - math.max(slot2, slot0._frame)) / slot3 * (slot0._duration or 0)
end

function slot0.onUpdate(slot0)
	if slot0._wayPoint then
		slot1 = 0

		if ((not slot0._getFrameFunction or slot0:getDeltaTime()) and Time.deltaTime * slot0._timeScale) <= 0 then
			return
		end

		slot0._posY = slot0._posY + (slot0._speedY - slot0._gravity * slot1 + slot0._speedY) / 2 * slot1
		slot0._posY = slot0._posY < slot0._wayPoint.y and slot0._wayPoint.y or slot0._posY
		slot0._speedY = slot2
		slot5 = slot0._posX + slot0._speedX * slot1 - slot0._posX
		slot6 = slot0._posZ + slot0._speedZ * slot1 - slot0._posZ
		slot7 = slot0._wayPoint.x - slot0._posX
		slot8 = slot0._wayPoint.z - slot0._posZ

		if slot5 * slot5 + slot6 * slot6 >= slot7 * slot7 + slot8 * slot8 then
			slot0._posX = slot0._wayPoint.x
			slot0._posZ = slot0._wayPoint.z
			slot0._wayPoint = nil

			slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
			slot0:dispatchEvent(UnitMoveEvent.Arrive, slot0)
		else
			slot0._posX = slot3
			slot0._posZ = slot4

			slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
		end
	end
end

function slot0.onDestroy(slot0)
	slot0._wayPoint = nil
end

return slot0
