module("modules.logic.versionactivity2_3.warmup.view.V2a3_WarmUpContainer", package.seeall)

local var_0_0 = class("V2a3_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local var_0_1 = {
	Done = 1999,
	None = 0
}
local var_0_2 = "v2a3_warmup_day%s"

function var_0_0.getImgResUrl(arg_1_0, arg_1_1)
	local var_1_0 = string.format(var_0_2, arg_1_1)

	return ResUrl.getV2a3WarmUpSingleBg(var_1_0)
end

function var_0_0.buildViews(arg_2_0)
	arg_2_0._warmUp = V2a3_WarmUp.New()
	arg_2_0._warmUpLeftView = V2a3_WarmUpLeftView.New()

	return {
		arg_2_0._warmUp,
		arg_2_0._warmUpLeftView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.__isWaitingPlayHasGetAnim = false

	var_0_0.super.onContainerInit(arg_3_0)

	arg_3_0._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function var_0_0.onContainerOpen(arg_4_0)
	arg_4_0._warmUp:setBlock_scroll(false)
	var_0_0.super.onContainerOpen(arg_4_0)
end

function var_0_0.onContainerClose(arg_5_0)
	var_0_0.super.onContainerClose(arg_5_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_5_0:setCurSelectEpisodeIdSlient(nil)
end

function var_0_0.onContainerCloseFinish(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
end

function var_0_0.onDataUpdateFirst(arg_7_0)
	arg_7_0._warmUp:onDataUpdateFirst()
	arg_7_0._warmUpLeftView:onDataUpdateFirst()
end

function var_0_0.onDataUpdate(arg_8_0)
	arg_8_0._warmUp:onDataUpdate()
	arg_8_0._warmUpLeftView:onDataUpdate()
end

function var_0_0.onDataUpdateDoneFirst(arg_9_0)
	arg_9_0:tryTweenDesc()
end

function var_0_0.onSwitchEpisode(arg_10_0)
	arg_10_0.__isWaitingPlayHasGetAnim = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	arg_10_0._warmUp:setBlock_scroll(false)
	arg_10_0._warmUp:onSwitchEpisode()
	arg_10_0._warmUpLeftView:onSwitchEpisode()
end

function var_0_0.episode2Index(arg_11_0, arg_11_1)
	return arg_11_0._warmUp:episode2Index(arg_11_1)
end

function var_0_0.switchTabWithAnim(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._tweenSwitchContext.lastEpisode then
		return
	end

	if not arg_12_2 then
		arg_12_0._tweenSwitchContext.lastEpisode = false
		arg_12_0._tweenSwitchContext.curEpisodeId = false

		return
	end

	arg_12_0._tweenSwitchContext.lastEpisode = arg_12_1
	arg_12_0._tweenSwitchContext.curEpisodeId = arg_12_2

	arg_12_0._warmUp:tweenSwitch(function()
		arg_12_0._tweenSwitchContext.lastEpisode = false
	end)
end

function var_0_0.switchTabNoAnim(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or arg_14_0._tweenSwitchContext.curEpisodeId
	arg_14_0._tweenSwitchContext.lastEpisode = false
	arg_14_0._tweenSwitchContext.curEpisodeId = false

	arg_14_0:setCurSelectEpisodeIdSlient(arg_14_2)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_15_0, ...)
	arg_15_0.__isWaitingPlayHasGetAnim = true

	var_0_0.super.sendFinishAct125EpisodeRequest(arg_15_0, ...)
end

function var_0_0.onCloseViewFinish(arg_16_0, arg_16_1)
	if arg_16_1 ~= ViewName.CommonPropView then
		return
	end

	arg_16_0._warmUp:playRewardItemsHasGetAnim()

	arg_16_0.__isWaitingPlayHasGetAnim = false
end

function var_0_0.isWaitingPlayHasGetAnim(arg_17_0)
	return arg_17_0.__isWaitingPlayHasGetAnim
end

function var_0_0.tryTweenDesc(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0:getRLOCCur()

	if var_18_0 then
		return
	end

	if var_18_1 then
		return
	end

	if not arg_18_0:checkIsDone() then
		return
	end

	arg_18_0:openDesc()
end

function var_0_0.checkIsDone(arg_19_0, arg_19_1)
	if arg_19_0:getRLOCCur() then
		return true
	end

	arg_19_1 = arg_19_1 or arg_19_0:getCurSelectedEpisode()

	return arg_19_0:getState(arg_19_1) == var_0_1.Done
end

function var_0_0.openDesc(arg_20_0)
	arg_20_0._warmUp:setBlock_scroll(true)
	arg_20_0._warmUp:openDesc(function()
		arg_20_0:setLocalIsPlayCur()
		arg_20_0._warmUp:_refresh()
		arg_20_0._warmUp:setBlock_scroll(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over_25005506)
	end)
end

local var_0_3 = "Act125Episode|"

function var_0_0._getPrefsKey(arg_22_0, arg_22_1)
	return arg_22_0:getPrefsKeyPrefix() .. var_0_3 .. tostring(arg_22_1)
end

function var_0_0.saveState(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:_getPrefsKey(arg_23_1)

	arg_23_0:saveInt(var_23_0, arg_23_2 or var_0_1.None)
end

function var_0_0.getState(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:_getPrefsKey(arg_24_1)

	return arg_24_0:getInt(var_24_0, arg_24_2 or var_0_1.None)
end

function var_0_0.saveStateDone(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:saveState(arg_25_1, arg_25_2 and var_0_1.Done or var_0_1.None)
end

return var_0_0
