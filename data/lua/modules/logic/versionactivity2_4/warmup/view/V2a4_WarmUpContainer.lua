module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpContainer", package.seeall)

local var_0_0 = class("V2a4_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local var_0_1 = {
	Done = 1999,
	None = 0
}

function var_0_0.buildViews(arg_1_0)
	arg_1_0._warmUp = V2a4_WarmUp.New()

	return {
		arg_1_0._warmUp
	}
end

function var_0_0.onContainerInit(arg_2_0)
	arg_2_0.__isWaitingPlayHasGetAnim = false

	var_0_0.super.onContainerInit(arg_2_0)

	arg_2_0._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function var_0_0.onContainerOpen(arg_3_0)
	arg_3_0._warmUp:setBlock_scroll(false)
	var_0_0.super.onContainerOpen(arg_3_0)
end

function var_0_0.onContainerClose(arg_4_0)
	var_0_0.super.onContainerClose(arg_4_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_4_0:setCurSelectEpisodeIdSlient(nil)
end

function var_0_0.onContainerCloseFinish(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
end

function var_0_0.onDataUpdateFirst(arg_6_0)
	arg_6_0._warmUp:onDataUpdateFirst()
end

function var_0_0.onDataUpdate(arg_7_0)
	arg_7_0._warmUp:onDataUpdate()
end

function var_0_0.onDataUpdateDoneFirst(arg_8_0)
	arg_8_0:tryTweenDesc()
end

function var_0_0.onSwitchEpisode(arg_9_0)
	arg_9_0.__isWaitingPlayHasGetAnim = false

	arg_9_0._warmUp:setBlock_scroll(false)
	arg_9_0._warmUp:onSwitchEpisode()
end

function var_0_0.episode2Index(arg_10_0, arg_10_1)
	return arg_10_0._warmUp:episode2Index(arg_10_1)
end

function var_0_0.switchTabWithAnim(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._tweenSwitchContext.lastEpisode then
		return
	end

	if not arg_11_2 then
		arg_11_0._tweenSwitchContext.lastEpisode = false
		arg_11_0._tweenSwitchContext.curEpisodeId = false

		return
	end

	arg_11_0._tweenSwitchContext.lastEpisode = arg_11_1
	arg_11_0._tweenSwitchContext.curEpisodeId = arg_11_2

	arg_11_0._warmUp:tweenSwitch(function()
		arg_11_0._tweenSwitchContext.lastEpisode = false
	end)
end

function var_0_0.switchTabNoAnim(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or arg_13_0._tweenSwitchContext.curEpisodeId
	arg_13_0._tweenSwitchContext.lastEpisode = false
	arg_13_0._tweenSwitchContext.curEpisodeId = false

	arg_13_0:setCurSelectEpisodeIdSlient(arg_13_2)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_14_0, ...)
	arg_14_0.__isWaitingPlayHasGetAnim = true

	var_0_0.super.sendFinishAct125EpisodeRequest(arg_14_0, ...)
end

function var_0_0.onCloseViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 ~= ViewName.CommonPropView then
		return
	end

	arg_15_0.__isWaitingPlayHasGetAnim = false
end

function var_0_0.isWaitingPlayHasGetAnim(arg_16_0)
	return arg_16_0.__isWaitingPlayHasGetAnim
end

function var_0_0.tryTweenDesc(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0:getRLOCCur()

	if var_17_0 then
		return
	end

	if var_17_1 then
		return
	end

	if not arg_17_0:checkIsDone() then
		return
	end

	arg_17_0:openDesc()
end

function var_0_0.checkIsDone(arg_18_0, arg_18_1)
	if arg_18_0:getRLOCCur() then
		return true
	end

	arg_18_1 = arg_18_1 or arg_18_0:getCurSelectedEpisode()

	return arg_18_0:getState(arg_18_1) == var_0_1.Done
end

function var_0_0.openDesc(arg_19_0)
	arg_19_0._warmUp:setBlock_scroll(true)
	arg_19_0._warmUp:openDesc(function()
		arg_19_0:setLocalIsPlayCur()
		arg_19_0._warmUp:_refresh()
		arg_19_0._warmUp:setBlock_scroll(false)
	end)
end

local var_0_2 = "Act125Episode|"

function var_0_0._getPrefsKey(arg_21_0, arg_21_1)
	return arg_21_0:getPrefsKeyPrefix() .. var_0_2 .. tostring(arg_21_1)
end

function var_0_0.saveState(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:_getPrefsKey(arg_22_1)

	arg_22_0:saveInt(var_22_0, arg_22_2 or var_0_1.None)
end

function var_0_0.getState(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:_getPrefsKey(arg_23_1)

	return arg_23_0:getInt(var_23_0, arg_23_2 or var_0_1.None)
end

function var_0_0.saveStateDone(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:saveState(arg_24_1, arg_24_2 and var_0_1.Done or var_0_1.None)
end

return var_0_0
