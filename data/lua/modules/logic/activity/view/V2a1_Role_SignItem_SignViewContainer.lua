module("modules.logic.activity.view.V2a1_Role_SignItem_SignViewContainer", package.seeall)

local var_0_0 = class("V2a1_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = V2a1_Role_SignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
end

function var_0_0.onBuildViews(arg_2_0)
	return {
		(arg_2_0:getMainView())
	}
end

return var_0_0
