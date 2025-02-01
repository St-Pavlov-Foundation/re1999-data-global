module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3MapEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_3MapEpisodeItem", VersionActivity1_3DungeonBaseEpisodeItem)

function slot0._promptlyShow(slot0)
	return not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_3DungeonChangeView and slot0._needShowMapLevelView then
		slot0:_showMapLevelView()
	end
end

return slot0
