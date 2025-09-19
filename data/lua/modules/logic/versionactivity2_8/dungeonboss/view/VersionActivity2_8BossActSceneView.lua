module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActSceneView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossActSceneView", VersionActivity2_8BossStorySceneView)

function var_0_0._startChangeMap(arg_1_0)
	local var_1_0 = var_0_0.getMap()

	arg_1_0:_changeMap(var_1_0)
end

function var_0_0.getMap()
	local var_2_0 = 11026

	return lua_chapter_map.configDict[var_2_0]
end

return var_0_0
