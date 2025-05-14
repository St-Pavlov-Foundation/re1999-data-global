module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonChangeViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonChangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity1_3DungeonChangeView.New())

	return var_1_0
end

return var_0_0
