module("modules.logic.equip.view.work.DelayFuncWork", package.seeall)

slot0 = class("DelayFuncWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0._func = slot1
	slot0._target = slot2
	slot0._delayTime = slot3
	slot0._param = slot4
end

function slot0.onStart(slot0)
	slot0._func(slot0._target, slot0._param)

	if not slot0._delayTime or slot0._delayTime == 0 then
		slot0.hadDelayTask = false

		slot0:onDone(true)
	else
		slot0.hadDelayTask = true

		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot0._delayTime)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	uv0.super.clearWork(slot0)

	if slot0.hadDelayTask then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	end
end

return slot0
