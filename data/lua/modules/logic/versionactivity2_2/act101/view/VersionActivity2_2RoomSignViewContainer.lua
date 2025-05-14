module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_2RoomSignViewContainer", Activity101SignViewBaseContainer)

function var_0_0.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = VersionActivity2_2RoomSignItem
	arg_1_1.scrollGOPath = "#scroll_ItemList"
	arg_1_1.cellWidth = 476
	arg_1_1.cellHeight = 576
	arg_1_1.cellSpaceH = 30
end

function var_0_0.onGetMainViewClassType(arg_2_0)
	return VersionActivity2_2RoomSignView
end

function var_0_0.onBuildViews(arg_3_0)
	return {
		(arg_3_0:getMainView())
	}
end

return var_0_0
