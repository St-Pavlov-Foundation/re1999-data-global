module("modules.logic.rouge.map.model.rpcmo.RougeChoiceEventMO", package.seeall)

slot0 = class("RougeChoiceEventMO", RougeBaseEventMO)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)
	slot0:updateCanChoiceSet()

	slot0.choiceSelect = slot0.jsonData.choiceSelect
end

function slot0.update(slot0, slot1, slot2)
	uv0.super.update(slot0, slot1, slot2)
	slot0:updateCanChoiceSet()

	slot0.choiceSelect = slot0.jsonData.choiceSelect
end

function slot0.updateCanChoiceSet(slot0)
	slot0.canChoiceList = slot0.jsonData.canChoiceSet

	if slot0.canChoiceList then
		table.sort(slot0.canChoiceList, slot0.sortChoice)
	end
end

function slot0.getChoiceIdList(slot0)
	return slot0.canChoiceList
end

function slot0.sortChoice(slot0, slot1)
	return slot0 < slot1
end

function slot0.__tostring(slot0)
	return uv0.super.__tostring(slot0)
end

return slot0
