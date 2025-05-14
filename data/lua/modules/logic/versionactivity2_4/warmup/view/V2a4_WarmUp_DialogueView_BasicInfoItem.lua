module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_BasicInfoItem", package.seeall)

local var_0_0 = class("V2a4_WarmUp_DialogueView_BasicInfoItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "bg/#txt_title")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")

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
	arg_4_0:__onInit()
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	arg_5_0:__onDispose()
end

function var_0_0.setData(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = V2a4_WarmUpConfig.instance:textInfoCO(var_6_0)

	arg_6_0._txttitle.text = var_6_1.name
	arg_6_0._txtdec.text = var_6_1.value
end

return var_0_0
