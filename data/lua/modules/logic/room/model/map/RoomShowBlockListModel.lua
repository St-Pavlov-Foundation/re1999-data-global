module("modules.logic.room.model.map.RoomShowBlockListModel", package.seeall)

slot0 = class("RoomShowBlockListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0:clearMapData()
end

function slot0.clearMapData(slot0)
	uv0.super.clear(slot0)

	slot0._selectBlockId = nil
	slot0._packageId = nil
	slot0._selectIndex = 1
end

function slot0.addScrollView(slot0, slot1)
	uv0.super.addScrollView(slot0, slot1)
end

function slot0.setShowBlockList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = nil
	slot4 = RoomInventoryBlockModel.instance:getSelectInventoryBlockId()

	for slot9 = 1, #slot0:_getPackageMOList() do
		slot10 = slot5[slot9]

		if slot0._isSelectPackage or slot0:_checkTheme(slot10.id) then
			for slot15, slot16 in ipairs(slot10:getUnUseBlockMOList()) do
				if slot0:_checkBlockMO(slot16) then
					if slot4 == slot16.id then
						slot3 = slot4
					end

					table.insert(slot1, slot16)
				end
			end
		end
	end

	table.sort(slot1, slot0._sortFunction)

	if slot3 == nil then
		slot3 = slot0:_findSelectId(slot1)
	end

	slot0:setList(slot1)
	slot0:setSelect(slot3)
end

function slot0._getPackageMOList(slot0)
	if slot0._isSelectPackage then
		return {
			RoomInventoryBlockModel.instance:getCurPackageMO()
		}
	end

	return RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()
end

function slot0._findSelectId(slot0, slot1)
	if not slot1 or #slot1 < 1 then
		return nil
	end

	slot2 = slot0._selectIndex and slot1[slot0._selectIndex] or slot1[#slot1]

	return slot2 and slot2.id or nil
end

function slot0._sortFunction(slot0, slot1)
	if uv0._getBirthdayBlockIndex(slot0) ~= uv0._getBirthdayBlockIndex(slot1) then
		return slot2 < slot3
	end

	if RoomInventoryBlockModel.instance:getBlockSortIndex(slot0.packageId, slot0.id) ~= RoomInventoryBlockModel.instance:getBlockSortIndex(slot1.packageId, slot1.id) then
		return slot4 < slot5
	end

	if slot0.packageId ~= slot1.packageId then
		return slot1.packageId < slot0.packageId
	end

	if slot0.packageOrder ~= slot1.packageOrder then
		return slot0.packageOrder < slot1.packageOrder
	end
end

function slot0._getBirthdayBlockIndex(slot0)
	if RoomConfig.instance:getSpecialBlockConfig(slot0.id) and RoomCharacterModel.instance:isOnBirthday(slot1.heroId) then
		return 1
	end

	return 9999
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectBlockId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectBlockId then
			slot0._selectIndex = slot6
			slot1 = slot7

			break
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectBlockId = slot1

	RoomInventoryBlockModel.instance:setSelectInventoryBlockId(slot1)
	slot0:_refreshSelect()
end

function slot0.initShowBlock(slot0)
	slot0._packageId = nil
	slot0._selectIndex = 1

	slot0:setShowBlockList()
end

function slot0._checkBlockMO(slot0, slot1)
	if not slot1:getBlockDefineCfg() then
		return false
	end

	if not slot0:_isEmptyList(slot0._filterExcludeList) then
		for slot6, slot7 in ipairs(slot0._filterExcludeList) do
			if slot2.resIdCountDict[slot7] then
				return false
			end
		end
	end

	if not slot0:_isEmptyList(slot0._filterIncludeList) then
		for slot6, slot7 in ipairs(slot0._filterIncludeList) do
			if slot2.resIdCountDict[slot7] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function slot0._checkTheme(slot0, slot1)
	if not RoomThemeFilterListModel.instance:getIsAll() and slot2:getSelectCount() > 0 and not slot2:isSelectById(RoomConfig.instance:getThemeIdByItem(slot1, MaterialEnum.MaterialType.BlockPackage)) then
		return false
	end

	return true
end

function slot0.setIsPackage(slot0, slot1)
	slot0._isSelectPackage = slot1 == true
end

function slot0.getIsPackage(slot0)
	return slot0._isSelectPackage
end

function slot0.setFilterResType(slot0, slot1, slot2)
	slot0._filterIncludeList = {}
	slot0._filterExcludeList = {}

	slot0:_setList(slot0._filterIncludeList, slot1)
	slot0:_setList(slot0._filterExcludeList, slot2)
end

function slot0.isFilterType(slot0, slot1, slot2)
	if slot0:_isSameValue(slot0._filterIncludeList, slot1) and slot0:_isSameValue(slot0._filterExcludeList, slot2) then
		return true
	end

	return false
end

function slot0.isFilterTypeEmpty(slot0)
	return slot0:_isEmptyList(slot0._filterTypeList)
end

function slot0._setList(slot0, slot1, slot2)
	tabletool.addValues(slot1, slot2)
end

function slot0._isListValue(slot0, slot1, slot2)
	if slot2 and tabletool.indexOf(slot1, slot2) then
		return true
	end

	return false
end

function slot0._isSameValue(slot0, slot1, slot2)
	if slot0:_isEmptyList(slot1) and slot0:_isEmptyList(slot2) then
		return true
	end

	if #slot1 ~= #slot2 then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if not tabletool.indexOf(slot1, slot7) then
			return false
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		if not tabletool.indexOf(slot2, slot7) then
			return false
		end
	end

	return true
end

function slot0._isEmptyList(slot0, slot1)
	return slot1 == nil or #slot1 < 1
end

slot0.instance = slot0.New()

return slot0
