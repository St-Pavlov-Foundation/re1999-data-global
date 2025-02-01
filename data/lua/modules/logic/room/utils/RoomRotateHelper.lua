module("modules.logic.room.utils.RoomRotateHelper", package.seeall)

return {
	getMod = function (slot0, slot1)
		return slot0 > 0 and slot0 % slot1 or slot0 + math.ceil(math.abs(slot0 / slot1)) * slot1
	end,
	rotateRotate = function (slot0, slot1)
		return uv0.getMod(slot0 + slot1, 6)
	end,
	rotateDirection = function (slot0, slot1)
		if slot0 == 0 then
			return slot0
		end

		return uv0.rotateRotate(slot0 - 1, slot1) + 1
	end,
	rotateDirectionWithCenter = function (slot0, slot1)
		return uv0.getMod(slot0 + slot1, 7)
	end,
	oppositeDirection = function (slot0)
		if slot0 == 0 then
			return slot0
		end

		return uv0.rotateDirection(slot0, 3)
	end,
	simpleRotate = function (slot0, slot1, slot2)
		slot3 = 0

		if Mathf.PI < Mathf.Abs(uv0.getMod(slot1, Mathf.PI * 2) - uv0.getMod(slot2, Mathf.PI * 2)) then
			if Mathf.PI < slot1 then
				slot1 = slot1 - Mathf.PI * 2
			elseif Mathf.PI < slot2 then
				slot2 = slot2 - Mathf.PI * 2
			end
		end

		return uv0.getMod((1 - slot0) * slot1 + slot0 * slot2, Mathf.PI * 2)
	end,
	getCameraNearRotate = function (slot0)
		return uv0.getMod(Mathf.Round((slot0 - 30) / 60), 6)
	end
}
