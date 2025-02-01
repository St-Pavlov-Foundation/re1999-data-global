module("modules.logic.commonprop.model.CommonPropListModel", package.seeall)

slot0 = class("CommonPropListModel", ListScrollModel)

function slot0.setPropList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	slot0:_sortList(slot0._moList)
	slot0:_stackList(slot0._moList)
	slot0:setList(slot0._moList)
end

function slot0._sortList(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		if uv0:_getQuality(slot0) ~= uv0:_getQuality(slot1) then
			return uv0:_getQuality(slot1) < uv0:_getQuality(slot0)
		elseif slot0.materilType ~= slot1.materilType then
			return slot1.materilType < slot0.materilType
		elseif slot0.materilType == 1 and slot1.materilType == 1 and uv0:_getSubType(slot0) ~= uv0:_getSubType(slot1) then
			return uv0:_getSubType(slot0) < uv0:_getSubType(slot1)
		elseif slot0.materilId ~= slot1.materilId then
			return slot1.materilId < slot0.materilId
		end
	end)
end

function slot0._getQuality(slot0, slot1)
	return ItemModel.instance:getItemRare(ItemModel.instance:getItemConfig(slot1.materilType, slot1.materilId))
end

function slot0._getSubType(slot0, slot1)
	return ItemModel.instance:getItemConfig(slot1.materilType, slot1.materilId).subType == nil and 0 or slot2.subType
end

function slot0._getStackable(slot0, slot1)
	return ItemConfig.instance:isItemStackable(slot1.materilType, slot1.materilId)
end

function slot0._stackList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot0:_getStackable(slot7) then
			table.insert(slot2, slot7)
		else
			for slot11 = 1, slot7.quantity do
				table.insert(slot2, {
					quantity = 1,
					materilType = slot7.materilType,
					materilId = slot7.materilId,
					uid = slot7.uid
				})
			end
		end
	end

	slot0._moList = slot2
end

slot0.HighRare = 5

function slot0.isHadHighRareProp(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if tonumber(slot7.materilType) == MaterialEnum.MaterialType.PlayerCloth then
			return true
		end

		if not ItemModel.instance:getItemConfig(tonumber(slot7.materilType), tonumber(slot7.materilId)) or not slot2.rare then
			logWarn(string.format("type : %s, id : %s; getConfig error", slot7.materilType, slot7.materilId))
		elseif uv0.HighRare <= slot2.rare then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
