module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day1", package.seeall)

local var_0_0 = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local var_0_1 = class("V2a2_WarmUpLeftView_Day1", var_0_0)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._btn1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "before/#btn_1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "before/#simage_icon1")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "after/#simage_icon2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btn1:AddClickListener(arg_2_0._btn1OnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btn1:RemoveClickListener()
end

local var_0_2 = {
	Clicked = 1
}

function var_0_1._btn1OnClick(arg_4_0)
	arg_4_0:_setActive_guide(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220215)
end

function var_0_1.ctor(arg_5_0, arg_5_1)
	var_0_0.ctor(arg_5_0, arg_5_1)

	arg_5_0._dragEnabled = false
	arg_5_0._needWaitCount = 0
	arg_5_0._drag = UIDragListenerHelper.New()
end

function var_0_1._editableInitView(arg_6_0)
	var_0_0._editableInitView(arg_6_0)

	arg_6_0._guideGo = gohelper.findChild(arg_6_0.viewGO, "guide_day1")
	arg_6_0._startGo = arg_6_0._btn1.gameObject
	arg_6_0._startTrans = arg_6_0._startGo.transform
	arg_6_0._startX, arg_6_0._startY = recthelper.getAnchor(arg_6_0._startTrans)
	arg_6_0._endGo = gohelper.findChild(arg_6_0.viewGO, "before/img_xieqian1")
	arg_6_0._endTrans = gohelper.findChild(arg_6_0.viewGO, "before/#go_dragEnd").transform
	arg_6_0._towardDir = Vector3.Normalize(arg_6_0._endTrans.position - arg_6_0._startTrans.position)

	arg_6_0._drag:create(arg_6_0._startGo)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventBegin, arg_6_0._onBeginDrag, arg_6_0)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventDragging, arg_6_0._onDrag, arg_6_0)
	arg_6_0._drag:registerCallback(arg_6_0._drag.EventEnd, arg_6_0._onEndDrag, arg_6_0)
end

function var_0_1._checkCanDrag(arg_7_0)
	return not arg_7_0:_canDrag()
end

function var_0_1._canDrag(arg_8_0)
	return arg_8_0._dragEnabled
end

function var_0_1._onBeginDrag(arg_9_0)
	if not arg_9_0:_canDrag() then
		return
	end

	var_0_0._onDragBegin(arg_9_0)
	arg_9_0:playAnimRaw_before_click(0, 0)
end

function var_0_1._onDrag(arg_10_0, arg_10_1)
	if not arg_10_0:_canDrag() then
		return
	end

	arg_10_1:tweenToMousePosWithConstrainedDirV2(arg_10_0._towardDir, arg_10_0._endTrans)

	local var_10_0 = recthelper.uiPosToScreenPos(arg_10_1:transform())

	if gohelper.isMouseOverGo(arg_10_0._endTrans, var_10_0) then
		arg_10_0._dragEnabled = false

		arg_10_0:saveState(var_0_2.Clicked)
		arg_10_0:setPosToEnd(arg_10_0._endTrans, arg_10_1:transform(), true, nil, arg_10_0._onStateClicked, arg_10_0)
	end
end

function var_0_1._onStateClicked(arg_11_0)
	arg_11_0:playAnim_before_finish(arg_11_0._finish_before_doneCb, arg_11_0)
end

function var_0_1._finish_before_doneCb(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220216)

	arg_12_0._needWaitCount = 2

	arg_12_0:playAnim_before_out(arg_12_0._onAfterDone, arg_12_0)
	arg_12_0:playAnim_after_in(arg_12_0._onAfterDone, arg_12_0)
end

function var_0_1._onAfterDone(arg_13_0)
	arg_13_0._needWaitCount = arg_13_0._needWaitCount - 1

	if arg_13_0._needWaitCount > 0 then
		return
	end

	arg_13_0:markIsFinishedInteractive(true)
	arg_13_0:saveStateDone(true)
	arg_13_0:setActive_before(false)
	arg_13_0:setActive_after(true)
	arg_13_0:openDesc()
end

function var_0_1._onEndDrag(arg_14_0)
	if not arg_14_0:_canDrag() then
		return
	end

	arg_14_0:playAnimRaw_before_click_r(0, 0)
	arg_14_0:tweenAnchorPos(arg_14_0._startTrans, arg_14_0._startX, arg_14_0._startY)
end

function var_0_1.onDestroyView(arg_15_0)
	GameUtil.onDestroyViewMember(arg_15_0, "_drag")
	var_0_0.onDestroyView(arg_15_0)
end

function var_0_1.setData(arg_16_0)
	var_0_0.setData(arg_16_0)

	local var_16_0 = arg_16_0:checkIsDone()

	arg_16_0:setActive_before(not var_16_0)
	arg_16_0:setActive_after(var_16_0)

	if var_16_0 then
		arg_16_0._dragEnabled = false
	else
		local var_16_1 = arg_16_0:getState()

		if var_16_1 == 0 then
			arg_16_0._dragEnabled = true

			recthelper.setAnchor(arg_16_0._startTrans, arg_16_0._startX, arg_16_0._startY)
			arg_16_0:playAnimRaw_before_idle(0, 1)
		elseif var_0_2.Clicked == var_16_1 then
			arg_16_0._dragEnabled = false

			arg_16_0:setPosToEnd(arg_16_0._endTrans, arg_16_0._startTrans)
			arg_16_0:_onStateClicked()
		else
			logError("[V2a2_WarmUpLeftView_Day1] invalid state:" .. var_16_1)
		end
	end
end

return var_0_1
