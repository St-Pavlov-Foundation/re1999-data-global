module("modules.logic.room.model.map.RoomCritterModel", package.seeall)

slot0 = class("RoomCritterModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0:clearBuildingCritterData()
end

function slot0.clearBuildingCritterData(slot0)
	slot0._buildingCritterList = {}
	slot0._buildingCritterDict = {}
end

function slot0.initCititer(slot0, slot1)
	slot0:clear()

	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = RoomCritterMO.New()

			slot8:init(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

function slot0.initStayBuildingCritters(slot0)
	slot0:clearBuildingCritterData()

	for slot5, slot6 in ipairs(ManufactureModel.instance:getAllManufactureMOList()) do
		if slot6:getSlot2CritterDict() then
			for slot12, slot13 in pairs(slot7) do
				slot14 = RoomCritterMO.New()

				slot14:initWithBuildingValue(slot13, slot6:getBuildingUid(), slot12)

				slot0._buildingCritterList[#slot0._buildingCritterList + 1] = slot14
				slot0._buildingCritterDict[slot13] = slot14
			end
		end
	end

	for slot6, slot7 in ipairs(ManufactureModel.instance:getAllCritterBuildingMOList()) do
		for slot13, slot14 in pairs(slot7:getSeatSlot2CritterDict()) do
			slot15 = RoomCritterMO.New()

			slot15:initWithBuildingValue(slot14, slot7:getBuildingUid(), slot13)

			slot0._buildingCritterList[#slot0._buildingCritterList + 1] = slot15
			slot0._buildingCritterDict[slot14] = slot15
		end
	end
end

function slot0.getRoomBuildingCritterList(slot0)
	return slot0._buildingCritterList
end

function slot0.getCritterMOById(slot0, slot1)
	if not slot0:getById(slot1) and slot0._buildingCritterDict then
		slot2 = slot0._buildingCritterDict[slot1]
	end

	if not slot2 and slot0._tempCritterMO and slot1 == slot0._tempCritterMO.uid then
		return slot0._tempCritterMO
	end

	return slot2
end

function slot0.getTrainCritterMOList(slot0)
	return slot0:getList()
end

function slot0.removeTrainCritterMO(slot0, slot1)
	slot0:remove(slot1)
end

function slot0.getAllCritterList(slot0)
	slot1 = {}

	tabletool.addValues(slot1, slot0:getList())
	tabletool.addValues(slot1, slot0:getRoomBuildingCritterList())

	return slot1
end

function slot0.getTempCritterMO(slot0)
	if not slot0._tempCritterMO then
		slot0._tempCritterMO = RoomCritterMO.New()
	end

	return slot0._tempCritterMO
end

slot0.instance = slot0.New()

return slot0
