module("modules.logic.dialogue.view.items.DialogueOptionItem", package.seeall)

local var_0_0 = class("DialogueOptionItem", DialogueItem)

function var_0_0.initView(arg_1_0)
	arg_1_0.goOptionItem = gohelper.findChild(arg_1_0.go, "#go_suboptionitem")

	gohelper.setActive(arg_1_0.goOptionItem, false)

	arg_1_0.optionList = GameUtil.splitString2(arg_1_0.stepCo.content, false)
	arg_1_0.optionItemList = {}
	arg_1_0.handled = false
end

function var_0_0.refresh(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.optionList) do
		arg_2_0:createOption(iter_2_1[1], tonumber(iter_2_1[2]))
	end
end

function var_0_0.createOption(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getUserDataTb_()

	var_3_0.go = gohelper.cloneInPlace(arg_3_0.goOptionItem)
	var_3_0.btn = gohelper.findChildButton(var_3_0.go, "#btn_suboption")
	var_3_0.txtOption = gohelper.findChildText(var_3_0.go, "#btn_suboption/#txt_suboption")
	var_3_0.txtOption.text = arg_3_1
	var_3_0.goBtn = var_3_0.btn.gameObject

	var_3_0.btn:AddClickListener(arg_3_0.onClickOption, arg_3_0, arg_3_2)

	var_3_0.jumpStepId = arg_3_2

	gohelper.setActive(var_3_0.go, true)
	table.insert(arg_3_0.optionItemList, var_3_0)
end

function var_0_0.onClickOption(arg_4_0, arg_4_1)
	if arg_4_0.handled then
		return
	end

	arg_4_0.handled = true

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.optionItemList) do
		ZProj.UGUIHelper.SetGrayscale(iter_4_1.goBtn, arg_4_1 ~= iter_4_1.jumpStepId)
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.OnClickOption, arg_4_1)
end

function var_0_0.calculateHeight(arg_5_0)
	ZProj.UGUIHelper.RebuildLayout(arg_5_0.go.transform)

	arg_5_0.height = recthelper.getHeight(arg_5_0.go.transform)
end

function var_0_0.onDestroy(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.optionItemList) do
		iter_6_1.btn:RemoveClickListener()
	end
end

return var_0_0
