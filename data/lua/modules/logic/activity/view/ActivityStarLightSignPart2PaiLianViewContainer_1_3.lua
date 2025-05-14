module("modules.logic.activity.view.ActivityStarLightSignPart2PaiLianViewContainer_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignPart2PaiLianViewContainer_1_3", ActivityStarLightSignPaiLianViewBaseContainer_1_3)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = ActivityStarLightSignItem_1_3
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -12.1
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return ActivityStarLightSignPart2PaiLianView_1_3
end

return var_0_0
