module("modules.logic.activity.view.ActivityStarLightSignViewBaseContainer_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignViewBaseContainer_1_3", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = ActivityStarLightSignItem_1_3
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -12
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	assert(false, "please override this function")
end

function var_0_0.onBuildViews(arg_3_0)
	return {
		arg_3_0.__mainView
	}
end

return var_0_0
