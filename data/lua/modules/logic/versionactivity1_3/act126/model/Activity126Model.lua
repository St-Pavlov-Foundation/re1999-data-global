module("modules.logic.versionactivity1_3.act126.model.Activity126Model", package.seeall)

slot0 = class("Activity126Model", BaseModel)

function slot0.onInit(slot0)
	slot0.spStatus = {}
end

function slot0.reInit(slot0)
	slot0.isInit = nil
	slot0._showDailyId = nil
	slot0.spStatus = {}
end

function slot0.updateInfo(slot0, slot1)
	slot0.isInit = true
	slot0.activityId = slot1.activityId
	slot0.spStatus = {}

	for slot5, slot6 in ipairs(slot1.spStatus) do
		slot7 = UserDungeonSpStatusMO.New()

		slot7:init(slot6)

		slot0.spStatus[slot7.episodeId] = slot7
	end

	slot0.starProgress = slot1.starProgress
	slot0.progressStr = slot1.progressStr
	slot0.horoscope = slot1.horoscope
	slot0.getHoroscope = slot1.getHoroscope

	slot0:_initList("starProgress", slot1, "Act126StarMO")
	slot0:_initList("getProgressBonus", slot1)
	slot0:_initMap("buffs", slot1)
	slot0:_initMap("spBuffs", slot1)
	slot0:_initList("dreamCards", slot1)
end

function slot0.getDailyPassNum(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(lua_activity126_episode_daily.configList) do
		if slot0.spStatus[slot6.id] and (slot8.status <= 0 or slot8.status == 3) then
			break
		end

		if not DungeonModel.instance:getEpisodeInfo(slot7) then
			break
		end

		slot1 = slot1 + slot9.todayPassNum
	end

	return slot1
end

function slot0.getRemainNum(slot0)
	slot2 = 1

	return math.max(0, slot2 - slot0:getDailyPassNum()), slot2
end

function slot0.getOpenDailyEpisodeList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_activity126_episode_daily.configList) do
		if slot0.spStatus[slot6.id] and (slot8.status <= 0 or slot8.status == 3) then
			break
		end

		if not DungeonModel.instance:getEpisodeInfo(slot7) then
			break
		end

		table.insert(slot1, slot9)
	end

	if #slot1 == #lua_activity126_episode_daily.configList then
		if slot0.spStatus[slot1[slot2].episodeId].status ~= 2 then
			return {
				slot1[slot2]
			}, false
		end

		return slot1, true
	end

	return {
		slot1[slot2]
	}, false
end

function slot0.changeShowDailyId(slot0, slot1)
	slot0._showDailyId = slot1

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), slot1)
end

function slot0.getShowDailyId(slot0)
	slot1, slot2 = slot0:getOpenDailyEpisodeList()

	if not slot2 then
		return slot1[1].episodeId
	end

	if not slot0._showDailyId then
		slot0._showDailyId = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), 0)
	end

	if slot0._showDailyId and slot0._showDailyId > 0 then
		return slot0._showDailyId
	end

	return slot1[1].episodeId
end

function slot0.updateHoroscope(slot0, slot1)
	slot0.horoscope = slot1
end

function slot0.receiveHoroscope(slot0)
	return slot0.horoscope
end

function slot0.updateGetHoroscope(slot0, slot1)
	slot0.getHoroscope = slot1
end

function slot0.receiveGetHoroscope(slot0)
	return slot0.getHoroscope
end

function slot0.updateStarProgress(slot0, slot1)
	slot0.horoscope = nil
	slot0.progressStr = slot1.progressStr

	slot0:_initList("starProgress", slot1, "Act126StarMO")
end

function slot0.getStarNum(slot0)
	for slot5, slot6 in ipairs(slot0.starProgress) do
		slot1 = 0 + slot6.num
	end

	return slot1
end

function slot0.getStarProgressStr(slot0)
	return slot0.progressStr
end

function slot0.hasBuff(slot0, slot1)
	return slot0.buffs[slot1] or slot0.spBuffs[slot1]
end

function slot0.hasDreamCard(slot0, slot1)
	if not slot0.spBuffs then
		return
	end

	for slot5, slot6 in pairs(slot0.spBuffs) do
		if lua_activity126_buff.configDict[slot5] and slot7.dreamlandCard == slot1 then
			return true
		end
	end
end

function slot0.updateGetProgressBonus(slot0, slot1)
	slot0:_initList("getProgressBonus", slot1)
end

function slot0.updateBuffInfo(slot0, slot1)
	slot0:_initMap("buffs", slot1)
	slot0:_initMap("spBuffs", slot1)
	slot0:_initList("dreamCards", slot1)
end

function slot0._initList(slot0, slot1, slot2, slot3)
	for slot9, slot10 in ipairs(slot2[slot1]) do
		if slot3 then
			_G[slot3].New():init(slot10)
		else
			slot4[slot9] = slot10
		end
	end

	slot0[slot1] = {
		[slot9] = slot12
	}
end

function slot0._initMap(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(slot2[slot1]) do
		-- Nothing
	end

	slot0[slot1] = {
		[slot9] = slot9
	}
end

slot0.instance = slot0.New()

return slot0
