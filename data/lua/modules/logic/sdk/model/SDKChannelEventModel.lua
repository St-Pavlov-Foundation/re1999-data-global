module("modules.logic.sdk.model.SDKChannelEventModel", package.seeall)

slot0 = class("SDKChannelEventModel", BaseController)

function slot0.onInit(slot0)
	slot0._enum = nil

	if GameChannelConfig.isEfun() then
		slot0._enum = SDKEfunChannelEventEnum
	elseif GameChannelConfig.isLongCheng() and BootNativeUtil.isMobilePlayer() then
		slot0._enum = SDKLongchengChannelEventEnum
	end

	slot0._totalChargeAmount = nil
	slot0._dailyTaskActiveNum = 0
	slot0._consumeItemDic = {}
	slot0._totalSummonCount = nil
	slot0._needAppReview = false
end

function slot0.reInit(slot0)
	slot0._dailyTaskActiveNum = 0
	slot0._totalChargeAmount = nil
	slot0._consumeItemDic = {}
	slot0._totalSummonCount = nil
	slot0._needAppReview = false
end

function slot0.addConstEvents(slot0)
end

function slot0.episodePass(slot0, slot1)
	if slot0._enum and slot0._enum.EpisodePass[slot1] then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.EpisodePass[slot1])
	end

	if slot0._enum and slot1 and slot0._enum.AppReviewePisodeId == slot1 then
		SDKMgr.instance:appReview()
	end
end

function slot0.playerLevelUp(slot0, slot1)
	if slot0._enum and slot0._enum.PlayerLevelUp[slot1] then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.PlayerLevelUp[slot1])
	end

	if GameChannelConfig.isEfun() and slot1 == 5 then
		SDKMgr.instance:showATTDialog("level_five")
	end
end

function slot0.firstSummon(slot0)
	if slot0._enum and slot0._enum.FirstSummon then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.FirstSummon)
	end
end

function slot0.addTotalSummonCount(slot0, slot1)
	if not slot0._totalSummonCount then
		slot0._totalSummonCount = 0
	end

	slot0:updateTotalSummonCount(slot0._totalSummonCount + slot1)
end

function slot0.updateTotalSummonCount(slot0, slot1)
	if slot0._totalSummonCount and slot0._enum and slot0._enum.Summon then
		for slot5, slot6 in pairs(slot0._enum.Summon) do
			if slot0._totalSummonCount < slot5 and slot5 <= slot1 then
				SDKDataTrackMgr.instance:trackChannelEvent(slot6)
			end
		end
	end

	slot0._totalSummonCount = slot1
end

function slot0.consumeItem(slot0, slot1, slot2)
	if slot0._enum and slot0._enum.ConsumeItem[slot1] and slot0._consumeItemDic[slot1] and slot0._consumeItemDic[slot1] < slot0._enum.ConsumeItem[slot1][1] and slot4[1] <= slot2 then
		SDKDataTrackMgr.instance:trackChannelEvent(slot4[2])
	end

	slot0._consumeItemDic[slot1] = slot2
end

function slot0.firstPurchase(slot0)
	if slot0._enum and slot0._enum.FirstPurchase then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.FirstPurchase)
	end
end

function slot0.purchase(slot0, slot1)
	if slot0._enum and slot0._enum.Purchase[slot1] then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.Purchase[slot1])
	end
end

function slot0.totalChargeAmount(slot0, slot1)
	slot1 = tonumber(slot1)

	if slot0._totalChargeAmount then
		if slot0._enum and slot0._enum.TotalChargeAmount then
			for slot5, slot6 in pairs(slot0._enum.TotalChargeAmount) do
				if slot0._totalChargeAmount < slot5 and slot5 <= slot1 then
					SDKDataTrackMgr.instance:trackChannelEvent(slot6)
				end
			end
		end

		for slot6, slot7 in pairs(GameChannelConfig.isGpJapan() and SDKMediaEventEnum.JP_TotalChargeAmount or SDKMediaEventEnum.TotalChargeAmount) do
			if slot0._totalChargeAmount < slot6 and slot6 <= slot1 then
				SDKDataTrackMgr.instance:trackMediaEvent(slot7)
			end
		end
	end

	slot0._totalChargeAmount = slot1
end

function slot0.getMaxRareHero(slot0)
	if slot0._enum and slot0._enum.GetMaxRareHero then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.GetMaxRareHero)
	end
end

function slot0.onSummonResult(slot0, slot1)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.AppReview) == 1 then
		return
	end

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.heroId and slot6.heroId ~= 0 and HeroConfig.instance:getHeroCO(slot6.heroId).rare == CharacterEnum.MaxRare then
				slot0:setNeedAppReview(true)

				break
			end
		end
	end
end

function slot0.setNeedAppReview(slot0, slot1)
	slot0._needAppReview = slot1
end

function slot0.needAppReview(slot0)
	return false
end

function slot0.firstBuyPower(slot0)
	if slot0._enum and slot0._enum.FirstBuyPower then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.FirstBuyPower)
	end
end

function slot0.nickName(slot0)
	if slot0._enum and slot0._enum.NickName then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.NickName)
	end
end

function slot0.firstExchangeDiamond(slot0)
	if slot0._enum and slot0._enum.FirstExchangeDiamond then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.FirstExchangeDiamond)
	end
end

function slot0.heroRankUp(slot0, slot1)
	if slot0._enum and slot0._enum.HeroRankUp[slot1] then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.HeroRankUp[slot1])
	end
end

function slot0.updateDailyTaskActive(slot0)
	if slot0._dailyTaskActiveNum ~= TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Daily).value and slot0._enum and slot0._enum.DailyTaskActive[slot2] then
		SDKDataTrackMgr.instance:trackChannelEvent(slot0._enum.DailyTaskActive[slot2])
	end

	slot0._dailyTaskActiveNum = slot2
end

slot0.instance = slot0.New()

return slot0
