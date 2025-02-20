module("modules.logic.chessgame.config.ChessGameConfig", package.seeall)

slot0 = class("ChessGameConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._mapCos = {}
	slot0._interactList = {}
end

function slot0.reqConfigNames(slot0)
end

function slot0.getMapCo(slot0, slot1)
	if not slot0._mapCos[slot1] then
		slot2 = {
			[slot7] = {}
		}
		slot7 = tostring(slot1)

		for slot7 = 1, #addGlobalModule("modules.configs.chessgame.lua_chessgame_group_" .. tostring(slot1), "lua_chessgame_group_" .. slot7) do
			slot2[slot7].path = slot3[slot7][1]
			slot2[slot7].interacts = {}

			for slot11, slot12 in ipairs(slot3[slot7][2]) do
				slot2[slot7].interacts[slot11] = {}

				for slot16, slot17 in pairs(ChessGameInteractField) do
					slot2[slot7].interacts[slot11][slot16] = slot12[slot17]
				end

				slot2[slot7].interacts[slot11].offset = {
					x = slot12[8][1],
					y = slot12[8][2],
					z = slot12[8][3]
				}
				slot2[slot7].interacts[slot11].effects = {}

				for slot16, slot17 in ipairs(slot12[15]) do
					slot2[slot7].interacts[slot11].effects[slot16] = {
						type = slot17[1],
						param = slot17[2]
					}
				end

				slot0._interactList[slot1] = slot0._interactList[slot1] or {}
				slot0._interactList[slot1][slot12[1]] = slot2[slot7].interacts[slot11]
			end

			slot2[slot7].nodes = {}

			for slot11, slot12 in ipairs(slot3[slot7][3]) do
				slot2[slot7].nodes[slot11] = {
					x = slot12[1],
					y = slot12[2]
				}
			end
		end

		slot0._mapCos[slot1] = slot2
	end

	return slot0._mapCos[slot1]
end

function slot0.getInteractCoById(slot0, slot1, slot2)
	return slot0._interactList[slot1][slot2]
end

function slot0.setCurrentMapGroupId(slot0, slot1)
	slot0._currentMapGroupId = slot1
end

function slot0.getCurrentMapGroupId(slot0)
	return slot0._currentMapGroupId
end

function slot0.getCurrentMapCo(slot0, slot1)
	if not slot0._currentMapGroupId then
		return
	end

	if not slot0._mapCos[slot0._currentMapGroupId] then
		return
	end

	if not slot1 then
		return slot2[1]
	else
		return slot2[slot1]
	end
end

function slot0.getCurrentMapCoList(slot0)
	return slot0._mapCos[slot0._currentMapGroupId]
end

slot0.instance = slot0.New()

return slot0
