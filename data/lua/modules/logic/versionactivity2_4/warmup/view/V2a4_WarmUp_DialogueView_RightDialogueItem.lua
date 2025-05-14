module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_RightDialogueItem", package.seeall)

local var_0_0 = class("V2a4_WarmUp_DialogueView_RightDialogueItem", V2a4_WarmUpDialogueItemBase_LR)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "content_bg/#txt_content")
	arg_1_0._goloading = gohelper.findChild(arg_1_0.viewGO, "content_bg/#go_loading")

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

function var_0_0.getTemplateGo(arg_5_0)
	return arg_5_0:parent()._gorightdialogueitem
end

function var_0_0.onDestroyView(arg_6_0)
	var_0_0.super.onDestroyView(arg_6_0)
end

return var_0_0
