module("modules.logic.achievement.view.AchievementNamePlateLevelViewContainer", package.seeall)

local var_0_0 = class("AchievementNamePlateLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AchievementNamePlateLevelView.New())

	return var_1_0
end

return var_0_0
