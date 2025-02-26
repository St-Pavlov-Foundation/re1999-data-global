module("modules.logic.fight.system.flow.BaseFightSequence", package.seeall)

slot0 = class("BaseFightSequence")

function slot0.ctor(slot0)
	slot0._sequence = nil
end

function slot0.buildFlow(slot0)
	if slot0._sequence then
		slot0._sequence:destroy()
	end

	slot0._sequence = FlowSequence.New()
end

function slot0.addWork(slot0, slot1)
	slot0._sequence:addWork(slot1)
end

function slot0.start(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2

	slot0._sequence:registerDoneListener(slot0.doCallback, slot0)
	slot0._sequence:start({})
end

function slot0.stop(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
	end
end

function slot0.isRunning(slot0)
	return slot0._sequence and slot0._sequence.status == WorkStatus.Running
end

function slot0.doneRunningWork(slot0)
	slot1 = {}
	slot5 = slot1

	slot0:_getRunningWorks(slot0._sequence, slot5)

	for slot5, slot6 in ipairs(slot1) do
		logError("行为复现出错，work: " .. slot6.__cname)
		slot6:onDone(true)
	end
end

function slot0._getRunningWorks(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1:getWorkList()) do
		if slot8.status == WorkStatus.Running then
			if isTypeOf(slot8, FlowSequence) then
				slot0:_getRunningWorks(slot8, slot2)
			elseif isTypeOf(slot8, FlowParallel) then
				slot0:_getRunningWorks(slot8, slot2)
			else
				table.insert(slot2, slot8)
			end
		end
	end
end

function slot0.dispose(slot0)
	if slot0._sequence then
		slot0._sequence:unregisterDoneListener(slot0.doCallback, slot0)
		slot0._sequence:destroy()
	end

	slot0._sequence = nil
	slot0._context = nil
	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0.doCallback(slot0)
	slot0._sequence:unregisterDoneListener(slot0.doCallback, slot0)

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj)
		else
			slot0._callback()
		end
	end
end

return slot0
