module("modules.logic.roomfishing.model.FishingPoolInfoMO", package.seeall)

local var_0_0 = pureTable("FishingPoolInfoMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.userId = arg_1_1
	arg_1_0.poolId = arg_1_2.poolId
	arg_1_0.refreshTime = arg_1_2.refreshTime

	arg_1_0:updateBoatInfos(arg_1_2.boatsInfo)
	arg_1_0:updateFishingProgressInfos(arg_1_2.fishingProgress)
end

function var_0_0.updateBoatInfos(arg_2_0, arg_2_1)
	arg_2_0._boatInfoDict = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			arg_2_0._boatInfoDict[iter_2_1.userId] = {
				isFriend = iter_2_1.type == FishingEnum.OtherPlayerBoatType.Friend,
				userId = iter_2_1.userId,
				name = iter_2_1.name,
				portrait = iter_2_1.portrait
			}
		end
	end
end

function var_0_0.updateFishingProgressInfos(arg_3_0, arg_3_1)
	arg_3_0.myProgressInfoDict = {}
	arg_3_0.otherProgressInfoDict = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			arg_3_0:updateFishingProgressInfo(iter_3_1)
		end
	end
end

function var_0_0.updateFishingProgressInfo(arg_4_0, arg_4_1)
	local var_4_0 = {
		userId = arg_4_1.fisheryUserId,
		poolId = arg_4_1.poolId,
		fishTimes = arg_4_1.fishTimes,
		startTime = arg_4_1.startTime,
		finishTime = arg_4_1.finishTime,
		name = arg_4_1.name,
		portrait = arg_4_1.portrait
	}

	if arg_4_1.type == FishingEnum.FishingProgressType.Myself then
		arg_4_0.myProgressInfoDict[var_4_0.userId] = var_4_0
	else
		arg_4_0.otherProgressInfoDict[var_4_0.userId] = var_4_0
	end
end

function var_0_0.setFriendInfo(arg_5_0, arg_5_1)
	arg_5_0._friendName = arg_5_1.name
	arg_5_0._friendPortrait = arg_5_1.portrait
end

function var_0_0.getUserId(arg_6_0)
	return arg_6_0.userId
end

function var_0_0.getPoolId(arg_7_0)
	return arg_7_0.poolId
end

function var_0_0.getLastRefreshTime(arg_8_0)
	return arg_8_0.refreshTime or 0
end

function var_0_0.getOwnerInfo(arg_9_0)
	local var_9_0 = arg_9_0:getUserId()
	local var_9_1 = ""
	local var_9_2 = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)

	if var_9_0 == PlayerModel.instance:getMyUserId() then
		var_9_1 = luaLang("p_roomview_fishing_myself")
		var_9_2 = PlayerModel.instance:getPlayinfo().portrait
	else
		var_9_1 = arg_9_0._friendName or var_9_1
		var_9_2 = arg_9_0._friendPortrait or var_9_2
	end

	return var_9_0, var_9_1, var_9_2
end

function var_0_0.getBoatInfoList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._boatInfoDict) do
		var_10_0[#var_10_0 + 1] = iter_10_1
	end

	return var_10_0
end

function var_0_0.getBoatUserInfo(arg_11_0, arg_11_1)
	local var_11_0 = ""
	local var_11_1 = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)
	local var_11_2 = arg_11_0._boatInfoDict and arg_11_0._boatInfoDict[arg_11_1]

	if var_11_2 then
		var_11_0 = var_11_2.name
		var_11_1 = var_11_2.portrait
	end

	return var_11_0, var_11_1
end

function var_0_0.getMyProgressInfoDict(arg_12_0)
	return arg_12_0.myProgressInfoDict
end

function var_0_0.getOtherProgressInfoDict(arg_13_0)
	return arg_13_0.otherProgressInfoDict
end

function var_0_0.getMyProgressInfo(arg_14_0, arg_14_1)
	return arg_14_0.myProgressInfoDict and arg_14_0.myProgressInfoDict[arg_14_1]
end

function var_0_0.getFishingCount(arg_15_0)
	local var_15_0 = 0

	if arg_15_0.myProgressInfoDict then
		for iter_15_0, iter_15_1 in pairs(arg_15_0.myProgressInfoDict) do
			local var_15_1 = iter_15_1.startTime
			local var_15_2 = iter_15_1.finishTime

			if not FishingHelper.isFishingFinished(var_15_1, var_15_2) then
				var_15_0 = var_15_0 + 1
			end
		end
	end

	return var_15_0
end

return var_0_0
