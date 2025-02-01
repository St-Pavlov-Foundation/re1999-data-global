module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGamePackListModel", package.seeall)

slot0 = class("AiZiLaGamePackListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}

	tabletool.addValues(slot1, AiZiLaGameModel.instance:getItemList())

	if #slot1 > 1 then
		table.sort(slot1, uv0.sortFunc)
	end

	slot0:setList(slot1)
end

function slot0.sortFunc(slot0, slot1)
	if slot0:getConfig().rare ~= slot1:getConfig().rare then
		return slot3.rare < slot2.rare
	end

	if slot0:getQuantity() ~= slot1:getQuantity() then
		return slot5 < slot4
	end

	if slot0.itemId ~= slot1.itemId then
		return slot0.itemId < slot1.itemId
	end
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
