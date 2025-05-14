module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView", package.seeall)

local var_0_0 = class("V2a5_WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goopen = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_open")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_open/#go_drag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = -1
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = SLFramework.AnimatorPlayer
local var_0_5 = {
	SwipeDone = 1
}
local var_0_6 = 5
local var_0_7 = "onShowDay"

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)

	arg_4_0._lastEpisodeId = nil
	arg_4_0._needWaitCount = 0
	arg_4_0._draggedState = var_0_1
	arg_4_0._dayItemList = {}
	arg_4_0._drag = UIDragListenerHelper.New()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._middleGo = gohelper.findChild(arg_5_0.viewGO, "Middle")
	arg_5_0._guideGo = gohelper.findChild(arg_5_0._middleGo, "guide")
	arg_5_0._animatorPlayer = var_0_4.Get(arg_5_0._middleGo)
	arg_5_0._animtor = arg_5_0._animatorPlayer.animator
	arg_5_0._animEvent = gohelper.onceAddComponent(arg_5_0._middleGo, gohelper.Type_AnimationEventWrap)

	arg_5_0._drag:create(arg_5_0._godrag)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventBegin, arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventEnd, arg_5_0._onDragEnd, arg_5_0)
	arg_5_0:_editableInitView_days()
	arg_5_0:_setActive_drag(true)
	arg_5_0._animEvent:AddEventListener(var_0_7, arg_5_0._onShowDay, arg_5_0)
end

function var_0_0._editableInitView_days(arg_6_0)
	for iter_6_0 = 1, var_0_6 do
		local var_6_0 = gohelper.findChild(arg_6_0._middleGo, "#go_day" .. iter_6_0)
		local var_6_1 = V2a5_WarmUpLeftView_Day.New({
			parent = arg_6_0,
			baseViewContainer = arg_6_0.viewContainer
		})

		var_6_1:setIndex(iter_6_0)
		var_6_1:_internal_setEpisode(iter_6_0)
		var_6_1:init(var_6_0)

		arg_6_0._dayItemList[iter_6_0] = var_6_1
	end
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._animEvent:RemoveEventListener(var_0_7)
	GameUtil.onDestroyViewMember(arg_8_0, "_drag")
	GameUtil.onDestroyViewMemberList(arg_8_0, "_dayItemList")
end

function var_0_0.onDestroyView(arg_9_0)
	GameUtil.onDestroyViewMember(arg_9_0, "_drag")
	GameUtil.onDestroyViewMemberList(arg_9_0, "_dayItemList")
end

function var_0_0.onDataUpdateFirst(arg_10_0)
	if isDebugBuild then
		assert(arg_10_0.viewContainer:getEpisodeCount() <= var_0_6, "invalid config json_activity125 actId: " .. arg_10_0.viewContainer:actId())
	end

	arg_10_0._draggedState = arg_10_0:_checkIsDone() and var_0_2 or var_0_1
end

function var_0_0.onDataUpdate(arg_11_0)
	arg_11_0:_setActive_curEpisode(false)
	arg_11_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_12_0)
	local var_12_0 = arg_12_0:_checkIsDone()

	if arg_12_0._draggedState == var_0_2 and not var_12_0 then
		arg_12_0._draggedState = var_0_1 - 1
	elseif arg_12_0._draggedState < var_0_1 and var_12_0 then
		arg_12_0._draggedState = var_0_2
	end

	arg_12_0:_setActive_curEpisode(false)
	arg_12_0:_refresh()
end

function var_0_0._episodeId(arg_13_0)
	return arg_13_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0._episode2Index(arg_14_0, arg_14_1)
	return arg_14_0.viewContainer:episode2Index(arg_14_1 or arg_14_0:_episodeId())
end

function var_0_0._checkIsDone(arg_15_0, arg_15_1)
	return arg_15_0.viewContainer:checkIsDone(arg_15_1 or arg_15_0:_episodeId())
end

function var_0_0._saveStateDone(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.viewContainer:saveStateDone(arg_16_2 or arg_16_0:_episodeId(), arg_16_1)
end

function var_0_0._saveState(arg_17_0, arg_17_1, arg_17_2)
	assert(arg_17_1 ~= 1999, "please call _saveStateDone instead")
	arg_17_0.viewContainer:saveState(arg_17_2 or arg_17_0:_episodeId(), arg_17_1)
end

function var_0_0._getState(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0.viewContainer:getState(arg_18_2 or arg_18_0:_episodeId(), arg_18_1)
end

function var_0_0._setActive_drag(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._godrag, arg_19_1)
end

function var_0_0._setActive_guide(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._guideGo, arg_20_1)
end

function var_0_0._refresh(arg_21_0)
	local var_21_0 = arg_21_0:_checkIsDone()

	if var_21_0 then
		arg_21_0:_playAnimOpend()
		arg_21_0:_setActive_drag(false)
		arg_21_0:_setActive_guide(false)
	else
		local var_21_1 = arg_21_0:_getState()

		if var_21_1 == 0 then
			arg_21_0:_setActive_guide(not var_21_0 and arg_21_0._draggedState <= var_0_1)
			arg_21_0:_setActive_drag(true)
			arg_21_0:_playAnimIdle()
		elseif var_0_5.SwipeDone == var_21_1 then
			arg_21_0:_setActive_guide(false)
			arg_21_0:_setActive_drag(false)
			arg_21_0:_playAnimAfterSwipe()
		else
			logError("[V2a5_WarmUpLeftView] invalid state:" .. var_21_1)
		end
	end
end

function var_0_0._getItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:_episode2Index(arg_22_1)

	return arg_22_0._dayItemList[var_22_0]
end

function var_0_0._setActive_curEpisode(arg_23_0, arg_23_1)
	arg_23_0:_setActiveByEpisode(arg_23_0:_episodeId(), arg_23_1)
end

function var_0_0._setActiveByEpisode(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._lastEpisodeId then
		arg_24_0:_getItem(arg_24_0._lastEpisodeId):setActive(false)
	end

	arg_24_0._lastEpisodeId = arg_24_1

	arg_24_0:_getItem(arg_24_1):setActive(arg_24_2)
end

function var_0_0._onDragBegin(arg_25_0)
	arg_25_0:_setActive_guide(false)
end

function var_0_0._onDragEnd(arg_26_0)
	if arg_26_0:_checkIsDone() then
		return
	end

	if arg_26_0._drag:isSwipeLT() or arg_26_0._drag:isSwipeRB() then
		arg_26_0:_saveState(var_0_5.SwipeDone)
		arg_26_0:_playAnimAfterSwipe()
		arg_26_0.viewContainer:setLocalIsPlayCurByUser()
	end
end

function var_0_0._playAnimAfterSwipe(arg_27_0)
	arg_27_0:_playAnimOpen(function()
		arg_27_0:_saveStateDone(true)
		arg_27_0.viewContainer:openDesc()
	end)
end

function var_0_0._playAnimIdle(arg_29_0)
	arg_29_0:_playAnim(UIAnimationName.Idle)
end

function var_0_0._playAnimOpen(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:_setActive_curEpisode(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_scissors_cut_25251415)
	arg_30_0:_playAnim(UIAnimationName.Open, arg_30_1, arg_30_2)
end

function var_0_0._playAnimOpend(arg_31_0)
	arg_31_0:_setActive_curEpisode(true)
	arg_31_0:_playAnim("finishidle")
end

function var_0_0._playAnim(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0._animatorPlayer:Play(arg_32_1, arg_32_2 or function()
		return
	end, arg_32_3)
end

function var_0_0._onShowDay(arg_34_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_page_25001215)
end

return var_0_0
