module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskItem", package.seeall)

local var_0_0 = class("AergusiDialogTaskItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._groupId = 0
	arg_1_0._txttarget2desc = gohelper.findChildText(arg_1_1, "#txt_target2desc")
	arg_1_0._goTargetFinished = gohelper.findChild(arg_1_1, "#go_TargetFinished")

	gohelper.setSibling(arg_1_1, 2)
	arg_1_0:_addEvents()
end

function var_0_0.hide(arg_2_0)
	gohelper.setActive(arg_2_0.go, false)
end

function var_0_0.setCo(arg_3_0, arg_3_1)
	arg_3_0._groupId = arg_3_1
end

function var_0_0.refreshItem(arg_4_0)
	gohelper.setActive(arg_4_0.go, false)

	local var_4_0 = AergusiConfig.instance:getEvidenceConfig(arg_4_0._groupId)

	if LuaUtil.getStrLen(var_4_0.conditionStr) == 0 then
		return
	end

	gohelper.setActive(arg_4_0.go, true)

	local var_4_1 = AergusiDialogModel.instance:getCurDialogGroup()

	if var_4_1 ~= arg_4_0._groupId then
		arg_4_0._txttarget2desc.text = string.format("<s>%s</s>", var_4_0.conditionStr)
	else
		arg_4_0._txttarget2desc.text = var_4_0.conditionStr
	end

	gohelper.setActive(arg_4_0._goTargetFinished, var_4_1 ~= arg_4_0._groupId)
end

function var_0_0._addEvents(arg_5_0)
	return
end

function var_0_0._removeEvents(arg_6_0)
	return
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:_removeEvents()
end

return var_0_0
