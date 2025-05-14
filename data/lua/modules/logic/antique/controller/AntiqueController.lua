module("modules.logic.antique.controller.AntiqueController", package.seeall)

local var_0_0 = class("AntiqueController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openAntiqueView(arg_3_0, arg_3_1)
	ViewMgr.instance:openView(ViewName.AntiqueView, arg_3_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
