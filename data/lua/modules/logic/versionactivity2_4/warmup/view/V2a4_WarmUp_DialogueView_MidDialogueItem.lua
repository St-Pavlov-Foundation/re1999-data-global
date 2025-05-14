module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_MidDialogueItem", package.seeall)

local var_0_0 = class("V2a4_WarmUp_DialogueView_MidDialogueItem", V2a4_WarmUpDialogueItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#txt_content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._txtGo = arg_5_0._txtcontent.gameObject
	arg_5_0._txtTrans = arg_5_0._txtGo.transform
	arg_5_0._oriTxtHeight = recthelper.getHeight(arg_5_0._txtTrans)
	arg_5_0._oriTxtWidth = recthelper.getWidth(arg_5_0._txtTrans)
end

function var_0_0.getTemplateGo(arg_6_0)
	return arg_6_0:parent()._gomiddialogueItem
end

function var_0_0.setData(arg_7_0, arg_7_1)
	var_0_0.super.setData(arg_7_0, arg_7_1)

	local var_7_0 = arg_7_1.dialogCO
	local var_7_1 = V2a4_WarmUpConfig.instance:getDialogDesc(var_7_0)

	arg_7_0:setText(var_7_1)
	arg_7_0:onFlush()
end

function var_0_0.onDestroyView(arg_8_0)
	var_0_0.super.onDestroyView(arg_8_0)
end

function var_0_0.onRefreshLineInfo(arg_9_0)
	local var_9_0 = arg_9_0:preferredHeightTxt()

	recthelper.setSize(arg_9_0._txtTrans, arg_9_0._oriTxtWidth, var_9_0)
	arg_9_0:addContentItem(var_9_0)
	arg_9_0:stepEnd()
end

function var_0_0.setGray(arg_10_0, arg_10_1)
	arg_10_0:grayscale(arg_10_1, arg_10_0._txtGo)
end

return var_0_0
