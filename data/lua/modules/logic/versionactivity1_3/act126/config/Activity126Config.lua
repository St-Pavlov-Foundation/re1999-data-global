module("modules.logic.versionactivity1_3.act126.config.Activity126Config", package.seeall)

slot0 = class("Activity126Config", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity126_buff",
		"activity126_const",
		"activity126_dreamland",
		"activity126_dreamland_card",
		"activity126_episode_daily",
		"activity126_star",
		"activity126_horoscope"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity126_dreamland" then
		slot0:_dealDreamlandTask()
	end
end

function slot0.getConst(slot0, slot1, slot2)
	return lua_activity126_const.configDict[slot1][slot2]
end

function slot0.getHoroscopeConfig(slot0, slot1, slot2)
	return lua_activity126_horoscope.configDict[slot2][slot1]
end

function slot0.getStarConfig(slot0, slot1, slot2)
	return lua_activity126_star.configDict[slot2][slot1]
end

function slot0._dealDreamlandTask(slot0)
	slot0._taskDic = {}

	for slot4, slot5 in ipairs(lua_activity126_dreamland.configList) do
		for slot10, slot11 in ipairs(string.splitToNumber(slot5.battleIds, "#")) do
			slot0._taskDic[slot11] = slot5
		end
	end
end

function slot0.getDramlandTask(slot0, slot1)
	if slot0._taskeDic then
		return slot0._taskDic[slot1]
	end

	slot0:_dealDreamlandTask()

	return slot0._taskDic[slot1]
end

slot0.instance = slot0.New()

return slot0
