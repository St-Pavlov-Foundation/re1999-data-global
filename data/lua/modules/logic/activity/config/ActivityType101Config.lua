module("modules.logic.activity.config.ActivityType101Config", package.seeall)

slot0 = class("ActivityType101Config", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity101_doublefestival",
		"activity101_springsign",
		"activity101_sp_bonus",
		"v2a1_activity101_moonfestivalsign",
		"linkage_activity"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity101_doublefestival" then
		slot0.__activity101_doublefestivals = nil

		slot0:__initDoubleFestival()
	elseif slot1 == "activity101_springsign" then
		slot0.__activity101_springsign = nil

		slot0:__initSpringSign()
	elseif slot1 == "v2a1_activity101_moonfestivalsign" then
		slot0.__v2a1_activity101_moonfestivalsign = nil

		slot0:__initMoonFestivalSign()
	elseif slot1 == "linkage_activity" then
		slot0.__linkage_activity = nil

		slot0:__linkageActivity()
	end
end

function slot0.__initDoubleFestival(slot0)
	if slot0.__activity101_doublefestivals then
		return slot1
	end

	slot0.__activity101_doublefestivals = {}

	for slot6, slot7 in ipairs(lua_activity101_doublefestival.configList) do
		slot2[slot8] = slot2[slot7.activityId] or {}
		slot2[slot8][slot7.day] = slot7
	end

	return slot2
end

function slot0.getDoubleFestivalCOByDay(slot0, slot1, slot2)
	slot0:__initDoubleFestival()

	if not slot0.__activity101_doublefestivals[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.__initSpringSign(slot0)
	if slot0.__activity101_springsign then
		return slot1
	end

	slot0.__activity101_springsign = {}

	for slot6, slot7 in ipairs(lua_activity101_springsign.configList) do
		slot2[slot8] = slot2[slot7.activityId] or {}
		slot2[slot8][slot7.day] = slot7
	end

	return slot2
end

function slot0.getSpringSignByDay(slot0, slot1, slot2)
	slot0:__initSpringSign()

	if not slot0.__activity101_springsign[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.getSpringSignMaxDay(slot0, slot1)
	slot0:__initSpringSign()

	if not slot0.__activity101_springsign[slot1] then
		return 0
	end

	return #slot2
end

function slot0.__initMoonFestivalSign(slot0)
	if slot0.__v2a1_activity101_moonfestivalsign then
		return slot1
	end

	slot0.__v2a1_activity101_moonfestivalsign = {}

	for slot6, slot7 in ipairs(v2a1_activity101_moonfestivalsign.configList) do
		slot2[slot8] = slot2[slot7.activityId] or {}
		slot2[slot8][slot7.day] = slot7
	end

	return slot2
end

function slot0.getMoonFestivalSignMaxDay(slot0, slot1)
	slot0:__initSpringSign()

	if not slot0.__v2a1_activity101_moonfestivalsign[slot1] then
		return 0
	end

	return #slot2
end

function slot0.getMoonFestivalByDay(slot0, slot1, slot2)
	slot0:__initMoonFestivalSign()

	if not slot0.__v2a1_activity101_moonfestivalsign[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.getMoonFestivalTaskCO(slot0, slot1)
	if not slot0:getSpBonusCO(slot1) then
		return
	end

	return slot2[1]
end

function slot0.getSpBonusCO(slot0, slot1)
	return lua_activity101_sp_bonus.configDict[slot1]
end

function slot0.__linkageActivity(slot0)
	if slot0.__linkage_activity then
		return slot1
	end

	slot0.__linkage_activity = {}

	for slot6, slot7 in ipairs(lua_linkage_activity.configList) do
		slot2[slot7.activityId] = slot7
	end

	return slot2
end

function slot0.getLinkageActivityCO(slot0, slot1)
	slot0:__linkageActivity()

	return slot0.__linkage_activity[slot1]
end

slot0.instance = slot0.New()

return slot0
