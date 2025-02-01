module("modules.logic.room.model.manufacture.ManufactureCritterListModel", package.seeall)

slot0 = class("ManufactureCritterListModel", ListScrollModel)
slot1 = 1
slot2 = 50
slot3 = 5

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
	slot0:clearSort()
end

function slot0.reInit(slot0)
	slot0:clearData()
	slot0:clearSort()
end

function slot0.clearData(slot0)
	slot0._newList = nil
	slot0._curPreviewIndex = 0
	slot0.critterAttrPreviewDict = {}
end

function slot0.clearSort(slot0)
	slot0:setOrder(CritterEnum.OrderType.MoodDown)
end

function slot4(slot0, slot1)
	slot5 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot1:getId())
	slot10 = false
	slot11 = false

	if uv0.instance:getTmpWorkingUid() then
		slot10 = ManufactureModel.instance:getCritterWorkingBuilding(slot2) == slot12 or (RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot0:getId()) and slot4.id) == slot12
		slot11 = ManufactureModel.instance:getCritterWorkingBuilding(slot3) == slot12 or (slot5 and slot5.id) == slot12
	end

	if slot10 ~= slot11 then
		return slot10
	end

	if slot0:getMoodValue() ~= slot1:getMoodValue() then
		if uv0.instance:getOrder() == CritterEnum.OrderType.MoodDown then
			return slot15 < slot14
		elseif slot13 == CritterEnum.OrderType.MoodUp then
			return slot14 < slot15
		end
	end

	if CritterConfig.instance:getCritterRare(slot0:getDefineId()) ~= CritterConfig.instance:getCritterRare(slot1:getDefineId()) then
		if slot13 == CritterEnum.OrderType.RareDown then
			return slot19 < slot18
		elseif slot13 == CritterEnum.OrderType.RareUp then
			return slot18 < slot19
		end
	end

	return slot16 < slot17
end

function slot0.setCritterNewList(slot0, slot1, slot2, slot3)
	slot0:clearData()

	slot0._newList = {}

	for slot8, slot9 in ipairs(CritterModel.instance:getAllCritters()) do
		if slot9:isMaturity() and not slot9:isCultivating() then
			slot12 = nil

			if slot2 then
				slot12 = ManufactureModel.instance:getCritterWorkingBuilding(slot9:getId())
			end

			if not slot12 then
				slot13 = true

				if slot3 then
					slot13 = slot3:isPassedFilter(slot9)
				end

				if slot13 then
					table.insert(slot0._newList, slot9)
				end
			end
		end
	end

	slot0:setTmpWorkingUid(slot1)
	table.sort(slot0._newList, uv0)
	slot0:setTmpWorkingUid()
end

function slot0.setTmpWorkingUid(slot0, slot1)
	slot0._tmpWorkingUid = slot1
end

function slot0.getTmpWorkingUid(slot0)
	return slot0._tmpWorkingUid
end

function slot0.getPreviewCritterUidList(slot0, slot1)
	slot1 = slot1 or uv0
	slot2 = {}

	if not (#(slot0._newList or slot0:getList()) <= slot0._curPreviewIndex) and slot1 <= slot4 and slot0._curPreviewIndex - slot1 <= uv1 then
		for slot14 = slot1, slot1 + (tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.MaxPreviewCount)) or uv2) - 1 do
			if not slot3[slot14] then
				break
			end

			slot2[#slot2 + 1] = slot15:getId()
		end
	end

	return slot2
end

function slot0.getPreviewAttrInfo(slot0, slot1)
	if slot0.critterAttrPreviewDict then
		slot2 = slot0.critterAttrPreviewDict[slot1] or {}
	end

	return slot2
end

function slot0.setAttrPreview(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0.critterAttrPreviewDict[slot6.critterUid] = {
			isSpSkillEffect = slot6.isSpSkillEffect,
			efficiency = slot6.efficiency,
			moodCostSpeed = slot6.moodCostSpeed,
			criRate = slot6.criRate
		}
	end

	slot2 = 0

	for slot6, slot7 in pairs(slot0.critterAttrPreviewDict) do
		slot8 = 0

		if slot0._newList then
			for slot12, slot13 in ipairs(slot0._newList) do
				if slot13:getId() == slot6 then
					slot8 = slot12
				end
			end
		elseif slot0:getById(slot6) then
			slot8 = slot0:getIndex(slot9)
		end

		if slot2 < slot8 then
			slot2 = slot8
		end
	end

	slot0._curPreviewIndex = slot2
end

function slot0.setManufactureCritterList(slot0)
	slot0:setList(slot0._newList)

	slot0._newList = nil
end

function slot0.isCritterListEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.setOrder(slot0, slot1)
	slot0._order = slot1
end

function slot0.getOrder(slot0)
	return slot0._order
end

slot0.instance = slot0.New()

return slot0
