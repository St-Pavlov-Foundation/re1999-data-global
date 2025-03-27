module("modules.logic.versionactivity2_4.pinball.view.PinballLoadingViewContainer", package.seeall)

slot0 = class("PinballLoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {}
end

function slot0.onContainerOpen(slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, slot0._viewSetting.delayTime or 2)
end

function slot0.onContainerClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
