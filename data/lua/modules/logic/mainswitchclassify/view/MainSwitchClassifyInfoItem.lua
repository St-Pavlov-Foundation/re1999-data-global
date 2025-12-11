module("modules.logic.mainswitchclassify.view.MainSwitchClassifyInfoItem", package.seeall)

local var_0_0 = class("MainSwitchClassifyInfoItem", MainSwitchClassifyItem)

function var_0_0.initInternal(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._view = arg_1_2
	arg_1_0._viewContainer = arg_1_0._view.viewContainer
	arg_1_0._goreddot = gohelper.findChild(arg_1_0._go, "reddot")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0._index = arg_2_1.Sort

	arg_2_0:setTxt(luaLang(arg_2_1.Title))

	local var_2_0 = #MainSwitchClassifyListModel.instance:getList()

	arg_2_0:showLine(var_2_0 > arg_2_0._index)

	local var_2_1 = arg_2_0:_checkReddot()

	gohelper.setActive(arg_2_0._goreddot, var_2_1)
end

function var_0_0._btnclickOnClick(arg_3_0)
	var_0_0.super._btnclickOnClick(arg_3_0)
	MainSwitchClassifyListModel.instance:selectCell(arg_3_0._index, true)
	arg_3_0._viewContainer:switchClassifyTab(arg_3_0._index)

	if arg_3_0._mo.Classify == MainSwitchClassifyEnum.Classify.Click and ClickUISwitchModel.instance:hasReddot() then
		ClickUISwitchModel.instance:cancelReddot()
		ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.CancelReddot)
		MainSwitchClassifyListModel.instance:onModelUpdate()
	end
end

function var_0_0._checkReddot(arg_4_0)
	if arg_4_0._mo.Classify == MainSwitchClassifyEnum.Classify.Click and ClickUISwitchModel.instance:hasReddot() then
		return true
	end
end

return var_0_0
