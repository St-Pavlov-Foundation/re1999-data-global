module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapLevelView", package.seeall)

slot0 = class("VersionActivity1_3DungeonMapLevelView", VersionActivity1_3DungeonBaseMapLevelView)

function slot0.getEpisodeIndex(slot0)
	return VersionActivity1_3DungeonController.instance:getEpisodeIndex(slot0.originEpisodeConfig.id)
end

return slot0
