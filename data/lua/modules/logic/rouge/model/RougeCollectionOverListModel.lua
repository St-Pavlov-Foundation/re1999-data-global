module("modules.logic.rouge.model.RougeCollectionOverListModel", package.seeall)

slot0 = class("RougeCollectionOverListModel", ListScrollModel)

function slot0.onInitData(slot0)
	slot0:onCollectionDataUpdate()
end

function slot0.onCollectionDataUpdate(slot0)
	slot1 = {}
	slot2 = {}

	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot7, slot8 in ipairs(slot3) do
			if not slot2[slot8.id] then
				slot2[slot8.id] = true

				table.insert(slot1, slot8)
			end
		end
	end

	table.sort(slot1, slot0.sortFunc)
	slot0:setList(slot1)
end

function slot0.sortFunc(slot0, slot1)
	slot3 = RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId)

	if (RougeCollectionConfig.instance:getCollectionCfg(slot0.cfgId) and slot2.showRare or 0) ~= (slot3 and slot3.showRare or 0) then
		return slot5 < slot4
	end

	slot7 = RougeCollectionConfig.instance:getOriginEditorParam(slot1.cfgId, RougeEnum.CollectionEditorParamType.Shape)

	if (RougeCollectionConfig.instance:getOriginEditorParam(slot0.cfgId, RougeEnum.CollectionEditorParamType.Shape) and #slot6 or 0) ~= (slot7 and #slot7 or 0) then
		return slot9 < slot8
	end

	return slot0.id < slot1.id
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

slot0.instance = slot0.New()

return slot0
