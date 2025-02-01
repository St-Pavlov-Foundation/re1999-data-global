module("modules.logic.room.model.record.RoomTradeTaskMo", package.seeall)

slot0 = class("RoomTradeTaskMo")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.progress = nil
	slot0.hasFinish = nil
	slot0.new = nil
	slot0.finishTime = nil
	slot0.co = nil
end

function slot0.initMo(slot0, slot1, slot2)
	slot0.id = slot1.id
	slot0.progress = slot1.progress
	slot0.hasFinish = slot1.hasFinish
	slot0.new = slot1.new
	slot0.finishTime = slot1.finishTime
	slot0.co = slot2
end

function slot0.setNew(slot0, slot1)
	slot0.new = false
end

function slot0.isFinish(slot0)
	if slot0.co then
		return slot0.co.maxProgress <= slot0.progress
	end
end

function slot0.isNormalTask(slot0)
	return true
end

return slot0
