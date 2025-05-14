module("modules.logic.versionactivity1_3.chess.model.Activity122Model", package.seeall)

local var_0_0 = class("Activity122Model", BaseModel)
local var_0_1 = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0.cacheData = nil
	arg_1_0.playerCacheData = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.cacheData = nil
	arg_2_0.playerCacheData = nil
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._curActivityId
end

function var_0_0.setCurEpisodeId(arg_4_0, arg_4_1)
	arg_4_0._curEpisodeId = arg_4_1
end

function var_0_0.getCurEpisodeId(arg_5_0)
	return arg_5_0._curEpisodeId
end

function var_0_0.getCurEpisodeSightMap(arg_6_0)
	return arg_6_0._curEpisodeSightMap
end

function var_0_0.checkPosIndexInSight(arg_7_0, arg_7_1)
	return arg_7_0._curEpisodeSightMap[arg_7_1]
end

function var_0_0.getCurEpisodeFireMap(arg_8_0)
	return arg_8_0._curEpisodeFireMap
end

function var_0_0.checkPosIndexInFire(arg_9_0, arg_9_1)
	return arg_9_0._curEpisodeFireMap[arg_9_1]
end

function var_0_0.onReceiveGetAct122InfoReply(arg_10_0, arg_10_1)
	arg_10_0._curActivityId = arg_10_1.activityId
	arg_10_0._curEpisodeId = arg_10_1.lastEpisodeId > 0 and arg_10_1.lastEpisodeId or var_0_1
	arg_10_0._episodeInfoData = {}

	local var_10_0 = arg_10_1.act122Episodes

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.act122Episodes) do
		local var_10_1 = iter_10_1.id

		arg_10_0._episodeInfoData[var_10_1] = {}
		arg_10_0._episodeInfoData[var_10_1].id = iter_10_1.id
		arg_10_0._episodeInfoData[var_10_1].star = iter_10_1.star
		arg_10_0._episodeInfoData[var_10_1].totalCount = iter_10_1.totalCount
	end

	if arg_10_1.map and arg_10_1.map.allFinishInteracts then
		Va3ChessGameModel.instance:updateFinishInteracts(arg_10_1.map.finishInteracts)
		Va3ChessGameModel.instance:updateAllFinishInteracts(arg_10_1.map.allFinishInteracts)
	end
end

function var_0_0.onReceiveAct122StartEpisodeReply(arg_11_0, arg_11_1)
	arg_11_0:increaseCount(arg_11_1.map.id)

	local var_11_0 = arg_11_1.map.act122Sight

	arg_11_0:initSight(var_11_0)

	local var_11_1 = arg_11_1.map.act122Fire

	arg_11_0:initFire(var_11_1)
end

function var_0_0.initSight(arg_12_0, arg_12_1)
	arg_12_0._curEpisodeSightMap = {}

	local var_12_0 = arg_12_1

	if not var_12_0 then
		return
	end

	local var_12_1 = #var_12_0

	for iter_12_0 = 1, var_12_1 do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = Va3ChessMapUtils.calPosIndex(var_12_2.x, var_12_2.y)

		arg_12_0._curEpisodeSightMap[var_12_3] = true
	end
end

function var_0_0.updateSight(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1

	if not var_13_0 then
		return
	end

	arg_13_0._curEpisodeSightMap = arg_13_0._curEpisodeSightMap or {}

	local var_13_1 = #var_13_0

	for iter_13_0 = 1, var_13_1 do
		local var_13_2 = var_13_0[iter_13_0]
		local var_13_3 = Va3ChessMapUtils.calPosIndex(var_13_2.x, var_13_2.y)

		arg_13_0._curEpisodeSightMap[var_13_3] = true
	end
end

function var_0_0.initFire(arg_14_0, arg_14_1)
	arg_14_0._curEpisodeFireMap = {}

	local var_14_0 = arg_14_1

	if not var_14_0 then
		return
	end

	local var_14_1 = #var_14_0

	for iter_14_0 = 1, var_14_1 do
		local var_14_2 = var_14_0[iter_14_0]
		local var_14_3 = Va3ChessMapUtils.calPosIndex(var_14_2.x, var_14_2.y)

		arg_14_0._curEpisodeFireMap[var_14_3] = true
	end
end

function var_0_0.updateFire(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1

	if not var_15_0 then
		return
	end

	local var_15_1 = #var_15_0

	for iter_15_0 = 1, var_15_1 do
		local var_15_2 = var_15_0[iter_15_0]
		local var_15_3 = Va3ChessMapUtils.calPosIndex(var_15_2.x, var_15_2.y)

		arg_15_0._curEpisodeFireMap[var_15_3] = true
	end
end

function var_0_0.getEpisodeData(arg_16_0, arg_16_1)
	return arg_16_0._episodeInfoData and arg_16_0._episodeInfoData[arg_16_1]
end

function var_0_0.isEpisodeClear(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getEpisodeData(arg_17_1)

	if var_17_0 then
		return var_17_0.star > 0
	end

	return false
end

function var_0_0.isEpisodeOpen(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getEpisodeData(arg_18_1)

	if not var_18_0 then
		return false
	end

	local var_18_1 = Activity122Config.instance:getEpisodeCo(arg_18_0:getCurActivityID(), var_18_0.id)

	return var_18_1.preEpisode == 0 or arg_18_0:isEpisodeClear(var_18_1.preEpisode)
end

function var_0_0.getTaskData(arg_19_0, arg_19_1)
	return TaskModel.instance:getTaskById(arg_19_1)
end

function var_0_0.increaseCount(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._episodeInfoData and arg_20_0._episodeInfoData[arg_20_1]

	if var_20_0 then
		var_20_0.totalCount = var_20_0.totalCount + 1
	end
end

function var_0_0.getPlayerCacheData(arg_21_0)
	if not arg_21_0.cacheData then
		local var_21_0 = tostring(PlayerModel.instance:getMyUserId())
		local var_21_1 = PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_3_Roel2ChessKey, "")

		if not string.nilorempty(var_21_1) then
			arg_21_0.cacheData = cjson.decode(var_21_1)
			arg_21_0.playerCacheData = arg_21_0.cacheData[var_21_0]
		end

		if not arg_21_0.cacheData then
			arg_21_0.cacheData = {}
		end

		if not arg_21_0.playerCacheData then
			arg_21_0.playerCacheData = {}
			arg_21_0.playerCacheData.isNextChapterLock = true
			arg_21_0.playerCacheData.lockNodeList = {}
			arg_21_0.cacheData[var_21_0] = arg_21_0.playerCacheData

			arg_21_0:saveCacheData()
		end
	end

	return arg_21_0.playerCacheData
end

function var_0_0.saveCacheData(arg_22_0)
	if not arg_22_0.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_3_Roel2ChessKey, cjson.encode(arg_22_0.cacheData))
end

var_0_0.instance = var_0_0.New()

return var_0_0
