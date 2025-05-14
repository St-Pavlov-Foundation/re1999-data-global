module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanelContainer", package.seeall)

local var_0_0 = class("V1a6_BossRush_ResultPanelContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {
		V1a6_BossRush_ResultPanel.New()
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(var_1_0, FightGMRecordView.New())
	end

	return var_1_0
end

return var_0_0
