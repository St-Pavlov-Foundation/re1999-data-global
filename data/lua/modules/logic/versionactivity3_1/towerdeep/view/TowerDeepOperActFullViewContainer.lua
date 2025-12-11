module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActFullViewContainer", package.seeall)

local var_0_0 = class("TowerDeepOperActFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerDeepOperActFullView.New())

	return var_1_0
end

return var_0_0
