module("modules.logic.room.utils.RoomWaveHelper", package.seeall)

return {
	getWaveList = function (slot0, slot1)
		slot2 = 0
		slot3 = true

		for slot7, slot8 in ipairs(slot0) do
			if not slot8 then
				slot3 = false
				slot2 = slot7

				break
			end
		end

		if slot3 then
			return {
				RoomScenePreloader.ResEffectWaveList[6]
			}, {
				0
			}, {
				RoomScenePreloader.ResEffectWaveList[6]
			}
		end

		slot4 = {}
		slot5 = {}
		slot6 = {}
		slot9 = slot2

		for slot13 = slot2, slot2 + 5 do
			slot8 = false or slot1[slot14]

			if slot0[(slot13 - 1) % 6 + 1] then
				slot7 = 0 + 1
			end

			if (not slot15 or slot13 == slot2 + 5) and slot7 > 0 then
				if slot8 then
					table.insert(slot4, RoomScenePreloader.ResEffectWaveWithRiverList[slot7])
					table.insert(slot6, RoomScenePreloader.ResEffectWaveWithRiverList[slot7])
				else
					table.insert(slot4, RoomScenePreloader.ResEffectWaveList[slot7])
					table.insert(slot6, RoomScenePreloader.ResEffectWaveList[slot7])
				end

				table.insert(slot5, slot9)
			end

			if not slot15 then
				slot9 = slot14 % 6 + 1
				slot7 = 0
				slot8 = false
			end
		end

		return slot4, slot5, slot4
	end
}
