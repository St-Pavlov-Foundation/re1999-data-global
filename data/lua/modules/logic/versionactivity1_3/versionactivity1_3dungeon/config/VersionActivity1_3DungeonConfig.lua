module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.config.VersionActivity1_3DungeonConfig", package.seeall)

slot0 = class("VersionActivity1_3DungeonConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity113_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getDungeonConst(slot0, slot1)
	return lua_activity113_const.configDict[VersionActivity1_3Enum.ActivityId.Dungeon][slot1]
end

slot0.instance = slot0.New()

return slot0
