module("modules.logic.gm.view.GM_VersionActivity_EnterView", package.seeall)

local var_0_0 = class("GM_VersionActivity_EnterView", BaseView)

local function var_0_1()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_EnterView)
end

function var_0_0.VersionActivityX_XEnterView(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0, var_0_1)
		GM_VersionActivity_EnterViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_VersionActivity_EnterViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		arg_6_0:refreshUI()
	end
end

function var_0_0.VersionActivityEnterViewTabItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "refreshNameText")

	local var_7_0 = "#FFFF00"

	function arg_7_0.refreshNameText(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "refreshNameText", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_8_0 = arg_8_0.actId
		local var_8_1 = gohelper.getRichColorText(tostring(var_8_0), var_7_0)

		arg_8_0.activityNameTexts.select.text = var_8_1
		arg_8_0.activityNameTexts.normal.text = var_8_1
	end
end

function var_0_0.VersionActivityX_XEnterViewTabItemBase_register(arg_9_0)
	GMMinusModel.instance:saveOriginalFunc(arg_9_0, "afterSetData")

	local var_9_0 = "#FFFF00"

	function arg_9_0.afterSetData(arg_10_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_10_0, "afterSetData", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_10_0 = arg_10_0.activityCo.id
		local var_10_1 = gohelper.getRichColorText(tostring(var_10_0), var_9_0)

		arg_10_0.txtName.text = var_10_1
		arg_10_0.txtNameEn.text = var_10_1
	end
end

function var_0_0.onInitView(arg_11_0)
	arg_11_0._btnClose = gohelper.findChildButtonWithAudio(arg_11_0.viewGO, "btnClose")
	arg_11_0._item1Toggle = gohelper.findChildToggle(arg_11_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_12_0)
	arg_12_0._btnClose:AddClickListener(arg_12_0.closeThis, arg_12_0)
	arg_12_0._item1Toggle:AddOnValueChanged(arg_12_0._onItem1ToggleValueChanged, arg_12_0)
end

function var_0_0.removeEvents(arg_13_0)
	arg_13_0._btnClose:RemoveClickListener()
	arg_13_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_16_0)
	local var_16_0 = var_0_0.s_ShowAllTabId

	arg_16_0._item1Toggle.isOn = var_16_0
end

function var_0_0._onItem1ToggleValueChanged(arg_17_0)
	local var_17_0 = arg_17_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_17_0

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_EnterView_ShowAllTabIdUpdate, var_17_0)
end

return var_0_0
