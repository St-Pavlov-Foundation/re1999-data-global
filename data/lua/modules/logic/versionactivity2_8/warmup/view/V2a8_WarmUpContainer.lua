module("modules.logic.versionactivity2_8.warmup.view.V2a8_WarmUpContainer", package.seeall)

local var_0_0 = class("V2a8_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local var_0_1 = {
	Done = 1999,
	None = 0
}
local var_0_2 = "v2a8_warmup_pic_%s"

function var_0_0.getImgResUrl(arg_1_0, arg_1_1)
	local var_1_0 = string.format(var_0_2, arg_1_1)

	return ResUrl.getV2a8WarmUpSingleBg(var_1_0)
end

function var_0_0.buildViews(arg_2_0)
	arg_2_0._warmUp = V2a8_WarmUp.New()
	arg_2_0._warmUpLeftView = V2a8_WarmUpLeftView.New()

	return {
		arg_2_0._warmUp,
		arg_2_0._warmUpLeftView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0._needWaitCount = 0
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

	if arg_4_0._needWaitCount > 0 then
		arg_4_0:tryTweenDesc()
	end
end

function var_0_0.onContainerClose(arg_5_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	var_0_0.super.onContainerClose(arg_5_0)
end

function var_0_0.onContainerDestroy(arg_6_0)
	arg_6_0:setCurSelectEpisodeIdSlient(nil)

	arg_6_0._needWaitCount = 0
	arg_6_0._isPlaying = false

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	var_0_0.super:onContainerDestroy()
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	arg_7_0:_play_stop_UI_Bus()
end

function var_0_0.onDataUpdateFirst(arg_8_0)
	arg_8_0._warmUp:onDataUpdateFirst()
	arg_8_0._warmUpLeftView:onDataUpdateFirst()
end

function var_0_0.onDataUpdate(arg_9_0)
	arg_9_0._warmUp:onDataUpdate()
	arg_9_0._warmUpLeftView:onDataUpdate()
end

function var_0_0.onDataUpdateDoneFirst(arg_10_0)
	arg_10_0:tryTweenDesc()
end

function var_0_0.onSwitchEpisode(arg_11_0)
	arg_11_0.__isWaitingPlayHasGetAnim = false

	arg_11_0:_play_stop_UI_Bus()
	arg_11_0._warmUp:setBlock_scroll(false)
	arg_11_0._warmUp:onSwitchEpisode()
	arg_11_0._warmUpLeftView:onSwitchEpisode()
end

function var_0_0.onUpdateActivity(arg_12_0)
	if arg_12_0._isPlaying then
		arg_12_0:setLocalIsPlayCur()
		arg_12_0._warmUp:onUpdateActivity()

		arg_12_0._isPlaying = false
	end
end

function var_0_0.episode2Index(arg_13_0, arg_13_1)
	return arg_13_0._warmUp:episode2Index(arg_13_1)
end

function var_0_0.switchTabWithAnim(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._tweenSwitchContext.lastEpisode then
		return
	end

	if not arg_14_2 then
		arg_14_0._tweenSwitchContext.lastEpisode = false
		arg_14_0._tweenSwitchContext.curEpisodeId = false

		return
	end

	arg_14_0._isPlaying = false
	arg_14_0._tweenSwitchContext.lastEpisode = arg_14_1
	arg_14_0._tweenSwitchContext.curEpisodeId = arg_14_2

	arg_14_0._warmUp:tweenSwitch(function()
		arg_14_0._tweenSwitchContext.lastEpisode = false
	end)
end

function var_0_0.switchTabNoAnim(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or arg_16_0._tweenSwitchContext.curEpisodeId
	arg_16_0._tweenSwitchContext.lastEpisode = false
	arg_16_0._tweenSwitchContext.curEpisodeId = false

	arg_16_0:setCurSelectEpisodeIdSlient(arg_16_2)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_17_0, ...)
	arg_17_0.__isWaitingPlayHasGetAnim = true

	var_0_0.super.sendFinishAct125EpisodeRequest(arg_17_0, ...)
end

function var_0_0.onCloseViewFinish(arg_18_0, arg_18_1)
	if arg_18_1 ~= ViewName.CommonPropView then
		return
	end

	arg_18_0._warmUp:playRewardItemsHasGetAnim()

	arg_18_0.__isWaitingPlayHasGetAnim = false
end

function var_0_0.isWaitingPlayHasGetAnim(arg_19_0)
	return arg_19_0.__isWaitingPlayHasGetAnim
end

function var_0_0.tryTweenDesc(arg_20_0)
	arg_20_0._needWaitCount = 0

	local var_20_0, var_20_1 = arg_20_0:getRLOCCur()

	if var_20_0 then
		return
	end

	if var_20_1 then
		return
	end

	if not arg_20_0:checkIsDone() then
		return
	end

	arg_20_0:setLocalIsPlayCurByUser()
	arg_20_0:openDesc()
end

function var_0_0.checkIsDone(arg_21_0, arg_21_1)
	if arg_21_0:getRLOCCur() then
		return true
	end

	arg_21_1 = arg_21_1 or arg_21_0:getCurSelectedEpisode()

	return arg_21_0:getState(arg_21_1) == var_0_1.Done
end

function var_0_0.openDesc(arg_22_0)
	arg_22_0._warmUp:setBlock_scroll(true)
	arg_22_0:addNeedWaitCount()
	arg_22_0._warmUp:openDesc(function()
		arg_22_0._isPlaying = false

		arg_22_0:onAnimDone()
		arg_22_0._warmUp:setBlock_scroll(false)
	end)
end

function var_0_0.setNeedWaitCount(arg_24_0, arg_24_1)
	arg_24_0._needWaitCount = arg_24_1 or 1
end

function var_0_0.addNeedWaitCount(arg_25_0)
	arg_25_0:setNeedWaitCount(arg_25_0._needWaitCount and arg_25_0._needWaitCount + 1 or 1)
end

function var_0_0.onAnimDone(arg_26_0)
	arg_26_0._needWaitCount = arg_26_0._needWaitCount - 1

	if arg_26_0._needWaitCount > 0 then
		return
	end

	arg_26_0:setLocalIsPlayCur()
	arg_26_0._warmUp:_refresh()
end

local var_0_3 = "Act125Episode|"

function var_0_0._getPrefsKey(arg_27_0, arg_27_1)
	return arg_27_0:getPrefsKeyPrefix() .. var_0_3 .. tostring(arg_27_1)
end

function var_0_0.saveState(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:_getPrefsKey(arg_28_1)

	arg_28_0:saveInt(var_28_0, arg_28_2 or var_0_1.None)
end

function var_0_0.getState(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:_getPrefsKey(arg_29_1)

	return arg_29_0:getInt(var_29_0, arg_29_2 or var_0_1.None)
end

function var_0_0.saveStateDone(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:saveState(arg_30_1, arg_30_2 and var_0_1.Done or var_0_1.None)

	if arg_30_2 then
		arg_30_0:onAnimDone()
	end
end

function var_0_0.setLocalIsPlayCurByUser(arg_31_0)
	arg_31_0._isPlaying = true
end

function var_0_0._play_stop_UI_Bus(arg_32_0)
	if not arg_32_0._isPlaying then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	end
end

return var_0_0
