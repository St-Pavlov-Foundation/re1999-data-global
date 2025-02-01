module("modules.logic.dungeon.model.DungeonAssistModel", package.seeall)

slot0 = class("DungeonAssistModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
end

function slot0.getAssistList(slot0, slot1, slot2)
	if not slot1 or not slot0._assistTypeDict then
		return {}
	end

	if slot2 then
		slot3 = (slot0._assistTypeDict[slot1] or {})[slot2] or {}
	else
		for slot8, slot9 in pairs(slot4) do
			tabletool.addValues(slot3, slot9)
		end
	end

	return slot3
end

function slot0.setAssistHeroCareersByServerData(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not slot0._assistTypeDict then
		slot0._assistTypeDict = {}
	end

	slot0._assistTypeDict[slot1] = {}

	for slot7, slot8 in ipairs(slot2) do
		slot3[slot8.career] = {}
		slot11 = {}

		for slot15, slot16 in ipairs(slot8.assistHeroInfos) do
			if not slot11[slot16.heroUid] then
				if DungeonAssistHeroMO.New():init(slot1, slot16) then
					slot10[#slot10 + 1] = slot18
				end

				slot11[slot17] = true
			end
		end
	end
end

function slot0.clear(slot0)
	slot0._assistTypeDict = {}

	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
