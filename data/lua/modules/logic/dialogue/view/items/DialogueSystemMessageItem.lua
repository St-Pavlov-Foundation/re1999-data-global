module("modules.logic.dialogue.view.items.DialogueSystemMessageItem", package.seeall)

local var_0_0 = class("DialogueSystemMessageItem", DialogueItem)

function var_0_0.initView(arg_1_0)
	arg_1_0.txtSystemMessage = gohelper.findChildText(arg_1_0.go, "#txt_systemmessage")
end

function var_0_0.refresh(arg_2_0)
	arg_2_0.txtSystemMessage.text = arg_2_0.stepCo.content
end

function var_0_0.calculateHeight(arg_3_0)
	arg_3_0.height = DialogueEnum.MinHeight[DialogueEnum.Type.SystemMessage]
end

function var_0_0.onDestroy(arg_4_0)
	return
end

return var_0_0
