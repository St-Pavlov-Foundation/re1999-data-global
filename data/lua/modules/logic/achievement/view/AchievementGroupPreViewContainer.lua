module("modules.logic.achievement.view.AchievementGroupPreViewContainer", package.seeall)

local var_0_0 = class("AchievementGroupPreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AchievementGroupPreView.New()
	}
end

return var_0_0
