module("modules.logic.room.model.manufacture.ManufactureFormulaListModel", package.seeall)

slot0 = class("ManufactureFormulaListModel", ListScrollModel)
slot1 = 1
slot2 = 200
slot3 = 2
slot4 = 262

function slot0.sortFormula(slot0, slot1)
	if ManufactureConfig.instance:getItemId(slot0.id) ~= ManufactureConfig.instance:getItemId(slot1.id) then
		return slot4 < slot5
	end

	if ManufactureConfig.instance:getUnitCount(slot2) ~= ManufactureConfig.instance:getUnitCount(slot3) then
		return slot6 < slot7
	end

	return slot2 < slot3
end

function slot0.setManufactureFormulaItemList(slot0, slot1)
	slot2 = {}
	slot0._isNoMat = true

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		slot0._isNoMat = RoomConfig.instance:getBuildingType(slot3.buildingId) == RoomBuildingEnum.BuildingType.Collect

		for slot11, slot12 in ipairs(ManufactureConfig.instance:getAllManufactureItems(slot4)) do
			if ManufactureConfig.instance:getManufactureItemNeedLevel(slot4, slot12) <= slot3:getLevel() then
				slot2[#slot2 + 1] = {
					id = slot12,
					buildingUid = slot1
				}
			end
		end
	end

	table.sort(slot2, slot0.sortFormula)
	slot0:setList(slot2)
end

function slot0.getInfoList(slot0, slot1)
	if not slot0:getList() or #slot3 <= 0 then
		return {}
	end

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot0._isNoMat and uv0 or uv1, slot0._isNoMat and uv2 or uv3, nil))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
