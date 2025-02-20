module("modules.logic.room.model.backpack.RoomBackpackCritterListModel", package.seeall)

slot0 = class("RoomBackpackCritterListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:setIsSortByRareAscend(false)
	slot0:setMatureFilterType(CritterEnum.MatureFilterType.All)
end

function slot1(slot0, slot1)
	slot2 = slot0:getId()
	slot3 = slot1:getId()

	if CritterConfig.instance:getCritterRare(slot0:getDefineId()) ~= CritterConfig.instance:getCritterRare(slot1:getDefineId()) then
		if uv0.instance:getIsSortByRareAscend() then
			return slot6 < slot7
		else
			return slot7 < slot6
		end
	end

	slot8 = false

	if ManufactureModel.instance:getCritterWorkingBuilding(slot2) or RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot2) then
		slot8 = true
	end

	slot11 = false

	if ManufactureModel.instance:getCritterWorkingBuilding(slot3) or RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot3) then
		slot11 = true
	end

	if slot8 ~= slot11 then
		return slot8
	end

	if slot0:isMaturity() ~= slot1:isMaturity() then
		return slot14
	end

	if slot0:isCultivating() ~= slot1:isCultivating() then
		return slot16
	end

	if slot4 ~= slot5 then
		return slot4 < slot5
	end

	return slot2 < slot3
end

function slot0.setBackpackCritterList(slot0, slot1)
	slot3 = {}
	slot4 = not slot0.matureFilterType or slot0.matureFilterType == CritterEnum.MatureFilterType.All
	slot5 = slot0.matureFilterType == CritterEnum.MatureFilterType.Mature

	for slot9, slot10 in ipairs(CritterModel.instance:getAllCritters()) do
		slot11 = true

		if slot1 then
			slot11 = slot1:isPassedFilter(slot10)
		end

		if slot11 then
			if slot4 then
				slot3[#slot3 + 1] = slot10
			else
				slot12 = slot10:isMaturity()

				if slot5 and slot12 or not slot5 and not slot12 then
					slot3[#slot3 + 1] = slot10
				end
			end
		end
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

function slot0.setIsSortByRareAscend(slot0, slot1)
	slot0._rareAscend = slot1
end

function slot0.setMatureFilterType(slot0, slot1)
	slot0.matureFilterType = slot1
end

function slot0.getIsSortByRareAscend(slot0)
	return slot0._rareAscend
end

function slot0.getMatureFilterType(slot0)
	return slot0.matureFilterType
end

function slot0.isBackpackEmpty(slot0)
	return slot0:getCount() <= 0
end

slot0.instance = slot0.New()

return slot0
