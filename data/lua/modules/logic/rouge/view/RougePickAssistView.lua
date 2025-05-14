module("modules.logic.rouge.view.RougePickAssistView", package.seeall)

local var_0_0 = class("RougePickAssistView", PickAssistView)

function var_0_0.onOpen(arg_1_0)
	arg_1_0._capacityParams = RougeController.instance.pickAssistViewParams

	arg_1_0:_initCapacity()
	var_0_0.super.onOpen(arg_1_0)
end

function var_0_0._initCapacity(arg_2_0)
	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "bg/volume")

	arg_2_0._capacityComp = RougeCapacityComp.Add(var_2_0, arg_2_0._capacityParams.curCapacity, arg_2_0._capacityParams.totalCapacity, true)

	arg_2_0._capacityComp:showChangeEffect(true)
end

function var_0_0.refreshBtnDetail(arg_3_0)
	var_0_0.super.refreshBtnDetail(arg_3_0)

	local var_3_0 = PickAssistListModel.instance:getSelectedMO()
	local var_3_1 = var_3_0 and RougeConfig1.instance:getRoleCapacity(var_3_0.heroMO.config.rare) or 0

	arg_3_0._capacityComp:updateCurNum(var_3_1 + arg_3_0._capacityParams.curCapacity)
end

return var_0_0
