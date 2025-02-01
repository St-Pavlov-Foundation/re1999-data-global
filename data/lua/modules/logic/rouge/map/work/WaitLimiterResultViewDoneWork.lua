module("modules.logic.rouge.map.work.WaitLimiterResultViewDoneWork", package.seeall)

slot0 = class("WaitLimiterResultViewDoneWork", BaseWork)

function slot0.onStart(slot0)
	if not slot0:_checkIsNeedOpenRougeLimiterResultView() then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onCloseViewDone, slot0)
	RougeDLCController101.instance:openRougeLimiterResultView()
end

function slot0._checkIsNeedOpenRougeLimiterResultView(slot0)
	return (RougeModel.instance:getRougeResult() and slot1:getLimiterResultMo()) ~= nil
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseViewDone, slot0)
end

function slot0.onCloseViewDone(slot0, slot1)
	if slot1 == ViewName.RougeLimiterResultView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseView, slot0)
		slot0:onDone(true)
	end
end

return slot0
