module("modules.logic.sp01.act205.view.Act205RuleTipsView", package.seeall)

local var_0_0 = class("Act205RuleTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_info")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#txt_desc")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.activityId = Act205Model.instance:getAct205Id()
	arg_8_0.gameStageId = Act205Model.instance:getGameStageId()

	local var_8_0 = Act205Config.instance:getStageConfig(arg_8_0.activityId, arg_8_0.gameStageId)

	arg_8_0._txttitle.text = var_8_0.ruleTitle
	arg_8_0._txtdesc.text = var_8_0.ruleDesc
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
