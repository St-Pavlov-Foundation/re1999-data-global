module("modules.logic.versionactivity1_3.act126.model.Activity126Model", package.seeall)

local var_0_0 = class("Activity126Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.spStatus = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.isInit = nil
	arg_2_0._showDailyId = nil
	arg_2_0.spStatus = {}
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.isInit = true
	arg_3_0.activityId = arg_3_1.activityId
	arg_3_0.spStatus = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.spStatus) do
		local var_3_0 = UserDungeonSpStatusMO.New()

		var_3_0:init(iter_3_1)

		arg_3_0.spStatus[var_3_0.episodeId] = var_3_0
	end

	arg_3_0.starProgress = arg_3_1.starProgress
	arg_3_0.progressStr = arg_3_1.progressStr
	arg_3_0.horoscope = arg_3_1.horoscope
	arg_3_0.getHoroscope = arg_3_1.getHoroscope

	arg_3_0:_initList("starProgress", arg_3_1, "Act126StarMO")
	arg_3_0:_initList("getProgressBonus", arg_3_1)
	arg_3_0:_initMap("buffs", arg_3_1)
	arg_3_0:_initMap("spBuffs", arg_3_1)
	arg_3_0:_initList("dreamCards", arg_3_1)
end

function var_0_0.getDailyPassNum(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(lua_activity126_episode_daily.configList) do
		local var_4_1 = iter_4_1.id
		local var_4_2 = arg_4_0.spStatus[var_4_1]

		if var_4_2 and (var_4_2.status <= 0 or var_4_2.status == 3) then
			break
		end

		local var_4_3 = DungeonModel.instance:getEpisodeInfo(var_4_1)

		if not var_4_3 then
			break
		end

		var_4_0 = var_4_0 + var_4_3.todayPassNum
	end

	return var_4_0
end

function var_0_0.getRemainNum(arg_5_0)
	local var_5_0 = arg_5_0:getDailyPassNum()
	local var_5_1 = 1

	return math.max(0, var_5_1 - var_5_0), var_5_1
end

function var_0_0.getOpenDailyEpisodeList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(lua_activity126_episode_daily.configList) do
		local var_6_1 = iter_6_1.id
		local var_6_2 = arg_6_0.spStatus[var_6_1]

		if var_6_2 and (var_6_2.status <= 0 or var_6_2.status == 3) then
			break
		end

		local var_6_3 = DungeonModel.instance:getEpisodeInfo(var_6_1)

		if not var_6_3 then
			break
		end

		table.insert(var_6_0, var_6_3)
	end

	local var_6_4 = #var_6_0

	if var_6_4 == #lua_activity126_episode_daily.configList then
		local var_6_5 = var_6_0[var_6_4]

		if arg_6_0.spStatus[var_6_5.episodeId].status ~= 2 then
			return {
				var_6_0[var_6_4]
			}, false
		end

		return var_6_0, true
	end

	return {
		var_6_0[var_6_4]
	}, false
end

function var_0_0.changeShowDailyId(arg_7_0, arg_7_1)
	arg_7_0._showDailyId = arg_7_1

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), arg_7_1)
end

function var_0_0.getShowDailyId(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:getOpenDailyEpisodeList()

	if not var_8_1 then
		return var_8_0[1].episodeId
	end

	if not arg_8_0._showDailyId then
		arg_8_0._showDailyId = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), 0)
	end

	if arg_8_0._showDailyId and arg_8_0._showDailyId > 0 then
		return arg_8_0._showDailyId
	end

	return var_8_0[1].episodeId
end

function var_0_0.updateHoroscope(arg_9_0, arg_9_1)
	arg_9_0.horoscope = arg_9_1
end

function var_0_0.receiveHoroscope(arg_10_0)
	return arg_10_0.horoscope
end

function var_0_0.updateGetHoroscope(arg_11_0, arg_11_1)
	arg_11_0.getHoroscope = arg_11_1
end

function var_0_0.receiveGetHoroscope(arg_12_0)
	return arg_12_0.getHoroscope
end

function var_0_0.updateStarProgress(arg_13_0, arg_13_1)
	arg_13_0.horoscope = nil
	arg_13_0.progressStr = arg_13_1.progressStr

	arg_13_0:_initList("starProgress", arg_13_1, "Act126StarMO")
end

function var_0_0.getStarNum(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.starProgress) do
		var_14_0 = var_14_0 + iter_14_1.num
	end

	return var_14_0
end

function var_0_0.getStarProgressStr(arg_15_0)
	return arg_15_0.progressStr
end

function var_0_0.hasBuff(arg_16_0, arg_16_1)
	return arg_16_0.buffs[arg_16_1] or arg_16_0.spBuffs[arg_16_1]
end

function var_0_0.hasDreamCard(arg_17_0, arg_17_1)
	if not arg_17_0.spBuffs then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.spBuffs) do
		local var_17_0 = lua_activity126_buff.configDict[iter_17_0]

		if var_17_0 and var_17_0.dreamlandCard == arg_17_1 then
			return true
		end
	end
end

function var_0_0.updateGetProgressBonus(arg_18_0, arg_18_1)
	arg_18_0:_initList("getProgressBonus", arg_18_1)
end

function var_0_0.updateBuffInfo(arg_19_0, arg_19_1)
	arg_19_0:_initMap("buffs", arg_19_1)
	arg_19_0:_initMap("spBuffs", arg_19_1)
	arg_19_0:_initList("dreamCards", arg_19_1)
end

function var_0_0._initList(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}
	local var_20_1 = arg_20_2[arg_20_1]

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if arg_20_3 then
			local var_20_2 = _G[arg_20_3].New()

			var_20_2:init(iter_20_1)

			var_20_0[iter_20_0] = var_20_2
		else
			var_20_0[iter_20_0] = iter_20_1
		end
	end

	arg_20_0[arg_20_1] = var_20_0
end

function var_0_0._initMap(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = arg_21_2[arg_21_1]

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		var_21_0[iter_21_1] = iter_21_1
	end

	arg_21_0[arg_21_1] = var_21_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
