module("modules.logic.versionactivity2_3.dungeon.model.VersionActivity2_3StoreListModel", package.seeall)

slot0 = class("VersionActivity2_3StoreListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initStoreGoodsConfig(slot0)
	if slot0.goodsConfigList then
		return
	end

	slot0.goodsConfigList = {}

	for slot5, slot6 in pairs(ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity2_3Enum.ActivityId.DungeonStore) or {}) do
		tabletool.addValues(slot0.goodsConfigList, slot6)
	end
end

function slot0._sortGoods(slot0, slot1)
	if (slot0.maxBuyCount ~= 0 and slot0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_3Enum.ActivityId.DungeonStore, slot0.id) <= 0) ~= (slot1.maxBuyCount ~= 0 and slot1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_3Enum.ActivityId.DungeonStore, slot1.id) <= 0) then
		if slot2 then
			return false
		end

		return true
	end

	return slot0.id < slot1.id
end

function slot0.refreshStore(slot0)
	slot0:initStoreGoodsConfig()
	table.sort(slot0.goodsConfigList, uv0._sortGoods)
	slot0:setList(slot0.goodsConfigList)
end

slot0.instance = slot0.New()

return slot0
