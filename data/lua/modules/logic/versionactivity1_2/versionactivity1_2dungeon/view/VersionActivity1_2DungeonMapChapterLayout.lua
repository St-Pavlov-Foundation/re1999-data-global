module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapChapterLayout", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapChapterLayout", VersionActivity1_2DungeonMapChapterBaseLayout)

function slot0.getEpisodeItemClass(slot0)
	return VersionActivity1_2MapEpisodeItem.New()
end

function slot0.getDungeonMapLevelView(slot0)
	return ViewName.VersionActivity1_2DungeonMapLevelView
end

return slot0
