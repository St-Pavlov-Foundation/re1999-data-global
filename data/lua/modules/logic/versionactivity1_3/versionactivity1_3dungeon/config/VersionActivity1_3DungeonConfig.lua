module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.config.VersionActivity1_3DungeonConfig", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity113_const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getDungeonConst(arg_4_0, arg_4_1)
	return lua_activity113_const.configDict[VersionActivity1_3Enum.ActivityId.Dungeon][arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
