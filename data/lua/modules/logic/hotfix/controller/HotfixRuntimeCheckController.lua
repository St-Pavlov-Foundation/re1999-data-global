module("modules.logic.hotfix.controller.HotfixRuntimeCheckController", package.seeall)

slot0 = class("HotfixRuntimeCheckController", BaseController)
slot0.NoInteractInterval = 600
slot0.HotfixCheckInterval = 600
slot1 = {
	[610.0] = true,
	[100.0] = true,
	[110.0] = true,
	[170.0] = true,
	[410.0] = true
}

function slot0.onInit(slot0)
	slot0.enableCheck = true
end

function slot0.addConstEvents(slot0)
	logNormal("HotfixRuntimeCheckController addConstEvents")
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.handleOnOpenView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._handleSummonTabChange, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.OnSwitchTab, slot0._handleStoreTabChange, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouchScreen, slot0)
	TaskDispatcher.runRepeat(slot0._onTick, slot0, 10)
end

function slot0.reInit(slot0)
	slot0._lastCheckTime = nil

	slot0:cleanFlow()
end

function slot0.checkInitViewNames(slot0)
	if ViewName and not slot0._focusViewNames then
		slot0._focusViewNames = {
			[ViewName.SummonADView] = true,
			[ViewName.StoreView] = true
		}
	end
end

function slot0.isViewNeedCheckVersion(slot0, slot1)
	slot0:checkInitViewNames()

	if slot1 and slot0._focusViewNames and slot0._focusViewNames[slot1] then
		return true
	end

	return false
end

function slot0.isTimeToCheckVersion(slot0)
	return not slot0._lastCheckTime or uv0.HotfixCheckInterval < Time.time - slot0._lastCheckTime
end

function slot0._onTouchScreen(slot0)
	slot0._lastInteractTime = Time.realtimeSinceStartup
end

function slot0._onTick(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		slot0._lastInteractTime = Time.realtimeSinceStartup

		return
	end

	slot1 = Time.realtimeSinceStartup

	if slot0._lastInteractTime and uv0.NoInteractInterval < slot1 - slot0._lastInteractTime and slot0:isTimeToCheckVersion() then
		slot0:checkNewVersion()

		slot0._lastInteractTime = slot1
	end
end

function slot0.checkNewVersion(slot0)
	if slot0.enableCheck and slot0:isTimeToCheckVersion() then
		slot0._lastCheckTime = Time.time

		if not slot0._flowCheckVer then
			slot0._flowCheckVer = FlowSequence.New()

			slot0._flowCheckVer:addWork(RuntimeCheckVersionWork.New())
			slot0._flowCheckVer:registerDoneListener(slot0.handleCheckVersionFlowDone, slot0)
			slot0._flowCheckVer:start()
		end
	end
end

function slot0.cleanFlow(slot0)
	if slot0._flowCheckVer then
		slot0._flowCheckVer:stop()
		slot0._flowCheckVer:unregisterDoneListener(slot0.handleCheckVersionFlowDone, slot0)

		slot0._flowCheckVer = nil
	end
end

function slot0.handleCheckVersionFlowDone(slot0, slot1)
	logNormal("HotfixRuntimeCheckController CheckVersionFlowDone : " .. tostring(slot1))
	slot0:cleanFlow()
end

function slot0.handleOnOpenView(slot0, slot1)
	if slot0:isViewNeedCheckVersion(slot1) then
		slot0:checkNewVersion()
	end
end

function slot0._handleSummonTabChange(slot0)
	slot0:checkNewVersion()
end

function slot0._handleStoreTabChange(slot0, slot1)
	if slot1 and uv0[slot1.id] then
		slot0:checkNewVersion()
	end
end

slot0.instance = slot0.New()

return slot0
