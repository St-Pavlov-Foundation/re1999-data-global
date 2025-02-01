module("modules.common.unit.UnitMoverMmo", package.seeall)

slot0 = class("UnitMoverMmo", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._speed = 0
	slot0._speedX = 0
	slot0._speedY = 0
	slot0._speedZ = 0
	slot0._posX = 0
	slot0._posY = 0
	slot0._posZ = 0
	slot0._wpPool = LuaObjPool.New(100, function ()
		return {}
	end, function (slot0)
	end, function (slot0)
	end)
	slot0._wayPoints = {}
	slot0._curWayPoint = nil
	slot0._accerationTime = 0
	slot0._startMoveTime = 0

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.simpleMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0:setSpeed(math.sqrt((slot1 - slot4)^2 + (slot2 - slot5)^2 + (slot3 - slot6)^2) > 0 and slot8 / slot7 or 100000000)
	slot0:setPosDirectly(slot1, slot2, slot3)
	slot0:addWayPoint(slot4, slot5, slot6)
end

function slot0.setPosDirectly(slot0, slot1, slot2, slot3)
	slot0:clearWayPoints()

	slot0._posX = slot1
	slot0._posY = slot2
	slot0._posZ = slot3

	slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
end

function slot0.getCurWayPoint(slot0)
	return slot0._curWayPoint
end

function slot0.getPos(slot0)
	return slot0._posX, slot0._posY, slot0._posZ
end

function slot0.setSpeed(slot0, slot1)
	slot0._speed = slot1

	if not slot0._curWayPoint then
		slot0._speedX = 0
		slot0._speedY = 0
		slot0._speedZ = 0
	else
		slot2 = slot0._curWayPoint.x - slot0._posX
		slot3 = slot0._curWayPoint.y - slot0._posY
		slot4 = slot0._curWayPoint.z - slot0._posZ
		slot5 = math.sqrt(slot2 * slot2 + slot3 * slot3 + slot4 * slot4)
		slot0._speedX = slot2 / slot5 * slot0._speed
		slot0._speedY = slot3 / slot5 * slot0._speed
		slot0._speedZ = slot4 / slot5 * slot0._speed
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot1 > 0 then
		slot0:setSpeed(slot0._speed * slot1)
	else
		logError("argument illegal, timeScale = " .. slot1)
	end
end

function slot0.setAccelerationTime(slot0, slot1)
	slot0._accerationTime = slot1
end

function slot0.getAccelerationTime(slot0)
	return slot0._accerationTime
end

function slot0.setWayPoint(slot0, slot1, slot2, slot3)
	if not slot0._wayPoints then
		return
	end

	for slot8 = 1, #slot0._wayPoints do
		slot0._wpPool:putObject(slot0._wayPoints[slot8])

		slot0._wayPoints[slot8] = nil
	end

	slot5 = slot0._wpPool:getObject()
	slot5.x = slot1
	slot5.y = slot2
	slot5.z = slot3

	slot0:_setNewWayPoint(slot5)
end

function slot0.addWayPoint(slot0, slot1, slot2, slot3, slot4)
	if slot0._posX == slot1 and slot0._posY == slot2 and slot0._posZ == slot3 then
		if not slot0._curWayPoint then
			return
		elseif slot0._curWayPoint.x == slot1 and slot0._curWayPoint.y == slot2 and slot0._curWayPoint.z == slot3 then
			return
		end
	end

	slot5 = slot0._wpPool:getObject()
	slot5.x = slot1
	slot5.y = slot2
	slot5.z = slot3

	if slot4 then
		slot6 = 0

		if slot0._curWayPoint and slot0._curWayPoint[1] then
			slot7 = slot0._curWayPoint[#slot0._curWayPoint]
			slot6 = math.sqrt((slot7.x - slot1)^2 + (slot7.y - slot2)^2 + (slot7.z - slot3)^2)
		else
			slot6 = math.sqrt((slot0._posX - slot1)^2 + (slot0._posY - slot2)^2 + (slot0._posZ - slot3)^2)
		end

		slot5.speed = slot6 > 0 and slot6 / slot4 or 100000000
	end

	if not slot0._curWayPoint then
		slot0:_setNewWayPoint(slot5)
	else
		table.insert(slot0._wayPoints, slot5)
	end
end

function slot0.clearWayPoints(slot0)
	for slot5 = 1, #slot0._wayPoints do
		slot0._wpPool:putObject(slot0._wayPoints[slot5])

		slot0._wayPoints[slot5] = nil
	end

	if slot0._curWayPoint then
		slot0:_setNewWayPoint(nil)
		slot0:dispatchEvent(UnitMoveEvent.Interrupt, slot0)
	end
end

function slot0._setNewWayPoint(slot0, slot1)
	slot2 = false

	if slot0._curWayPoint then
		slot0._wpPool:putObject(slot0._curWayPoint)
	elseif slot1 then
		slot2 = true
	end

	slot0._curWayPoint = slot1

	if not slot0._curWayPoint then
		slot0._speedX = 0
		slot0._speedY = 0
		slot0._speedZ = 0
	else
		if slot1.speed then
			slot0._speed = slot1.speed
		end

		slot3 = slot0._curWayPoint.x - slot0._posX
		slot4 = slot0._curWayPoint.y - slot0._posY
		slot5 = slot0._curWayPoint.z - slot0._posZ
		slot6 = math.sqrt(slot3 * slot3 + slot4 * slot4 + slot5 * slot5)
		slot0._speedX = slot3 / slot6 * slot0._speed
		slot0._speedY = slot4 / slot6 * slot0._speed
		slot0._speedZ = slot5 / slot6 * slot0._speed
	end

	if slot2 then
		slot0._startMoveTime = Time.time

		slot0:dispatchEvent(UnitMoveEvent.StartMove, slot0)
	end
end

function slot0.onUpdate(slot0)
	if slot0._curWayPoint then
		if slot0._accerationTime > 0 and Time.time - slot0._startMoveTime < slot0._accerationTime then
			slot1 = Time.deltaTime * slot2 / slot0._accerationTime
		end

		slot5 = slot0._posX + slot0._speedX * slot1 - slot0._posX
		slot6 = slot0._posY + slot0._speedY * slot1 - slot0._posY
		slot7 = slot0._posZ + slot0._speedZ * slot1 - slot0._posZ
		slot8 = slot0._curWayPoint.x - slot0._posX
		slot9 = slot0._curWayPoint.y - slot0._posY
		slot10 = slot0._curWayPoint.z - slot0._posZ

		if slot5 * slot5 + slot6 * slot6 + slot7 * slot7 >= slot8 * slot8 + slot9 * slot9 + slot10 * slot10 then
			slot0._posX = slot0._curWayPoint.x
			slot0._posY = slot0._curWayPoint.y
			slot0._posZ = slot0._curWayPoint.z

			slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
			slot0:dispatchEvent(UnitMoveEvent.PassWayPoint, slot0._posX, slot0._posY, slot0._posZ)

			if #slot0._wayPoints > 0 then
				table.remove(slot0._wayPoints, 1)
				slot0:_setNewWayPoint(slot0._wayPoints[1])
			else
				slot0:_setNewWayPoint(nil)
				slot0:dispatchEvent(UnitMoveEvent.Arrive, slot0)
			end
		else
			slot0._posX = slot2
			slot0._posY = slot3
			slot0._posZ = slot4

			slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:clearWayPoints()
	slot0._wpPool:dispose()

	slot0._wpPool = nil
	slot0._wayPoints = nil
	slot0._curWayPoint = nil
end

return slot0
