module("modules.logic.backpack.config.ItemConfig", package.seeall)

slot0 = class("ItemConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._itemConfig = nil
	slot0._itemUseConfig = nil
	slot0._itemSpecialConfig = nil
	slot0._itemPowerConfig = nil
	slot0._itemInsightConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"item",
		"item_use",
		"item_specialitem",
		"power_item",
		"item_category_show",
		"insight_item"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "item" then
		slot0._itemConfig = slot2
	elseif slot1 == "item_use" then
		slot0._itemUseConfig = slot2
	elseif slot1 == "item_specialitem" then
		slot0._itemSpecialConfig = slot2
	elseif slot1 == "power_item" then
		slot0._itemPowerConfig = slot2
	elseif slot1 == "item_category_show" then
		slot0._itemCategoryShow = slot2
	elseif slot1 == "insight_item" then
		slot0._itemInsightConfig = slot2
	end
end

function slot0.getItemsCo(slot0)
	return slot0._itemConfig.configDict
end

function slot0.getItemCo(slot0, slot1)
	return slot0._itemConfig.configDict[slot1]
end

function slot0.getItemsUseCo(slot0)
	return slot0._itemUseConfig.configDict
end

function slot0.getItemUseCo(slot0, slot1)
	return slot0._itemUseConfig.configDict[slot1]
end

function slot0.getItemsSpecialCo(slot0)
	return slot0._itemSpecialConfig.configDict
end

function slot0.getItemSpecialCo(slot0, slot1)
	return slot0._itemSpecialConfig.configDict[slot1]
end

function slot0.getItemsPowerCo(slot0)
	return slot0._itemPowerConfig.configDict
end

function slot0.getPowerItemCo(slot0, slot1)
	return slot0._itemPowerConfig.configDict[slot1]
end

function slot0.getItemsInsightCo(slot0)
	return slot0._itemInsightConfig.configDict
end

function slot0.getInsightItemCo(slot0, slot1)
	return slot0._itemInsightConfig.configDict[slot1]
end

function slot0.getItemNameById(slot0, slot1)
	return slot0._itemConfig.configDict[slot1] and slot0._itemConfig.configDict[slot1].name
end

function slot0.getItemIconById(slot0, slot1)
	return slot0._itemConfig.configDict[slot1] and slot0._itemConfig.configDict[slot1].icon
end

function slot0.getItemListBySubType(slot0, slot1)
	if not slot0._subTypeDict then
		slot0._subTypeDict = {}

		for slot5, slot6 in ipairs(slot0._itemConfig.configList) do
			if not slot0._subTypeDict[slot6.subType] then
				slot0._subTypeDict[slot6.subType] = {}
			end

			table.insert(slot7, slot6)
		end
	end

	return slot0._subTypeDict[slot1]
end

function slot0.getStackItemList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = tonumber(slot7[1])
		slot9 = tonumber(slot7[2])

		if ItemModel.instance:getItemConfig(tonumber(slot7[1]), tonumber(slot7[2])) then
			if slot0:isItemStackable(slot8, slot9) then
				table.insert(slot2, {
					slot8,
					slot9,
					tonumber(slot7[3])
				})
			else
				for slot16 = 1, slot10 do
					table.insert(slot2, {
						slot8,
						slot9,
						1
					})
				end
			end
		else
			logError(string.format("getStackItemList no config, type: %s, id: %s", slot8, slot9))
		end
	end

	return slot2
end

function slot0.isItemStackable(slot0, slot1, slot2)
	slot3 = true
	slot4 = slot0:getItemConfig(tonumber(slot1), tonumber(slot2))

	if slot1 == MaterialEnum.MaterialType.Item then
		slot3 = not slot4.isStackable or slot4.isStackable == 1
	elseif slot1 == MaterialEnum.MaterialType.Hero or slot1 == MaterialEnum.MaterialType.HeroSkin or slot1 == MaterialEnum.MaterialType.EquipCard or slot1 == MaterialEnum.MaterialType.PlayerCloth or slot1 == MaterialEnum.MaterialType.Season123EquipCard then
		slot3 = false
	elseif slot1 == MaterialEnum.MaterialType.Equip then
		slot3 = slot4.isExpEquip and slot4.isExpEquip == 1
	end

	return slot3
end

function slot0.getItemCategroyShow(slot0, slot1)
	return slot0._itemCategoryShow.configDict[slot1]
end

function slot0.getItemConfig(slot0, slot1, slot2)
	slot3 = nil

	return (not ItemConfigGetDefine.instance:getItemConfigFunc(tonumber(slot1)) or slot4(tonumber(slot2))) and slot0:getItemSpecialCo(slot1)
end

function slot0.isUniqueByCo(slot0, slot1, slot2)
	if slot1 ~= MaterialEnum.MaterialType.Equip then
		return false
	end

	return slot2.upperLimit and slot2.upperLimit == 1
end

function slot0.isUniqueById(slot0, slot1, slot2)
	return slot0:isUniqueByCo(slot1, slot0:getItemConfig(slot1, slot2))
end

function slot0.getRewardGroupRateInfoList(slot0, slot1)
	slot2 = lua_reward.configDict[tonumber(slot1)]
	slot3 = {}
	slot4 = 0

	repeat
		if string.nilorempty(slot2["rewardGroup" .. slot4 + 1]) then
			return slot3
		end

		if string.split(slot5, ":") then
			DungeonConfig.instance:_calcRewardGroupRateInfoList(slot3, slot6[1])
		end
	until not slot6 or #slot6 == 0

	return slot3
end

slot0.instance = slot0.New()

return slot0
