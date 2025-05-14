module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", package.seeall)

local var_0_0 = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local var_0_1 = class("V2a2_WarmUpLeftView_Day5", var_0_0)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "before/#simage_icon1")
	arg_1_0._goValidArea = gohelper.findChild(arg_1_0.viewGO, "before/#go_ValidArea")
	arg_1_0._btn1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "before/#btn_1")
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
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220226)
end

function var_0_1.ctor(arg_5_0, arg_5_1)
	var_0_0.ctor(arg_5_0, arg_5_1)

	arg_5_0._dragEnabled = false
	arg_5_0._needWaitCount = 0
end

function var_0_1._editableInitView(arg_6_0)
	var_0_0._editableInitView(arg_6_0)

	arg_6_0._guideGo = gohelper.findChild(arg_6_0.viewGO, "guide_day5")
	arg_6_0._startGo = arg_6_0._btn1.gameObject
	arg_6_0._startTrans = arg_6_0._startGo.transform
	arg_6_0._startX, arg_6_0._startY = recthelper.getAnchor(arg_6_0._startTrans)
	arg_6_0._startAnimation = arg_6_0._startGo:GetComponent(gohelper.Type_Animation)
	arg_6_0._endGo = arg_6_0._goValidArea
	arg_6_0._endTrans = arg_6_0._endGo.transform

	CommonDragHelper.instance:registerDragObj(arg_6_0._startGo, arg_6_0._onBeginDrag, arg_6_0._onDrag, arg_6_0._onEndDrag, arg_6_0._checkCanDrag, arg_6_0)
end

function var_0_1.onDestroyView(arg_7_0)
	CommonDragHelper.instance:unregisterDragObj(arg_7_0._startGo)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)
	var_0_0.onDestroyView(arg_7_0)
end

function var_0_1._checkCanDrag(arg_8_0)
	return not arg_8_0:_canDrag()
end

function var_0_1._canDrag(arg_9_0)
	return arg_9_0._dragEnabled
end

function var_0_1._onBeginDrag(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:_canDrag() then
		return
	end

	arg_10_0._startAnimation.enabled = false

	var_0_0._onDragBegin(arg_10_0)
end

function var_0_1._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0:_canDrag() then
		return
	end

	if gohelper.isMouseOverGo(arg_11_0._endTrans, arg_11_2.position) then
		CommonDragHelper.instance:setGlobalEnabled(false)

		arg_11_0._dragEnabled = false

		arg_11_0:saveState(var_0_2.Clicked)
		arg_11_0:_onStateClicked()
	end
end

function var_0_1._onEndDrag(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0:_canDrag() then
		return
	end

	arg_12_0:tweenAnchorPos(arg_12_0._startTrans, arg_12_0._startX, arg_12_0._startY)
end

function var_0_1._onStateClicked(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_cut_loop_20220227)
	arg_13_0:playAnim_before_click(arg_13_0._click_before_doneCb, arg_13_0)
end

function var_0_1._click_before_doneCb(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)

	arg_14_0._needWaitCount = 2

	arg_14_0:playAnim_before_out(arg_14_0._onAfterDone, arg_14_0)
	arg_14_0:playAnim_after_in(arg_14_0._onAfterDone, arg_14_0)
end

function var_0_1._onAfterDone(arg_15_0)
	arg_15_0._needWaitCount = arg_15_0._needWaitCount - 1

	if arg_15_0._needWaitCount > 0 then
		return
	end

	arg_15_0:saveStateDone(true)
	arg_15_0:setActive_before(false)
	arg_15_0:setActive_after(true)
	arg_15_0:openDesc()
end

function var_0_1.setData(arg_16_0)
	var_0_0.setData(arg_16_0)

	local var_16_0 = arg_16_0:checkIsDone()

	arg_16_0:setActive_before(not var_16_0)
	arg_16_0:setActive_after(var_16_0)
	arg_16_0:playAnimRaw_before_idle(0, 1)

	arg_16_0._startAnimation.enabled = true

	if var_16_0 then
		arg_16_0._dragEnabled = false
	else
		local var_16_1 = arg_16_0:getState()

		if var_16_1 == 0 then
			arg_16_0._dragEnabled = true

			recthelper.setAnchor(arg_16_0._startTrans, arg_16_0._startX, arg_16_0._startY)
		elseif var_0_2.Clicked == var_16_1 then
			arg_16_0._dragEnabled = false

			arg_16_0:_onStateClicked()
		else
			logError("[V2a2_WarmUpLeftView_Day5] invalid state:" .. var_16_1)
		end
	end
end

return var_0_1
