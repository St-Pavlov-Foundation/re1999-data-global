module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapLevelView", VersionActivity1_3DungeonBaseMapLevelView)

function var_0_0.getEpisodeIndex(arg_1_0)
	return VersionActivity1_3DungeonController.instance:getEpisodeIndex(arg_1_0.originEpisodeConfig.id)
end

return var_0_0
