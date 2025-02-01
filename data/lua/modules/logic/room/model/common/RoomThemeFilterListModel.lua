module("modules.logic.room.model.common.RoomThemeFilterListModel", package.seeall)

slot0 = class("RoomThemeFilterListModel", ListScrollModel)

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
	slot0:_clearSelectData()
end

function slot0._clearSelectData(slot0)
	slot0._selectIdList = {}
	slot0._isAll = false
end

function slot0.init(slot0)
	slot0:_clearData()

	slot2 = {}

	for slot6, slot7 in ipairs(RoomConfig.instance:getThemeConfigList()) do
		slot8 = RoomThemeMO.New()

		slot8:init(slot7.id, slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, uv0.sortMOFunc)
	slot0:setList(slot2)
end

function slot0.sortMOFunc(slot0, slot1)
	if slot0.id ~= slot1.id then
		return slot1.id < slot0.id
	end
end

function slot0.clearFilterData(slot0)
	slot0:_clearSelectData()
	slot0:onModelUpdate()
end

function slot0.getIsAll(slot0)
	return slot0._isAll
end

function slot0.getSelectCount(slot0)
	if slot0._selectIdList then
		return #slot0._selectIdList
	end

	return 0
end

function slot0.isSelectById(slot0, slot1)
	if slot0._isAll then
		return true
	end

	if tabletool.indexOf(slot0._selectIdList, slot1) then
		return true
	end

	return false
end

function slot0.selectAll(slot0)
	if slot0._isAll == true then
		return
	end

	slot0._selectIdList = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		table.insert(slot0._selectIdList, slot6.id)
	end

	slot0:_checkAll()
	slot0:onModelUpdate()
end

function slot0.setSelectById(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	if slot2 == true then
		if not tabletool.indexOf(slot0._selectIdList, slot1) then
			table.insert(slot0._selectIdList, slot1)
			slot0:_checkAll()
			slot0:onModelUpdate()
		end
	elseif slot2 == false and tabletool.indexOf(slot0._selectIdList, slot1) then
		table.remove(slot0._selectIdList, slot3)
		slot0:_checkAll()
		slot0:onModelUpdate()
	end
end

function slot0._checkAll(slot0)
	slot1 = true

	if #slot0:getList() > #slot0._selectIdList then
		slot1 = false
	end

	slot0._isAll = slot1
end

slot0.instance = slot0.New()

return slot0
