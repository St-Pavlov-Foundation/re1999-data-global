module("modules.logic.rouge.map.work.WaitRougeCollectionEffectDoneWork", package.seeall)

slot0 = class("WaitRougeCollectionEffectDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo() then
		return slot0:onDone(true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionChessView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.RougeCollectionChessView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
