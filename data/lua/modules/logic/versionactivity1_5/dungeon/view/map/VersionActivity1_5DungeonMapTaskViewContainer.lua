module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity1_5DungeonMapTaskView.New())

	return var_1_0
end

return var_0_0
