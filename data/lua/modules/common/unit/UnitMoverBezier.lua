module("modules.common.unit.UnitMoverBezier", package.seeall)

slot0 = class("UnitMoverBezier", LuaCompBase)

function slot0.ctor(slot0)
	slot0._timeScale = 1
	slot0._currTime = 0
	slot0._duration = 0
	slot0._wayPointBegin = nil
	slot0._wayPointEnd = nil
	slot0._wayPointValue = nil
	slot0._animationCurve = nil
	slot0._getTimeFunction = nil
	slot0._getTimeObject = nil

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.setBezierParam(slot0, slot1)
	if not string.nilorempty(slot1) and FightStrUtil.instance:getSplitToNumberCache(slot1, "#") and #slot2 >= 2 then
		slot0._bezierX = tonumber(slot2[1]) or 0.5
		slot0._bezierY = tonumber(slot2[2]) or 0
	end
end

function slot0.setEaseType(slot0, slot1)
	slot0._easeType = slot1 or EaseType.Linear
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

	slot0:updatePrePos()
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
	return slot0._posX, slot0._posY + (slot0._yOffset or 0), slot0._posZ
end

function slot0.getPrePos(slot0)
	return slot0.prePosX, slot0.prePosY, slot0.prePosZ
end

function slot0.updatePrePos(slot0)
	slot0.prePosX = slot0._posX
	slot0.prePosY = slot0._posY
	slot0.prePosZ = slot0._posZ
end

function slot0.onUpdate(slot0)
	if not slot0._wayPointBegin then
		return
	end

	slot0:updatePrePos()

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
		if slot0._bezierX and slot0._bezierY then
			slot2 = LuaTween.tween(slot0._currTime / slot0._duration, 0, 1, 1, slot0._easeType)
			slot0._posX = (1 - slot2) * (1 - slot2) * slot0._wayPointBegin.x + 2 * slot2 * (1 - slot2) * (slot0._bezierX * slot0._wayPointEnd.x + (1 - slot0._bezierX) * slot0._wayPointBegin.x) + slot2 * slot2 * slot0._wayPointEnd.x
			slot0._posY = (1 - slot2) * (1 - slot2) * slot0._wayPointBegin.y + 2 * slot2 * (1 - slot2) * slot0._bezierY + slot2 * slot2 * slot0._wayPointEnd.y
			slot0._posZ = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.z, slot0._wayPointValue.z, slot0._duration, slot0._easeType)
		else
			slot0._posX = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.x, slot0._wayPointValue.x, slot0._duration, slot0._easeType)
			slot0._posY = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.y, slot0._wayPointValue.y, slot0._duration, slot0._easeType)
			slot0._posZ = LuaTween.tween(slot0._currTime, slot0._wayPointBegin.z, slot0._wayPointValue.z, slot0._duration, slot0._easeType)
		end

		slot0:dispatchEvent(UnitMoveEvent.PosChanged, slot0)
	end
end

function slot0.onDestroy(slot0)
	slot0._animationCurve = nil
end

return slot0
