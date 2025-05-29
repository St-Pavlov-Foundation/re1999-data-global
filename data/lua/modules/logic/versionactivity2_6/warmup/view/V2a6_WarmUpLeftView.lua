local var_0_0 = string.format

module("modules.logic.versionactivity2_6.warmup.view.V2a6_WarmUpLeftView", package.seeall)

local var_0_1 = class("V2a6_WarmUpLeftView", BaseView)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/open/#simage_pic")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	return
end

function var_0_1.removeEvents(arg_3_0)
	return
end

local var_0_2 = -1
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = SLFramework.AnimatorPlayer
local var_0_6 = {
	SwipeDone = 1
}
local var_0_7 = 5

function var_0_1.ctor(arg_4_0, ...)
	var_0_1.super.ctor(arg_4_0, ...)

	arg_4_0._lastEpisodeId = nil
	arg_4_0._needWaitCount = 0
	arg_4_0._draggedState = var_0_2
	arg_4_0._dayItemList = {}
	arg_4_0._drag = UIDragListenerHelper.New()
end

function var_0_1._editableInitView(arg_5_0)
	arg_5_0._middleGo = gohelper.findChild(arg_5_0.viewGO, "Middle")
	arg_5_0._openGo = gohelper.findChild(arg_5_0._middleGo, "open")
	arg_5_0._unopenGo = gohelper.findChild(arg_5_0._middleGo, "unopen")
	arg_5_0._godrag = gohelper.findChild(arg_5_0._unopenGo, "drag")
	arg_5_0._guideGo = gohelper.findChild(arg_5_0._unopenGo, "guide")
	arg_5_0._animatorPlayer = var_0_5.Get(arg_5_0._middleGo)
	arg_5_0._animtor = arg_5_0._animatorPlayer.animator

	arg_5_0._drag:create(arg_5_0._godrag)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventBegin, arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventEnd, arg_5_0._onDragEnd, arg_5_0)
	arg_5_0:_setActive_drag(true)
end

function var_0_1.onOpen(arg_6_0)
	return
end

function var_0_1.onClose(arg_7_0)
	GameUtil.onDestroyViewMember(arg_7_0, "_drag")
end

function var_0_1.onDestroyView(arg_8_0)
	GameUtil.onDestroyViewMember(arg_8_0, "_drag")
end

function var_0_1.onDataUpdateFirst(arg_9_0)
	if isDebugBuild then
		assert(arg_9_0.viewContainer:getEpisodeCount() <= var_0_7, "invalid config json_activity125 actId: " .. arg_9_0.viewContainer:actId())
	end

	arg_9_0._draggedState = arg_9_0:_checkIsDone() and var_0_3 or var_0_2
end

function var_0_1.onDataUpdate(arg_10_0)
	arg_10_0:_refresh()
end

function var_0_1.onSwitchEpisode(arg_11_0)
	local var_11_0 = arg_11_0:_checkIsDone()

	if arg_11_0._draggedState == var_0_3 and not var_11_0 then
		arg_11_0._draggedState = var_0_2 - 1
	elseif arg_11_0._draggedState < var_0_2 and var_11_0 then
		arg_11_0._draggedState = var_0_3
	end

	arg_11_0:_refresh()
end

function var_0_1._episodeId(arg_12_0)
	return arg_12_0.viewContainer:getCurSelectedEpisode()
end

function var_0_1._episode2Index(arg_13_0, arg_13_1)
	return arg_13_0.viewContainer:episode2Index(arg_13_1 or arg_13_0:_episodeId())
end

function var_0_1._checkIsDone(arg_14_0, arg_14_1)
	return arg_14_0.viewContainer:checkIsDone(arg_14_1 or arg_14_0:_episodeId())
end

function var_0_1._saveStateDone(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.viewContainer:saveStateDone(arg_15_2 or arg_15_0:_episodeId(), arg_15_1)
end

function var_0_1._saveState(arg_16_0, arg_16_1, arg_16_2)
	assert(arg_16_1 ~= 1999, "please call _saveStateDone instead")
	arg_16_0.viewContainer:saveState(arg_16_2 or arg_16_0:_episodeId(), arg_16_1)
end

function var_0_1._getState(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0.viewContainer:getState(arg_17_2 or arg_17_0:_episodeId(), arg_17_1)
end

function var_0_1._setActive_drag(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._godrag, arg_18_1)
end

function var_0_1._setActive_guide(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._guideGo, arg_19_1)
end

function var_0_1._refresh(arg_20_0)
	local var_20_0 = arg_20_0:_checkIsDone()

	arg_20_0:_refreshImg()

	if var_20_0 then
		arg_20_0:_playAnimOpend()
		arg_20_0:_setActive_drag(false)
		arg_20_0:_setActive_guide(false)
	else
		local var_20_1 = arg_20_0:_getState()

		if var_20_1 == 0 then
			arg_20_0:_setActive_guide(not var_20_0 and arg_20_0._draggedState <= var_0_2)
			arg_20_0:_setActive_drag(true)
			arg_20_0:_playAnimIdle()
		elseif var_0_6.SwipeDone == var_20_1 then
			arg_20_0:_setActive_guide(false)
			arg_20_0:_setActive_drag(false)
			arg_20_0:_playAnimAfterSwipe()
		else
			logError("[V2a6_WarmUpLeftView] invalid state:" .. var_20_1)
		end
	end
end

function var_0_1._refreshImg(arg_21_0)
	GameUtil.loadSImage(arg_21_0._simagepic, var_0_0("singlebg/v2a6_warmup_singlebg/v2a6_warmup_pic_%s.png", arg_21_0:_episodeId()))
end

function var_0_1._onDragBegin(arg_22_0)
	arg_22_0:_setActive_guide(false)
end

function var_0_1._onDragEnd(arg_23_0)
	if arg_23_0:_checkIsDone() then
		return
	end

	if arg_23_0._drag:isSwipeLT() or arg_23_0._drag:isSwipeRB() or arg_23_0._drag:isSwipeLeft() then
		arg_23_0:_saveState(var_0_6.SwipeDone)
		arg_23_0:_playAnimAfterSwipe()
	end
end

function var_0_1._playAnimAfterSwipe(arg_24_0)
	arg_24_0:_playAnimOpen(function()
		arg_24_0:_saveStateDone(true)
		arg_24_0.viewContainer:openDesc()
	end)
end

function var_0_1._playAnimIdle(arg_26_0)
	arg_26_0:_playAnim(UIAnimationName.Close)
end

function var_0_1._playAnimOpen(arg_27_0, arg_27_1, arg_27_2)
	AudioMgr.instance:trigger(AudioEnum2_6.WarmUp.play_ui_wenming_page_20260904)
	arg_27_0:_playAnim(UIAnimationName.Open, arg_27_1, arg_27_2)
end

function var_0_1._playAnimOpend(arg_28_0)
	arg_28_0:_playAnim(UIAnimationName.Finish)
end

function var_0_1._playAnim(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._animatorPlayer:Play(arg_29_1, arg_29_2 or function()
		return
	end, arg_29_3)
end

return var_0_1
