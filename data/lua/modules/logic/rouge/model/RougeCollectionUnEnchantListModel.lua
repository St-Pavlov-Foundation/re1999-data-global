module("modules.logic.rouge.model.RougeCollectionUnEnchantListModel", package.seeall)

slot0 = class("RougeCollectionUnEnchantListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._collections = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.onInitData(slot0, slot1)
	slot0._collections = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0._collections, RougeCollectionModel.instance:getCollectionByUid(slot6))
		end
	end

	slot0:setList(slot0._collections)
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.markCurSelectHoleIndex(slot0, slot1)
	slot0._selectHoleIndex = slot1 or 1
end

function slot0.getCurSelectHoleIndex(slot0)
	return slot0._selectHoleIndex
end

function slot0.switchSelectCollection(slot0, slot1)
	slot0._curSelectCollectionId = slot1
end

function slot0.getCurSelectIndex(slot0)
	return slot0:getIndex(slot0:getById(slot0:getCurSelectCollectionId()))
end

function slot0.getCurSelectCollectionId(slot0)
	return slot0._curSelectCollectionId
end

slot0.instance = slot0.New()

return slot0
