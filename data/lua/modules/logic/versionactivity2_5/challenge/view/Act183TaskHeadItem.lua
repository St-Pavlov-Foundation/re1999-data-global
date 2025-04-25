module("modules.logic.versionactivity2_5.challenge.view.Act183TaskHeadItem", package.seeall)

slot0 = class("Act183TaskHeadItem", Act183TaskBaseItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtdesc = gohelper.findChildText(slot0.go, "txt_desc")
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	uv0.super.onUpdateMO(slot0, slot1, slot2, slot3)

	slot0._firstTaskMo = slot1.data
	slot0._firstTaskCo = slot0._firstTaskMo and slot0._firstTaskMo.config

	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0._txtdesc.text = slot0._firstTaskCo and slot0._firstTaskCo.minType
end

function slot0._getTaskFinishCount(slot0, slot1)
	slot2 = 0

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if TaskModel.instance:taskHasFinished(TaskEnum.TaskType.Activity183, slot7.id) then
				slot2 = slot2 + 1
			end
		end
	end

	return slot2
end

return slot0
