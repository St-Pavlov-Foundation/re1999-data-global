module("modules.logic.main.controller.work.MainAchievementToast", package.seeall)

local var_0_0 = class("MainAchievementToast", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	AchievementToastController.instance:dispatchEvent(AchievementEvent.LoginShowToast)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
