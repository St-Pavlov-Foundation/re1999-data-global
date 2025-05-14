module("modules.logic.achievement.view.AchievementLevelViewContainer", package.seeall)

local var_0_0 = class("AchievementLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AchievementLevelView.New()
	}
end

return var_0_0
