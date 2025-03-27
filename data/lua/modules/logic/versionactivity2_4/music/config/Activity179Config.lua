module("modules.logic.versionactivity2_4.music.config.Activity179Config", package.seeall)

slot0 = class("Activity179Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity179_episode",
		"activity179_beat",
		"activity179_combo",
		"activity179_const",
		"activity179_task",
		"activity179_instrument",
		"activity179_tone",
		"activity179_note"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity179_episode" then
		slot0._episodeConfig = slot2
		slot0._episodeDict = {}

		for slot6, slot7 in ipairs(slot0._episodeConfig.configList) do
			slot0._episodeDict[slot7.activityId] = slot0._episodeDict[slot7.activityId] or {}

			table.insert(slot0._episodeDict[slot7.activityId], slot7)

			if slot7.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Free then
				slot0._freeEpisodeId = slot7.id
			end
		end

		return
	end

	if slot1 == "activity179_instrument" then
		slot0._instrumentSwitchList = {}
		slot0._instrumentNoSwitchList = {}

		for slot6, slot7 in ipairs(lua_activity179_instrument.configList) do
			if slot7.switch == 1 then
				table.insert(slot0._instrumentSwitchList, slot7)
			else
				table.insert(slot0._instrumentNoSwitchList, slot7)
			end
		end

		return
	end

	if slot1 == "activity179_tone" then
		slot0._noteDict = {}
		slot0._noteInstrumentList = {}

		for slot6, slot7 in ipairs(lua_activity179_tone.configList) do
			slot8 = slot0._noteInstrumentList[slot7.instrument] or {}
			slot0._noteInstrumentList[slot7.instrument] = slot8

			table.insert(slot8, slot7)

			slot9 = slot0._noteDict[slot7.instrument] or {}
			slot0._noteDict[slot7.instrument] = slot9
			slot9[#slot8] = slot7
		end

		return
	end

	if slot1 == "activity179_combo" then
		slot0._comboDict = {}

		for slot6, slot7 in ipairs(lua_activity179_combo.configList) do
			slot8 = slot0._comboDict[slot7.episodeId] or {}
			slot0._comboDict[slot7.episodeId] = slot8

			table.insert(slot8, slot7)
		end

		return
	end
end

function slot0.getFreeEpisodeId(slot0)
	return slot0._freeEpisodeId
end

function slot0.getComboList(slot0, slot1)
	return slot0._comboDict[slot1]
end

function slot0.getNoteConfig(slot0, slot1, slot2)
	return slot0._noteDict[slot1][slot2]
end

function slot0.getInstrumentSwitchList(slot0)
	return slot0._instrumentSwitchList
end

function slot0.getInstrumentNoSwitchList(slot0)
	return slot0._instrumentNoSwitchList
end

function slot0.getEpisodeCfgList(slot0, slot1)
	return slot0._episodeDict[slot1] or {}
end

function slot0.getConstValue(slot0, slot1, slot2)
	slot4 = lua_activity179_const.configDict[slot1] and slot3[slot2]

	return slot4.value1, slot4.value2
end

function slot0.getEpisodeConfig(slot0, slot1)
	return lua_activity179_episode.configDict[Activity179Model.instance:getActivityId()][slot1]
end

function slot0.getBeatConfig(slot0, slot1)
	return lua_activity179_beat.configDict[Activity179Model.instance:getActivityId()][slot1]
end

slot0.instance = slot0.New()

return slot0
