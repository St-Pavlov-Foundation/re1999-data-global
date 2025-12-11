module("modules.logic.roomfishing.model.FishingModel", package.seeall)

local var_0_0 = class("FishingModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0.myselfPoolInfo = nil
	arg_3_0.otherPoolInfo = nil
end

function var_0_0.updateMyselfPoolInfo(arg_4_0, arg_4_1)
	if not arg_4_0.myselfPoolInfo then
		arg_4_0.myselfPoolInfo = FishingPoolInfoMO.New()
	end

	local var_4_0 = PlayerModel.instance:getMyUserId()

	arg_4_0.myselfPoolInfo:init(var_4_0, arg_4_1)
	arg_4_0:setHasExchangedTimes(arg_4_1.changeCount)
	arg_4_0:setHasGotShareRewardTimes(arg_4_1.todayAcceptShareCount)
	FishingFriendListModel.instance:setFriendList()
end

function var_0_0.setHasExchangedTimes(arg_5_0, arg_5_1)
	arg_5_0._hasExchangedTimes = arg_5_1 or 0
end

function var_0_0.setHasGotShareRewardTimes(arg_6_0, arg_6_1)
	arg_6_0._hasGotShareRewardTimes = arg_6_1 or 0
end

function var_0_0.updateMyProgressInfo(arg_7_0, arg_7_1)
	if arg_7_0.myselfPoolInfo then
		arg_7_0.myselfPoolInfo:updateFishingProgressInfo(arg_7_1)
		FishingFriendListModel.instance:setFriendList()
	end
end

function var_0_0.updateOtherPoolInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0.otherPoolInfo then
		arg_8_0.otherPoolInfo = FishingPoolInfoMO.New()
	end

	arg_8_0.otherPoolInfo:init(arg_8_1, arg_8_2)
	arg_8_0.otherPoolInfo:setFriendInfo(arg_8_3)
end

function var_0_0.isUnlockRoomFishing(arg_9_0, arg_9_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoomFishing) then
		if arg_9_1 then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.RoomFishing))
		end

		return false
	end

	local var_9_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishingActId, true)
	local var_9_1, var_9_2, var_9_3 = ActivityHelper.getActivityStatusAndToast(var_9_0)

	if not (var_9_1 == ActivityEnum.ActivityStatus.Normal) then
		if var_9_2 and arg_9_1 then
			GameFacade.showToastWithTableParam(var_9_2, var_9_3)
		end

		return false
	end

	return true
end

function var_0_0.getIsShowingMySelf(arg_10_0)
	return (RoomController.instance:isFishingMode())
end

function var_0_0.isInFishing(arg_11_0)
	local var_11_0 = arg_11_0:getIsShowingMySelf()
	local var_11_1 = RoomController.instance:isFishingVisitMode()

	return var_11_0 or var_11_1
end

function var_0_0.isEnoughToFish(arg_12_0, arg_12_1)
	local var_12_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")

	return arg_12_1 * var_12_0[2] <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_12_0[1])
end

function var_0_0.getCurFishingPoolInfo(arg_13_0)
	local var_13_0

	if arg_13_0:isInFishing() then
		if arg_13_0:getIsShowingMySelf() then
			var_13_0 = arg_13_0.myselfPoolInfo
		else
			var_13_0 = arg_13_0.otherPoolInfo
		end
	end

	return var_13_0
end

function var_0_0.getCurFishingPoolId(arg_14_0)
	local var_14_0 = arg_14_0:getCurFishingPoolInfo()

	return var_14_0 and var_14_0:getPoolId()
end

function var_0_0.getCurShowingUserId(arg_15_0)
	local var_15_0 = arg_15_0:getCurFishingPoolInfo()

	return var_15_0 and var_15_0:getUserId()
end

function var_0_0.getCurFishingPoolUserInfo(arg_16_0)
	local var_16_0 = arg_16_0:getCurFishingPoolInfo()

	if var_16_0 then
		return var_16_0:getOwnerInfo()
	end
end

function var_0_0.getCurFishingPoolItem(arg_17_0)
	local var_17_0 = arg_17_0:getCurFishingPoolId()

	return (FishingConfig.instance:getFishingPoolItem(var_17_0))
end

function var_0_0.getCurFishingPoolRefreshTime(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = false

	if not arg_18_0:isUnlockRoomFishing() then
		return var_18_0, var_18_1
	end

	local var_18_2 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishingActId, true)
	local var_18_3 = ActivityModel.instance:getActStartTime(var_18_2) / 1000
	local var_18_4 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.PoolRefreshInterval, true) * TimeUtil.OneDaySecond
	local var_18_5 = ServerTime.now() - var_18_3
	local var_18_6 = var_18_5 % var_18_4
	local var_18_7 = math.max(0, var_18_4 - var_18_6)
	local var_18_8 = arg_18_0:getCurFishingPoolInfo()

	if var_18_8 then
		local var_18_9 = math.floor(var_18_5 / var_18_4)
		local var_18_10 = var_18_8:getLastRefreshTime()

		var_18_1 = math.floor((var_18_10 - var_18_3) / var_18_4) ~= var_18_9
	end

	return var_18_7, var_18_1
end

function var_0_0.getRemainFishingTime(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = arg_19_0.myselfPoolInfo and arg_19_0.myselfPoolInfo:getMyProgressInfo(arg_19_1)
	local var_19_2 = var_19_1 and var_19_1.startTime
	local var_19_3 = var_19_1 and var_19_1.finishTime

	if var_19_2 and var_19_3 and var_19_2 > 0 and var_19_3 > 0 and var_19_2 < var_19_3 then
		local var_19_4 = ServerTime.now()

		var_19_0 = math.max(var_19_0, var_19_3 - var_19_4)
	end

	return var_19_0
end

local var_0_1 = 1

function var_0_0.getFriendBoatInfoList(arg_20_0)
	local var_20_0 = arg_20_0:getCurFishingPoolInfo()
	local var_20_1 = var_20_0 and var_20_0:getBoatInfoList() or {}

	if not arg_20_0:getIsShowingMySelf() then
		local var_20_2 = false
		local var_20_3 = PlayerModel.instance:getMyUserId()

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			if iter_20_1.userId == var_20_3 then
				var_20_2 = iter_20_0

				break
			end
		end

		if var_20_2 then
			if var_20_2 ~= var_0_1 then
				local var_20_4 = table.remove(var_20_1, var_20_2)

				table.insert(var_20_1, var_0_1, var_20_4)
			end
		else
			local var_20_5 = var_20_0 and var_20_0:getUserId()
			local var_20_6 = SocialModel.instance:isMyFriendByUserId(var_20_5)

			table.insert(var_20_1, var_0_1, {
				isFriend = var_20_6,
				userId = var_20_3
			})
		end
	end

	return var_20_1
end

function var_0_0.getFishingFriendInfo(arg_21_0, arg_21_1)
	if arg_21_1 == arg_21_0:getCurShowingUserId() then
		local var_21_0, var_21_1, var_21_2 = arg_21_0:getCurFishingPoolUserInfo()

		return var_21_1, var_21_2
	else
		local var_21_3 = arg_21_0:getCurFishingPoolInfo()

		if var_21_3 then
			return var_21_3:getBoatUserInfo(arg_21_1)
		end
	end
end

function var_0_0.getIsFishingInUserPool(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.myselfPoolInfo and arg_22_0.myselfPoolInfo:getMyProgressInfo(arg_22_1)
	local var_22_1 = var_22_0 and var_22_0.startTime
	local var_22_2 = var_22_0 and var_22_0.finishTime
	local var_22_3 = false

	if var_22_1 and var_22_2 and var_22_1 > 0 and var_22_2 > 0 and var_22_1 < var_22_2 then
		var_22_3 = true
	end

	return var_22_3
end

function var_0_0.getFishingTimes(arg_23_0, arg_23_1)
	local var_23_0 = 0
	local var_23_1 = arg_23_0.myselfPoolInfo and arg_23_0.myselfPoolInfo:getMyProgressInfo(arg_23_1)

	var_23_0 = var_23_1 and var_23_1.fishTimes or var_23_0

	return var_23_0
end

function var_0_0.getMyFishingProgress(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.myselfPoolInfo and arg_24_0.myselfPoolInfo:getMyProgressInfo(arg_24_1)
	local var_24_1 = var_24_0 and var_24_0.startTime
	local var_24_2 = var_24_0 and var_24_0.finishTime

	return (FishingHelper.getFishingProgress(var_24_1, var_24_2))
end

function var_0_0.isCanGetMyFishingBonusInUser(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.myselfPoolInfo and arg_25_0.myselfPoolInfo:getMyProgressInfo(arg_25_1)
	local var_25_1 = var_25_0 and var_25_0.startTime
	local var_25_2 = var_25_0 and var_25_0.finishTime

	return (FishingHelper.isFishingFinished(var_25_1, var_25_2))
end

function var_0_0.isCanGetMyFishingBonus(arg_26_0)
	local var_26_0 = arg_26_0.myselfPoolInfo and arg_26_0.myselfPoolInfo:getMyProgressInfoDict()

	if var_26_0 then
		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			if arg_26_0:isCanGetMyFishingBonusInUser(iter_26_0) then
				return true
			end
		end
	end
end

function var_0_0.isCanGetOtherFishingBonus(arg_27_0)
	if arg_27_0:getHasGotShareRewardTimes() >= FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxCanGetShareRewardTimes, true, "") then
		return false
	end

	local var_27_0 = 0
	local var_27_1 = arg_27_0.myselfPoolInfo and arg_27_0.myselfPoolInfo:getOtherProgressInfoDict()

	if var_27_1 then
		for iter_27_0, iter_27_1 in pairs(var_27_1) do
			local var_27_2 = iter_27_1 and iter_27_1.startTime
			local var_27_3 = iter_27_1 and iter_27_1.finishTime

			if FishingHelper.isFishingFinished(var_27_2, var_27_3) then
				var_27_0 = var_27_0 + 1
			end
		end
	end

	return var_27_0 >= FishingConfig.instance:getFishingConst(FishingEnum.ConstId.GetFriendBonusMinCount, true)
end

function var_0_0.getMyFishingCount(arg_28_0)
	local var_28_0 = 0

	if arg_28_0.myselfPoolInfo then
		var_28_0 = arg_28_0.myselfPoolInfo:getFishingCount()
	end

	return var_28_0
end

function var_0_0.getMyFishingFriendList(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = arg_29_0.myselfPoolInfo and arg_29_0.myselfPoolInfo:getMyProgressInfoDict()

	if var_29_1 then
		local var_29_2 = PlayerModel.instance:getMyUserId()

		for iter_29_0, iter_29_1 in pairs(var_29_1) do
			if iter_29_0 ~= var_29_2 then
				local var_29_3 = FishingFriendInfoMO.New()
				local var_29_4 = SocialModel.instance:isMyFriendByUserId(iter_29_0)

				var_29_3:init({
					type = var_29_4 and FishingEnum.OtherPlayerBoatType.Friend or FishingEnum.OtherPlayerBoatType.Stranger,
					userId = iter_29_0,
					name = iter_29_1.name,
					portrait = iter_29_1.portrait,
					poolId = iter_29_1.poolId
				})

				var_29_0[#var_29_0 + 1] = var_29_3
			end
		end
	end

	return var_29_0
end

local function var_0_2(arg_30_0, arg_30_1)
	if not arg_30_0 or not arg_30_1 then
		return false
	end

	local var_30_0 = arg_30_0.id
	local var_30_1 = arg_30_1.id
	local var_30_2 = arg_30_0.rare
	local var_30_3 = arg_30_1.rare

	if var_30_2 ~= var_30_3 then
		return var_30_3 < var_30_2
	end

	return var_30_1 < var_30_0
end

function var_0_0.getBackpackItemList(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = CurrencyModel.instance:getCurrencyList() or {}

	for iter_31_0, iter_31_1 in pairs(var_31_1) do
		local var_31_2 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, iter_31_1.currencyId)

		if (var_31_2 and var_31_2.subType) == CurrencyEnum.SubType.RoomFishingResourceItem and iter_31_1.quantity > 0 then
			table.insert(var_31_0, {
				id = iter_31_1.currencyId,
				type = MaterialEnum.MaterialType.Currency,
				quantity = iter_31_1.quantity,
				rare = var_31_2.rare
			})
		end
	end

	table.sort(var_31_0, var_0_2)

	return var_31_0
end

function var_0_0.getFishingItemList(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {}

	if not arg_32_1 then
		return var_32_0
	end

	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		local var_32_2

		if arg_32_3 then
			var_32_2 = FishingConfig.instance:getFishingShareItem(iter_32_1)
		else
			var_32_2 = FishingConfig.instance:getFishingPoolItem(iter_32_1)
		end

		if var_32_2 then
			local var_32_3 = var_32_2[2]

			if not var_32_1[var_32_3] then
				local var_32_4 = ItemModel.instance:getItemConfig(var_32_2[1], var_32_2[2])

				var_32_1[var_32_3] = {
					quantity = 0,
					type = var_32_2[1],
					id = var_32_3,
					rare = var_32_4.rare
				}
			end

			local var_32_5 = arg_32_2[iter_32_1] or 0

			var_32_1[var_32_3].quantity = var_32_1[var_32_3].quantity + var_32_2[3] * var_32_5
		end
	end

	for iter_32_2, iter_32_3 in pairs(var_32_1) do
		var_32_0[#var_32_0 + 1] = iter_32_3
	end

	table.sort(var_32_0, var_0_2)

	return var_32_0
end

function var_0_0.getHasExchangedTimes(arg_33_0)
	return arg_33_0._hasExchangedTimes or 0
end

function var_0_0.getHasGotShareRewardTimes(arg_34_0)
	return arg_34_0._hasGotShareRewardTimes or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
