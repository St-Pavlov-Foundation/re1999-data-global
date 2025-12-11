module("modules.logic.survival.view.handbook.tab.SurvivalHandbookViewTab", package.seeall)

local var_0_0 = class("SurvivalHandbookViewTab", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0.go_unselect = gohelper.findChild(arg_1_1, "#go_unselect")
	arg_1_0.unselect_go_unfinish = gohelper.findChild(arg_1_0.go_unselect, "#go_unfinish")
	arg_1_0.unselect_go_finished = gohelper.findChild(arg_1_0.go_unselect, "#go_finished")
	arg_1_0.unselect_txt_num = gohelper.findChildTextMesh(arg_1_0.unselect_go_unfinish, "#txt_num")
	arg_1_0.unselect_go_redDot = gohelper.findChild(arg_1_0.go_unselect, "#go_redDot")
	arg_1_0.go_select = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0.select_go_unfinish = gohelper.findChild(arg_1_0.go_select, "#go_unfinish")
	arg_1_0.select_go_finished = gohelper.findChild(arg_1_0.go_select, "#go_finished")
	arg_1_0.select_txt_num = gohelper.findChildTextMesh(arg_1_0.select_go_unfinish, "#txt_num")
	arg_1_0.select_go_redDot = gohelper.findChild(arg_1_0.go_select, "#go_redDot")

	arg_1_0:setSelect(false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onClickBtnClick(arg_4_0)
	if arg_4_0.onClickTabCallBack then
		arg_4_0.onClickTabCallBack(arg_4_0.onClickTabContext, arg_4_0)
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0.type = arg_5_1.type
	arg_5_0.index = arg_5_1.index
	arg_5_0.onClickTabCallBack = arg_5_1.onClickTabCallBack
	arg_5_0.onClickTabContext = arg_5_1.onClickTabContext

	local var_5_0 = SurvivalHandbookModel.instance.handbookTypeCfg[arg_5_0.type].RedDot

	RedDotController.instance:addRedDot(arg_5_0.unselect_go_redDot, var_5_0, -1)
	RedDotController.instance:addRedDot(arg_5_0.select_go_redDot, var_5_0, -1)

	local var_5_1 = SurvivalHandbookModel.instance:getProgress(arg_5_0.type)

	arg_5_0.unselect_txt_num.text = string.format("<#FFFFFF><size=50>%s</size></color>/%s", var_5_1.progress, var_5_1.amount)
	arg_5_0.select_txt_num.text = string.format("<size=50>%s</size>/%s", var_5_1.progress, var_5_1.amount)
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	arg_6_0.isSelect = arg_6_1

	gohelper.setActive(arg_6_0.go_unselect, not arg_6_0.isSelect)
	gohelper.setActive(arg_6_0.go_select, arg_6_0.isSelect)
end

return var_0_0
