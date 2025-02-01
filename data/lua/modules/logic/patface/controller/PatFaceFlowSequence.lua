module("modules.logic.patface.controller.PatFaceFlowSequence", package.seeall)

slot0 = class("PatFaceFlowSequence", FlowSequence)
slot1 = "PatFaceUIBlock"

function slot0.isContinuePopView(slot0)
	return slot0._curIndex < #slot0._workList
end

function slot0._runNext(slot0)
	if slot0._curIndex + 1 > #slot0._workList then
		slot0._curIndex = slot1

		slot0:onDone(true)

		return
	end

	UIBlockMgr.instance:startBlock(uv0)
	slot0:_waitInMainView()
end

function slot0._waitInMainView(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	if MainController.instance:isInMainView() then
		uv1.super._runNext(slot0)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._viewChangeCheckIsInMainView, slot0)
	end
end

function slot0._removeViewChangeEvent(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._viewChangeCheckIsInMainView, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.MainView then
		return
	end

	slot0:_viewChangeCheckIsInMainView()
end

function slot0._viewChangeCheckIsInMainView(slot0)
	if not MainController.instance:isInMainView() then
		return
	end

	slot0:_removeViewChangeEvent()
	slot0:_runNext()
end

function slot0.clearWork(slot0)
	slot0:_removeViewChangeEvent()
	UIBlockMgr.instance:endBlock(uv0)
end

return slot0
