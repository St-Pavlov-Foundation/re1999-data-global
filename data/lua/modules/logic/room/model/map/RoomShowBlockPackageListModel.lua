module("modules.logic.room.model.map.RoomShowBlockPackageListModel", package.seeall)

slot0 = class("RoomShowBlockPackageListModel", ListScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	function slot0._selectSortFunc(slot0, slot1)
		if uv0._selectBlockPackageId == slot0.id ~= (uv0._selectBlockPackageId == slot1.id) then
			if slot2 then
				return true
			elseif slot3 then
				return false
			end
		end

		if slot0.num < 1 ~= (slot1.num < 1) then
			return slot5
		end

		slot6 = nil

		if uv0._isSortRate then
			if slot0.rare ~= slot1.rare then
				if uv0._isSortOrder then
					return slot0.rare < slot1.rare
				else
					return slot1.rare < slot0.rare
				end
			end

			if slot0.num ~= slot1.num then
				return slot1.num < slot0.num
			end
		else
			if slot0.num ~= slot1.num then
				if uv0._isSortOrder then
					return slot0.num < slot1.num
				else
					return slot1.num < slot0.num
				end
			end

			if slot0.rare ~= slot1.rare then
				return slot1.rare < slot0.rare
			end
		end

		if slot0.id ~= slot1.id then
			return slot0.id < slot1.id
		end
	end
end

function slot0.getSortRate(slot0)
	return slot0._isSortRate
end

function slot0.getSortOrder(slot0)
	return slot0._isSortOrder
end

function slot0.setSortParam(slot0, slot1, slot2)
	slot0._isSortOrder = slot2
	slot0._isSortRate = slot1

	slot0:sort(slot0._selectSortFunc)
end

function slot0.setShowBlockList(slot0)
	slot1 = {}

	for slot6 = 1, #RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList() do
		if RoomConfig.instance:getBlockPackageConfig(slot2[slot6].id) and slot0:_checkTheme(slot7.id) then
			slot9 = RoomShowBlockPackageMO.New()

			slot9:init(slot7.id, slot7:getUnUseCount(), slot8.rare or 0)
			table.insert(slot1, slot9)
		end
	end

	table.sort(slot1, slot0._selectSortFunc)
	slot0:setList(slot1)
	slot0:setSelect(nil)
end

function slot0._checkTheme(slot0, slot1)
	if not RoomThemeFilterListModel.instance:getIsAll() and slot2:getSelectCount() > 0 and not slot2:isSelectById(RoomConfig.instance:getThemeIdByItem(slot1, MaterialEnum.MaterialType.BlockPackage)) then
		return false
	end

	return true
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectBlockPackageId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectBlockPackageId then
			slot1 = slot7

			break
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectBlockPackageId = slot1

	slot0:_refreshSelect()
end

function slot0.initShow(slot0, slot1)
	slot0._isSortRate = true
	slot0._isSortOrder = true
	slot0._selectBlockPackageId = slot1

	slot0:setShowBlockList()
end

slot0.instance = slot0.New()

return slot0
