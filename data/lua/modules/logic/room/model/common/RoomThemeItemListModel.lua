module("modules.logic.room.model.common.RoomThemeItemListModel", package.seeall)

slot0 = class("RoomThemeItemListModel", ListScrollModel)
slot0.SwitchType = {
	Source = 2,
	Collect = 1
}

function slot0.setItemShowType(slot0, slot1)
	slot0._showType = slot1

	slot0:onModelUpdate()
end

function slot0.getItemShowType(slot0)
	return slot0._showType or uv0.SwitchType.Collect
end

function slot0.setThemeId(slot0, slot1)
	slot3 = {}

	tabletool.addValues(slot3, RoomModel.instance:getThemeItemMOListById(slot1))
	table.sort(slot3, uv0.sortMOFunc)
	slot0:setList(slot3)
	slot0:onModelUpdate()
end

function slot0.sortMOFunc(slot0, slot1)
	if uv0._getFinishIndex(slot0) ~= uv0._getFinishIndex(slot1) then
		return slot2 < slot3
	end

	if uv0._getTypeIndex(slot0.materialType) ~= uv0._getTypeIndex(slot1.materialType) then
		return slot4 < slot5
	end

	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0._getSourcesTypeIndex(slot0)
	if slot0:getItemConfig() and not string.nilorempty(slot1.sourcesType) then
		for slot7, slot8 in ipairs(string.splitToNumber(slot1.sourcesType, "#")) do
			if RoomConfig.instance:getSourcesTypeConfig(slot8) and slot9.order < 9999 then
				slot3 = slot9.order
			end
		end

		return slot3
	end

	return 99999
end

function slot0._getTypeIndex(slot0)
	if slot0 == MaterialEnum.MaterialType.BlockPackage then
		return 1
	elseif slot0 == MaterialEnum.MaterialType.Building then
		return 2
	end

	return 99999
end

function slot0._getFinishIndex(slot0)
	if slot0:getItemQuantity() < slot0.itemNum then
		return 1
	end

	return 99999
end

slot0.instance = slot0.New()

return slot0
