module("modules.logic.task.model.TaskActivityMo", package.seeall)

slot0 = pureTable("TaskActivityMo")

function slot0.ctor(slot0)
	slot0.typeId = 0
	slot0.defineId = 0
	slot0.value = 0
	slot0.gainValue = 0
	slot0.expiryTime = 0
	slot0.config = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0:update(slot1)

	slot0.config = slot2
end

function slot0.update(slot0, slot1)
	slot0.typeId = slot1.typeId
	slot0.defineId = slot1.defineId
	slot0.value = slot1.value
	slot0.gainValue = slot1.gainValue
	slot0.expiryTime = slot1.expiryTime
end

function slot0.getbonus(slot0, slot1, slot2)
	if slot1 == slot0.typeId then
		slot0.defineId = slot2
		slot0.gainValue = slot0.gainValue + slot0.config.needActivity
	end
end

return slot0
