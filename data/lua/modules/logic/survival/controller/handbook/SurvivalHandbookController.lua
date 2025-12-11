module("modules.logic.survival.controller.handbook.SurvivalHandbookController", package.seeall)

local var_0_0 = class("SurvivalHandbookController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.sendOpenSurvivalHandbookView(arg_2_0)
	ViewMgr.instance:openView(ViewName.SurvivalHandbookView)
end

function var_0_0.markNewHandbook(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = SurvivalHandbookModel.instance:getNewHandbook(arg_3_1, arg_3_2)

	if #var_3_0 > 0 then
		SurvivalOutSideRpc.instance:sendSurvivalMarkNewHandbook(var_3_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
