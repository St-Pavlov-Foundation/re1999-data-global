module("modules.logic.versionactivity1_5.act142.model.Activity142Model", package.seeall)

local var_0_0 = class("Activity142Model", BaseModel)
local var_0_1 = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)

	arg_3_0._activityId = nil
	arg_3_0._curEpisodeId = nil
	arg_3_0._episodeInfoData = {}
	arg_3_0._hasCollectionDict = {}

	arg_3_0:clearCacheData()
end

function var_0_0.onReceiveGetAct142InfoReply(arg_4_0, arg_4_1)
	arg_4_0._activityId = arg_4_1.activityId
	arg_4_0._episodeInfoData = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.episodes) do
		local var_4_0 = iter_4_1.id

		arg_4_0._episodeInfoData[var_4_0] = {}
		arg_4_0._episodeInfoData[var_4_0].id = iter_4_1.id
		arg_4_0._episodeInfoData[var_4_0].star = iter_4_1.star
		arg_4_0._episodeInfoData[var_4_0].totalCount = iter_4_1.totalCount
	end
end

function var_0_0.getRemainTimeStr(arg_5_0, arg_5_1)
	local var_5_0 = ""
	local var_5_1 = ActivityModel.instance:getActMO(arg_5_1)

	if var_5_1 then
		local var_5_2 = var_5_1:getRemainTimeStr3()

		var_5_0 = string.format(luaLang("remain"), var_5_2)
	else
		var_5_0 = string.format(luaLang("activity_warmup_remain_time"), "0")
	end

	return var_5_0
end

function var_0_0.getActivityId(arg_6_0)
	return arg_6_0._activityId or VersionActivity1_5Enum.ActivityId.Activity142
end

function var_0_0.setCurEpisodeId(arg_7_0, arg_7_1)
	arg_7_0._curEpisodeId = arg_7_1
end

function var_0_0.getCurEpisodeId(arg_8_0)
	return arg_8_0._curEpisodeId or var_0_1
end

function var_0_0.getEpisodeData(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_0._episodeInfoData then
		var_9_0 = arg_9_0._episodeInfoData[arg_9_1]
	end

	return var_9_0
end

function var_0_0.isEpisodeClear(arg_10_0, arg_10_1)
	local var_10_0 = false
	local var_10_1 = arg_10_0:getEpisodeData(arg_10_1)

	if var_10_1 then
		var_10_0 = var_10_1.star > 0
	end

	return var_10_0
end

function var_0_0.isOpenDay(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = false
	local var_11_1 = ActivityModel.instance:getActMO(arg_11_1)
	local var_11_2 = Activity142Config.instance:getEpisodeOpenDay(arg_11_1, arg_11_2)

	if var_11_1 and var_11_2 and var_11_1:getRealStartTimeStamp() + (var_11_2 - 1) * TimeUtil.OneDaySecond < ServerTime.now() then
		var_11_0 = true
	end

	return var_11_0
end

function var_0_0.isPreEpisodeClear(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = false
	local var_12_1 = Activity142Config.instance:getEpisodePreEpisode(arg_12_1, arg_12_2)

	return var_12_1 == 0 and true or arg_12_0:isEpisodeClear(var_12_1)
end

function var_0_0.isEpisodeOpen(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:isOpenDay(arg_13_1, arg_13_2)

	return arg_13_0:isPreEpisodeClear(arg_13_1, arg_13_2) and var_13_0
end

function var_0_0.onReceiveAct142StartEpisodeReply(arg_14_0, arg_14_1)
	arg_14_0:increaseCount(arg_14_1.map.id)
end

function var_0_0.increaseCount(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._episodeInfoData and arg_15_0._episodeInfoData[arg_15_1]

	if var_15_0 then
		var_15_0.totalCount = var_15_0.totalCount + 1
	end
end

function var_0_0.setHasCollection(arg_16_0, arg_16_1)
	if not arg_16_0._hasCollectionDict then
		arg_16_0._hasCollectionDict = {}
	end

	arg_16_0._hasCollectionDict[arg_16_1] = true
end

function var_0_0.getHadCollectionCount(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = arg_17_0:getActivityId()
	local var_17_2 = Activity142Config.instance:getCollectionList(var_17_1)

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		if arg_17_0:isHasCollection(iter_17_1) then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_0.getHadCollectionIdList(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = arg_18_0:getActivityId()
	local var_18_2 = Activity142Config.instance:getCollectionList(var_18_1)

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		if arg_18_0:isHasCollection(iter_18_1) then
			var_18_0[#var_18_0 + 1] = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0.isHasCollection(arg_19_0, arg_19_1)
	local var_19_0 = false

	if arg_19_0._hasCollectionDict and arg_19_0._hasCollectionDict[arg_19_1] then
		var_19_0 = true
	end

	return var_19_0
end

function var_0_0.getPlayerCacheData(arg_20_0)
	local var_20_0 = PlayerModel.instance:getMyUserId()

	if not var_20_0 or var_20_0 == 0 then
		return
	end

	local var_20_1 = tostring(var_20_0)

	if not arg_20_0.cacheData then
		local var_20_2 = PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_5_Act142ChessKey, "")

		if not string.nilorempty(var_20_2) then
			arg_20_0.cacheData = cjson.decode(var_20_2)
			arg_20_0.playerCacheData = arg_20_0.cacheData[var_20_1]
		end

		arg_20_0.cacheData = arg_20_0.cacheData or {}
	end

	if not arg_20_0.playerCacheData then
		arg_20_0.playerCacheData = {}
		arg_20_0.cacheData[var_20_1] = arg_20_0.playerCacheData

		arg_20_0:saveCacheData()
	end

	return arg_20_0.playerCacheData
end

function var_0_0.saveCacheData(arg_21_0)
	if not arg_21_0.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_5_Act142ChessKey, cjson.encode(arg_21_0.cacheData))
end

function var_0_0.clearCacheData(arg_22_0)
	arg_22_0.cacheData = nil
	arg_22_0.playerCacheData = nil
end

function var_0_0.getStarCount(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = Va3ChessGameModel.instance:getActId()
	local var_23_2 = Va3ChessModel.instance:getEpisodeId()

	if not var_23_1 or not var_23_2 then
		return var_23_0
	end

	local var_23_3 = Va3ChessConfig.instance:getEpisodeCo(var_23_1, var_23_2)

	if not var_23_3 then
		return var_23_0
	end

	if Activity142Helper.checkConditionIsFinish(var_23_3.mainConfition, var_23_1) then
		var_23_0 = var_23_0 + 1
	end

	if Activity142Helper.checkConditionIsFinish(var_23_3.extStarCondition, var_23_1) then
		var_23_0 = var_23_0 + 1
	end

	return var_23_0
end

function var_0_0.isChapterOpen(arg_24_0, arg_24_1)
	local var_24_0 = false
	local var_24_1 = arg_24_0:getActivityId()
	local var_24_2 = Activity142Config.instance:getChapterEpisodeIdList(var_24_1, arg_24_1)
	local var_24_3 = var_24_2 and var_24_2[1]

	if var_24_3 then
		var_24_0 = arg_24_0:isEpisodeOpen(var_24_1, var_24_3)
	end

	return var_24_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
