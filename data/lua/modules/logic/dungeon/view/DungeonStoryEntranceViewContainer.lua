module("modules.logic.dungeon.view.DungeonStoryEntranceViewContainer", package.seeall)

local var_0_0 = class("DungeonStoryEntranceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DungeonStoryEntranceView.New())

	return var_1_0
end

return var_0_0
