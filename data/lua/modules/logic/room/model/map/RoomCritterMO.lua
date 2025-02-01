module("modules.logic.room.model.map.RoomCritterMO", package.seeall)

slot0 = pureTable("RoomCritterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.uid
	slot0.uid = slot1.uid
	slot0.critterId = slot1.critterId or slot1.defineId
	slot0.skinId = slot1.skinId
	slot0.currentPosition = slot1.currentPosition
	slot0.heroId = slot1.heroId or nil
	slot0.characterId = slot1.characterId or nil
end

function slot0.initWithBuildingValue(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.uid = slot1
	slot0.critterId = CritterModel.instance:getCritterMOByUid(slot0.id) and slot4.defineId
	slot0.skinId = slot4 and slot4:getSkinId()
	slot0.stayBuildingUid = slot2
	slot0.stayBuildingSlotId = slot3
end

function slot0.setIsRestCritter(slot0, slot1)
	slot0._isRestCritter = slot1
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.getSkinId(slot0)
	return slot0.skinId or CritterModel.instance:getCritterSkinId(slot0:getId())
end

function slot0.getCurrentPosition(slot0)
	return slot0.currentPosition
end

function slot0.getStayBuilding(slot0)
	return slot0.stayBuildingUid, slot0.stayBuildingSlotId
end

function slot0.isRestingCritter(slot0)
	slot1 = false

	return slot0._isRestCritter and true or RoomMapBuildingModel.instance:getBuildingMOById(slot0.stayBuildingUid) and slot3:isCritterInSeatSlot(slot0.uid) and true or false, nil
end

function slot0.getSpecialRate(slot0)
	return CritterConfig.instance:getCritterSpecialRate(slot0.critterId) / 1000
end

return slot0
