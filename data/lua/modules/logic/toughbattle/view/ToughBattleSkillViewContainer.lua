module("modules.logic.toughbattle.view.ToughBattleSkillViewContainer", package.seeall)

local var_0_0 = class("ToughBattleSkillViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToughBattleSkillView.New()
	}
end

return var_0_0
