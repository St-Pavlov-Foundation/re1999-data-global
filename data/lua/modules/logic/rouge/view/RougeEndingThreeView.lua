module("modules.logic.rouge.view.RougeEndingThreeView", package.seeall)

local var_0_0 = class("RougeEndingThreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButton(arg_1_0.viewGO, "Content/#btn_next")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "Content/#go_success/txt_success")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Content/Title/#txt_Title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
end

function var_0_0._btnnextOnClick(arg_4_0)
	arg_4_0:closeThis()
	RougeController.instance:openRougeResultView()
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeTitle]
	local var_5_1 = var_5_0 and var_5_0.value2
	local var_5_2 = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeContent]
	local var_5_3 = var_5_2 and var_5_2.value2

	arg_5_0._txttitle.text = var_5_1
	arg_5_0._txtcontent.text = var_5_3
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenEndingThreeView)
end

return var_0_0
