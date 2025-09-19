module("modules.logic.survival.controller.work.SurvivalSceneOperationLogPushWork", package.seeall)

local var_0_0 = class("SurvivalSceneOperationLogPushWork", SurvivalMsgPushWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._msg.data) do
		local var_1_1 = SurvivalLogMo.New()

		var_1_1:init(iter_1_1)
		SurvivalController.instance:showToast(var_1_1:getLogStr())

		if var_1_1.isNpcRecr then
			var_1_0 = var_1_0 or {}

			local var_1_2 = SurvivalBagItemMo.New()

			var_1_2:init({
				count = 1,
				id = var_1_1.isNpcRecr
			})
			table.insert(var_1_0, var_1_2)
		end
	end

	if var_1_0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.onViewClose, arg_1_0)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
			items = var_1_0,
			title = luaLang("survival_reward_npc_title")
		})
	else
		arg_1_0:onDone(true)
	end
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
