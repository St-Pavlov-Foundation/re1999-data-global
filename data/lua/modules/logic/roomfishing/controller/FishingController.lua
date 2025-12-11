module("modules.logic.roomfishing.controller.FishingController", package.seeall)

local var_0_0 = class("FishingController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._lastGetFriendInfoTime = nil
	arg_4_0._enterFishingTime = nil
	arg_4_0._tmpPrePoolUserId = nil
end

function var_0_0.enterFishingMode(arg_5_0, arg_5_1)
	if not FishingModel.instance:isUnlockRoomFishing(true) then
		return
	end

	if arg_5_1 then
		local var_5_0 = FishingModel.instance:getCurShowingUserId()
		local var_5_1 = PlayerModel.instance:getMyUserId()

		arg_5_0:sendExitFishingTrack(StatEnum.RoomFishingResult.VisitBack, var_5_0, var_5_1, true)
	else
		arg_5_0._enterFishingTime = UnityEngine.Time.realtimeSinceStartup
	end

	RoomController.instance:enterRoom(RoomEnum.GameMode.Fishing, nil, nil, nil, nil, nil, true)
end

function var_0_0.openFishingStoreView(arg_6_0)
	if not FishingModel.instance:isUnlockRoomFishing() then
		return
	end

	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.RoomFishingStore
	}, arg_6_0._afterGetStoreInfo, arg_6_0)
end

function var_0_0._afterGetStoreInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomFishingStoreView)
end

function var_0_0.openFishingRewardView(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 and not arg_8_2 then
		return
	end

	local var_8_0 = GuideController.instance:isGuiding()
	local var_8_1 = GuideController.instance:isForbidGuides()

	if var_8_0 and not var_8_1 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomFishingRewardView, {
		myFishingInfo = arg_8_1,
		otherFishingInfo = arg_8_2
	})
end

function var_0_0.selectFriendTab(arg_9_0, arg_9_1)
	FishingFriendListModel.instance:onSelectFriendTab(arg_9_1)
	arg_9_0:dispatchEvent(FishingEvent.OnSelectFriendTab)
end

function var_0_0.getFishingInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 then
		FishingRpc.instance:sendGetOtherFishingInfoRequest(arg_10_1, arg_10_2, arg_10_3)
	else
		FishingRpc.instance:sendGetFishingInfoRequest(arg_10_2, arg_10_3)
	end
end

function var_0_0.beginFishing(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 then
		return
	end

	local var_11_0 = FishingModel.instance:getCurShowingUserId()

	if FishingModel.instance:getIsFishingInUserPool(var_11_0) then
		return
	end

	local var_11_1 = 0
	local var_11_2 = FishingModel.instance:getCurFishingPoolId()
	local var_11_3 = FishingConfig.instance:getFishingTime(var_11_2)

	if var_11_3 then
		var_11_1 = var_11_3 * arg_11_1
	end

	if not (var_11_1 < FishingModel.instance:getCurFishingPoolRefreshTime()) then
		GameFacade.showToast(ToastEnum.NoTimeToFishing)

		return
	end

	if not FishingModel.instance:isEnoughToFish(arg_11_1) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomFishingCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, arg_11_0.openFishingExchange, nil, nil, arg_11_0)

		return
	end

	local var_11_4 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxInFishingCount, true, "#")

	if FishingModel.instance:getMyFishingCount() >= var_11_4[1] then
		GameFacade.showToast(var_11_4[2], var_11_4[1])

		return
	end

	FishingRpc.instance:sendFishingRequest(var_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:dispatchEvent(FishingEvent.ShowFishingTip, false)
end

function var_0_0.checkGetBonus(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = FishingModel.instance:getCurShowingUserId()
	local var_12_1 = FishingModel.instance:isCanGetMyFishingBonusInUser(var_12_0)
	local var_12_2 = FishingModel.instance:getIsShowingMySelf()

	if not var_12_1 and var_12_2 then
		local var_12_3 = FishingModel.instance:isCanGetMyFishingBonus()
		local var_12_4 = FishingModel.instance:isCanGetOtherFishingBonus()

		var_12_1 = var_12_3 or var_12_4
	end

	if var_12_1 then
		FishingRpc.instance:sendGetFishingBonusRequest(arg_12_1, arg_12_2)

		return true
	end
end

function var_0_0.exchangeFishingCurrency(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local var_13_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_13_0[1])
	local var_13_2 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0

	if var_13_2 < var_13_1 + arg_13_1 then
		GameFacade.showToast(ToastEnum.MaxCanHasFishingCurrency, var_13_2)

		return
	end

	local var_13_3 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")

	if FishingModel.instance:getHasExchangedTimes() + arg_13_1 > var_13_3[1] then
		GameFacade.showToast(var_13_3[2], var_13_3[1])

		return
	end

	FishingRpc.instance:sendChangeFishingCurrencyRequest(arg_13_1, arg_13_2, arg_13_3)
end

local var_0_1 = 2

function var_0_0.getFriendListInfo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = false
	local var_14_1 = Time.realtimeSinceStartup

	if arg_14_0._lastGetFriendInfoTime then
		var_14_0 = var_14_1 - arg_14_0._lastGetFriendInfoTime < var_0_1
	end

	if var_14_0 then
		arg_14_0:updateFriendListInfo()

		if arg_14_1 then
			arg_14_1(arg_14_2)
		end
	else
		arg_14_0._lastGetFriendInfoTime = var_14_1

		FishingRpc.instance:sendGetFishingFriendsRequest(arg_14_1, arg_14_2)
	end
end

function var_0_0.visitOtherFishingPool(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	if arg_15_1 == PlayerModel.instance:getMyUserId() then
		GameFacade.showToast(ToastEnum.VisitMyselfFishingPool)

		return
	end

	arg_15_0._tmpPrePoolUserId = FishingModel.instance:getCurShowingUserId()

	FishingRpc.instance:sendGetOtherFishingInfoRequest(arg_15_1, arg_15_0._afterGetOtherInfo, arg_15_0)
end

function var_0_0._afterGetOtherInfo(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 ~= 0 then
		return
	end

	local var_16_0 = FishingModel.instance:getIsShowingMySelf() and StatEnum.RoomFishingResult.Visit or StatEnum.RoomFishingResult.VisitNext

	arg_16_0:sendExitFishingTrack(var_16_0, arg_16_0._tmpPrePoolUserId, arg_16_3.userId, true)

	arg_16_0._tmpPrePoolUserId = nil

	RoomController.instance:enterRoom(RoomEnum.GameMode.FishingVisit, nil, nil, {
		hasFishingVisitInfo = true,
		userId = arg_16_3.userId
	}, nil, nil, true)
end

function var_0_0.updateFishingInfo(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_1 then
		FishingModel.instance:updateOtherPoolInfo(arg_17_1, arg_17_2, arg_17_3)
	else
		FishingModel.instance:updateMyselfPoolInfo(arg_17_2)
	end

	ViewMgr.instance:closeView(ViewName.CommonExchangeView)
	arg_17_0:dispatchEvent(FishingEvent.OnFishingInfoUpdate, arg_17_1)
end

function var_0_0.onFishing(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	FishingModel.instance:updateMyProgressInfo(arg_18_3)
	arg_18_0:dispatchEvent(FishingEvent.OnFishingProgressUpdate)
end

function var_0_0.onGetFishingBonus(arg_19_0, arg_19_1)
	FishingModel.instance:setHasGotShareRewardTimes(arg_19_1 and arg_19_1.todayAcceptShareCount)

	local var_19_0 = arg_19_1 and arg_19_1.bonusInfo

	if not var_19_0 then
		return
	end

	local var_19_1 = {
		time = 0,
		poolIdList = {},
		fishingTimesDict = {}
	}
	local var_19_2 = {
		time = 0,
		poolIdList = {},
		fishingTimesDict = {}
	}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_3 = iter_19_1.poolId
		local var_19_4 = iter_19_1.fishTimes
		local var_19_5 = iter_19_1.startTime
		local var_19_6 = iter_19_1.finishTime
		local var_19_7 = iter_19_1.type == FishingEnum.FishingProgressType.Myself and var_19_1 or var_19_2
		local var_19_8 = var_19_7.fishingTimesDict[var_19_3]

		if var_19_8 then
			var_19_7.fishingTimesDict[var_19_3] = var_19_8 + var_19_4
		else
			var_19_7.fishingTimesDict[var_19_3] = var_19_4

			table.insert(var_19_7.poolIdList, var_19_3)
		end

		var_19_7.time = var_19_7.time + var_19_6 - var_19_5
	end

	arg_19_0:openFishingRewardView(var_19_1, var_19_2)
	arg_19_0:getFishingInfo()
end

function var_0_0.onExchangeFishingCurrency(arg_20_0, arg_20_1, arg_20_2)
	FishingModel.instance:setHasExchangedTimes(arg_20_2)
end

function var_0_0.updateFriendListInfo(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 or arg_21_2 then
		FishingFriendListModel.instance:updateFriendListInfo(arg_21_1)
	else
		FishingFriendListModel.instance:setFriendList()
	end
end

function var_0_0.openFishingExchange(arg_22_0)
	local var_22_0 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")

	if FishingModel.instance:getHasExchangedTimes() >= var_22_0[1] then
		GameFacade.showToast(var_22_0[2], var_22_0[1])

		return
	end

	local var_22_1 = MaterialDataMO.New()
	local var_22_2 = MaterialDataMO.New()
	local var_22_3 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.ExchangeCostCurrency, true)

	var_22_1:initValue(MaterialEnum.MaterialType.Currency, var_22_3)
	var_22_2:initValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomFishing)
	MaterialTipController.instance:openExchangeTipView(var_22_1, var_22_2, arg_22_0.exchangeFishingCurrency, arg_22_0, arg_22_0.getMaxFishingCurrencyExchangeTime, arg_22_0, arg_22_0.getFishingCurrencyExchangeNum, arg_22_0)
end

function var_0_0.getMaxFishingCurrencyExchangeTime(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = FishingConfig.instance:getMaxCostExchangeTimes()
	local var_23_2 = FishingConfig.instance:getExchangeCost(var_23_1)
	local var_23_3 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.ExchangeCostCurrency, true)
	local var_23_4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_23_3)
	local var_23_5 = FishingModel.instance:getHasExchangedTimes()
	local var_23_6 = var_23_5 + 1

	if var_23_1 <= var_23_6 then
		var_23_0 = math.floor(var_23_4 / var_23_2)
	else
		local var_23_7 = 0

		while var_23_0 < var_23_1 do
			var_23_7 = var_23_7 + FishingConfig.instance:getExchangeCost(var_23_6)

			if var_23_7 <= var_23_4 then
				var_23_0 = var_23_0 + 1
				var_23_6 = var_23_6 + 1
			else
				break
			end
		end

		if var_23_7 < var_23_4 then
			var_23_0 = var_23_0 + math.floor((var_23_4 - var_23_7) / var_23_2)
		end
	end

	local var_23_8 = 0
	local var_23_9 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")[1]

	if var_23_5 < var_23_9 then
		var_23_8 = math.min(var_23_9 - var_23_5, var_23_0)
	end

	local var_23_10 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local var_23_11 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_23_10[1])
	local var_23_12 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0

	if var_23_11 <= var_23_12 then
		var_23_8 = math.min(var_23_8, var_23_12 - var_23_11)
	end

	return var_23_8, var_23_0
end

function var_0_0.getFishingCurrencyExchangeNum(arg_24_0, arg_24_1)
	local var_24_0 = 0
	local var_24_1 = FishingModel.instance:getHasExchangedTimes()

	for iter_24_0 = var_24_1 + 1, var_24_1 + arg_24_1 do
		var_24_0 = var_24_0 + FishingConfig.instance:getExchangeCost(iter_24_0)
	end

	return var_24_0, arg_24_1
end

function var_0_0.sendExitFishingTrack(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if not arg_25_0._enterFishingTime then
		return
	end

	local var_25_0 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomTrade)
	local var_25_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomFishing)
	local var_25_2 = FishingModel.instance:getBackpackItemList()
	local var_25_3 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_2) do
		local var_25_4 = ItemModel.instance:getItemConfigAndIcon(iter_25_1.type, iter_25_1.id)

		var_25_3[iter_25_0] = {
			materialtype = iter_25_1.type,
			materialid = iter_25_1.id,
			materialname = var_25_4 and var_25_4.name or "",
			materialnum = iter_25_1.quantity
		}
	end

	local var_25_5 = ""
	local var_25_6 = PlayerModel.instance:getMyUserId()

	if not string.nilorempty(arg_25_3) and arg_25_3 ~= var_25_6 then
		var_25_5 = SocialModel.instance:isMyFriendByUserId(arg_25_3) and StatEnum.RoomFishingVisitType.Friend or StatEnum.RoomFishingVisitType.Stranger
	end

	StatController.instance:track(StatEnum.EventName.ExitRoomFishing, {
		[StatEnum.EventProperties.Result] = arg_25_1,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_25_0._enterFishingTime,
		[StatEnum.EventProperties.RoomPivotLevel] = RoomModel.instance:getRoomLevel() or 0,
		[StatEnum.EventProperties.HaveFishingNum] = var_25_1,
		[StatEnum.EventProperties.HaveCrittersCoin] = var_25_0,
		[StatEnum.EventProperties.FishingGroundBox] = var_25_3,
		[StatEnum.EventProperties.BeforeRoleId] = arg_25_2 or "",
		[StatEnum.EventProperties.AfterRoleId] = arg_25_3 or "",
		[StatEnum.EventProperties.VisitType] = var_25_5
	})

	if arg_25_4 then
		arg_25_0._enterFishingTime = UnityEngine.Time.realtimeSinceStartup
	else
		arg_25_0._enterFishingTime = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
