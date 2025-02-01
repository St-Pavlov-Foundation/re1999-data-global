module("modules.logic.room.utils.RoomDistributionHelper", package.seeall)

return {
	matchType = function (slot0, slot1, slot2)
		slot3 = RoomDistributionEnum.DistributionTypeValue[slot0]

		for slot7 = 1, 6 do
			slot8 = RoomRotateHelper.rotateDirection(slot7, slot2 or 0)
			slot9 = true

			for slot13 = 1, 6 do
				if slot1[RoomRotateHelper.rotateDirection(slot13, slot2)] ~= slot3[slot13] then
					slot9 = false

					break
				end
			end

			if slot9 then
				return true, slot8
			end

			slot1 = uv0._moveForward(slot1)
		end

		return false, 0
	end,
	_moveForward = function (slot0)
		for slot5 = 1, 6 do
		end

		return {
			[slot5] = slot0[RoomRotateHelper.rotateDirection(slot5, 1)]
		}
	end,
	getIndex = function (slot0, slot1)
		slot2 = 0

		for slot6 = 1, 6 do
			slot7 = RoomRotateHelper.rotateDirection(slot6, slot1)
			slot2 = slot7

			if not slot0[slot7] then
				break
			end
		end

		return slot2
	end
}
