module("modules.logic.seasonver.act123.controller.Season123ShowHeroController", package.seeall)

local var_0_0 = class("Season123ShowHeroController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	Season123ShowHeroModel.instance:init(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onCloseView(arg_2_0)
	Season123ShowHeroModel.instance:release()
end

function var_0_0.openReset(arg_3_0)
	Season123Controller.instance:openResetView({
		actId = Season123ShowHeroModel.instance.activityId,
		stage = Season123ShowHeroModel.instance.stage
	})
end

function var_0_0.notifyView(arg_4_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
