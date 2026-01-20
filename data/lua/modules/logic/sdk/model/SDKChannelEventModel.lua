-- chunkname: @modules/logic/sdk/model/SDKChannelEventModel.lua

module("modules.logic.sdk.model.SDKChannelEventModel", package.seeall)

local SDKChannelEventModel = class("SDKChannelEventModel", BaseController)

function SDKChannelEventModel:onInit()
	self._enum = nil

	if GameChannelConfig.isEfun() then
		self._enum = SDKEfunChannelEventEnum
	elseif GameChannelConfig.isLongCheng() and BootNativeUtil.isMobilePlayer() then
		self._enum = SDKLongchengChannelEventEnum
	end

	self._totalChargeAmount = nil
	self._dailyTaskActiveNum = 0
	self._consumeItemDic = {}
	self._totalSummonCount = nil
	self._needAppReview = false
end

function SDKChannelEventModel:reInit()
	self._dailyTaskActiveNum = 0
	self._totalChargeAmount = nil
	self._consumeItemDic = {}
	self._totalSummonCount = nil
	self._needAppReview = false
end

function SDKChannelEventModel:addConstEvents()
	return
end

function SDKChannelEventModel:episodePass(episodeId)
	if self._enum and self._enum.EpisodePass[episodeId] then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.EpisodePass[episodeId])
	end

	if self._enum and episodeId and self._enum.AppReviewePisodeId == episodeId then
		SDKMgr.instance:appReview()
	end
end

function SDKChannelEventModel:playerLevelUp(newLevel)
	if self._enum and self._enum.PlayerLevelUp[newLevel] then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.PlayerLevelUp[newLevel])
	end

	if GameChannelConfig.isEfun() and newLevel == 5 then
		SDKMgr.instance:showATTDialog("level_five")
	end
end

function SDKChannelEventModel:firstSummon()
	if self._enum and self._enum.FirstSummon then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.FirstSummon)
	end
end

function SDKChannelEventModel:addTotalSummonCount(num)
	if not self._totalSummonCount then
		self._totalSummonCount = 0
	end

	self:updateTotalSummonCount(self._totalSummonCount + num)
end

function SDKChannelEventModel:updateTotalSummonCount(new)
	if self._totalSummonCount and self._enum and self._enum.Summon then
		for i, v in pairs(self._enum.Summon) do
			if i > self._totalSummonCount and i <= new then
				SDKDataTrackMgr.instance:trackChannelEvent(v)
			end
		end
	end

	self._totalSummonCount = new
end

function SDKChannelEventModel:consumeItem(id, new)
	if self._enum and self._enum.ConsumeItem[id] and self._consumeItemDic[id] then
		local old = self._consumeItemDic[id]
		local arr = self._enum.ConsumeItem[id]

		if old < arr[1] and new >= arr[1] then
			SDKDataTrackMgr.instance:trackChannelEvent(arr[2])
		end
	end

	self._consumeItemDic[id] = new
end

function SDKChannelEventModel:firstPurchase()
	if self._enum and self._enum.FirstPurchase then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.FirstPurchase)
	end
end

function SDKChannelEventModel:purchase(id)
	if self._enum and self._enum.Purchase[id] then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.Purchase[id])
	end
end

function SDKChannelEventModel:totalChargeAmount(totalChargeAmount)
	totalChargeAmount = tonumber(totalChargeAmount)

	if self._totalChargeAmount then
		if self._enum and self._enum.TotalChargeAmount then
			for i, v in pairs(self._enum.TotalChargeAmount) do
				if i > self._totalChargeAmount and i <= totalChargeAmount then
					SDKDataTrackMgr.instance:trackChannelEvent(v)
				end
			end
		end

		local mediaTotalChargeAmount = GameChannelConfig.isGpJapan() and SDKMediaEventEnum.JP_TotalChargeAmount or SDKMediaEventEnum.TotalChargeAmount

		for i, v in pairs(mediaTotalChargeAmount) do
			if i > self._totalChargeAmount and i <= totalChargeAmount then
				SDKDataTrackMgr.instance:trackMediaEvent(v)
			end
		end
	end

	self._totalChargeAmount = totalChargeAmount
end

function SDKChannelEventModel:getMaxRareHero()
	if self._enum and self._enum.GetMaxRareHero then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.GetMaxRareHero)
	end
end

function SDKChannelEventModel:onSummonResult(summonResult)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.AppReview) == 1 then
		return
	end

	if summonResult and #summonResult > 0 then
		for i, result in ipairs(summonResult) do
			if result.heroId and result.heroId ~= 0 then
				local config = HeroConfig.instance:getHeroCO(result.heroId)

				if config.rare == CharacterEnum.MaxRare then
					self:setNeedAppReview(true)

					break
				end
			end
		end
	end
end

function SDKChannelEventModel:setNeedAppReview(v)
	self._needAppReview = v
end

function SDKChannelEventModel:needAppReview()
	return false
end

function SDKChannelEventModel:firstBuyPower()
	if self._enum and self._enum.FirstBuyPower then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.FirstBuyPower)
	end
end

function SDKChannelEventModel:nickName()
	if self._enum and self._enum.NickName then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.NickName)
	end
end

function SDKChannelEventModel:firstExchangeDiamond()
	if self._enum and self._enum.FirstExchangeDiamond then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.FirstExchangeDiamond)
	end
end

function SDKChannelEventModel:heroRankUp(rank)
	if self._enum and self._enum.HeroRankUp[rank] then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.HeroRankUp[rank])
	end
end

function SDKChannelEventModel:updateDailyTaskActive()
	local actMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Daily)
	local num = actMo.value

	if self._dailyTaskActiveNum ~= num and self._enum and self._enum.DailyTaskActive[num] then
		SDKDataTrackMgr.instance:trackChannelEvent(self._enum.DailyTaskActive[num])
	end

	self._dailyTaskActiveNum = num
end

SDKChannelEventModel.instance = SDKChannelEventModel.New()

return SDKChannelEventModel
