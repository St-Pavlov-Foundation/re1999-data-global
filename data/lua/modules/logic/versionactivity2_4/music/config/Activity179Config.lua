module("modules.logic.versionactivity2_4.music.config.Activity179Config", package.seeall)

local var_0_0 = class("Activity179Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
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

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity179_episode" then
		arg_3_0._episodeConfig = arg_3_2
		arg_3_0._episodeDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._episodeConfig.configList) do
			arg_3_0._episodeDict[iter_3_1.activityId] = arg_3_0._episodeDict[iter_3_1.activityId] or {}

			table.insert(arg_3_0._episodeDict[iter_3_1.activityId], iter_3_1)

			if iter_3_1.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Free then
				arg_3_0._freeEpisodeId = iter_3_1.id
			end
		end

		return
	end

	if arg_3_1 == "activity179_instrument" then
		arg_3_0._instrumentSwitchList = {}
		arg_3_0._instrumentNoSwitchList = {}

		for iter_3_2, iter_3_3 in ipairs(lua_activity179_instrument.configList) do
			if iter_3_3.switch == 1 then
				table.insert(arg_3_0._instrumentSwitchList, iter_3_3)
			else
				table.insert(arg_3_0._instrumentNoSwitchList, iter_3_3)
			end
		end

		return
	end

	if arg_3_1 == "activity179_tone" then
		arg_3_0._noteDict = {}
		arg_3_0._noteInstrumentList = {}

		for iter_3_4, iter_3_5 in ipairs(lua_activity179_tone.configList) do
			local var_3_0 = arg_3_0._noteInstrumentList[iter_3_5.instrument] or {}

			arg_3_0._noteInstrumentList[iter_3_5.instrument] = var_3_0

			table.insert(var_3_0, iter_3_5)

			local var_3_1 = arg_3_0._noteDict[iter_3_5.instrument] or {}

			arg_3_0._noteDict[iter_3_5.instrument] = var_3_1
			var_3_1[#var_3_0] = iter_3_5
		end

		return
	end

	if arg_3_1 == "activity179_combo" then
		arg_3_0._comboDict = {}

		for iter_3_6, iter_3_7 in ipairs(lua_activity179_combo.configList) do
			local var_3_2 = arg_3_0._comboDict[iter_3_7.episodeId] or {}

			arg_3_0._comboDict[iter_3_7.episodeId] = var_3_2

			table.insert(var_3_2, iter_3_7)
		end

		return
	end
end

function var_0_0.getFreeEpisodeId(arg_4_0)
	return arg_4_0._freeEpisodeId
end

function var_0_0.getComboList(arg_5_0, arg_5_1)
	return arg_5_0._comboDict[arg_5_1]
end

function var_0_0.getNoteConfig(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._noteDict[arg_6_1][arg_6_2]
end

function var_0_0.getInstrumentSwitchList(arg_7_0)
	return arg_7_0._instrumentSwitchList
end

function var_0_0.getInstrumentNoSwitchList(arg_8_0)
	return arg_8_0._instrumentNoSwitchList
end

function var_0_0.getEpisodeCfgList(arg_9_0, arg_9_1)
	return arg_9_0._episodeDict[arg_9_1] or {}
end

function var_0_0.getConstValue(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = lua_activity179_const.configDict[arg_10_1]
	local var_10_1 = var_10_0 and var_10_0[arg_10_2]

	return var_10_1.value1, var_10_1.value2
end

function var_0_0.getEpisodeConfig(arg_11_0, arg_11_1)
	return lua_activity179_episode.configDict[Activity179Model.instance:getActivityId()][arg_11_1]
end

function var_0_0.getBeatConfig(arg_12_0, arg_12_1)
	return lua_activity179_beat.configDict[Activity179Model.instance:getActivityId()][arg_12_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
