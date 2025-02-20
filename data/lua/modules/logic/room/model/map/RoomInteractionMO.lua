module("modules.logic.room.model.map.RoomInteractionMO", package.seeall)

slot0 = pureTable("RoomInteractionMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.interactionId = slot2
	slot0.config = RoomConfig.instance:getCharacterInteractionConfig(slot0.interactionId)
	slot0.hasInteraction = false
	slot0._interactionRate = slot0.config.rate * 0.001
	slot0._buildingUids = slot3
	slot0._interactionPoint = {}

	slot0:_initBuildingCaramer()
end

function slot0._initBuildingCaramer(slot0)
	if not string.nilorempty(slot0.config.buildingCameraIds) then
		slot0._buildingCameraIds = string.splitToNumber(slot0.config.buildingCameraIds, "#")
	else
		slot0._buildingCameraIds = {}
	end

	slot0._buildingNodesDic = {}
	slot0._buildingNodeList = {}

	for slot4, slot5 in ipairs(slot0._buildingCameraIds) do
		if not string.nilorempty(RoomConfig.instance:getCharacterBuildingInteractCameraConfig(slot5).nodesXYZ) then
			slot7 = GameUtil.splitString2(slot6.nodesXYZ, true)
			slot0._buildingNodesDic[slot5] = slot7

			tabletool.addValues(slot0._buildingNodeList, slot7)
		end
	end
end

function slot0.isCanByRandom(slot0)
	return math.random() <= slot0._interactionRate
end

function slot0.getBuildingUids(slot0)
	return slot0._buildingUids
end

function slot0.getBuildingCameraIds(slot0)
	return slot0._buildingCameraIds
end

function slot0.getBuildingNodeList(slot0)
	return slot0._buildingNodeList
end

function slot0.buildingNodesByCId(slot0, slot1)
	return slot0._buildingNodesDic[slot1]
end

function slot0.getInteractionPointParam(slot0, slot1)
	return slot0._interactionPoint[slot1]
end

function slot0.getBuildingRangeIndexList(slot0, slot1)
	return RoomMapInteractionModel.instance:getBuildingRangeIndexList(slot1)
end

function slot0.getInteractionBuilingUidAndCarmeraId(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0.config.heroId) or slot1:getCurrentInteractionId() ~= nil and slot1:getCurrentInteractionId() ~= 0 then
		return nil
	end

	if not slot0:getBuildingUids() or #slot2 < 1 then
		return nil
	end

	for slot7, slot8 in ipairs(slot2) do
		if slot0:getBuildingCameraIdByBuildingUid(slot8, slot1.currentPosition) then
			return slot8, slot9
		end
	end
end

function slot0.getBuildingCameraIdByBuildingUid(slot0, slot1, slot2)
	if not GameSceneMgr.instance:getCurScene() or not slot3.buildingmgr then
		return nil
	end

	if not slot3.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
		logError(string.format("RoomInteractionMO:getBuildingCameraIdByBuildingUid(buildingUid,posv3) :%s", slot1))

		return nil
	end

	slot5 = slot2.y

	for slot9, slot10 in pairs(slot0._buildingNodesDic) do
		for slot14, slot15 in ipairs(slot10) do
			if Vector3.Distance(slot2, slot4:transformPoint(slot15[1], slot5, slot15[3])) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				return slot9
			end
		end
	end

	return nil
end

function slot0.getInteractionBuilingUid(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0.config.heroId) or slot1:getCurrentInteractionId() ~= nil and slot1:getCurrentInteractionId() ~= 0 then
		return nil
	end

	if not slot0:getBuildingUids() or #slot2 < 1 then
		return nil
	end

	slot3 = slot1.currentPosition
	slot5 = HexMath.positionToRoundHex(Vector2(slot3.x, slot3.z), RoomBlockEnum.BlockSize)
	slot10 = slot5.y

	for slot10 = 1, #slot2 do
		if RoomMapBuildingModel.instance:getBuildingMOById(slot2[slot10]) and (slot12:getCurrentInteractionId() == nil or slot12:getCurrentInteractionId() == 0) and slot0:getBuildingRangeIndexList(slot11) and tabletool.indexOf(slot13, RoomResourceModel.instance:getIndexByXY(slot5.x, slot10)) then
			return slot11
		end
	end

	return nil
end

return slot0
