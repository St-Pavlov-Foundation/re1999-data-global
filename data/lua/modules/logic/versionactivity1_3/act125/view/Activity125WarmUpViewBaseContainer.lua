module("modules.logic.versionactivity1_3.act125.view.Activity125WarmUpViewBaseContainer", package.seeall)

local var_0_0 = class("Activity125WarmUpViewBaseContainer", Activity125ViewBaseContainer)

function var_0_0.onContainerInit(arg_1_0)
	var_0_0.super.onContainerInit(arg_1_0)
end

function var_0_0.onContainerOpen(arg_2_0)
	var_0_0.super.onContainerOpen(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, arg_2_0._onUpdateActivity, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_2_0._onDataUpdate, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.SwitchEpisode, arg_2_0._onSwitchEpisode, arg_2_0)

	if not arg_2_0._isInited then
		Activity125Controller.instance:getAct125InfoFromServer(arg_2_0:actId())
	end
end

function var_0_0.onContainerClose(arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.UpdateActivity, arg_3_0._onUpdateActivity, arg_3_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.SwitchEpisode, arg_3_0._onSwitchEpisode, arg_3_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_3_0._onDataUpdate, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	var_0_0.super.onContainerClose(arg_3_0)
end

function var_0_0.onContainerDestroy(arg_4_0)
	arg_4_0._isInited = false

	var_0_0.super.onContainerDestroy(arg_4_0)
end

function var_0_0._onDataUpdate(arg_5_0)
	local var_5_0 = arg_5_0._isInited

	if not arg_5_0._isInited then
		arg_5_0:onDataUpdateFirst()

		arg_5_0._isInited = true
	end

	arg_5_0:onDataUpdate()

	if var_5_0 ~= arg_5_0._isInited then
		arg_5_0:onDataUpdateDoneFirst()
	end
end

function var_0_0._onSwitchEpisode(arg_6_0)
	if not arg_6_0._isInited then
		return
	end

	arg_6_0:onSwitchEpisode()
end

function var_0_0._onUpdateActivity(arg_7_0)
	if not arg_7_0._isInited then
		return
	end

	arg_7_0:onUpdateActivity()
end

function var_0_0._onDailyRefresh(arg_8_0)
	Activity125Controller.instance:getAct125InfoFromServer(arg_8_0:actId())
end

function var_0_0._onCloseViewFinish(arg_9_0, ...)
	if not arg_9_0._isInited then
		return
	end

	arg_9_0:onCloseViewFinish(...)
end

function var_0_0.actId(arg_10_0)
	return arg_10_0.viewParam.actId
end

function var_0_0.dispatchRedEvent(arg_11_0)
	Activity125Model.instance:setHasCheckEpisode(arg_11_0:actId(), arg_11_0:getCurSelectedEpisode())
	RedDotController.instance:dispatchEvent(RedDotEvent.RedDotEvent.UpdateActTag)
end

function var_0_0.onDataUpdateFirst(arg_12_0)
	return
end

function var_0_0.onDataUpdate(arg_13_0)
	assert(false, "please override this function")
end

function var_0_0.onDataUpdateDoneFirst(arg_14_0)
	return
end

function var_0_0.onSwitchEpisode(arg_15_0)
	return
end

function var_0_0.onCloseViewFinish(arg_16_0, ...)
	return
end

function var_0_0.onUpdateActivity(arg_17_0)
	return
end

return var_0_0
