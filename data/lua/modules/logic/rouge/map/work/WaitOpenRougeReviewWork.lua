module("modules.logic.rouge.map.work.WaitOpenRougeReviewWork", package.seeall)

slot0 = class("WaitOpenRougeReviewWork", BaseWork)

function slot0.onStart(slot0)
	if (RougeModel.instance:getRougeResult() and slot1.finalScore or 0) <= 0 then
		return slot0:onDone(true)
	end

	slot0.flow = FlowSequence.New()

	slot0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultReView))
	slot0.flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0.flow:start()
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0.flow then
		slot0.flow:destroy()

		slot0.flow = nil
	end
end

return slot0
