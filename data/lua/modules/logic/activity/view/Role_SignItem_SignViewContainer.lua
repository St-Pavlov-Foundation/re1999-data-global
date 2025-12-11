module("modules.logic.activity.view.Role_SignItem_SignViewContainer", package.seeall)

local var_0_0 = class("Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = Role_SignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -12
end

function var_0_0.onBuildViews(arg_2_0)
	return {
		(arg_2_0:getMainView())
	}
end

return var_0_0
