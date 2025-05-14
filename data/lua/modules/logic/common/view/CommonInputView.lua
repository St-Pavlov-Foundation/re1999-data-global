module("modules.logic.common.view.CommonInputView", package.seeall)

local var_0_0 = class("CommonInputView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._txtyes = gohelper.findChildText(arg_1_0.viewGO, "#btn_yes/#txt_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._txtno = gohelper.findChildText(arg_1_0.viewGO, "#btn_no/#txt_no")
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#input")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._input:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
	arg_2_0._input:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._input:RemoveOnEndEdit()
	arg_3_0._input:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_4_0._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	arg_5_0._txttitle.text = var_5_0.title
	arg_5_0._txtno.text = var_5_0.cancelBtnName
	arg_5_0._txtyes.text = var_5_0.sureBtnName

	arg_5_0._input:SetText(var_5_0.defaultInput)
end

function var_0_0._btnyesOnClick(arg_6_0)
	local var_6_0 = arg_6_0.viewParam

	if var_6_0.sureCallback then
		local var_6_1 = arg_6_0._input:GetText()

		if var_6_0.callbackObj then
			var_6_0.sureCallback(var_6_0.callbackObj, var_6_1)
		else
			var_6_0.sureCallback(var_6_1)
		end
	else
		arg_6_0:closeThis()
	end
end

function var_0_0._btnnoOnClick(arg_7_0)
	local var_7_0 = arg_7_0.viewParam

	arg_7_0:closeThis()

	if var_7_0.cancelCallback then
		var_7_0.cancelCallack(var_7_0.callbackObj)
	end
end

function var_0_0._onEndEdit(arg_8_0, arg_8_1)
	arg_8_1 = GameUtil.filterRichText(arg_8_1 or "")

	arg_8_0._input:SetText(arg_8_1)
end

function var_0_0._onValueChanged(arg_9_0)
	local var_9_0 = arg_9_0._input:GetText()
	local var_9_1 = string.gsub(var_9_0, "\n", "")
	local var_9_2 = GameUtil.getBriefName(var_9_1, arg_9_0.viewParam.characterLimit, "")

	arg_9_0._input:SetText(var_9_2)
end

return var_0_0
