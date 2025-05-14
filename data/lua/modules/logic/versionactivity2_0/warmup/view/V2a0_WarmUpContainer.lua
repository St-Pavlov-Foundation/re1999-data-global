module("modules.logic.versionactivity2_0.warmup.view.V2a0_WarmUpContainer", package.seeall)

local var_0_0 = class("V2a0_WarmUpContainer", Activity125WarmUpViewBaseContainer)
local var_0_1 = {
	Closed = 0,
	Opened = 1
}
local var_0_2 = {
	Big = 1,
	Small = 0
}
local var_0_3 = "v2a0_warmup_img%s"

function var_0_0.getImgResUrl(arg_1_0, arg_1_1)
	local var_1_0 = string.format(var_0_3, arg_1_1)

	return ResUrl.getV2a0WarmUpSingleBg(var_1_0)
end

function var_0_0.buildViews(arg_2_0)
	arg_2_0._warmUp = V2a0_WarmUp.New()
	arg_2_0._warmUpLeftView = Act2_0WarmUpLeftView.New()

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
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_yure_caption_20200115)
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
	if not arg_9_0:checkLidIsOpened() then
		arg_9_0:openGuide()

		return
	end

	arg_9_0:tryTweenDesc()
end

function var_0_0.onSwitchEpisode(arg_10_0)
	arg_10_0.__isWaitingPlayHasGetAnim = false

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

	if arg_18_0:checkEyeIsClicked() then
		arg_18_0:openDesc()
	end
end

function var_0_0.checkLidIsOpened(arg_19_0)
	return arg_19_0:_get_lid(var_0_1.Closed) == var_0_1.Opened
end

function var_0_0.checkEyeIsClicked(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or arg_20_0:getCurSelectedEpisode()

	if not arg_20_0:isEpisodeReallyOpen(arg_20_1) then
		return false
	end

	return arg_20_0:_get_eye(arg_20_1, var_0_2.Small) == var_0_2.Big
end

function var_0_0.saveLidState(arg_21_0, arg_21_1)
	arg_21_0:_save_lid(arg_21_1 and var_0_1.Opened or var_0_1.Closed)
end

function var_0_0.saveEyeState(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 or arg_22_0:getCurSelectedEpisode()

	arg_22_0:_save_eye(arg_22_1, arg_22_2 and var_0_2.Big or var_0_2.Small)
end

function var_0_0.openGuide(arg_23_0)
	arg_23_0._warmUpLeftView:openGuide()
end

function var_0_0.openDesc(arg_24_0)
	arg_24_0._warmUp:setBlock_scroll(true)
	arg_24_0._warmUp:openDesc(function()
		arg_24_0:setLocalIsPlayCur()
		arg_24_0._warmUp:_refresh()
		arg_24_0._warmUp:setBlock_scroll(false)
	end)
end

local var_0_4 = "lid|"

function var_0_0._getPrefsKey_lid(arg_26_0)
	return arg_26_0:getPrefsKeyPrefix() .. var_0_4
end

function var_0_0._save_lid(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:_getPrefsKey_lid()

	arg_27_0:saveInt(var_27_0, arg_27_1 or var_0_1.Closed)
end

function var_0_0._get_lid(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:_getPrefsKey_lid()

	return arg_28_0:getInt(var_28_0, arg_28_1 or var_0_1.Closed)
end

local var_0_5 = "eye|"

function var_0_0._getPrefsKey_eye(arg_29_0, arg_29_1)
	return arg_29_0:getPrefsKeyPrefix() .. var_0_5 .. tostring(arg_29_1)
end

function var_0_0._save_eye(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:_getPrefsKey_eye(arg_30_1)

	arg_30_0:saveInt(var_30_0, arg_30_2 or var_0_1.Closed)
end

function var_0_0._get_eye(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:_getPrefsKey_eye(arg_31_1)

	return arg_31_0:getInt(var_31_0, arg_31_2 or var_0_2.Small)
end

return var_0_0
