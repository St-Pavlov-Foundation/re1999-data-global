module("modules.logic.fight.view.FightItemSkillInfosViewContainer", package.seeall)

local var_0_0 = class("FightItemSkillInfosViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightItemSkillInfosView.New()
	}
end

return var_0_0
