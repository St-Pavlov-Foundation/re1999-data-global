module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightLayoutView", package.seeall)

slot0 = class("V1a5_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function slot0.checkNeedSetOffset(slot0)
	return DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)
end

return slot0
