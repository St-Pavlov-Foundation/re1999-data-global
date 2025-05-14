module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetViewContainer", package.seeall)

local var_0_0 = class("FightChangeHeroSelectSkillTargetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightChangeHeroSelectSkillTargetView.New()
	}
end

return var_0_0
