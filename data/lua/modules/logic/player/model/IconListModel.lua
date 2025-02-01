module("modules.logic.player.model.IconListModel", package.seeall)

slot0 = class("IconListModel", ListScrollModel)

function slot0.setIconList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		slot0._moList = slot1

		table.sort(slot0._moList, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end

	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
