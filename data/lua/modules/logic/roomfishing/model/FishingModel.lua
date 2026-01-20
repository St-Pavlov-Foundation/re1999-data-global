-- chunkname: @modules/logic/roomfishing/model/FishingModel.lua

module("modules.logic.roomfishing.model.FishingModel", package.seeall)

local FishingModel = class("FishingModel", BaseModel)

function FishingModel:onInit()
	self:clear()
	self:clearData()
end

function FishingModel:reInit()
	self:clearData()
end

function FishingModel:clearData()
	self.myselfPoolInfo = nil
	self.otherPoolInfo = nil
end

function FishingModel:updateMyselfPoolInfo(fishingPoolInfo)
	if not self.myselfPoolInfo then
		self.myselfPoolInfo = FishingPoolInfoMO.New()
	end

	local myUserId = PlayerModel.instance:getMyUserId()

	self.myselfPoolInfo:init(myUserId, fishingPoolInfo)
	self:setHasExchangedTimes(fishingPoolInfo.changeCount)
	self:setHasGotShareRewardTimes(fishingPoolInfo.todayAcceptShareCount)
	FishingFriendListModel.instance:setFriendList()
end

function FishingModel:setHasExchangedTimes(times)
	self._hasExchangedTimes = times or 0
end

function FishingModel:setHasGotShareRewardTimes(times)
	self._hasGotShareRewardTimes = times or 0
end

function FishingModel:updateMyProgressInfo(progressInfo)
	if self.myselfPoolInfo then
		self.myselfPoolInfo:updateFishingProgressInfo(progressInfo)
		FishingFriendListModel.instance:setFriendList()
	end
end

function FishingModel:updateOtherPoolInfo(userId, fishingPoolInfo, friendInfo)
	if not self.otherPoolInfo then
		self.otherPoolInfo = FishingPoolInfoMO.New()
	end

	self.otherPoolInfo:init(userId, fishingPoolInfo)
	self.otherPoolInfo:setFriendInfo(friendInfo)
end

function FishingModel:isUnlockRoomFishing(isToast)
	local isOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoomFishing)

	if not isOpen then
		if isToast then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.RoomFishing))
		end

		return false
	end

	local fishingActId = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishingActId, true)
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(fishingActId)
	local isActOpen = status == ActivityEnum.ActivityStatus.Normal

	if not isActOpen then
		if toastId and isToast then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return false
	end

	return true
end

function FishingModel:getIsShowingMySelf()
	local isMyselfFishing = RoomController.instance:isFishingMode()

	return isMyselfFishing
end

function FishingModel:isInFishing()
	local isShowMyself = self:getIsShowingMySelf()
	local isFishingVisit = RoomController.instance:isFishingVisitMode()

	return isShowMyself or isFishingVisit
end

function FishingModel:isEnoughToFish(times)
	local costData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local needCost = times * costData[2]
	local hasQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, costData[1])

	return needCost <= hasQuantity
end

function FishingModel:getCurFishingPoolInfo()
	local fishingPoolMO
	local isInFishing = self:isInFishing()

	if isInFishing then
		local isShowMyself = self:getIsShowingMySelf()

		if isShowMyself then
			fishingPoolMO = self.myselfPoolInfo
		else
			fishingPoolMO = self.otherPoolInfo
		end
	end

	return fishingPoolMO
end

function FishingModel:getCurFishingPoolId()
	local fishingPoolMO = self:getCurFishingPoolInfo()

	return fishingPoolMO and fishingPoolMO:getPoolId()
end

function FishingModel:getCurShowingUserId()
	local fishingPoolMO = self:getCurFishingPoolInfo()

	return fishingPoolMO and fishingPoolMO:getUserId()
end

function FishingModel:getCurFishingPoolUserInfo()
	local fishingPoolMO = self:getCurFishingPoolInfo()

	if fishingPoolMO then
		return fishingPoolMO:getOwnerInfo()
	end
end

function FishingModel:getCurFishingPoolItem()
	local poolId = self:getCurFishingPoolId()
	local poolItemData = FishingConfig.instance:getFishingPoolItem(poolId)

	return poolItemData
end

function FishingModel:getCurFishingPoolRefreshTime()
	local remainSecond = 0
	local needRefresh = false
	local isUnlock = self:isUnlockRoomFishing()

	if not isUnlock then
		return remainSecond, needRefresh
	end

	local fishingActId = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishingActId, true)
	local startTime = ActivityModel.instance:getActStartTime(fishingActId) / 1000
	local intervalTime = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.PoolRefreshInterval, true) * TimeUtil.OneDaySecond
	local nowTime = ServerTime.now()
	local offsetTime = nowTime - startTime
	local passTime = offsetTime % intervalTime

	remainSecond = math.max(0, intervalTime - passTime)

	local fishingPoolMO = self:getCurFishingPoolInfo()

	if fishingPoolMO then
		local index = math.floor(offsetTime / intervalTime)
		local lastRefreshTime = fishingPoolMO:getLastRefreshTime()
		local lastRefreshIndex = math.floor((lastRefreshTime - startTime) / intervalTime)

		needRefresh = lastRefreshIndex ~= index
	end

	return remainSecond, needRefresh
end

function FishingModel:getRemainFishingTime(fishingPoolUserId)
	local remainSecond = 0
	local progressInfo = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfo(fishingPoolUserId)
	local startTime = progressInfo and progressInfo.startTime
	local endTime = progressInfo and progressInfo.finishTime

	if startTime and endTime and startTime > 0 and endTime > 0 and startTime < endTime then
		local nowTime = ServerTime.now()

		remainSecond = math.max(remainSecond, endTime - nowTime)
	end

	return remainSecond
end

local MY_BOAT_INDEX = 1

function FishingModel:getFriendBoatInfoList()
	local fishingPoolMO = self:getCurFishingPoolInfo()
	local boatList = fishingPoolMO and fishingPoolMO:getBoatInfoList() or {}
	local isShowMyself = self:getIsShowingMySelf()

	if not isShowMyself then
		local myBoatIndex = false
		local myUserId = PlayerModel.instance:getMyUserId()

		for i, boatInfo in ipairs(boatList) do
			if boatInfo.userId == myUserId then
				myBoatIndex = i

				break
			end
		end

		if myBoatIndex then
			if myBoatIndex ~= MY_BOAT_INDEX then
				local myBoatInfo = table.remove(boatList, myBoatIndex)

				table.insert(boatList, MY_BOAT_INDEX, myBoatInfo)
			end
		else
			local curUserId = fishingPoolMO and fishingPoolMO:getUserId()
			local isFriend = SocialModel.instance:isMyFriendByUserId(curUserId)

			table.insert(boatList, MY_BOAT_INDEX, {
				isFriend = isFriend,
				userId = myUserId
			})
		end
	end

	return boatList
end

function FishingModel:getFishingFriendInfo(userId)
	local curPoolUserId = self:getCurShowingUserId()

	if userId == curPoolUserId then
		local _, name, portrait = self:getCurFishingPoolUserInfo()

		return name, portrait
	else
		local fishingPoolMO = self:getCurFishingPoolInfo()

		if fishingPoolMO then
			return fishingPoolMO:getBoatUserInfo(userId)
		end
	end
end

function FishingModel:getIsFishingInUserPool(fishingPoolUserId)
	local progressInfo = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfo(fishingPoolUserId)
	local startTime = progressInfo and progressInfo.startTime
	local endTime = progressInfo and progressInfo.finishTime
	local result = false

	if startTime and endTime and startTime > 0 and endTime > 0 and startTime < endTime then
		result = true
	end

	return result
end

function FishingModel:getFishingTimes(fishingPoolUserId)
	local result = 0
	local progressInfo = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfo(fishingPoolUserId)

	result = progressInfo and progressInfo.fishTimes or result

	return result
end

function FishingModel:getMyFishingProgress(fishingPoolUserId)
	local progressInfo = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfo(fishingPoolUserId)
	local startTime = progressInfo and progressInfo.startTime
	local endTime = progressInfo and progressInfo.finishTime
	local result = FishingHelper.getFishingProgress(startTime, endTime)

	return result
end

function FishingModel:isCanGetMyFishingBonusInUser(fishingPoolUserId)
	local progressInfo = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfo(fishingPoolUserId)
	local startTime = progressInfo and progressInfo.startTime
	local endTime = progressInfo and progressInfo.finishTime
	local result = FishingHelper.isFishingFinished(startTime, endTime)

	return result
end

function FishingModel:isCanGetMyFishingBonus()
	local progressInfoDict = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfoDict()

	if progressInfoDict then
		for userId, _ in pairs(progressInfoDict) do
			local isCanGet = self:isCanGetMyFishingBonusInUser(userId)

			if isCanGet then
				return true
			end
		end
	end
end

function FishingModel:isCanGetOtherFishingBonus()
	local hasGotTimes = self:getHasGotShareRewardTimes()
	local maxCanGetTimes = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxCanGetShareRewardTimes, true, "")

	if maxCanGetTimes <= hasGotTimes then
		return false
	end

	local curFinishedCount = 0
	local otherProgressInfoDict = self.myselfPoolInfo and self.myselfPoolInfo:getOtherProgressInfoDict()

	if otherProgressInfoDict then
		for _, progressInfo in pairs(otherProgressInfoDict) do
			local startTime = progressInfo and progressInfo.startTime
			local endTime = progressInfo and progressInfo.finishTime
			local isFinished = FishingHelper.isFishingFinished(startTime, endTime)

			if isFinished then
				curFinishedCount = curFinishedCount + 1
			end
		end
	end

	local minFriendBonusCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.GetFriendBonusMinCount, true)

	return minFriendBonusCount <= curFinishedCount
end

function FishingModel:getMyFishingCount()
	local result = 0

	if self.myselfPoolInfo then
		result = self.myselfPoolInfo:getFishingCount()
	end

	return result
end

function FishingModel:getMyFishingFriendList()
	local result = {}
	local progressInfoDict = self.myselfPoolInfo and self.myselfPoolInfo:getMyProgressInfoDict()

	if progressInfoDict then
		local myUserId = PlayerModel.instance:getMyUserId()

		for userId, progressInfo in pairs(progressInfoDict) do
			if userId ~= myUserId then
				local info = FishingFriendInfoMO.New()
				local isFriend = SocialModel.instance:isMyFriendByUserId(userId)

				info:init({
					type = isFriend and FishingEnum.OtherPlayerBoatType.Friend or FishingEnum.OtherPlayerBoatType.Stranger,
					userId = userId,
					name = progressInfo.name,
					portrait = progressInfo.portrait,
					poolId = progressInfo.poolId
				})

				result[#result + 1] = info
			end
		end
	end

	return result
end

local function _sortResourceItem(aPropItem, bPropItem)
	if not aPropItem or not bPropItem then
		return false
	end

	local aId = aPropItem.id
	local bId = bPropItem.id
	local aRare = aPropItem.rare
	local bRare = bPropItem.rare

	if aRare ~= bRare then
		return bRare < aRare
	end

	return bId < aId
end

function FishingModel:getBackpackItemList()
	local list = {}
	local currencyList = CurrencyModel.instance:getCurrencyList() or {}

	for _, currencyMO in pairs(currencyList) do
		local itemConfig = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, currencyMO.currencyId)
		local subType = itemConfig and itemConfig.subType

		if subType == CurrencyEnum.SubType.RoomFishingResourceItem and currencyMO.quantity > 0 then
			table.insert(list, {
				id = currencyMO.currencyId,
				type = MaterialEnum.MaterialType.Currency,
				quantity = currencyMO.quantity,
				rare = itemConfig.rare
			})
		end
	end

	table.sort(list, _sortResourceItem)

	return list
end

function FishingModel:getFishingItemList(poolIdList, fishingTimesDict, isShare)
	local list = {}

	if not poolIdList then
		return list
	end

	local itemDict = {}

	for _, poolId in ipairs(poolIdList) do
		local itemInfo

		if isShare then
			itemInfo = FishingConfig.instance:getFishingShareItem(poolId)
		else
			itemInfo = FishingConfig.instance:getFishingPoolItem(poolId)
		end

		if itemInfo then
			local id = itemInfo[2]

			if not itemDict[id] then
				local itemConfig = ItemModel.instance:getItemConfig(itemInfo[1], itemInfo[2])

				itemDict[id] = {
					quantity = 0,
					type = itemInfo[1],
					id = id,
					rare = itemConfig.rare
				}
			end

			local fishingTimes = fishingTimesDict[poolId] or 0

			itemDict[id].quantity = itemDict[id].quantity + itemInfo[3] * fishingTimes
		end
	end

	for _, itemData in pairs(itemDict) do
		list[#list + 1] = itemData
	end

	table.sort(list, _sortResourceItem)

	return list
end

function FishingModel:getHasExchangedTimes()
	return self._hasExchangedTimes or 0
end

function FishingModel:getHasGotShareRewardTimes()
	return self._hasGotShareRewardTimes or 0
end

FishingModel.instance = FishingModel.New()

return FishingModel
