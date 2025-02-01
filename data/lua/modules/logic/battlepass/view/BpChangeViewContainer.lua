module("modules.logic.battlepass.view.BpChangeViewContainer", package.seeall)

slot0 = class("BpChangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {}
end

function slot0.onContainerOpen(slot0)
	UIBlockMgr.instance:startBlock("BP_Switch")
	TaskDispatcher.runDelay(slot0._delayClose, slot0, 1)
end

function slot0._delayClose(slot0)
	slot0:closeThis()
end

function slot0.onContainerClose(slot0)
	UIBlockMgr.instance:endBlock("BP_Switch")
	TaskDispatcher.cancelTask(slot0._delayClose, slot0)
end

return slot0
