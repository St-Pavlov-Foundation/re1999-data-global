module("modules.logic.room.model.interact.RoomInteractBuildingMO", package.seeall)

slot0 = pureTable("RoomInteractBuildingMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.buildingUId
	slot0.buildingMO = slot1
	slot0._interactHeroIdList = {}
	slot0._interactHeroIdMap = {}
	slot0.config = RoomConfig.instance:getInteractBuildingConfig(slot1.buildingId)
end

function slot0.clear(slot0)
	if #slot0._interactHeroIdList > 0 then
		for slot4 = #slot0._interactHeroIdList, 1, -1 do
			slot0._interactHeroIdMap[slot0._interactHeroIdList[slot4]] = false

			table.remove(slot0._interactHeroIdList, slot4)
		end
	end
end

function slot0.addHeroId(slot0, slot1)
	if not slot0._interactHeroIdMap[slot1] then
		slot0._interactHeroIdMap[slot1] = true

		table.insert(slot0._interactHeroIdList, slot1)
	end
end

function slot0.removeHeroId(slot0, slot1)
	if slot0._interactHeroIdMap[slot1] then
		slot0._interactHeroIdMap[slot1] = false

		tabletool.removeValue(slot0._interactHeroIdList, slot1)
	end
end

function slot0.getHeroIdList(slot0)
	return slot0._interactHeroIdList
end

function slot0.getHeroCount(slot0)
	return #slot0._interactHeroIdList
end

function slot0.isHeroMax(slot0)
	if slot0:getHeroMax() <= slot0:getHeroCount() then
		return true
	end

	return false
end

function slot0.getHeroMax(slot0)
	if slot0.config then
		return slot0.config.heroCount
	end

	return 1
end

function slot0.isFindPath(slot0)
	if slot0.config and slot0.config.interactType == 1 then
		return true
	end

	return false
end

function slot0.isHasHeroId(slot0, slot1)
	if slot0._interactHeroIdMap[slot1] then
		return true
	end

	return false
end

function slot0.checkHeroIdList(slot0)
	if not slot0._interactHeroIdList then
		return
	end

	for slot5 = #slot0._interactHeroIdList, 1, -1 do
		if RoomCharacterModel.instance:getCharacterMOById(slot0._interactHeroIdList[slot5]) == nil then
			table.remove(slot0._interactHeroIdList, slot5)

			slot0._interactHeroIdMap[slot6] = false
		end
	end
end

return slot0
