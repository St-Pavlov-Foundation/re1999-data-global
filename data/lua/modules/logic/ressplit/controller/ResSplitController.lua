module("modules.logic.ressplit.controller.ResSplitController", package.seeall)

local var_0_0 = class("ResSplitController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._versionResSplitHandler = VersionResSplitHandler.New()

	ResSplitHelper.init()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.generateResSplitCfg(arg_5_0)
	arg_5_0._versionResSplitHandler:generateResSplitCfg()
end

function var_0_0.staticVersionResSplitAction()
	var_0_0.instance:generateResSplitCfg()
end

var_0_0.instance = var_0_0.New()

return var_0_0
