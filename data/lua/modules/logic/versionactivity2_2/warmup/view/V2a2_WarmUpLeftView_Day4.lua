module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", package.seeall)

local var_0_0 = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local var_0_1 = class("V2a2_WarmUpLeftView_Day4", var_0_0)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "before/#simage_icon1")
	arg_1_0._btn1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "before/#btn_1")
	arg_1_0._btn2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "before/#btn_2")
	arg_1_0._btn3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "before/#btn_3")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "after/#simage_icon2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btn1:AddClickListener(arg_2_0._btn1OnClick, arg_2_0)
	arg_2_0._btn2:AddClickListener(arg_2_0._btn2OnClick, arg_2_0)
	arg_2_0._btn3:AddClickListener(arg_2_0._btn3OnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btn1:RemoveClickListener()
	arg_3_0._btn2:RemoveClickListener()
	arg_3_0._btn3:RemoveClickListener()
end

local var_0_2 = SLFramework.AnimatorPlayer

local function var_0_3(arg_4_0)
	local var_4_0 = ""

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_4_0 = (iter_4_1 and "1" or "0") .. var_4_0
	end

	return "_" .. var_4_0
end

local var_0_4 = {}
local var_0_5 = 0

local function var_0_6(...)
	local var_5_0 = {
		...
	}

	tabletool.revert(var_5_0)

	local var_5_1 = var_0_3(var_5_0)

	var_0_4[var_5_1] = var_0_5
	var_0_5 = var_0_5 + 1
end

local var_0_7 = false
local var_0_8 = true

var_0_6(var_0_7, var_0_7, var_0_7)
var_0_6(var_0_7, var_0_7, var_0_8)
var_0_6(var_0_7, var_0_8, var_0_7)
var_0_6(var_0_7, var_0_8, var_0_8)
var_0_6(var_0_8, var_0_7, var_0_7)
var_0_6(var_0_8, var_0_7, var_0_8)
var_0_6(var_0_8, var_0_8, var_0_7)
var_0_6(var_0_8, var_0_8, var_0_8)

function var_0_1._btn1OnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function var_0_1._btn2OnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function var_0_1._btn3OnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function var_0_1.ctor(arg_9_0, arg_9_1)
	var_0_0.ctor(arg_9_0, arg_9_1)

	arg_9_0._context = {
		needWaitCount = 0,
		dragEnabled = false
	}
end

function var_0_1._editableInitView(arg_10_0)
	var_0_0._editableInitView(arg_10_0)

	arg_10_0._guideGo = gohelper.findChild(arg_10_0.viewGO, "guide_day4")
	arg_10_0._startDefaultPosList = {}
	arg_10_0._startGoList = arg_10_0:getUserDataTb_()
	arg_10_0._endGoList = arg_10_0:getUserDataTb_()
	arg_10_0._startTransList = arg_10_0:getUserDataTb_()
	arg_10_0._endTransList = arg_10_0:getUserDataTb_()
	arg_10_0._startAnimPlayerList = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, 3 do
		local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "before/btn_highlight_" .. iter_10_0)
		local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "before/#btn_" .. iter_10_0)
		local var_10_2 = var_10_0.transform
		local var_10_3 = var_10_1.transform
		local var_10_4, var_10_5 = recthelper.getAnchor(var_10_3)
		local var_10_6 = var_0_2.Get(var_10_1)

		table.insert(arg_10_0._startDefaultPosList, {
			x = var_10_4,
			y = var_10_5
		})
		table.insert(arg_10_0._startGoList, var_10_1)
		table.insert(arg_10_0._endGoList, var_10_0)
		table.insert(arg_10_0._startTransList, var_10_3)
		table.insert(arg_10_0._endTransList, var_10_2)
		table.insert(arg_10_0._startAnimPlayerList, var_10_6)
		CommonDragHelper.instance:registerDragObj(var_10_1, arg_10_0._onBeginDrag, nil, arg_10_0._onEndDrag, arg_10_0._checkCanDrag, arg_10_0, iter_10_0)
	end
end

local var_0_9 = -313

function var_0_1._checkCanDrag(arg_11_0)
	local var_11_0 = not arg_11_0:_canDrag()

	if arg_11_0:_isDone3() and var_11_0 then
		GameFacade.showToast(var_0_9)
	end

	return var_11_0
end

function var_0_1._canDrag(arg_12_0)
	return arg_12_0._context.dragEnabled
end

function var_0_1._setDragEnabled(arg_13_0, arg_13_1)
	arg_13_0._context.dragEnabled = arg_13_1
end

function var_0_1._setActive_anim(arg_14_0, arg_14_1)
	arg_14_0._anim_before.enabled = arg_14_1
end

function var_0_1._onBeginDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:_canDrag() then
		return
	end

	arg_15_0:_setActive_anim(false)
	var_0_0._onDragBegin(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function var_0_1._onEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:_canDrag() then
		return
	end

	local var_16_0 = arg_16_0._startTransList[arg_16_1]
	local var_16_1 = arg_16_0._endTransList[arg_16_1]

	arg_16_0._context.lastDragIndex = arg_16_1

	arg_16_0:_setNeedWait(1)
	arg_16_0:setPosToEnd(var_16_1, var_16_0, true, nil, arg_16_0._setPostEndTweeen_doneCb, arg_16_0)
end

function var_0_1._setNeedWait(arg_17_0, arg_17_1)
	arg_17_0._context.needWaitCount = assert(tonumber(arg_17_1))
	arg_17_0._context.dragEnabled = false
end

function var_0_1._subNeedWait(arg_18_0)
	arg_18_0._context.needWaitCount = arg_18_0._context.needWaitCount - 1

	local var_18_0 = arg_18_0._context.needWaitCount > 0

	arg_18_0._context.dragEnabled = not var_18_0

	return var_18_0
end

function var_0_1._saveState(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:_getLastState()

	if var_19_0[arg_19_1] == true then
		return
	end

	var_19_0[arg_19_1] = true

	local var_19_1 = arg_19_0:_getState(var_19_0)

	arg_19_0:saveState(var_19_1)
end

function var_0_1._getState(arg_20_0, arg_20_1)
	local var_20_0 = var_0_3(arg_20_1 or arg_20_0:_getLastState())

	return var_0_4[var_20_0]
end

function var_0_1._setPostEndTweeen_doneCb(arg_21_0)
	if arg_21_0:_subNeedWait() then
		return
	end

	local var_21_0 = arg_21_0._context.lastDragIndex

	arg_21_0:_saveState(var_21_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_door_effect_put_20220224)
	arg_21_0:_onPutState(var_21_0, arg_21_0._onPut_doneCb, arg_21_0)
end

function var_0_1._onPutState(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0._startAnimPlayerList[arg_22_1]

	local function var_22_1(arg_23_0)
		local var_23_0 = arg_23_0._endGoList[arg_22_1]

		gohelper.setActive(var_23_0, false)

		if arg_22_2 then
			arg_22_2(arg_22_3)
		end
	end

	if not var_22_0.isActiveAndEnabled then
		var_22_1(arg_22_0)

		return
	end

	var_22_0:Play("put", var_22_1, arg_22_0)
end

function var_0_1._isDone3(arg_24_0)
	return arg_24_0:_getState() == var_0_4._111
end

function var_0_1._onPut_doneCb(arg_25_0)
	if arg_25_0:_subNeedWait() then
		return
	end

	if arg_25_0:_isDone3() and not arg_25_0:isFinishInteractive() then
		arg_25_0:markIsFinishedInteractive(true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220225)
		arg_25_0:_setDragEnabled(false)
		arg_25_0:_setNeedWait(2)
		arg_25_0:playAnim_before_out(arg_25_0._onAfterDone, arg_25_0)
		arg_25_0:playAnim_after_in(arg_25_0._onAfterDone, arg_25_0)
	end
end

function var_0_1._onAfterDone(arg_26_0)
	if arg_26_0:_subNeedWait() then
		return
	end

	arg_26_0:saveStateDone(true)
	arg_26_0:setActive_before(false)
	arg_26_0:setActive_after(true)
	arg_26_0:openDesc()
end

function var_0_1.onDestroyView(arg_27_0)
	var_0_0.onDestroyView(arg_27_0)

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._startGoList) do
		CommonDragHelper.instance:unregisterDragObj(iter_27_1)
	end
end

function var_0_1._getLastState(arg_28_0)
	local var_28_0 = arg_28_0:checkIsDone()

	if var_28_0 then
		arg_28_0._lastState = {
			var_0_8,
			var_0_8,
			var_0_8
		}

		return arg_28_0._lastState, var_28_0
	end

	if not arg_28_0._lastState then
		arg_28_0._lastState = {
			var_0_7,
			var_0_7,
			var_0_7
		}

		local var_28_1 = arg_28_0:getState(var_0_4._000)

		if var_0_4._001 == var_28_1 or var_0_4._011 == var_28_1 or var_0_4._101 == var_28_1 or var_0_4._111 == var_28_1 then
			arg_28_0._lastState[1] = true
		end

		if var_0_4._010 == var_28_1 or var_0_4._011 == var_28_1 or var_0_4._110 == var_28_1 or var_0_4._111 == var_28_1 then
			arg_28_0._lastState[2] = true
		end

		if var_0_4._100 == var_28_1 or var_0_4._101 == var_28_1 or var_0_4._110 == var_28_1 or var_0_4._111 == var_28_1 then
			arg_28_0._lastState[3] = true
		end
	end

	return arg_28_0._lastState, var_28_0
end

function var_0_1._setPosToDefault(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._startTransList[arg_29_1]
	local var_29_1 = arg_29_0._startDefaultPosList[arg_29_1]

	if arg_29_2 then
		arg_29_0:tweenAnchorPos(var_29_0, var_29_1.x, var_29_1.y)
	else
		recthelper.setAnchor(var_29_0, var_29_1.x, var_29_1.y)
	end
end

function var_0_1.setData(arg_30_0)
	var_0_0.setData(arg_30_0)

	local var_30_0, var_30_1 = arg_30_0:_getLastState()

	arg_30_0:setActive_before(not var_30_1)
	arg_30_0:setActive_after(var_30_1)
	arg_30_0:_setDragEnabled(not var_30_1)

	if not var_30_1 then
		local var_30_2 = 0

		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			local var_30_3 = arg_30_0._startTransList[iter_30_0]
			local var_30_4 = arg_30_0._endTransList[iter_30_0]
			local var_30_5 = arg_30_0._startGoList[iter_30_0]
			local var_30_6 = arg_30_0._endGoList[iter_30_0]

			gohelper.setActive(var_30_5, true)
			gohelper.setActive(var_30_6, not iter_30_1)

			if iter_30_1 then
				var_30_2 = var_30_2 + 1

				arg_30_0:setPosToEnd(var_30_4, var_30_3)
			else
				arg_30_0:_setPosToDefault(iter_30_0)
			end
		end

		if var_30_2 > 0 and var_30_2 == #var_30_0 then
			arg_30_0:_setActive_anim(true)
			arg_30_0:playAnimRaw_before_idle(0, 1)
			arg_30_0:_setNeedWait(3)

			for iter_30_2, iter_30_3 in ipairs(var_30_0) do
				arg_30_0:_onPutState(iter_30_2, arg_30_0._onPut_doneCb, arg_30_0)
			end

			arg_30_0:_setDragEnabled(false)
		end
	end
end

return var_0_1
