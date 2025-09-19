module("modules.logic.survival.view.SurvivalItemInfoView", package.seeall)

local var_0_0 = class("SurvivalItemInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.infoPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.viewGO, SurvivalBagInfoPart)

	arg_1_0.infoPart:setCloseShow(true, arg_1_0.onClickClose, arg_1_0)
	arg_1_0.infoPart:setIsShowEmpty(true)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.itemMo = arg_7_0.viewParam and arg_7_0.viewParam.itemMo
	arg_7_0.goPanel = arg_7_0.viewParam and arg_7_0.viewParam.goPanel
end

function var_0_0.refreshView(arg_8_0)
	if arg_8_0.goPanel then
		local var_8_0, var_8_1, var_8_2 = transformhelper.getPos(arg_8_0.goPanel.transform)

		transformhelper.setPos(arg_8_0.viewGO.transform, var_8_0, var_8_1, var_8_2)
	end

	arg_8_0.infoPart:updateMo(arg_8_0.itemMo)
end

return var_0_0
