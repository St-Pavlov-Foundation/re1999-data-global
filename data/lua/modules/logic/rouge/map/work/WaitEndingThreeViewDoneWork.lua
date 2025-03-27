module("modules.logic.rouge.map.work.WaitEndingThreeViewDoneWork", package.seeall)

slot0 = class("WaitEndingThreeViewDoneWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.endId = slot1
end

function slot0.onStart(slot0)
	if slot0.endId ~= RougeEnum.EndingThreeId then
		slot0:onDone(true)

		return
	end

	if not (RougeModel.instance:getRougeResult() and slot1:isSucceed()) then
		slot0:onDone(true)
	end

	slot0.flow = FlowSequence.New()

	slot0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeEndingThreeView))
	slot0.flow:registerDoneListener(slot0.onFlowDone, slot0)
	slot0.flow:start()
end

function slot0.onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0.flow then
		slot0.flow:onDestroy()

		slot0.flow = nil
	end
end

return slot0
