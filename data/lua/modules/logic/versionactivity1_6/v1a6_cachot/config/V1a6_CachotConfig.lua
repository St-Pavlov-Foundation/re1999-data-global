module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotConfig", package.seeall)

slot0 = class("V1a6_CachotConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rogue_const",
		"rogue_difficulty",
		"rogue_room",
		"rogue_field",
		"rogue_heartbeat",
		"rogue_score",
		"rogue_scene_level"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rogue_score" then
		V1a6_CachotScoreConfig.instance:init(slot2)
	elseif slot1 == "rogue_room" then
		V1a6_CachotRoomConfig.instance:init(slot2)
	end
end

function slot0.getHeartConfig(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(lua_rogue_heartbeat.configList) do
		if string.splitToNumber(slot7.range, "#")[1] <= slot1 and slot1 <= slot8[2] then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		logError("没有心跳对应的配置:" .. slot1)

		slot2 = lua_rogue_heartbeat.configList[1]
	end

	return slot2
end

function slot0.getDifficultyConfig(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(lua_rogue_difficulty.configList) do
		if slot1 == slot6 then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		logError("没有难度对应的配置:" .. slot1)

		slot2 = lua_rogue_difficulty.configList[1]
	end

	return slot2
end

function slot0.getDifficultyCount(slot0)
	return #lua_rogue_difficulty.configList
end

function slot0.getConstConfig(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(lua_rogue_const.configList) do
		if slot1 == slot6 then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		logError("没有常量对应的配置:" .. slot1)

		slot2 = lua_rogue_const.configList[1]
	end

	return slot2
end

function slot0.getSceneLevelId(slot0, slot1)
	return (lua_rogue_scene_level.configDict[slot1] or lua_rogue_scene_level.configList[1]).sceneLevel
end

slot0.instance = slot0.New()

return slot0
