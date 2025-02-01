module("modules.logic.teach.model.TeachNoteRewardListModel", package.seeall)

slot0 = class("TeachNoteRewardListModel", ListScrollModel)

function slot0.setRewardList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0._moList, slot6)
		end
	end

	table.sort(slot0._moList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
