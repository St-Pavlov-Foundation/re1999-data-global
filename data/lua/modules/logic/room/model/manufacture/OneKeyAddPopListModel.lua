module("modules.logic.room.model.manufacture.OneKeyAddPopListModel", package.seeall)

slot0 = class("OneKeyAddPopListModel", ListScrollModel)
slot0.MINI_COUNT = 1
slot1 = 1
slot2 = 200
slot3 = 2
slot4 = 262

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0._strCache = nil

	slot0:setSelectedManufactureItem()
end

function slot0.resetSelectManufactureItemFromCache(slot0)
	if not slot0._strCache then
		slot0._strCache = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, "")
	end

	slot1 = string.splitToNumber(slot0._strCache or "", "|")

	slot0:setSelectedManufactureItem(slot1[1], slot1[2])
end

function slot0.recordSelectManufactureItem(slot0)
	slot1, slot2 = slot0:getSelectedManufactureItem()

	if slot1 then
		slot0._strCache = string.format("%s|%s", slot1, slot2)

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, slot0._strCache)
	end
end

function slot0.setOneKeyFormulaItemList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot0._isNoMat = true
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if RoomMapBuildingModel.instance:getBuildingMOById(slot9) then
			slot0._isNoMat = RoomConfig.instance:getBuildingType(slot10.buildingId) == RoomBuildingEnum.BuildingType.Collect

			for slot18, slot19 in ipairs(ManufactureConfig.instance:getAllManufactureItems(slot11)) do
				slot20 = ManufactureConfig.instance:getUnitCount(slot19)

				if (not slot4[ManufactureConfig.instance:getItemId(slot19)] or slot20 < slot4[slot21]) and ManufactureConfig.instance:getManufactureItemNeedLevel(slot11, slot19) <= slot10:getLevel() then
					slot2[slot21] = {
						id = slot19,
						buildingUid = slot9
					}
					slot4[slot21] = slot20
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot2) do
		slot3[#slot3 + 1] = slot9
	end

	table.sort(slot3, ManufactureFormulaListModel.sortFormula)
	slot0:setList(slot3)
end

function slot0.setSelectedManufactureItem(slot0, slot1, slot2)
	slot0._selectedManufacture = slot1
	slot0._selectedManufactureCount = slot2 or uv0.MINI_COUNT
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

function slot0.getSelectedManufactureItem(slot0)
	if not slot0._strCache then
		slot0:resetSelectManufactureItemFromCache()
	end

	return slot0._selectedManufacture, slot0._selectedManufactureCount or uv0.MINI_COUNT
end

function slot0.getTabDataList(slot0)
	slot1 = {}
	slot2 = {}

	for slot7, slot8 in ipairs(ManufactureModel.instance:getAllPlacedManufactureBuilding()) do
		if not slot2[RoomConfig.instance:getBuildingType(slot8.buildingId)] then
			slot2[slot10] = {}
		end

		slot11[#slot11 + 1] = slot8.id
	end

	for slot7, slot8 in pairs(slot2) do
		if slot7 == RoomBuildingEnum.BuildingType.Collect then
			slot1[#slot1 + 1] = slot8
		else
			for slot12, slot13 in ipairs(slot8) do
				slot1[#slot1 + 1] = {
					slot13
				}
			end
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
