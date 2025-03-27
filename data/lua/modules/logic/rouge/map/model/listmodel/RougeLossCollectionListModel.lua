module("modules.logic.rouge.map.model.listmodel.RougeLossCollectionListModel", package.seeall)

slot0 = class("RougeLossCollectionListModel", ListScrollModel)

function slot0.setLossType(slot0, slot1)
	slot0.lossType = slot1
end

function slot0.getLossType(slot0)
	return slot0.lossType
end

function slot0.initList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.maxSelectCount = slot1
	slot0.selectCount = 0
	slot0.selectMoList = {}
	slot0.allMoList = {}
	slot0.baseTagFilterMap = slot3
	slot0.extraTagFilterMap = slot4

	for slot9, slot10 in ipairs(slot2) do
		slot0:addCollection(slot10.id, slot10.cfgId, slot5)

		for slot16, slot17 in ipairs(slot10:getAllEnchantId()) do
			slot0:addCollection(slot17, slot10:getAllEnchantCfgId()[slot16], slot5)
		end
	end

	slot0.showMoList = {}

	slot0:filterCollection()
end

function slot0.addCollection(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	if slot1 == 0 or slot2 == 0 then
		return
	end

	if slot3 then
		if not RougeCollectionHelper.isUniqueCollection(slot2) then
			table.insert(slot0.allMoList, {
				uid = slot1,
				collectionId = slot2
			})
		end
	else
		table.insert(slot0.allMoList, {
			uid = slot1,
			collectionId = slot2
		})
	end
end

function slot0.filterCollection(slot0)
	tabletool.clear(slot0.showMoList)

	for slot4, slot5 in ipairs(slot0.allMoList) do
		if RougeCollectionHelper.checkCollectionHasAnyOneTag(slot5.collectionId, nil, slot0.baseTagFilterMap, slot0.extraTagFilterMap) then
			table.insert(slot0.showMoList, slot5)
		end
	end
end

function slot0.refresh(slot0)
	slot0:setList(slot0.showMoList)
end

function slot0.getSelectMoList(slot0)
	return slot0.selectMoList
end

function slot0.checkCanSelect(slot0)
	return #slot0.selectMoList < slot0.maxSelectCount
end

function slot0.getSelectCount(slot0)
	return slot0.selectCount
end

function slot0.selectMo(slot0, slot1)
	if slot0.maxSelectCount <= slot0.selectCount then
		return
	end

	if tabletool.indexOf(slot0.selectMoList, slot1) then
		return
	end

	slot0.selectCount = slot0.selectCount + 1

	tabletool.removeValue(slot0.showMoList, slot1)
	table.insert(slot0.selectMoList, slot1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)
end

function slot0.deselectMo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.selectMoList) do
		if slot6 == slot1 then
			slot0.selectCount = slot0.selectCount - 1

			table.remove(slot0.selectMoList, slot5)
			table.insert(slot0.showMoList, slot1)
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)

			return
		end
	end
end

function slot0.isFiltering(slot0)
	return not GameUtil.tabletool_dictIsEmpty(slot0.baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(slot0.extraTagFilterMap)
end

function slot0.clear(slot0)
	slot0.maxSelectCount = nil
	slot0.selectCount = nil
	slot0.selectMoList = nil
	slot0.allMoList = nil
	slot0.showMoList = nil
	slot0.baseTagFilterMap = nil
	slot0.extraTagFilterMap = nil
	slot0.lossType = nil
end

slot0.instance = slot0.New()

return slot0
