module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookListModel", package.seeall)

slot0 = class("AiZiLaHandbookListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}

	tabletool.addValues(slot1, AiZiLaModel.instance:getHandbookMOList())
	table.sort(slot1, uv0.sortFunc)
	slot0:setList(slot1)
end

function slot0.sortFunc(slot0, slot1)
	if uv0.getSortIdx(slot0) ~= uv0.getSortIdx(slot1) then
		return slot2 < slot3
	end

	if slot0:getConfig().rare ~= slot1:getConfig().rare then
		return slot5.rare < slot4.rare
	end

	if slot0.itemId ~= slot1.itemId then
		return slot0.itemId < slot1.itemId
	end
end

function slot0.getSortIdx(slot0)
	if AiZiLaModel.instance:isCollectItemId(slot0.itemId) then
		if slot0:getQuantity() > 0 then
			return 1
		end

		return 10
	end

	return 100
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectItemId))
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectItemId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelect(slot0)
	return slot0._selectItemId
end

function slot0.getSelectMO(slot0)
	return slot0:getById(slot0._selectItemId)
end

slot0.instance = slot0.New()

return slot0
