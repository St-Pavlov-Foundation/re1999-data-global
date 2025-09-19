module("modules.logic.survival.view.map.SurvivalPickAssistView", package.seeall)

local var_0_0 = class("SurvivalPickAssistView", PickAssistView)

function var_0_0._btnconfirmOnClick(arg_1_0)
	local var_1_0 = PickAssistListModel.instance:getSelectedMO()

	if var_1_0 and SurvivalShelterModel.instance:getWeekInfo():getHeroMo(var_1_0.heroMO.heroId).health <= 0 then
		GameFacade.showToast(ToastEnum.SurvivalHeroDead)

		return
	end

	PickAssistController.instance:pickOver()
	arg_1_0:closeThis()
end

return var_0_0
