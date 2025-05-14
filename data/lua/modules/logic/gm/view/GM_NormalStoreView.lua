module("modules.logic.gm.view.GM_NormalStoreView", package.seeall)

local var_0_0 = class("GM_NormalStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._item1Toggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item1/Toggle")
	arg_1_0._item2Toggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item2/Toggle")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._item1Toggle:AddOnValueChanged(arg_2_0._onItem1ToggleValueChanged, arg_2_0)
	arg_2_0._item2Toggle:AddOnValueChanged(arg_2_0._onItem2ToggleValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._item1Toggle:RemoveOnValueChanged()
	arg_3_0._item2Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshItem1()
	arg_4_0:_refreshItem2()
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_6_0)
	local var_6_0 = var_0_0.s_ShowAllTabId

	arg_6_0._item1Toggle.isOn = var_6_0
end

function var_0_0._onItem1ToggleValueChanged(arg_7_0)
	local var_7_0 = arg_7_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_7_0

	GMController.instance:dispatchEvent(GMEvent.NormalStoreView_ShowAllTabIdUpdate, var_7_0)
end

var_0_0.s_ShowAllGoodsId = false

function var_0_0._refreshItem2(arg_8_0)
	local var_8_0 = var_0_0.s_ShowAllGoodsId

	arg_8_0._item2Toggle.isOn = var_8_0
end

function var_0_0._onItem2ToggleValueChanged(arg_9_0)
	local var_9_0 = arg_9_0._item2Toggle.isOn

	var_0_0.s_ShowAllGoodsId = var_9_0

	GMController.instance:dispatchEvent(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, var_9_0)
end

return var_0_0
