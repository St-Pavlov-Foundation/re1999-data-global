module("modules.logic.sp01.sign.view.V2a9_LoginSign_FullViewContainer", package.seeall)

local var_0_0 = class("V2a9_LoginSign_FullViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V2a9_LoginSignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return V2a9_LoginSign_FullView
end

function var_0_0.onBuildViews(arg_3_0)
	return {
		arg_3_0:getMainView(),
		(TabViewGroup.New(1, "#go_topleft"))
	}
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return var_0_0
