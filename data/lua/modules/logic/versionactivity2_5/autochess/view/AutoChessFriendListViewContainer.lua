module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendListViewContainer", package.seeall)

local var_0_0 = class("AutoChessFriendListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessFriendListView.New())

	return var_1_0
end

return var_0_0
