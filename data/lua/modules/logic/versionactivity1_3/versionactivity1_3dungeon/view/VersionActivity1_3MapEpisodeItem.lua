module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3MapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_3MapEpisodeItem", VersionActivity1_3DungeonBaseEpisodeItem)

function var_0_0._promptlyShow(arg_1_0)
	return not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView)
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.VersionActivity1_3DungeonChangeView and arg_2_0._needShowMapLevelView then
		arg_2_0:_showMapLevelView()
	end
end

return var_0_0
