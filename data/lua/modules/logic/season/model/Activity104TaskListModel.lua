module("modules.logic.season.model.Activity104TaskListModel", package.seeall)

slot0 = class("Activity104TaskListModel", ListScrollModel)

function slot0.setTaskList(slot0, slot1)
	slot2 = {
		[slot7] = slot8
	}

	for slot7, slot8 in ipairs(slot1) do
		if slot8.hasFinished then
			slot3 = 0 + 1
		end
	end

	if slot3 > 1 then
		table.insert(slot2, 1, {
			isTotalGet = true
		})
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
