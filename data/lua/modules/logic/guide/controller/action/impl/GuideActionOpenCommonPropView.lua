module("modules.logic.guide.controller.action.impl.GuideActionOpenCommonPropView", package.seeall)

local var_0_0 = class("GuideActionOpenCommonPropView", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.actionParam
	local var_2_1 = GameUtil.splitString2(var_2_0, false, "$", ",")
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_3 = MaterialDataMO.New()

		var_2_3:initValue(iter_2_1[1], iter_2_1[2], iter_2_1[3])
		table.insert(var_2_2, var_2_3)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_2_2)
	arg_2_0:onDone(true)
end

return var_0_0
