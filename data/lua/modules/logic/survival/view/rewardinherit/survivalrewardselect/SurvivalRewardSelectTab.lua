module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectTab", package.seeall)

local var_0_0 = class("SurvivalRewardSelectTab", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_num")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_num/#txt_num")
	arg_1_0._btntab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tab")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btntab, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	arg_3_0.index = arg_3_1.index
	arg_3_0.handbookType = arg_3_1.handbookType
	arg_3_0.onClickTabCallBack = arg_3_1.onClickTabCallBack
	arg_3_0.onClickTabContext = arg_3_1.onClickTabContext

	arg_3_0:refreshAmount()
end

function var_0_0.refreshAmount(arg_4_0)
	local var_4_0 = SurvivalRewardInheritModel.instance:getSelectNum(arg_4_0.handbookType, nil)

	if var_4_0 > 0 then
		gohelper.setActive(arg_4_0._gonum, true)

		arg_4_0._txtnum.text = var_4_0
	else
		gohelper.setActive(arg_4_0._gonum, false)
	end
end

function var_0_0.onClickBtnClick(arg_5_0)
	if arg_5_0.onClickTabCallBack then
		arg_5_0.onClickTabCallBack(arg_5_0.onClickTabContext, arg_5_0)
	end
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	arg_6_0.isSelect = arg_6_1

	gohelper.setActive(arg_6_0._goselect, arg_6_0.isSelect)
end

return var_0_0
