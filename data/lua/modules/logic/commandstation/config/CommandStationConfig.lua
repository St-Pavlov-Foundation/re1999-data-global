module("modules.logic.commandstation.config.CommandStationConfig", package.seeall)

local var_0_0 = class("CommandStationConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"copost_character_event",
		"copost_version",
		"copost_time_axis",
		"copost_time_point",
		"copost_time_point_event",
		"copost_event",
		"copost_event_text",
		"copost_version_task",
		"copost_catch_task",
		"copost_bonus",
		"copost_npc",
		"copost_npc_text",
		"copost_password_paper",
		"copost_character",
		"copost_const",
		"copost_scene",
		"copost_decoration",
		"copost_decoration_coordinates"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "copost_version" then
		arg_3_0:_initVersion()
	elseif arg_3_1 == "copost_time_axis" then
		arg_3_0:_initTimeAxis()
	elseif arg_3_1 == "copost_time_point" then
		arg_3_0:_initTimePoint()
	elseif arg_3_1 == "copost_time_point_event" then
		arg_3_0:_initTimePointEvent()
	elseif arg_3_1 == "copost_event" then
		arg_3_0:_initEvent()
	elseif arg_3_1 == "copost_character_event" then
		arg_3_0:_initCharacterEvent()
	elseif arg_3_1 == "copost_event_text" then
		arg_3_0:_initEventText()
	elseif arg_3_1 == "copost_version_task" then
		arg_3_0:_initVersionTask()
	elseif arg_3_1 == "copost_catch_task" then
		arg_3_0:_initCatchTask()
	elseif arg_3_1 == "copost_bonus" then
		arg_3_0:_initBonus()
	elseif arg_3_1 == "copost_npc" then
		arg_3_0:_initNpc()
	elseif arg_3_1 == "copost_npc_text" then
		arg_3_0:_initNpcText()
	elseif arg_3_1 == "copost_password_paper" then
		arg_3_0:_initPasswordPaper()
	end
end

function var_0_0._initVersion(arg_4_0)
	local var_4_0 = #lua_copost_version.configList

	arg_4_0._maxVersionId = lua_copost_version.configList[var_4_0].versionId
end

function var_0_0._initTimeAxis(arg_5_0)
	arg_5_0:_initVersionTimeline()
	arg_5_0:_initTimeGroup()
end

function var_0_0._initVersionTimeline(arg_6_0)
	arg_6_0._verionTimeline = {}
	arg_6_0._timePointSceneMap = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(lua_copost_time_axis.configList) do
		arg_6_0._verionTimeline[iter_6_1.versionId] = arg_6_0._verionTimeline[iter_6_1.versionId] or {}

		table.insert(arg_6_0._verionTimeline[iter_6_1.versionId], iter_6_1)

		var_6_0[iter_6_1.id] = var_6_0[iter_6_1.id] or {}

		local var_6_1 = var_6_0[iter_6_1.id]

		for iter_6_2, iter_6_3 in ipairs(iter_6_1.timeId) do
			table.insert(var_6_1, iter_6_3)

			arg_6_0._timePointSceneMap[iter_6_3] = iter_6_1.sceneId
		end
	end

	local var_6_2 = {}

	for iter_6_4, iter_6_5 in pairs(var_6_0) do
		table.insert(var_6_2, {
			id = iter_6_4,
			timeId = iter_6_5
		})
	end

	arg_6_0._verionTimeline[CommandStationEnum.AllVersion] = var_6_2

	for iter_6_6, iter_6_7 in pairs(arg_6_0._verionTimeline) do
		table.sort(iter_6_7, function(arg_7_0, arg_7_1)
			return arg_7_0.id < arg_7_1.id
		end)
	end
end

function var_0_0._initTimeGroup(arg_8_0)
	arg_8_0._timeGroup = {}

	for iter_8_0, iter_8_1 in ipairs(lua_copost_time_axis.configList) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1.timeId) do
			arg_8_0._timeGroup[iter_8_3] = iter_8_1
		end
	end
end

function var_0_0._initTimePoint(arg_9_0)
	return
end

function var_0_0._initTimePointEvent(arg_10_0)
	arg_10_0._episodeIdTimeIdMap = {}
	arg_10_0._characterEventTime = {}
	arg_10_0._characterTimeGroup = {}

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(lua_copost_time_point_event.configList) do
		if not arg_10_0._episodeIdTimeIdMap[iter_10_1.fightId] then
			arg_10_0._episodeIdTimeIdMap[iter_10_1.fightId] = iter_10_1.id
		end

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.chaEventId) do
			arg_10_0._characterEventTime[iter_10_3] = iter_10_1

			local var_10_1 = lua_copost_character_event.configDict[iter_10_3]

			if var_10_1 then
				var_10_0[var_10_1.chaId] = var_10_0[var_10_1.chaId] or {}

				local var_10_2 = arg_10_0._timeGroup[iter_10_1.id]

				if var_10_2 then
					local var_10_3 = var_10_0[var_10_1.chaId]

					if not tabletool.indexOf(var_10_3, var_10_2) then
						table.insert(var_10_3, var_10_2)
					end
				else
					logError(string.format("CommandStationConfig _initTimePointEvent timeId %d not exist in copost_time_axis", var_10_1.id))
				end
			else
				logError(string.format("CommandStationConfig _initTimePointEvent characterEventId %d not exist", iter_10_3))
			end
		end
	end

	for iter_10_4, iter_10_5 in pairs(var_10_0) do
		table.sort(iter_10_5, function(arg_11_0, arg_11_1)
			return arg_11_0.id < arg_11_1.id
		end)
	end

	for iter_10_6, iter_10_7 in pairs(var_10_0) do
		arg_10_0._characterTimeGroup[iter_10_6] = {}

		for iter_10_8, iter_10_9 in pairs(iter_10_7) do
			local var_10_4 = {}

			for iter_10_10, iter_10_11 in ipairs(iter_10_9.timeId) do
				local var_10_5 = arg_10_0:getCharacterEventList(iter_10_11)

				for iter_10_12, iter_10_13 in ipairs(var_10_5) do
					if arg_10_0._characterEventMap[iter_10_13] == iter_10_6 then
						table.insert(var_10_4, iter_10_11)
					end
				end
			end

			arg_10_0._characterTimeGroup[iter_10_6][iter_10_8] = {
				versionId = iter_10_9.versionId,
				id = iter_10_9.id,
				timeId = var_10_4
			}
		end
	end
end

function var_0_0._initEvent(arg_12_0)
	return
end

function var_0_0._initCharacterEvent(arg_13_0)
	arg_13_0._characterEventMap = {}

	for iter_13_0, iter_13_1 in ipairs(lua_copost_character_event.configList) do
		arg_13_0._characterEventMap[iter_13_1.id] = iter_13_1.chaId
	end
end

function var_0_0._initEventText(arg_14_0)
	return
end

function var_0_0._initVersionTask(arg_15_0)
	return
end

function var_0_0._initCatchTask(arg_16_0)
	return
end

function var_0_0._initBonus(arg_17_0)
	arg_17_0._taskBonusList = {}

	for iter_17_0, iter_17_1 in ipairs(lua_copost_bonus.configList) do
		table.insert(arg_17_0._taskBonusList, iter_17_1)
	end

	table.sort(arg_17_0._taskBonusList, SortUtil.tableKeyLower({
		"versionId",
		"pointNum"
	}))
end

function var_0_0._initNpc(arg_18_0)
	arg_18_0._dialogueList = {}

	for iter_18_0, iter_18_1 in ipairs(lua_copost_npc.configList) do
		arg_18_0._dialogueList[iter_18_1.condition] = iter_18_1
	end
end

function var_0_0._initNpcText(arg_19_0)
	return
end

function var_0_0._initPasswordPaper(arg_20_0)
	arg_20_0._paperList = {}

	for iter_20_0, iter_20_1 in ipairs(lua_copost_password_paper.configList) do
		table.insert(arg_20_0._paperList, iter_20_1)
	end

	table.sort(arg_20_0._paperList, SortUtil.keyLower("versionId"))
end

function var_0_0.getMaxVersionId(arg_21_0)
	return arg_21_0._maxVersionId
end

function var_0_0.getSceneConfig(arg_22_0, arg_22_1)
	local var_22_0 = lua_copost_scene.configDict[arg_22_1]

	if not var_22_0 then
		logError(string.format("场景配置表不存在，id:%d", arg_22_1))

		return nil
	end

	return var_22_0
end

function var_0_0.getTimeIdByEpisodeId(arg_23_0, arg_23_1)
	return arg_23_0._episodeIdTimeIdMap[arg_23_1]
end

function var_0_0.getTimeGroupByEpisodeId(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getTimeIdByEpisodeId(arg_24_1)

	return var_24_0 and arg_24_0._timeGroup[var_24_0]
end

function var_0_0.getConstConfig(arg_25_0, arg_25_1)
	local var_25_0 = lua_copost_const.configDict[arg_25_1]

	if not var_25_0 then
		logError("lua_copost_const config not found id:" .. arg_25_1)
	end

	return var_25_0
end

function var_0_0.getDialogByType(arg_26_0, arg_26_1)
	return arg_26_0._dialogueList[arg_26_1]
end

function var_0_0.getRandomDialogTextId(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._dialogueList[arg_27_1]
	local var_27_1 = var_27_0.textId
	local var_27_2 = var_27_0.weight
	local var_27_3 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_2) do
		var_27_3 = var_27_3 + iter_27_1
	end

	local var_27_4 = math.random(1, var_27_3)
	local var_27_5 = 0

	for iter_27_2, iter_27_3 in ipairs(var_27_2) do
		var_27_5 = var_27_5 + iter_27_3

		if var_27_4 <= var_27_5 then
			return var_27_1[iter_27_2]
		end
	end
end

function var_0_0.getCharacterIdByEventId(arg_28_0, arg_28_1)
	return arg_28_0._characterEventMap[arg_28_1]
end

function var_0_0.getVersionList(arg_29_0)
	return lua_copost_version.configList
end

function var_0_0.getVersionIndex(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(lua_copost_version.configList) do
		if iter_30_1.versionId == arg_30_1 then
			return iter_30_0
		end
	end

	return 1
end

function var_0_0.getVersionTimeline(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._verionTimeline[arg_31_1]

	if not var_31_0 then
		logError(string.format("CommandStationConfig getVersionTimeline not list versionId:%s", arg_31_1))

		return {}
	end

	return var_31_0
end

function var_0_0.getTimeGroupByTimeId(arg_32_0, arg_32_1)
	return arg_32_0._timeGroup[arg_32_1]
end

function var_0_0.getTimeGroupByCharacterId(arg_33_0, arg_33_1)
	return arg_33_0._characterTimeGroup[arg_33_1]
end

function var_0_0.getTimeGroupByCharacterEventId(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._characterEventTime[arg_34_1]

	return var_34_0 and arg_34_0:getTimeGroupByTimeId(var_34_0.id)
end

function var_0_0.getCharacterEventList(arg_35_0, arg_35_1)
	local var_35_0 = lua_copost_time_point_event.configDict[arg_35_1]

	if not var_35_0 then
		logError(string.format("CommandStationConfig getCharacterEventList not timePointConfig timeId:%s", arg_35_1))

		return {}
	end

	return var_35_0.chaEventId
end

function var_0_0.getTimePointEpisodeId(arg_36_0, arg_36_1)
	local var_36_0 = lua_copost_time_point_event.configDict[arg_36_1]

	if not var_36_0 then
		logError(string.format("CommandStationConfig getTimePointEpisodeId not timePointConfig timeId:%s", arg_36_1))

		return nil
	end

	return var_36_0.fightId
end

function var_0_0.getEventList(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = lua_copost_time_point_event.configDict[arg_37_1]

	if not var_37_0 then
		logError(string.format("CommandStationConfig getEventList not timePointConfig timeId:%s", arg_37_1))

		return {}
	end

	local var_37_1 = var_37_0[arg_37_3 or CommandStationEnum.EventCategoryKey.Normal]

	if arg_37_2 then
		if tabletool.indexOf(var_37_1, arg_37_2) == -1 then
			logError(string.format("CommandStationConfig getEventList not filteredEventId timeId:%s filteredEventId:%s", arg_37_1, arg_37_2))

			return {}
		end

		local var_37_2 = lua_copost_event.configDict[arg_37_2]

		if not var_37_2 then
			logError(string.format("CommandStationConfig getEventList not filteredEventConfig timeId:%s filteredEventId:%s", arg_37_1, arg_37_2))

			return {}
		end

		local var_37_3 = {}

		for iter_37_0, iter_37_1 in ipairs(var_37_1) do
			local var_37_4 = lua_copost_event.configDict[iter_37_1]

			if var_37_4 and var_37_4.eventType == var_37_2.eventType then
				table.insert(var_37_3, iter_37_1)
			end
		end

		return var_37_3
	end

	return var_37_1
end

function var_0_0.getTimePointName(arg_38_0, arg_38_1)
	local var_38_0 = lua_copost_time_point.configDict[arg_38_1]

	if not var_38_0 then
		logError(string.format("CommandStationConfig getTimePointName not config timeId:%s", arg_38_1))

		return ""
	end

	return var_38_0.time
end

function var_0_0.getCurVersionId(arg_39_0)
	if not arg_39_0._curVersionId then
		arg_39_0._curVersionId = CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_CurVersion)
	end

	return arg_39_0._curVersionId
end

function var_0_0.getPaperItemId(arg_40_0)
	if not arg_40_0._paperItemId then
		arg_40_0._paperItemId = CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_PaperItemId)
	end

	return arg_40_0._paperItemId
end

function var_0_0.getCurTotalPaperCount(arg_41_0, arg_41_1)
	local var_41_0 = 0
	local var_41_1 = arg_41_1 or arg_41_0:getCurVersionId()

	for iter_41_0, iter_41_1 in ipairs(arg_41_0._paperList) do
		if var_41_1 >= iter_41_1.versionId then
			var_41_0 = var_41_0 + iter_41_1.allNum
		else
			break
		end
	end

	return var_41_0
end

function var_0_0.getPaperList(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = arg_42_0:getCurVersionId()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._paperList) do
		if var_42_1 >= iter_42_1.versionId then
			table.insert(var_42_0, iter_42_1)
		end
	end

	return var_42_0
end

function var_0_0.getCurPaperCount(arg_43_0)
	local var_43_0 = arg_43_0:getPaperItemId()

	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_43_0)
end

function var_0_0.getTotalTaskRewards(arg_44_0)
	local var_44_0 = {}
	local var_44_1 = {}
	local var_44_2 = arg_44_0:getCurVersionId()

	for iter_44_0, iter_44_1 in ipairs(arg_44_0._taskBonusList) do
		if var_44_2 >= iter_44_1.versionId then
			table.insert(var_44_0, iter_44_1)
			table.insert(var_44_1, #GameUtil.splitString2(iter_44_1.bonus))
		else
			break
		end
	end

	return var_44_0, var_44_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
