module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_TabViewGroup", package.seeall)

local var_0_0 = class("V1a6_BossRush_TabViewGroup", TabViewGroup)

function var_0_0._openTabView(arg_1_0, arg_1_1)
	if arg_1_0.__tabId == arg_1_1 then
		return
	end

	arg_1_0.__tabId = arg_1_1

	var_0_0.super._openTabView(arg_1_0, arg_1_1)
end

function var_0_0._setVisible(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tabCanvasGroup[arg_2_1]

	if not var_2_0 then
		local var_2_1 = arg_2_0._tabViews[arg_2_1].viewGO

		var_2_0 = gohelper.onceAddComponent(var_2_1, typeof(UnityEngine.CanvasGroup))
		arg_2_0._tabCanvasGroup[arg_2_1] = var_2_0
	end

	var_2_0.interactable = arg_2_2
	var_2_0.blocksRaycasts = arg_2_2
end

return var_0_0
