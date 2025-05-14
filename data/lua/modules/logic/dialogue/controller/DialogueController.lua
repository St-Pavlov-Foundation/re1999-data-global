module("modules.logic.dialogue.controller.DialogueController", package.seeall)

local var_0_0 = class("DialogueController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterDialogue(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	ViewMgr.instance:openView(ViewName.DialogueView, {
		dialogueId = arg_3_1,
		callback = arg_3_2,
		callbackTarget = arg_3_3
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
