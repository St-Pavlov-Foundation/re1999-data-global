module("modules.logic.activity.view.V2a8_DragonBoat_PanelViewContainer", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_PanelViewContainer", V2a8_DragonBoat_RewardItemViewContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	V2a8_DragonBoat_RewardItemViewContainer.onModifyListScrollParam(arg_1_0, arg_1_1)

	arg_1_1.scrollGOPath = "root/#scroll_ItemList"
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return V2a8_DragonBoat_PanelView
end

return var_0_0
