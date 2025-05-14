module("modules.logic.versionactivity2_3.warmup.view.V2a3_WarmUpLeftView", package.seeall)

local var_0_0 = class("V2a3_WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._Middle = gohelper.findChild(arg_1_0.viewGO, "Middle")

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
local var_0_5 = ZProj.TweenHelper
local var_0_6 = UIMesh
local var_0_7 = {
	DraggedDone = 1
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._drag = UIDragListenerHelper.New()
	arg_4_0._draggedState = var_0_1
	arg_4_0._needWaitCount = 0
	arg_4_0._iconGo = gohelper.findChild(arg_4_0._Middle, "#icon")
	arg_4_0._simageicon = gohelper.findChild(arg_4_0._iconGo, "#simage_icon"):GetComponent(typeof(var_0_6))
	arg_4_0._centerGo = gohelper.findChild(arg_4_0._Middle, "#go_center")
	arg_4_0._centerTrans = arg_4_0._centerGo.transform
	arg_4_0._dragGo = gohelper.findChild(arg_4_0._centerGo, "#go_drag")
	arg_4_0._firstGo = gohelper.findChild(arg_4_0._Middle, "first")
	arg_4_0._dec2Go = gohelper.findChild(arg_4_0._firstGo, "dec2")
	arg_4_0._rudderTran = arg_4_0._dec2Go.transform
	arg_4_0._firstAnimPlayer = var_0_4.Get(arg_4_0._firstGo)
	arg_4_0._firstAnimator = arg_4_0._firstAnimPlayer.animator
	arg_4_0._iconAnimPlayer = var_0_4.Get(arg_4_0._iconGo)
	arg_4_0._iconAnimator = arg_4_0._iconAnimPlayer.animator
	arg_4_0._firstAnimator.enabled = false
	arg_4_0._dragEnabled = false

	arg_4_0:_setActive_drag(true)
end

function var_0_0.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMember_TweenId(arg_5_0, "_tweener")
	GameUtil.onDestroyViewMember(arg_5_0, "_drag")
end

function var_0_0.onDataUpdateFirst(arg_6_0)
	local var_6_0 = arg_6_0:_checkIsDone()

	arg_6_0._draggedState = var_6_0 and var_0_2 or var_0_1

	arg_6_0._drag:create(arg_6_0._dragGo)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventBegin, arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventDragging, arg_6_0._onDrag, arg_6_0)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventEnd, arg_6_0._onDragEnd, arg_6_0)

	arg_6_0._centerScreenPosV2 = recthelper.uiPosToScreenPos(arg_6_0._centerTrans)

	arg_6_0:_setActive_icon(var_6_0)
	arg_6_0:_setActive_rudder(not var_6_0)
end

function var_0_0.onDataUpdate(arg_7_0)
	arg_7_0._hasDraggedAngle = 0

	arg_7_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_8_0)
	local var_8_0 = arg_8_0:_checkIsDone()

	if arg_8_0._draggedState == var_0_2 and not var_8_0 then
		arg_8_0._draggedState = var_0_1 - 1
	elseif arg_8_0._draggedState < var_0_1 and var_8_0 then
		arg_8_0._draggedState = var_0_2
	end

	arg_8_0._hasDraggedAngle = 0

	arg_8_0:_refresh()
end

function var_0_0._episodeId(arg_9_0)
	return arg_9_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0._getImgResUrl(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_episode2Index(arg_10_1)

	return arg_10_0.viewContainer:getImgResUrl(var_10_0)
end

function var_0_0._episode2Index(arg_11_0, arg_11_1)
	return arg_11_0.viewContainer:episode2Index(arg_11_1 or arg_11_0:_episodeId())
end

function var_0_0._checkIsDone(arg_12_0, arg_12_1)
	return arg_12_0.viewContainer:checkIsDone(arg_12_1 or arg_12_0:_episodeId())
end

function var_0_0._saveStateDone(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.viewContainer:saveStateDone(arg_13_2 or arg_13_0:_episodeId(), arg_13_1)
end

function var_0_0._saveState(arg_14_0, arg_14_1, arg_14_2)
	assert(arg_14_1 ~= 1999, "please call _saveStateDone instead")
	arg_14_0.viewContainer:saveState(arg_14_2 or arg_14_0:_episodeId(), arg_14_1)
end

function var_0_0._getState(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0.viewContainer:getState(arg_15_2 or arg_15_0:_episodeId(), arg_15_1)
end

function var_0_0._setActive_drag(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._dragGo, arg_16_1)
end

function var_0_0._setActive_guide(arg_17_0, arg_17_1)
	return
end

function var_0_0.onOpen(arg_18_0)
	return
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:_clearFrameTimer()
	GameUtil.onDestroyViewMember_TweenId(arg_19_0, "_tweener")
end

function var_0_0._refresh(arg_20_0)
	local var_20_0 = arg_20_0:_episodeId()
	local var_20_1 = arg_20_0:_checkIsDone()

	arg_20_0:_loadImage(var_20_0)
	arg_20_0:_setActive_icon(var_20_1)
	arg_20_0:_setActive_rudder(not var_20_1)
	arg_20_0:_setActive_guide(not var_20_1 and arg_20_0._draggedState <= var_0_1)

	if var_20_1 then
		arg_20_0._dragEnabled = false
	else
		local var_20_2 = arg_20_0:_getState()

		if var_20_2 == 0 then
			arg_20_0._dragEnabled = true

			arg_20_0:_playAnim_Rudder_idle()
		elseif var_0_7.DraggedDone == var_20_2 then
			arg_20_0._dragEnabled = false

			arg_20_0:_playAnim_Rudder_click()
		else
			logError("[V2a3_WarmUpLeftView] invalid state:" .. var_20_2)
		end
	end
end

function var_0_0._getImgRes(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:_getImgResUrl(arg_21_1)

	return arg_21_0.viewContainer:getRes(var_21_0)
end

function var_0_0._loadImage(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:_getImgRes(arg_22_1)

	arg_22_0._simageicon.texture = var_22_0

	arg_22_0._simageicon:SetMaterialDirty()
end

function var_0_0._setActive_icon(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._iconGo, arg_23_1)
end

function var_0_0._setActive_rudder(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._firstGo, arg_24_1)
end

function var_0_0._canDrag(arg_25_0)
	return arg_25_0._dragEnabled
end

function var_0_0._onDragBegin(arg_26_0)
	arg_26_0:_clearFrameTimer()

	if not arg_26_0:_canDrag() then
		return
	end

	arg_26_0:_setActive_guide(false)

	arg_26_0._draggedState = var_0_3
end

local var_0_8 = 240

function var_0_0._onDrag(arg_27_0, arg_27_1)
	if not arg_27_0:_canDrag() then
		return
	end

	arg_27_0._hasDraggedAngle = arg_27_0._hasDraggedAngle or 0

	local var_27_0, var_27_1, var_27_2 = arg_27_1:quaternionToMouse(arg_27_0._rudderTran, arg_27_0._centerScreenPosV2)

	if var_27_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_turn_loop_20234004)
		arg_27_0:_createFTimer()

		arg_27_0._rudderTran.rotation = arg_27_0._rudderTran.rotation * var_27_0
		arg_27_0._hasDraggedAngle = arg_27_0._hasDraggedAngle + var_27_1
	end

	if arg_27_0._hasDraggedAngle >= var_0_8 then
		arg_27_0._dragEnabled = false

		arg_27_0:_saveState(var_0_7.DraggedDone)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_reset_20234006)
		arg_27_0:_playAnim_Rudder_click()
	end
end

function var_0_0._onDragEnd(arg_28_0)
	arg_28_0:_clearFrameTimer()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)

	if not arg_28_0:_canDrag() then
		return
	end
end

function var_0_0._resetRudder(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_1 = arg_29_1 or 0.7

	GameUtil.onDestroyViewMember_TweenId(arg_29_0, "_tweener")

	arg_29_0._tweener = var_0_5.DOLocalRotate(arg_29_0._rudderTran, 0, 0, 0, arg_29_1, arg_29_2, arg_29_3, nil, EaseType.OutCirc)
end

function var_0_0._playAnim_Rudder(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0._firstAnimator.enabled = true

	arg_30_0._firstAnimPlayer:Play(arg_30_1, arg_30_2, arg_30_3)
end

function var_0_0._playAnim_Icon(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0:_setActive_icon(true)

	arg_31_0._iconAnimator.enabled = true

	arg_31_0._iconAnimPlayer:Play(arg_31_1, arg_31_2, arg_31_3)
end

function var_0_0._playAnim_Rudder_idle(arg_32_0)
	arg_32_0._firstAnimator.enabled = true

	arg_32_0._firstAnimator:Play(UIAnimationName.Idle, 0, 1)
	arg_32_0._firstAnimator:Update(0)

	arg_32_0._firstAnimator.enabled = false
end

function var_0_0._playAnim_Rudder_click(arg_33_0)
	arg_33_0:_playAnim_Rudder(UIAnimationName.Click, arg_33_0._onAfterClickAnim, arg_33_0)
end

function var_0_0._onAfterClickAnim(arg_34_0)
	arg_34_0._needWaitCount = 2

	arg_34_0:_playAnim_Rudder(UIAnimationName.Close, arg_34_0._onFinishAnim, arg_34_0)
	arg_34_0:_playAnim_Icon(UIAnimationName.In, arg_34_0._onFinishAnim, arg_34_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_taskinterface_2000011)
end

function var_0_0._onFinishAnim(arg_35_0)
	arg_35_0._needWaitCount = arg_35_0._needWaitCount - 1

	if arg_35_0._needWaitCount > 0 then
		return
	end

	arg_35_0:_saveStateDone(true)
	arg_35_0.viewContainer:openDesc()
end

local var_0_9 = 3
local var_0_10 = 1e-06

function var_0_0._checkIsDragging(arg_36_0)
	if arg_36_0._checkDraggingCount == var_0_9 then
		arg_36_0:_clearFrameTimer()
	elseif arg_36_0._checkDraggingCount < var_0_9 then
		arg_36_0._checkDraggingCount = math.abs(arg_36_0._lastDraggedAngle - arg_36_0._hasDraggedAngle) < var_0_10 and arg_36_0._checkDraggingCount + 1 or 0
		arg_36_0._lastDraggedAngle = arg_36_0._hasDraggedAngle
	end
end

function var_0_0._createFTimer(arg_37_0)
	if not arg_37_0._fTimer then
		arg_37_0._fTimer = FrameTimerController.instance:register(arg_37_0._checkIsDragging, arg_37_0, 3, 9)

		arg_37_0._fTimer:Start()
	end
end

function var_0_0._clearFrameTimer(arg_38_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
	FrameTimerController.onDestroyViewMember(arg_38_0, "_fTimer")

	arg_38_0._checkDraggingCount = 0
	arg_38_0._lastDraggedAngle = arg_38_0._hasDraggedAngle
end

return var_0_0
