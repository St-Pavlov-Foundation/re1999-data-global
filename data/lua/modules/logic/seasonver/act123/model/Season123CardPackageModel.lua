module("modules.logic.seasonver.act123.model.Season123CardPackageModel", package.seeall)

slot0 = class("Season123CardPackageModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:reInit()

	slot0.packageMap = {}
end

function slot0.release(slot0)
	slot0:clear()

	slot0.cardItemList = {}
	slot0.cardItemMap = {}
	slot0.curActId = nil
end

function slot0.reInit(slot0)
	slot0.curActId = nil
	slot0.packageConfigMap = {}
	slot0.cardItemList = {}
	slot0.cardItemMap = {}
	slot0.packageCount = 0
	slot0.packageMap = {}
end

function slot0.initData(slot0, slot1)
	slot0.curActId = slot1

	slot0:initOpenPackageMO(slot1)
	slot0:initPackageCount()
end

function slot0.getOpenPackageMO(slot0)
	if slot0.packageCount > 0 then
		for slot4, slot5 in pairs(slot0.packageMap) do
			if ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot5.id) > 0 then
				return slot5
			end
		end
	end
end

function slot0.initOpenPackageMO(slot0, slot1)
	slot2 = ItemModel.instance:getDict()

	if GameUtil.getTabLen(slot0.packageConfigMap) == 0 then
		slot0:initCurActCardPackageConfigMap(slot1)
	end

	for slot6, slot7 in pairs(slot0.packageConfigMap) do
		if slot2[slot7.id] and ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot7.id) > 0 then
			slot0.packageMap[slot8.id] = slot8
		end
	end
end

function slot0.initCurActCardPackageConfigMap(slot0, slot1)
	for slot6, slot7 in ipairs(ItemConfig.instance:getItemListBySubType(Activity123Enum.CardPackageSubType) or {}) do
		if slot7.activityId == slot1 then
			slot0.packageConfigMap[slot7.id] = slot7
		end
	end
end

function slot0.initPackageCount(slot0)
	slot0.packageCount = 0

	if GameUtil.getTabLen(slot0.packageMap) == 0 then
		slot0:initOpenPackageMO(slot0.curActId)
	end

	for slot4, slot5 in pairs(slot0.packageMap) do
		slot0.packageCount = slot0.packageCount + ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot5.id)
	end

	return slot0.packageCount
end

function slot0.setCardItemList(slot0, slot1)
	slot0.cardItemList = {}
	slot0.cardItemMap = {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.cardItemMap[slot6] then
			slot7 = Season123CardPackageItemMO.New()

			slot7:init(slot6)

			slot0.cardItemMap[slot6] = slot7

			table.insert(slot0.cardItemList, slot7)
		else
			slot7.count = slot7.count + 1
		end
	end

	table.sort(slot0.cardItemList, slot0.sortCardItemList)
	slot0:setList(slot0.cardItemList)
end

function slot0.sortCardItemList(slot0, slot1)
	slot3 = slot1.config

	if slot0.config ~= nil and slot3 ~= nil then
		if slot2.rare ~= slot3.rare then
			return slot3.rare < slot2.rare
		else
			return slot3.equipId < slot2.equipId
		end
	else
		return slot0.itemId < slot1.itemId
	end
end

function slot0.getCardMaxRare(slot0)
	for slot5, slot6 in pairs(slot0.cardItemList) do
		if slot6.config and 0 < slot6.config.rare then
			slot1 = slot6.config.rare
		elseif not slot6.config then
			logError("activity123_equip config id is not exit: " .. tostring(slot6.itemId))
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
