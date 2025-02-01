module("modules.logic.room.entity.comp.RoomVehicleFollowPathData", package.seeall)

slot0 = class("RoomVehicleFollowPathData")

function slot0.ctor(slot0, slot1)
	slot0._pathPosList = {}
	slot0._pathDisList = {}
	slot0._pathPosDistance = 0
	slot0._maxDistance = 5
end

function slot0.setMaxDistance(slot0, slot1)
	slot0._maxDistance = slot1 or 3
end

function slot0.getMaxDistance(slot0)
	return slot0._maxDistance
end

function slot0.clear(slot0)
	if #slot0._pathPosList > 0 then
		slot0._pathPosList = {}
		slot0._pathDisList = {}
		slot0._pathPosDistance = 0
	end
end

function slot0.addPathPos(slot0, slot1)
	if #slot0._pathPosList > 0 then
		slot2 = Vector3.Distance(slot0._pathPosList[1], slot1)

		table.insert(slot0._pathDisList, 1, slot2)

		slot0._pathPosDistance = slot0._pathPosDistance + slot2
	end

	table.insert(slot0._pathPosList, 1, slot1)
	slot0:_checkPath()
end

function slot0.getPosByDistance(slot0, slot1)
	if slot0._pathPosDistance <= slot1 then
		return slot0:getLastPos()
	elseif slot1 <= 0 then
		return slot0:getFirstPos()
	end

	slot2 = 0 + slot1

	for slot6, slot7 in ipairs(slot0._pathDisList) do
		if slot7 == slot2 then
			return slot0._pathPosList[slot6 + 1]
		elseif slot2 < slot7 then
			return Vector3.Lerp(slot0._pathPosList[slot6], slot0._pathPosList[slot6 + 1], slot2 / slot7)
		end

		slot2 = slot2 - slot7
	end

	return slot0:getLastPos()
end

function slot0._checkPath(slot0)
	if slot0._pathPosDistance < slot0._maxDistance or #slot0._pathDisList < 2 then
		return
	end

	for slot4 = #slot0._pathDisList, 2, -1 do
		if slot0._maxDistance < slot0._pathPosDistance - slot0._pathDisList[#slot0._pathDisList] then
			slot0._pathPosDistance = slot0._pathPosDistance - slot5

			table.remove(slot0._pathDisList, #slot0._pathDisList)
			table.remove(slot0._pathPosList, #slot0._pathPosList)
		else
			break
		end
	end
end

function slot0.getPathDistance(slot0)
	return slot0._pathPosDistance
end

function slot0.getPosCount(slot0)
	return #slot0._pathPosList
end

function slot0.getFirstPos(slot0)
	return slot0._pathPosList[1]
end

function slot0.getLastPos(slot0)
	return slot0._pathPosList[#slot0._pathPosList]
end

return slot0
