module("modules.logic.gm.view.GM_VersionActivity1_3DungeonMapView", package.seeall)

slot0 = class("GM_VersionActivity1_3DungeonMapView", GM_VersionActivity_DungeonMapView)

function slot0.register()
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapView_register(VersionActivity1_3DungeonMapView)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XMapEpisodeItem_register(VersionActivity1_3MapEpisodeItem)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapLevelView_register(VersionActivity1_3DungeonMapLevelView, 1, 3)
end

return slot0
