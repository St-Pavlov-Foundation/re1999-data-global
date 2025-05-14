module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapChapterLayout", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapChapterLayout", VersionActivity1_2DungeonMapChapterBaseLayout)

function var_0_0.getEpisodeItemClass(arg_1_0)
	return VersionActivity1_2MapEpisodeItem.New()
end

function var_0_0.getDungeonMapLevelView(arg_2_0)
	return ViewName.VersionActivity1_2DungeonMapLevelView
end

return var_0_0
