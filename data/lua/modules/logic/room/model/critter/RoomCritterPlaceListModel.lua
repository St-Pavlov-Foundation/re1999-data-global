module("modules.logic.room.model.critter.RoomCritterPlaceListModel", package.seeall)

slot0 = class("RoomCritterPlaceListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:setOrder(CritterEnum.OrderType.MoodUp)
end

function slot1(slot0, slot1)
	slot6 = false
	slot7 = false

	if uv0.instance:getTmpBuildingUid() then
		slot6 = ManufactureModel.instance:getCritterRestingBuilding(slot0:getId()) == slot8
		slot7 = ManufactureModel.instance:getCritterRestingBuilding(slot1:getId()) == slot8
	end

	if slot6 ~= slot7 then
		return slot6
	end

	if slot0:getMoodValue() ~= slot1:getMoodValue() then
		if uv0.instance:getOrder() == CritterEnum.OrderType.MoodDown then
			return slot11 < slot10
		elseif slot9 == CritterEnum.OrderType.MoodUp then
			return slot10 < slot11
		end
	end

	if CritterConfig.instance:getCritterRare(slot0:getDefineId()) ~= CritterConfig.instance:getCritterRare(slot1:getDefineId()) then
		if slot9 == CritterEnum.OrderType.RareDown then
			return slot15 < slot14
		elseif slot9 == CritterEnum.OrderType.RareUp then
			return slot14 < slot15
		end
	end

	slot16 = false

	if ManufactureModel.instance:getCritterWorkingBuilding(slot2) or RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot2) then
		slot16 = true
	end

	slot19 = false

	if ManufactureModel.instance:getCritterWorkingBuilding(slot3) or RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot3) then
		slot19 = true
	end

	if slot16 ~= slot19 then
		return slot16
	end

	if (slot4 and true or false) ~= (slot5 and true or false) then
		return slot23
	end

	if slot12 ~= slot13 then
		return slot12 < slot13
	end

	return slot2 < slot3
end

function slot0.setCritterPlaceList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(CritterModel.instance:getAllCritters()) do
		if not slot8:isCultivating() then
			table.insert(slot2, slot8)
		end
	end

	slot0:setTmpBuildingUid(slot1)
	table.sort(slot2, uv0)
	slot0:setTmpBuildingUid()
	slot0:setList(slot2)
	slot0:refreshSelectList(slot1)
end

function slot0.setTmpBuildingUid(slot0, slot1)
	slot0._tmpBuildingUid = slot1
end

function slot0.getTmpBuildingUid(slot0)
	return slot0._tmpBuildingUid
end

function slot0.refreshSelectList(slot0, slot1)
	slot2 = {}

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		for slot8, slot9 in ipairs(slot0:getList()) do
			if slot3:isCritterInSeatSlot(slot9:getId()) then
				slot2[#slot2 + 1] = slot9
			end
		end
	end

	for slot7, slot8 in ipairs(slot0._scrollViews) do
		slot8:setSelectList(slot2)
	end
end

function slot0.setOrder(slot0, slot1)
	slot0._order = slot1
end

function slot0.getOrder(slot0)
	return slot0._order
end

slot0.instance = slot0.New()

return slot0
