module("modules.logic.rouge.model.RougeCollectionBagListModel", package.seeall)

slot0 = class("RougeCollectionBagListModel", ListScrollModel)

function slot0.onInitData(slot0, slot1, slot2)
	slot0._baseTagFilterMap = slot1
	slot0._extraTagFilterMap = slot2

	slot0:filterCollection()
	slot0:markCurSelectCollectionId()
end

function slot0.filterCollection(slot0)
	slot1 = {}

	if RougeCollectionModel.instance:getBagAreaCollection() then
		for slot6, slot7 in ipairs(slot2) do
			if RougeCollectionHelper.checkCollectionHasAnyOneTag(slot7.cfgId, slot7:getAllEnchantCfgId(), slot0._baseTagFilterMap, slot0._extraTagFilterMap) then
				table.insert(slot1, slot7)
			end
		end
	end

	table.sort(slot1, slot0.sortFunc)
	slot0:setList(slot1)
end

function slot0.sortFunc(slot0, slot1)
	slot3 = RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId)

	if RougeCollectionConfig.instance:getCollectionCfg(slot0.cfgId) and slot3 and slot2.showRare ~= slot3.showRare then
		return slot3.showRare < slot2.showRare
	end

	if RougeCollectionConfig.instance:getCollectionCellCount(slot0.cfgId, RougeEnum.CollectionEditorParamType.Shape) ~= RougeCollectionConfig.instance:getCollectionCellCount(slot1.cfgId, RougeEnum.CollectionEditorParamType.Shape) then
		return slot5 < slot4
	end

	return slot0.id < slot1.id
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.isFiltering(slot0)
	return not GameUtil.tabletool_dictIsEmpty(slot0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(slot0._extraTagFilterMap)
end

function slot0.isCollectionSelect(slot0, slot1)
	if not slot1 or not slot0._curSelectCollection then
		return
	end

	return slot0._curSelectCollection == slot1
end

function slot0.markCurSelectCollectionId(slot0, slot1)
	slot0._curSelectCollection = slot1
end

slot0.instance = slot0.New()

return slot0
