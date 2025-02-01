module("modules.logic.versionactivity1_4.act136.config.Activity136Config", package.seeall)

slot0 = class("Activity136Config", BaseConfig)

function slot0.ctor(slot0)
	slot0.Id2HeroIdDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity136"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.activity136ConfigLoaded(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.configList) do
		slot0.Id2HeroIdDict[slot6.activityId] = string.splitToNumber(slot6.heroIds, "#")
	end
end

function slot0.getCfg(slot0, slot1)
	return lua_activity136.configDict[slot1]
end

function slot0.getCfgWithNilError(slot0, slot1)
	if not slot0:getCfg(slot1) then
		logError("Activity136Config:getCfgWithNilError:cfg nil, id:" .. (slot1 or "nil"))
	end

	return slot2
end

function slot0.getSelfSelectCharacterIdList(slot0, slot1)
	if not slot0.Id2HeroIdDict[slot1] then
		slot2 = {}

		logError("Activity136Config:getSelfSelectCharacterIdList error, no heroIds data, id:" .. (slot1 or "nil"))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
