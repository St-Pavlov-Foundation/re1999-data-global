module("modules.logic.activity.model.ActivityType172Model", package.seeall)

slot0 = class("ActivityType172Model", BaseModel)
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._type172Info = {}
end

function slot0.setType172Info(slot0, slot1, slot2)
	slot3 = ActivityType172InfoMo.New()

	slot3:init(slot2.useItemTaskIds)

	slot0._type172Info[slot1] = slot3
end

function slot0.updateType172Info(slot0, slot1, slot2)
	if not slot0._type172Info[slot1] then
		slot3 = ActivityType172InfoMo.New()

		slot3:init(slot2)

		slot0._type172Info[slot1] = slot3
	else
		slot0._type172Info[slot1]:update(slot2)
	end
end

function slot0.isTaskHasUsed(slot0, slot1, slot2)
	if not slot0._type172Info[slot1] then
		return false
	end

	for slot6, slot7 in pairs(slot0._type172Info[slot1].useItemTaskIds) do
		if slot7 == slot2 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
