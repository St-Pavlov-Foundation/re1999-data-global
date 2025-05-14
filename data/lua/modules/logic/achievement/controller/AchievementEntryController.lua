module("modules.logic.achievement.controller.AchievementEntryController", package.seeall)

local var_0_0 = class("AchievementEntryController", BaseController)

function var_0_0.onOpenView(arg_1_0)
	AchievementEntryModel.instance:initData()
end

function var_0_0.onCloseView(arg_2_0)
	return
end

function var_0_0.updateAchievementState(arg_3_0)
	AchievementEntryModel.instance:initData()
end

var_0_0.instance = var_0_0.New()

return var_0_0
