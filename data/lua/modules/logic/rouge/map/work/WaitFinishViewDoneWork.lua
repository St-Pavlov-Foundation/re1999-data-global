module("modules.logic.rouge.map.work.WaitFinishViewDoneWork", package.seeall)

slot0 = class("WaitFinishViewDoneWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.rougeFinish = slot1
end

function slot0.onStart(slot0)
	if slot0.rougeFinish then
		RougeMapController.instance:openRougeFinishView()
	else
		RougeMapController.instance:openRougeFailView()
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onFinishViewDone, slot0.onFinishViewDone, slot0)
end

function slot0.onFinishViewDone(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, slot0.onFinishViewDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, slot0.onFinishViewDone, slot0)
end

return slot0
