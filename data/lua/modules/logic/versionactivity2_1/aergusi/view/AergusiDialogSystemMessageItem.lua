module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogSystemMessageItem", package.seeall)

local var_0_0 = class("AergusiDialogSystemMessageItem", AergusiDialogItem)
local var_0_1 = -4.18611

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.initView(arg_2_0)
	arg_2_0._txtSystemMessage = gohelper.findChildText(arg_2_0.go, "#txt_systemmessage")
	arg_2_0._goline = gohelper.findChild(arg_2_0.go, "line")
	arg_2_0._txtSystemMessageGrey = gohelper.findChildText(arg_2_0.go, "#txt_systemmessage_grey")
	arg_2_0._golinegrey = gohelper.findChild(arg_2_0.go, "line_grey")
	arg_2_0.go.name = string.format("systemmessageitem_%s_%s", arg_2_0.stepCo.id, arg_2_0.stepCo.stepId)
	arg_2_0._txtSystemMessageMarkTopIndex = arg_2_0:createMarktopCmp(arg_2_0._txtSystemMessage)
	arg_2_0._txtSystemMessageGreyMarkTopIndex = arg_2_0:createMarktopCmp(arg_2_0._txtSystemMessageGrey)

	arg_2_0:setTopOffset(arg_2_0._txtSystemMessageMarkTopIndex, 0, var_0_1)
	arg_2_0:setTopOffset(arg_2_0._txtSystemMessageGreyMarkTopIndex, 0, var_0_1)
end

function var_0_0.refresh(arg_3_0)
	local var_3_0 = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(arg_3_0._txtSystemMessage.gameObject, var_3_0 == arg_3_0.stepCo.id)
	gohelper.setActive(arg_3_0._txtSystemMessageGrey.gameObject, var_3_0 ~= arg_3_0.stepCo.id)
	gohelper.setActive(arg_3_0._goline, var_3_0 == arg_3_0.stepCo.id)
	gohelper.setActive(arg_3_0._golinegrey, var_3_0 ~= arg_3_0.stepCo.id)

	if var_3_0 == arg_3_0.stepCo.id then
		arg_3_0:setTextWithMarktopByIndex(arg_3_0._txtSystemMessageMarkTopIndex, arg_3_0.stepCo.content)
	else
		arg_3_0:setTextWithMarktopByIndex(arg_3_0._txtSystemMessageGreyMarkTopIndex, arg_3_0.stepCo.content)
	end
end

function var_0_0.calculateHeight(arg_4_0)
	arg_4_0.height = AergusiEnum.MinHeight[arg_4_0.type]
end

function var_0_0.onDestroy(arg_5_0)
	return
end

return var_0_0
