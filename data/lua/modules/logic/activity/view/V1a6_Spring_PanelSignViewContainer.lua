module("modules.logic.activity.view.V1a6_Spring_PanelSignViewContainer", package.seeall)

local var_0_0 = class("V1a6_Spring_PanelSignViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V1a6_Spring_SignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return V1a6_Spring_PanelSignView
end

function var_0_0.onBuildViews(arg_3_0)
	return {
		arg_3_0.__mainView
	}
end

return var_0_0
