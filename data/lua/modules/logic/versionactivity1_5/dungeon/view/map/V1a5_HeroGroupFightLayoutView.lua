module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightLayoutView", package.seeall)

local var_0_0 = class("V1a5_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function var_0_0.checkNeedSetOffset(arg_1_0)
	return DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)
end

return var_0_0
