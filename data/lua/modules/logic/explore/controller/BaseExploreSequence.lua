module("modules.logic.explore.controller.BaseExploreSequence", package.seeall)

slot0 = class("BaseExploreSequence")

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
			slot0._callback(slot0._callbackObj, slot0._sequence.isSuccess)
		else
			slot0._callback(slot0._sequence.isSuccess)
		end
	end
end

return slot0
