module("modules.logic.gm.view.GM_ActivityBeginnerView", package.seeall)

local var_0_0 = class("GM_ActivityBeginnerView", BaseView)
local var_0_1 = "#FFFF00"

function var_0_0.register()
	var_0_0.ActivityBeginnerView_register(ActivityBeginnerView)
	var_0_0.ActivityCategoryItem_register(ActivityCategoryItem)
end

function var_0_0.ActivityBeginnerView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_ActivityBeginnerViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_ActivityBeginnerViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		ActivityBeginnerCategoryListModel.instance:onModelUpdate()
	end
end

function var_0_0.ActivityCategoryItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "_refreshItem")

	function arg_7_0._refreshItem(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "_refreshItem", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_8_0 = arg_8_0._mo.id
		local var_8_1 = gohelper.getRichColorText(var_8_0, var_0_1)

		arg_8_0._txtnamecn.text = var_8_1
		arg_8_0._txtunselectnamecn.text = var_8_1
	end
end

function var_0_0.onInitView(arg_9_0)
	arg_9_0._btnClose = gohelper.findChildButtonWithAudio(arg_9_0.viewGO, "btnClose")
	arg_9_0._item1Toggle = gohelper.findChildToggle(arg_9_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_10_0)
	arg_10_0._btnClose:AddClickListener(arg_10_0.closeThis, arg_10_0)
	arg_10_0._item1Toggle:AddOnValueChanged(arg_10_0._onItem1ToggleValueChanged, arg_10_0)
end

function var_0_0.removeEvents(arg_11_0)
	arg_11_0._btnClose:RemoveClickListener()
	arg_11_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_14_0)
	local var_14_0 = var_0_0.s_ShowAllTabId

	arg_14_0._item1Toggle.isOn = var_14_0
end

function var_0_0._onItem1ToggleValueChanged(arg_15_0)
	local var_15_0 = arg_15_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_15_0

	GMController.instance:dispatchEvent(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, var_15_0)
end

return var_0_0
