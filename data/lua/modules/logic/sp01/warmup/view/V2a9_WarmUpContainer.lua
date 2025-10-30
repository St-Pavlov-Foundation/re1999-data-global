module("modules.logic.sp01.warmup.view.V2a9_WarmUpContainer", package.seeall)

local var_0_0 = class("V2a9_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local var_0_1 = {
	Done = 1999,
	None = 0
}
local var_0_2 = "v2a9_warmup_pic_%s"

function var_0_0.getImgResUrl(arg_1_0, arg_1_1)
	local var_1_0 = string.format(var_0_2, arg_1_1)

	return ResUrl.getV2a9WarmUpSingleBg(var_1_0)
end

function var_0_0.buildViews(arg_2_0)
	arg_2_0._warmUp = V2a9_WarmUp.New()
	arg_2_0._warmUpLeftView = V2a9_WarmUpLeftView.New()

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

	arg_10_0:_play_stop_UI_Bus()
	arg_10_0._warmUp:setBlock_scroll(false)
	arg_10_0._warmUp:onSwitchEpisode()
	arg_10_0._warmUpLeftView:onSwitchEpisode()
end

function var_0_0.onUpdateActivity(arg_11_0)
	if arg_11_0._isPlaying then
		arg_11_0:setLocalIsPlayCur()
		arg_11_0._warmUp:onUpdateActivity()

		arg_11_0._isPlaying = false
	end
end

function var_0_0.episode2Index(arg_12_0, arg_12_1)
	return arg_12_0._warmUp:episode2Index(arg_12_1)
end

function var_0_0.switchTabWithAnim(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._tweenSwitchContext.lastEpisode then
		return
	end

	if not arg_13_2 then
		arg_13_0._tweenSwitchContext.lastEpisode = false
		arg_13_0._tweenSwitchContext.curEpisodeId = false

		return
	end

	arg_13_0._isPlaying = false
	arg_13_0._tweenSwitchContext.lastEpisode = arg_13_1
	arg_13_0._tweenSwitchContext.curEpisodeId = arg_13_2

	arg_13_0._warmUp:tweenSwitch(function()
		arg_13_0._tweenSwitchContext.lastEpisode = false
	end)
end

function var_0_0.switchTabNoAnim(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or arg_15_0._tweenSwitchContext.curEpisodeId
	arg_15_0._tweenSwitchContext.lastEpisode = false
	arg_15_0._tweenSwitchContext.curEpisodeId = false

	arg_15_0:setCurSelectEpisodeIdSlient(arg_15_2)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_16_0, ...)
	arg_16_0.__isWaitingPlayHasGetAnim = true

	var_0_0.super.sendFinishAct125EpisodeRequest(arg_16_0, ...)
end

function var_0_0.onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 ~= ViewName.CommonPropView then
		return
	end

	arg_17_0._warmUp:playRewardItemsHasGetAnim()

	arg_17_0.__isWaitingPlayHasGetAnim = false
end

function var_0_0.isWaitingPlayHasGetAnim(arg_18_0)
	return arg_18_0.__isWaitingPlayHasGetAnim
end

function var_0_0.tryTweenDesc(arg_19_0)
	arg_19_0._needWaitCount = 0

	local var_19_0, var_19_1 = arg_19_0:getRLOCCur()

	if var_19_0 then
		return
	end

	if var_19_1 then
		return
	end

	if not arg_19_0:checkIsDone() then
		return
	end

	arg_19_0:setLocalIsPlayCurByUser()
	arg_19_0:openDesc()
end

function var_0_0.checkIsDone(arg_20_0, arg_20_1)
	if arg_20_0:getRLOCCur() then
		return true
	end

	arg_20_1 = arg_20_1 or arg_20_0:getCurSelectedEpisode()

	return arg_20_0:getState(arg_20_1) == var_0_1.Done
end

function var_0_0.openDesc(arg_21_0)
	arg_21_0._warmUp:setBlock_scroll(true)
	arg_21_0:addNeedWaitCount()
	arg_21_0._warmUp:openDesc(function()
		arg_21_0._isPlaying = false

		arg_21_0:onAnimDone()
		arg_21_0._warmUp:setBlock_scroll(false)
	end)
end

function var_0_0.setNeedWaitCount(arg_23_0, arg_23_1)
	arg_23_0._needWaitCount = arg_23_1 or 1
end

function var_0_0.addNeedWaitCount(arg_24_0)
	arg_24_0:setNeedWaitCount(arg_24_0._needWaitCount and arg_24_0._needWaitCount + 1 or 1)
end

function var_0_0.onAnimDone(arg_25_0)
	arg_25_0._needWaitCount = arg_25_0._needWaitCount - 1

	if arg_25_0._needWaitCount > 0 then
		return
	end

	arg_25_0:setLocalIsPlayCur()
	arg_25_0._warmUp:_refresh()
end

local var_0_3 = "Act125Episode|"

function var_0_0._getPrefsKey(arg_26_0, arg_26_1)
	return arg_26_0:getPrefsKeyPrefix() .. var_0_3 .. tostring(arg_26_1)
end

function var_0_0.saveState(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:_getPrefsKey(arg_27_1)

	arg_27_0:saveInt(var_27_0, arg_27_2 or var_0_1.None)
end

function var_0_0.getState(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:_getPrefsKey(arg_28_1)

	return arg_28_0:getInt(var_28_0, arg_28_2 or var_0_1.None)
end

function var_0_0.saveStateDone(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:saveState(arg_29_1, arg_29_2 and var_0_1.Done or var_0_1.None)

	if arg_29_2 then
		arg_29_0:onAnimDone()
	end
end

function var_0_0.setLocalIsPlayCurByUser(arg_30_0)
	arg_30_0._isPlaying = true
end

function var_0_0._play_stop_UI_Bus(arg_31_0)
	if not arg_31_0._isPlaying then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	end
end

return var_0_0
