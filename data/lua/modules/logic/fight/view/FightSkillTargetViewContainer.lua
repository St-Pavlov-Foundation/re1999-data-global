module("modules.logic.fight.view.FightSkillTargetViewContainer", package.seeall)

local var_0_0 = class("FightSkillTargetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSkillTargetView.New()
	}
end

return var_0_0
