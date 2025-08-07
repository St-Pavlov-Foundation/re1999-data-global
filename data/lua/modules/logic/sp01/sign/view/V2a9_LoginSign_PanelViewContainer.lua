module("modules.logic.sp01.sign.view.V2a9_LoginSign_PanelViewContainer", package.seeall)

local var_0_0 = class("V2a9_LoginSign_PanelViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V2a9_LoginSignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return V2a9_LoginSign_PanelView
end

function var_0_0.onBuildViews(arg_3_0)
	return {
		(arg_3_0:getMainView())
	}
end

return var_0_0
