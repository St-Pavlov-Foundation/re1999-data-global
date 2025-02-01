module("modules.logic.store.model.StoreRoomGoodsItemListModel", package.seeall)

slot0 = class("StoreRoomGoodsItemListModel", TreeScrollModel)

function slot0.setMOList(slot0, slot1)
	slot0:clear()
	table.sort(slot1, slot0.sortFunction)

	slot4 = {
		rootType = 1,
		rootLength = 373 + 24
	}

	for slot8 = 1, #slot1 do
		if slot1[slot8].children then
			slot9 = math.ceil(#slot1[slot8].children / 4)
			slot10 = {
				rootType = 1,
				rootLength = slot3,
				nodeType = slot9 + 1,
				nodeLength = 387 * slot9 + 30,
				nodeCountEachLine = 1,
				nodeStartSpace = 0,
				nodeEndSpace = 0,
				isExpanded = slot1[slot8].isExpand or false
			}
			slot1[slot8].treeRootParam = slot10
			slot1[slot8].children.rootindex = slot8

			slot0:addRoot(slot1[slot8], slot10, slot8)
			slot0:addNode(slot1[slot8].children, slot8, 1)
		else
			slot0:addRoot(slot1[slot8], {
				rootType = 1,
				rootLength = slot3
			}, slot8)
		end
	end

	for slot8, slot9 in pairs(slot1) do
		if slot9.children then
			table.sort(slot9.children, slot0.sortFunction)
		end
	end

	slot0:addRoot({
		update = true,
		type = 0
	}, slot4, #slot1 + 1)
end

function slot0.getInfoList(slot0)
	return uv0.super.getInfoList(slot0)
end

function slot0.sortFunction(slot0, slot1)
	slot2 = StoreConfig.instance:getGoodsConfig(slot0.goodsId)
	slot3 = StoreConfig.instance:getGoodsConfig(slot1.goodsId)
	slot6 = StoreNormalGoodsItemListModel._isStoreItemUnlock(slot0.goodsId)
	slot7 = StoreNormalGoodsItemListModel._isStoreItemUnlock(slot1.goodsId)

	if not StoreNormalGoodsItemListModel._isStoreItemSoldOut(slot0.goodsId) and StoreNormalGoodsItemListModel._isStoreItemSoldOut(slot1.goodsId) then
		return true
	elseif slot4 and not slot5 then
		return false
	end

	if slot6 and not slot7 then
		return true
	elseif not slot6 and slot7 then
		return false
	end

	if slot0:alreadyHas() ~= slot1:alreadyHas() then
		return slot9
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot0.goodsId) ~= StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot1.goodsId) then
		if slot10 then
			return false
		end

		return true
	end

	if slot2.order < slot3.order then
		return true
	elseif slot3.order < slot2.order then
		return false
	end

	if slot2.id < slot3.id then
		return true
	elseif slot3.id < slot2.id then
		return false
	end
end

function slot0._isStoreItemUnlock(slot0)
	if not StoreConfig.instance:getGoodsConfig(slot0).needEpisodeId or slot1 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0.needWeekWalkLayerUnlock(slot0)
	if StoreConfig.instance:getGoodsConfig(slot0).needWeekwalkLayer <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	return WeekWalkModel.instance:getMaxLayerId() < slot1
end

function slot0._isStoreItemSoldOut(slot0)
	return StoreModel.instance:getGoodsMO(slot0):isSoldOut()
end

slot0.instance = slot0.New()

return slot0
