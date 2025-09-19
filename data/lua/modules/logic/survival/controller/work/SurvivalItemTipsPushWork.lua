module("modules.logic.survival.controller.work.SurvivalItemTipsPushWork", package.seeall)

local var_0_0 = class("SurvivalItemTipsPushWork", SurvivalMsgPushWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.fastExecute then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.onViewClose, arg_1_0)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._msg.itemTips) do
		local var_1_1 = SurvivalBagItemMo.New()

		var_1_1:init({
			id = iter_1_1.itemId,
			count = iter_1_1.count
		})

		var_1_1.source = SurvivalEnum.ItemSource.Drop

		table.insert(var_1_0, var_1_1)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
		items = var_1_0
	})
end

function var_0_0.onViewClose(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.SurvivalGetRewardView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0.onViewClose, arg_3_0)
end

return var_0_0
