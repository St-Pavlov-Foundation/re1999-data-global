module("modules.logic.hotfix.controller.HotfixRuntimeCheckController", package.seeall)

local var_0_0 = class("HotfixRuntimeCheckController", BaseController)

var_0_0.NoInteractInterval = 600
var_0_0.HotfixCheckInterval = 600

local var_0_1 = {
	[610] = true,
	[100] = true,
	[110] = true,
	[170] = true,
	[410] = true
}

function var_0_0.onInit(arg_1_0)
	arg_1_0.enableCheck = true
end

function var_0_0.addConstEvents(arg_2_0)
	logNormal("HotfixRuntimeCheckController addConstEvents")
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.handleOnOpenView, arg_2_0)
	arg_2_0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_2_0._handleSummonTabChange, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.OnSwitchTab, arg_2_0._handleStoreTabChange, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_2_0._onTouchScreen, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._onTick, arg_2_0, 10)
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._lastCheckTime = nil

	arg_3_0:cleanFlow()
end

function var_0_0.checkInitViewNames(arg_4_0)
	if ViewName and not arg_4_0._focusViewNames then
		arg_4_0._focusViewNames = {
			[ViewName.SummonADView] = true,
			[ViewName.StoreView] = true
		}
	end
end

function var_0_0.isViewNeedCheckVersion(arg_5_0, arg_5_1)
	arg_5_0:checkInitViewNames()

	if arg_5_1 and arg_5_0._focusViewNames and arg_5_0._focusViewNames[arg_5_1] then
		return true
	end

	return false
end

function var_0_0.isTimeToCheckVersion(arg_6_0)
	return not arg_6_0._lastCheckTime or Time.time - arg_6_0._lastCheckTime > var_0_0.HotfixCheckInterval
end

function var_0_0._onTouchScreen(arg_7_0)
	arg_7_0._lastInteractTime = Time.realtimeSinceStartup
end

function var_0_0._onTick(arg_8_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		arg_8_0._lastInteractTime = Time.realtimeSinceStartup

		return
	end

	local var_8_0 = Time.realtimeSinceStartup

	if arg_8_0._lastInteractTime and var_8_0 - arg_8_0._lastInteractTime > var_0_0.NoInteractInterval and arg_8_0:isTimeToCheckVersion() then
		arg_8_0:checkNewVersion()

		arg_8_0._lastInteractTime = var_8_0
	end
end

function var_0_0.checkNewVersion(arg_9_0)
	if arg_9_0.enableCheck and arg_9_0:isTimeToCheckVersion() then
		arg_9_0._lastCheckTime = Time.time

		if not arg_9_0._flowCheckVer then
			arg_9_0._flowCheckVer = FlowSequence.New()

			arg_9_0._flowCheckVer:addWork(RuntimeCheckVersionWork.New())
			arg_9_0._flowCheckVer:registerDoneListener(arg_9_0.handleCheckVersionFlowDone, arg_9_0)
			arg_9_0._flowCheckVer:start()
		end
	end
end

function var_0_0.cleanFlow(arg_10_0)
	if arg_10_0._flowCheckVer then
		arg_10_0._flowCheckVer:stop()
		arg_10_0._flowCheckVer:unregisterDoneListener(arg_10_0.handleCheckVersionFlowDone, arg_10_0)

		arg_10_0._flowCheckVer = nil
	end
end

function var_0_0.handleCheckVersionFlowDone(arg_11_0, arg_11_1)
	logNormal("HotfixRuntimeCheckController CheckVersionFlowDone : " .. tostring(arg_11_1))
	arg_11_0:cleanFlow()
end

function var_0_0.handleOnOpenView(arg_12_0, arg_12_1)
	if arg_12_0:isViewNeedCheckVersion(arg_12_1) then
		arg_12_0:checkNewVersion()
	end
end

function var_0_0._handleSummonTabChange(arg_13_0)
	arg_13_0:checkNewVersion()
end

function var_0_0._handleStoreTabChange(arg_14_0, arg_14_1)
	if arg_14_1 and var_0_1[arg_14_1.id] then
		arg_14_0:checkNewVersion()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
