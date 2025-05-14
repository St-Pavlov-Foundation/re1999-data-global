module("modules.logic.gm.view.GM_TaskListCommonItem", package.seeall)

local var_0_0 = class("GM_TaskListCommonItem", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._item1Toggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item1/Toggle")
	arg_1_0._item2Toggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item2/Toggle")
	arg_1_0._item3Btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item3/Button")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._item1Toggle:AddOnValueChanged(arg_2_0._onItem1ToggleValueChanged, arg_2_0)
	arg_2_0._item2Toggle:AddOnValueChanged(arg_2_0._onItem2ToggleValueChanged, arg_2_0)
	arg_2_0._item3Btn:AddClickListener(arg_2_0._onItem3Click, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._item1Toggle:RemoveOnValueChanged()
	arg_3_0._item2Toggle:RemoveOnValueChanged()
	arg_3_0._item3Btn:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshItem1()
	arg_4_0:_refreshItem2()
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0._refreshItem1(arg_6_0)
	local var_6_0 = arg_6_0.class.s_ShowAllTabId or false

	arg_6_0._item1Toggle.isOn = var_6_0
end

function var_0_0._onItem1ToggleValueChanged(arg_7_0)
	local var_7_0 = arg_7_0._item1Toggle.isOn
	local var_7_1 = arg_7_0.class

	if var_7_1.s_ShowAllTabId == var_7_0 then
		return
	end

	var_7_1.s_ShowAllTabId = var_7_0

	arg_7_0.viewContainer:_gm_showAllTabIdUpdate(var_7_0)
end

function var_0_0._refreshItem2(arg_8_0)
	local var_8_0 = arg_8_0.class.s_enableFinishSelectedTask or false

	arg_8_0._item2Toggle.isOn = var_8_0
end

function var_0_0._onItem2ToggleValueChanged(arg_9_0)
	local var_9_0 = arg_9_0._item2Toggle.isOn
	local var_9_1 = arg_9_0.class

	if var_9_1.s_enableFinishSelectedTask == var_9_0 then
		return
	end

	var_9_1.s_enableFinishSelectedTask = var_9_0

	arg_9_0.viewContainer:_gm_enableFinishOnSelect(var_9_0)
end

function var_0_0._onItem3Click(arg_10_0)
	arg_10_0.viewContainer:_gm_onClickFinishAll()
end

return var_0_0
