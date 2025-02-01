module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotRoomConfig", package.seeall)

slot0 = class("V1a6_CachotRoomConfig")

function slot0.init(slot0, slot1)
	slot0._roomConfigTable = slot1
	slot0._roomConfigDict = slot1.configDict
	slot0._roomConfigList = slot1.configList
end

function slot0.getRoomConfigList(slot0)
	return slot0._roomConfigList
end

function slot0.getRoomConfigDict(slot0)
	return slot0._roomConfigDict
end

function slot0.getCoByRoomId(slot0, slot1)
	return slot0:getRoomConfigDict()[slot1]
end

function slot0._initRoomInfo(slot0)
	if not slot0._layerRoomCount then
		slot0._layerRoomCount = {}

		for slot4, slot5 in pairs(lua_rogue_difficulty.configDict) do
			slot6 = slot5.initRoom

			if not slot0._layerRoomCount[slot4] then
				slot0._layerRoomCount[slot4] = {}
			end

			slot7 = nil

			if lua_rogue_room.configDict[slot6] then
				slot7 = slot9.layer
				slot0._layerRoomCount[slot4][slot7] = {
					count = 1,
					[slot6] = 1
				}
				slot10 = lua_rogue_room.configDict[slot9.nextRoom]
				slot11 = nil

				if isDebugBuild then
					slot11 = {}
				end

				while slot10 do
					if slot10.layer == slot7 then
						slot0._layerRoomCount[slot4][slot7][slot10.id] = slot8 + 1
						slot0._layerRoomCount[slot4][slot7].count = slot0._layerRoomCount[slot4][slot7].count + 1
					else
						slot7 = slot10.layer
						slot0._layerRoomCount[slot4][slot7] = {
							count = 1,
							[slot10.id] = 1
						}
					end

					if slot11 then
						if slot11[slot10.nextRoom] then
							logError("房间配置死循环了！！！！！！请检查配置")

							return
						else
							slot11[slot10.nextRoom] = true
						end
					end

					slot10 = lua_rogue_room.configDict[slot10.nextRoom]
				end
			end
		end
	end
end

function slot0.getRoomIndexAndTotal(slot0, slot1)
	slot0:_initRoomInfo()

	if not lua_rogue_room.configDict[slot1] then
		return 0, 0
	end

	if slot2.type == 0 then
		return slot0:getRoomIndexAndTotal(lua_rogue_difficulty.configDict[slot2.difficulty].initRoom)
	end

	if not slot0._layerRoomCount[slot2.difficulty][slot2.layer] then
		return 0, 0
	end

	return slot3[slot2.id], slot3.count
end

function slot0.getLayerIndexAndTotal(slot0, slot1)
	slot0:_initRoomInfo()

	if not lua_rogue_room.configDict[slot1] then
		return 0, 0
	end

	if slot2.type == 0 then
		return slot0:getLayerIndexAndTotal(lua_rogue_difficulty.configDict[slot2.difficulty].initRoom)
	end

	if not slot0._layerRoomCount[slot2.difficulty] then
		return 0, 0
	end

	return slot2.layer, #slot3
end

function slot0.getLayerName(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._roomConfigDict) do
		if slot7.layer == slot1 and slot7.difficulty == slot2 then
			return slot7.name
		end
	end
end

function slot0.checkNextRoomIsLastRoom(slot0, slot1)
	if slot0._roomConfigDict[slot1] then
		if not slot2.nextRoom then
			return true
		elseif slot0._roomConfigDict[slot3] and slot4.layer ~= slot2.layer then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
