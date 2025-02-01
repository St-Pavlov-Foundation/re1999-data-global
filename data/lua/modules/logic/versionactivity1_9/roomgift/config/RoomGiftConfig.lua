module("modules.logic.versionactivity1_9.roomgift.config.RoomGiftConfig", package.seeall)

slot0 = class("RoomGiftConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity159",
		"activity159_critter"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot1(slot0)
	slot1 = nil

	if not string.nilorempty(slot0) then
		slot1 = lua_activity159_critter.configDict[slot0]
	end

	if not slot1 then
		logError(string.format("RoomGiftConfig.getRoomGiftSpineCfg error, no cfg, name:%s", slot0))
	end

	return slot1
end

function slot0.getAllRoomGiftSpineList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_activity159_critter.configList) do
		slot1[#slot1 + 1] = slot6.name
	end

	return slot1
end

function slot0.getRoomGiftSpineRes(slot0, slot1)
	slot2 = nil

	if uv0(slot1) then
		slot2 = slot3.res
	end

	return slot2
end

function slot0.getRoomGiftSpineAnim(slot0, slot1)
	slot2 = nil

	if uv0(slot1) then
		slot2 = slot3.anim
	end

	return slot2
end

function slot0.getRoomGiftSpineStartPos(slot0, slot1)
	slot2 = {
		0,
		0,
		0
	}

	if uv0(slot1) then
		slot2 = string.splitToNumber(slot3.startPos, "#")
	end

	return slot2
end

function slot0.getRoomGiftSpineScale(slot0, slot1)
	slot2 = 1

	if uv0(slot1) then
		slot2 = slot3.scale
	end

	return slot2
end

function slot2(slot0, slot1, slot2)
	slot3 = nil

	if slot0 and slot1 then
		slot3 = lua_activity159.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("RoomGiftConfig:getActivity159Cfg error, cfg is nil, actId:%s  day:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getRoomGiftBonus(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2) then
		slot3 = slot4.bonus
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
