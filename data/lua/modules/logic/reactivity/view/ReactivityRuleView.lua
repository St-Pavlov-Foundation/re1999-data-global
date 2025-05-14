module("modules.logic.reactivity.view.ReactivityRuleView", package.seeall)

local var_0_0 = class("ReactivityRuleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_go")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Mask")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._onClickJump, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	ReactivityRuleModel.instance:refreshList()
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0._onClickJump(arg_9_0)
	JumpController.instance:jumpByParam("1#180")
end

function var_0_0._onClickClose(arg_10_0)
	arg_10_0:closeThis()
end

return var_0_0
