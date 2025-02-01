module("modules.logic.rouge.map.view.finish.RougeFinishViewContainer", package.seeall)

slot0 = class("RougeFinishViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeFinishView.New())

	return slot1
end

function slot0.playCloseTransition(slot0)
	TaskDispatcher.runDelay(slot0.onCloseAnimDone, slot0, 0.5)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
end

function slot0.onCloseAnimDone(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFinishViewDone)
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.RougeResultView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
		slot0:onPlayCloseTransitionFinish()
	end
end

return slot0
