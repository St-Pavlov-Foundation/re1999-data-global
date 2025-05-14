module("modules.logic.toughbattle.view.ToughBattleEnemyInfoViewContainer", package.seeall)

local var_0_0 = class("ToughBattleEnemyInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToughBattleEnemyInfoView.New()
	}
end

return var_0_0
