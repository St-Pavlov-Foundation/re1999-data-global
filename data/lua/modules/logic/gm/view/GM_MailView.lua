module("modules.logic.gm.view.GM_MailView", package.seeall)

local var_0_0 = class("GM_MailView", BaseView)
local var_0_1 = string.format
local var_0_2 = "#FFFF00"
local var_0_3 = "#FF0000"
local var_0_4 = "#00FF00"
local var_0_5 = "#0000FF"

function var_0_0.register()
	var_0_0.MailView_register(MailView)
	var_0_0.MailCategoryListItem_register(MailCategoryListItem)
end

function var_0_0.MailView_register(arg_2_0)
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
		GM_MailViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_MailViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		MailCategroyModel.instance:onModelUpdate()
	end
end

function var_0_0.MailCategoryListItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "_refreshInfo")

	function arg_7_0._refreshInfo(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "_refreshInfo", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_8_0 = arg_8_0._mo
		local var_8_1 = var_0_1("mailId=%s", gohelper.getRichColorText(var_8_0.mailId, var_0_3))
		local var_8_2 = var_0_1("mailId=%s", gohelper.getRichColorText(var_8_0.mailId, var_0_2))
		local var_8_3 = var_0_1("incr=%s", gohelper.getRichColorText(var_8_0.id, var_0_5))
		local var_8_4 = var_0_1("incr=%s", gohelper.getRichColorText(var_8_0.id, var_0_4))

		arg_8_0._txtmailTitleSelect.text = var_8_2
		arg_8_0._txtmailTitleUnSelect.text = var_8_1
		arg_8_0._txtmailTimeSelect.text = var_8_4
		arg_8_0._txtmailTimeUnSelect.text = var_8_3
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

	GMController.instance:dispatchEvent(GMEvent.MailView_ShowAllTabIdUpdate, var_15_0)
end

return var_0_0
