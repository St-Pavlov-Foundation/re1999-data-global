﻿module("modules.logic.gm.view.GM_VersionActivity1_3DungeonMapView", package.seeall)

local var_0_0 = class("GM_VersionActivity1_3DungeonMapView", GM_VersionActivity_DungeonMapView)

function var_0_0.register()
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapView_register(VersionActivity1_3DungeonMapView)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XMapEpisodeItem_register(VersionActivity1_3MapEpisodeItem)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapLevelView_register(VersionActivity1_3DungeonMapLevelView, 1, 3)
end

return var_0_0
