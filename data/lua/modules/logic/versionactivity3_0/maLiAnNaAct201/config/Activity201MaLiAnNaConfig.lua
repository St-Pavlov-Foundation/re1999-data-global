module("modules.logic.versionactivity3_0.maLiAnNaAct201.config.Activity201MaLiAnNaConfig", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaConfig", BaseConfig)

var_0_0._ActivityDataName = "T_lua_MaLiAnNa_ActivityData"

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity203_const",
		"activity203_episode",
		"activity203_task",
		"activity203_game",
		"activity203_base",
		"activity203_soldier",
		"activity203_skill",
		"activity203_passiveskill",
		"activity203_dialog",
		"activity203_ai"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.triggerList = {}
	arg_2_0._taskDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0._initMaLiAnNaLevelData(arg_4_0)
	arg_4_0._maLiAnNaLevelData = {}

	if _G[arg_4_0._ActivityDataName] == nil then
		return
	end

	for iter_4_0 = 1, #T_lua_MaLiAnNa_ActivityData do
		local var_4_0 = _G[arg_4_0._ActivityDataName][iter_4_0]
		local var_4_1 = MaLiAnNaLaLevelMo.New()

		var_4_1:init(var_4_0)

		arg_4_0._maLiAnNaLevelData[var_4_0.id] = var_4_1
	end
end

function var_0_0.getMaLiAnNaLevelData(arg_5_0)
	if arg_5_0._maLiAnNaLevelData == nil then
		arg_5_0:_initMaLiAnNaLevelData()
	end

	return arg_5_0._maLiAnNaLevelData
end

function var_0_0.getMaLiAnNaLevelDataByLevelId(arg_6_0, arg_6_1)
	if arg_6_0._maLiAnNaLevelData == nil then
		arg_6_0:_initMaLiAnNaLevelData()
	end

	return arg_6_0._maLiAnNaLevelData[arg_6_1]
end

function var_0_0.getSlotConfigById(arg_7_0, arg_7_1)
	local var_7_0 = lua_activity203_base.configDict[arg_7_1]

	if var_7_0 == nil then
		logError("activity203_base 没有找到对应的配置 id = " .. arg_7_1)
	end

	return var_7_0
end

function var_0_0.getGameConfigById(arg_8_0, arg_8_1)
	local var_8_0 = lua_activity203_game.configDict[arg_8_1]

	if var_8_0 == nil then
		logError("activity203_game 没有找到对应的配置 id = " .. arg_8_1)
	end

	return var_8_0
end

function var_0_0.getWinConditionById(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getGameConfigById(arg_9_1)
	local var_9_1 = {}

	if var_9_0 ~= nil then
		local var_9_2 = var_9_0.gameTarget

		if not string.nilorempty(var_9_2) then
			local var_9_3 = string.split(var_9_2, "|")

			for iter_9_0 = 1, #var_9_3 do
				local var_9_4 = string.splitToNumber(var_9_3[iter_9_0], "#")

				table.insert(var_9_1, var_9_4)
			end
		end
	end

	return var_9_1
end

function var_0_0.getLoseConditionById(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getGameConfigById(arg_10_1)
	local var_10_1 = {}

	if var_10_0 ~= nil then
		local var_10_2 = var_10_0.loseTarget

		if not string.nilorempty(var_10_2) then
			local var_10_3 = string.split(var_10_2, "|")

			for iter_10_0 = 1, #var_10_3 do
				local var_10_4 = string.splitToNumber(var_10_3[iter_10_0], "#")

				table.insert(var_10_1, var_10_4)
			end
		end
	end

	return var_10_1
end

function var_0_0.getSoldierById(arg_11_0, arg_11_1)
	local var_11_0 = lua_activity203_soldier.configDict[arg_11_1]

	if var_11_0 == nil then
		logError("activity203_soldier 没有找到对应的配置 id = " .. arg_11_1)
	end

	return var_11_0
end

function var_0_0.getConstValueNumber(arg_12_0, arg_12_1)
	local var_12_0 = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local var_12_1 = lua_activity203_const.configDict[var_12_0]

	if var_12_1 == nil then
		logError("activity203_const 没有找到对应的配置 activityId = " .. var_12_0)

		return nil
	end

	local var_12_2 = var_12_1[arg_12_1]

	if var_12_2 == nil then
		logError("activity203_const 没有找到对应的配置 id = " .. arg_12_1)

		return nil
	end

	return tonumber(var_12_2.value)
end

function var_0_0.getConstValue(arg_13_0, arg_13_1)
	local var_13_0 = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local var_13_1 = lua_activity203_const.configDict[var_13_0]

	if var_13_1 == nil then
		logError("activity203_const 没有找到对应的配置 id = " .. arg_13_1)
	end

	local var_13_2 = var_13_1[arg_13_1]

	return var_13_2.value, var_13_2.value2
end

function var_0_0.getAllHeroConfig(arg_14_0)
	local var_14_0 = {}

	for iter_14_0 = 1, #lua_activity203_soldier.configList do
		local var_14_1 = lua_activity203_soldier.configList[iter_14_0]

		if var_14_1.type == Activity201MaLiAnNaEnum.SoldierType.hero then
			table.insert(var_14_0, var_14_1)
		end
	end

	return var_14_0
end

function var_0_0.getAllSlot(arg_15_0)
	return lua_activity203_base.configList
end

function var_0_0.getActiveSkillConfig(arg_16_0, arg_16_1)
	return lua_activity203_skill.configDict[arg_16_1]
end

function var_0_0.getPassiveSkillConfig(arg_17_0, arg_17_1)
	return lua_activity203_passiveskill.configDict[arg_17_1]
end

function var_0_0._initSlotConstValue(arg_18_0)
	if arg_18_0._slotConstList == nil then
		arg_18_0._slotConstList = {}
	end

	local var_18_0 = 3
	local var_18_1 = 10

	for iter_18_0 = var_18_0, var_18_1 do
		local var_18_2, var_18_3 = arg_18_0:getConstValue(iter_18_0)

		if not string.nilorempty(var_18_3) then
			local var_18_4 = string.split(var_18_3, "|")
			local var_18_5 = var_18_4[1]
			local var_18_6 = var_18_4[2]
			local var_18_7 = string.splitToNumber(var_18_6, "#")

			if #var_18_7 == 4 then
				arg_18_0._slotConstList[var_18_5] = var_18_7
			end
		end
	end
end

function var_0_0.getSlotConstValue(arg_19_0, arg_19_1)
	if arg_19_0._slotConstList == nil then
		arg_19_0:_initSlotConstValue()
	end

	local var_19_0 = arg_19_0:getSlotConfigById(arg_19_1)

	if var_19_0 == nil then
		logError("activity203_base 没有找到对应的配置 id = " .. arg_19_1)

		return 0, 0, 0, 0
	end

	local var_19_1 = var_19_0.picture
	local var_19_2 = arg_19_0._slotConstList[var_19_1]
	local var_19_3 = Activity201MaLiAnNaEnum.defaultDragRange
	local var_19_4 = Activity201MaLiAnNaEnum.defaultHideRange
	local var_19_5 = Activity201MaLiAnNaEnum.defaultOffsetX
	local var_19_6 = Activity201MaLiAnNaEnum.defaultOffsetY

	if var_19_2 ~= nil then
		var_19_3 = var_19_2[1] or Activity201MaLiAnNaEnum.defaultDragRange
		var_19_4 = var_19_2[2] or Activity201MaLiAnNaEnum.defaultHideRange
		var_19_5 = var_19_2[3] or Activity201MaLiAnNaEnum.defaultOffsetX
		var_19_6 = var_19_2[4] or Activity201MaLiAnNaEnum.defaultOffsetY
	end

	return var_19_3, var_19_4, var_19_5, var_19_6
end

function var_0_0.getEpisodeCoList(arg_20_0, arg_20_1)
	if not arg_20_0._episodeDict then
		arg_20_0._episodeDict = {}

		for iter_20_0, iter_20_1 in ipairs(lua_activity203_episode.configList) do
			if not arg_20_0._episodeDict[iter_20_1.activityId] then
				arg_20_0._episodeDict[iter_20_1.activityId] = {}
			end

			table.insert(arg_20_0._episodeDict[iter_20_1.activityId], iter_20_1)
		end
	end

	return arg_20_0._episodeDict[arg_20_1] or {}
end

function var_0_0.getLevelDialogConfig(arg_21_0, arg_21_1)
	local var_21_0 = lua_activity203_dialog.configDict[arg_21_1]

	if var_21_0 == nil then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_0.getTriggerList(arg_22_0, arg_22_1)
	if arg_22_0.triggerList == nil then
		arg_22_0.triggerList = {}
	end

	if arg_22_1 then
		if not arg_22_0.triggerList[arg_22_1] then
			local var_22_0 = string.splitToNumber(arg_22_1, "#")

			arg_22_0.triggerList[arg_22_1] = var_22_0
		end

		return arg_22_0.triggerList[arg_22_1]
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getEpisodeCoList(arg_23_1)

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1.episodeId == arg_23_2 then
			return iter_23_1
		end
	end
end

function var_0_0.getTaskByActId(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._taskDict[arg_24_1]

	if not var_24_0 then
		var_24_0 = {}

		for iter_24_0, iter_24_1 in ipairs(lua_activity203_task.configList) do
			if iter_24_1.activityId == arg_24_1 then
				table.insert(var_24_0, iter_24_1)
			end
		end

		arg_24_0._taskDict[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0.getStoryBefore(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getEpisodeCo(arg_25_1, arg_25_2)

	return var_25_0 and var_25_0.storyBefore
end

function var_0_0.getStoryClear(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getEpisodeCo(arg_26_1, arg_26_2)

	return var_26_0 and var_26_0.storyClear
end

var_0_0.instance = var_0_0.New()

return var_0_0
