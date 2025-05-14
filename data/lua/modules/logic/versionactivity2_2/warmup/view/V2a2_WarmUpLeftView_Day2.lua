module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", package.seeall)

local var_0_0 = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local var_0_1 = class("V2a2_WarmUpLeftView_Day2", var_0_0)

function var_0_1.onInitView(arg_1_0)
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

function var_0_1._btn1OnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)

	if not arg_4_0._allowClick then
		return
	end

	arg_4_0:markGuided()
	arg_4_0:_setActive_guide(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_horn_20220218)
	arg_4_0:playAnim_before_click(arg_4_0._click_before_doneCb, arg_4_0)
end

function var_0_1._click_before_doneCb(arg_5_0)
	arg_5_0._allowClick = false
	arg_5_0._needWaitCount = 2

	arg_5_0:playAnim_before_out(arg_5_0._onAfterDone, arg_5_0)
	arg_5_0:playAnim_after_in(arg_5_0._onAfterDone, arg_5_0)
end

function var_0_1._onAfterDone(arg_6_0)
	arg_6_0._needWaitCount = arg_6_0._needWaitCount - 1

	if arg_6_0._needWaitCount > 0 then
		return
	end

	arg_6_0:markIsFinishedInteractive(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220219)
	arg_6_0:saveStateDone(true)
	arg_6_0:setActive_before(false)
	arg_6_0:setActive_after(true)
	arg_6_0:openDesc()
end

function var_0_1.ctor(arg_7_0, arg_7_1)
	var_0_0.ctor(arg_7_0, arg_7_1)

	arg_7_0._needWaitCount = 0
	arg_7_0._allowClick = false
end

function var_0_1._editableInitView(arg_8_0)
	var_0_0._editableInitView(arg_8_0)

	arg_8_0._guideGo = gohelper.findChild(arg_8_0.viewGO, "guide_day2")
	arg_8_0._click_after = gohelper.getClick(arg_8_0._simageicon2.gameObject)

	arg_8_0._click_after:AddClickListener(arg_8_0._onclick_after, arg_8_0)
end

function var_0_1._onclick_after(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)
end

function var_0_1.onDestroyView(arg_10_0)
	var_0_0.onDestroyView(arg_10_0)
	arg_10_0._click_after:RemoveClickListener()
end

function var_0_1.setData(arg_11_0)
	var_0_0.setData(arg_11_0)

	local var_11_0 = arg_11_0:checkIsDone()

	if not var_11_0 then
		arg_11_0:playAnimRaw_before_idle(0, 1)
	end

	arg_11_0._allowClick = not var_11_0

	arg_11_0:setActive_before(not var_11_0)
	arg_11_0:setActive_after(var_11_0)
end

return var_0_1
