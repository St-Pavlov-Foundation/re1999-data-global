module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventItem", package.seeall)

local var_0_0 = class("AiZiLaGameEventItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goEnable = gohelper.findChild(arg_1_0.viewGO, "#go_Enable")
	arg_1_0._goDisable = gohelper.findChild(arg_1_0.viewGO, "#go_Disable")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo then
		AiZiLaGameController.instance:selectOption(arg_4_0._mo.optionId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	if not arg_9_0._mo then
		return
	end

	local var_9_0 = arg_9_0._mo.actId
	local var_9_1 = arg_9_0._mo.optionId
	local var_9_2 = arg_9_0._mo.eventType == AiZiLaEnum.EventType.BranchLine
	local var_9_3 = AiZiLaConfig.instance:getOptionCo(var_9_0, var_9_1)
	local var_9_4 = AiZiLaModel.instance:isSelectOptionId(var_9_1)
	local var_9_5 = var_9_3 and var_9_3.name or var_9_1

	if not var_9_2 and var_9_4 then
		var_9_5 = string.format("%s\n<color=#85541b>%s</color>", var_9_5, var_9_3 and var_9_3.optionDesc or var_9_1)
	end

	arg_9_0._txtname.text = var_9_5

	gohelper.setActive(arg_9_0._goEnable, not var_9_4)
	gohelper.setActive(arg_9_0._goEnable, not var_9_4)
	gohelper.setActive(arg_9_0._goDisable, var_9_4)
	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtname, var_9_4 and "#7c684f" or "#442a0d")
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
