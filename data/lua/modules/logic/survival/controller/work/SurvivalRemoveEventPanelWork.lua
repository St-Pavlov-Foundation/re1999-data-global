module("modules.logic.survival.controller.work.SurvivalRemoveEventPanelWork", package.seeall)

local var_0_0 = class("SurvivalRemoveEventPanelWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1]

	if var_1_0 == 1 then
		SurvivalMapModel.instance:getSceneMo().panel = nil
	elseif var_1_0 == 2 then
		SurvivalShelterModel.instance:getWeekInfo().panel = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalMapEventView)
	ViewMgr.instance:closeView(ViewName.SurvivalMapSearchView)
	ViewMgr.instance:closeView(ViewName.SurvivalDropSelectView)
	ViewMgr.instance:closeView(ViewName.SurvivalShopView)
	arg_1_0:onDone(true)
end

return var_0_0
