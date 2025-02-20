module("modules.logic.room.model.interact.RoomInteractBuildingModel", package.seeall)

slot0 = class("RoomInteractBuildingModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	RoomMapBuildingAreaModel.super.clear(slot0)

	slot0._heroId2BuildingUidDict = {}
end

function slot0.init(slot0)
	slot0._heroId2BuildingUidDict = {}
	slot2 = RoomCharacterModel.instance

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot7:getInteractMO() then
			slot9 = slot8.id

			for slot14 = #slot8:getHeroIdList(), 1, -1 do
				if slot2:getCharacterMOById(slot10[slot14]) == nil then
					slot8:removeHeroId(slot15)
				elseif slot0._heroId2BuildingUidDict[slot15] == nil then
					slot0._heroId2BuildingUidDict[slot15] = slot9
				elseif slot0._heroId2BuildingUidDict[slot15] ~= slot9 then
					slot8:removeHeroId(slot15)
				end
			end
		end
	end
end

function slot0.checkAllHero(slot0)
	for slot5, slot6 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot6:getInteractMO() then
			slot7:checkHeroIdList()
		end
	end
end

function slot0.setSelectBuildingMO(slot0, slot1)
	slot0._selectBuildingMO = slot1
	slot0._selectInteractMO = nil

	if slot1 then
		slot0._selectInteractMO = slot1:getInteractMO()
	end
end

function slot0.isSelectHeroId(slot0, slot1)
	if slot0._selectInteractMO and slot0._selectInteractMO:isHasHeroId(slot1) then
		return true
	end

	return false
end

function slot0.addInteractHeroId(slot0, slot1, slot2)
	if slot0:_getInteractMOByUid(slot1) and not slot3:isHeroMax() then
		slot0._heroId2BuildingUidDict[slot2] = slot1

		slot3:addHeroId(slot2)

		if slot0._heroId2BuildingUidDict[slot2] then
			slot0:removeInteractHeroId(slot4, slot2)
		end
	end
end

function slot0.removeInteractHeroId(slot0, slot1, slot2)
	if slot0:_getInteractMOByUid(slot1) and slot3:isHasHeroId(slot2) then
		slot3:removeHeroId(slot2)

		if slot0._heroId2BuildingUidDict[slot2] == slot1 then
			slot0._heroId2BuildingUidDict[slot2] = nil
		end
	end
end

function slot0._getInteractMOByUid(slot0, slot1)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return slot2:getInteractMO()
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
