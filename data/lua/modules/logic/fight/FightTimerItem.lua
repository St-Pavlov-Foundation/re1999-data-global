module("modules.logic.fight.FightTimerItem", package.seeall)

slot0 = class("FightTimerItem")

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.time = slot1
	slot0.originRepeatCount = slot2
	slot0.repeatCount = slot2
	slot0.callback = slot3
	slot0.handle = slot4
	slot0.param = slot5
	slot0.updateTime = 0
end

function slot0.restart(slot0, slot1, slot2, slot3)
	slot0.updateTime = 0
	slot0.time = slot1 or slot0.time
	slot0.repeatCount = slot2 or slot0.originRepeatCount
	slot0.param = slot3 or slot0.param
	slot0.isDone = false
end

function slot0.update(slot0, slot1)
	if slot0.isDone then
		return
	end

	slot0.updateTime = slot0.updateTime + slot1

	if slot0.time <= slot0.updateTime then
		slot0.updateTime = 0

		if slot0.repeatCount ~= -1 then
			slot0.repeatCount = slot0.repeatCount - 1
		end

		xpcall(slot0.callback, __G__TRACKBACK__, slot0.handle, slot0.param)

		if slot0.repeatCount == 0 then
			slot0.isDone = true
		end
	end
end

return slot0
