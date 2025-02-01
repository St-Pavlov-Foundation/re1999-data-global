module("modules.logic.rouge.model.RougeCollectionEnchantListModel", package.seeall)

slot0 = class("RougeCollectionEnchantListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._enchantList = nil
	slot0._curSelectEnchantId = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
	slot0:clear()
end

function slot0.onInitData(slot0, slot1)
	slot0._enchantList = slot0:buildEnchantDataTab(slot1)

	slot0:setList(slot0._enchantList)

	if slot0:getById(slot0:getCurSelectEnchantId()) then
		slot0:selectCell(slot2, true)
	end
end

function slot0.buildEnchantDataTab(slot0, slot1)
	slot4 = slot0:buildEnchantMOList(RougeCollectionModel.instance:getSlotAreaCollection(), RougeCollectionModel.instance:getBagAreaCollection())

	table.sort(slot4, slot1 and slot0.sortFunc or slot0.sortFunc2)

	return slot4
end

function slot0.buildEnchantMOList(slot0, slot1, slot2)
	slot3 = {}

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			slot0:dealCollectionInfo(slot8, slot3)
		end
	end

	if slot2 then
		for slot7, slot8 in pairs(slot2) do
			slot0:dealCollectionInfo(slot8, slot3)
		end
	end

	return slot3
end

function slot0.dealCollectionInfo(slot0, slot1, slot2)
	slot5 = nil

	if RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId).type == RougeEnum.CollectionType.Enchant then
		table.insert(slot2, slot0:createRougeEnchantMO(slot1.id, slot1.cfgId))
	else
		slot7 = slot1:getAllEnchantCfgId()

		if slot1:getAllEnchantId() then
			for slot11, slot12 in pairs(slot6) do
				if slot12 > 0 and RougeCollectionConfig.instance:getCollectionCfg(slot7[slot11]) then
					slot5 = slot0:createRougeEnchantMO(slot12, slot13)

					slot5:updateEnchantTargetId(slot1.id)
					table.insert(slot2, slot5)
				end
			end
		end
	end
end

function slot0.createRougeEnchantMO(slot0, slot1, slot2)
	slot3 = RougeCollectionMO.New()

	slot3:init({
		id = slot1,
		itemId = slot2
	})

	return slot3
end

function slot0.sortFunc(slot0, slot1)
	if slot0:isEnchant2Collection() ~= slot1:isEnchant2Collection() then
		return not slot2
	end

	slot5 = RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId)

	if (RougeCollectionConfig.instance:getCollectionCfg(slot0.cfgId) and slot4.showRare or 0) ~= (slot5 and slot5.showRare or 0) then
		return slot7 < slot6
	end

	return slot0.id < slot1.id
end

function slot0.sortFunc2(slot0, slot1)
	if uv0.instance:getById(slot0.id) ~= nil ~= (uv0.instance:getById(slot1.id) ~= nil) then
		return slot4
	end

	if slot4 and slot5 and uv0.instance:getIndex(slot2) ~= uv0.instance:getIndex(slot3) then
		return slot6 < slot7
	end

	return slot0.id < slot1.id
end

function slot0.executeSortFunc(slot0)
	table.sort(slot0._enchantList, slot0.sortFunc)
	slot0:setList(slot0._enchantList)
end

function slot0.isEnchantEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.selectCell(slot0, slot1, slot2)
	slot3 = slot0._curSelectEnchantId

	if slot1 and slot1 > 0 then
		slot0:_selectCellInternal(slot1, slot2)
	else
		slot0:_selectCellInternal(slot3, false)
	end
end

function slot0._selectCellInternal(slot0, slot1, slot2)
	slot4 = nil

	if slot0:getById(slot1) then
		uv0.super.selectCell(slot0, slot0:getIndex(slot3), slot2)

		slot0._curSelectEnchantId = slot2 and slot3.id or nil
	end
end

function slot0.getCurSelectEnchantId(slot0)
	return slot0._curSelectEnchantId
end

slot0.instance = slot0.New()

return slot0
