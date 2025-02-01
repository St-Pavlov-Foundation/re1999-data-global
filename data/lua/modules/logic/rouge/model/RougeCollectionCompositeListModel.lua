module("modules.logic.rouge.model.RougeCollectionCompositeListModel", package.seeall)

slot0 = class("RougeCollectionCompositeListModel", ListScrollModel)

function slot0.onInitData(slot0, slot1, slot2)
	slot0._baseTagFilterMap = slot1
	slot0._extraTagFilterMap = slot2

	slot0:filterCollection()
end

function slot0.filterCollection(slot0)
	slot1 = {}

	if RougeCollectionConfig.instance:getCollectionSynthesisList() then
		for slot6, slot7 in ipairs(slot2) do
			if RougeCollectionHelper.checkCollectionHasAnyOneTag(slot7.product, nil, slot0._baseTagFilterMap, slot0._extraTagFilterMap) and RougeDLCHelper.isCurrentUsingContent(slot7.version) then
				table.insert(slot1, slot7)
			end
		end
	end

	table.sort(slot1, slot0.sortFunc)
	slot0:setList(slot1)
end

function slot0.sortFunc(slot0, slot1)
	if RougeCollectionModel.instance:checkIsCanCompositeCollection(slot0.id) ~= RougeCollectionModel.instance:checkIsCanCompositeCollection(slot1.id) then
		return slot2
	end

	return slot0.id < slot1.id
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.selectCell(slot0, slot1, slot2)
	if not slot0:getByIndex(slot1) then
		return
	end

	slot0._curSelectId = slot2 and slot3.id or 0

	uv0.super.selectCell(slot0, slot1, slot2)
end

function slot0.selectFirstOrDefault(slot0)
	if not slot0:isBagEmpty() then
		slot0:selectCell(1, true)
	end
end

function slot0.getCurSelectCellId(slot0)
	return slot0._curSelectId or 0
end

function slot0.isFiltering(slot0)
	return not GameUtil.tabletool_dictIsEmpty(slot0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(slot0._extraTagFilterMap)
end

slot0.instance = slot0.New()

return slot0
