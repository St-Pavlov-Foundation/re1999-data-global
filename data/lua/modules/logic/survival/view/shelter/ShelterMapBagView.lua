module("modules.logic.survival.view.shelter.ShelterMapBagView", package.seeall)

local var_0_0 = class("ShelterMapBagView", SurvivalMapBagView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "root/toggleGroup")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(arg_1_0._goheavy, false)
end

function var_0_0.onOpen(arg_2_0)
	var_0_0.super.onOpen(arg_2_0)
	arg_2_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, 2)
end

function var_0_0.getBag(arg_3_0)
	return SurvivalShelterModel.instance:getWeekInfo().bag
end

return var_0_0
